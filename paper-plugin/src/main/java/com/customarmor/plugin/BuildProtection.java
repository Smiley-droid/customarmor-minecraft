package com.customarmor.plugin;

import org.bukkit.Chunk;
import org.bukkit.World;
import org.bukkit.block.BlockState;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.block.BlockPlaceEvent;
import org.bukkit.event.world.ChunkLoadEvent;

import java.io.*;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Marque les chunks contenant probablement une construction de joueur, pour que
 * le systeme de reliques legendaires evite d'y spawner.
 *
 * Pour rester leger en RAM, on ne stocke qu'une cle "chunk" (pas bloc par bloc) :
 * un simple Set<Long> suffit meme pour un tres gros monde (quelques millions
 * d'entrees maximum, negligeable comparé au reste du serveur).
 *
 * Deux sources de detection :
 *  1) Un joueur pose un bloc (BlockPlaceEvent) -> marque immediat.
 *  2) Un chunk se charge et contient un bloc-entite "signe de construction"
 *     (coffre, lit, four, etc.) -> marque passif, sans avoir besoin de scanner
 *     tout le monde a l'avance.
 */
public class BuildProtection implements Listener {

    private final CustomArmorPlugin plugin;
    private final Set<Long> markedChunks = new HashSet<>();
    private final Map<String, Integer> worldIds = new HashMap<>();
    private final File saveFile;
    private boolean dirty = false;

    public BuildProtection(CustomArmorPlugin plugin) {
        this.plugin = plugin;
        this.saveFile = new File(plugin.getDataFolder(), "protected-chunks.dat");
        loadFromDisk();
    }

    // ==================== API publique ====================

    public boolean isSafe(World world, int blockX, int blockZ) {
        int cx = blockX >> 4;
        int cz = blockZ >> 4;
        for (int dx = -1; dx <= 1; dx++) {
            for (int dz = -1; dz <= 1; dz++) {
                if (markedChunks.contains(key(world, cx + dx, cz + dz))) {
                    return false;
                }
            }
        }
        return true;
    }

    // ==================== Détection ====================

    @EventHandler(ignoreCancelled = true)
    public void onBlockPlace(BlockPlaceEvent event) {
        mark(event.getBlock().getWorld(), event.getBlock().getX() >> 4, event.getBlock().getZ() >> 4);
    }

    @EventHandler
    public void onChunkLoad(ChunkLoadEvent event) {
        Chunk chunk = event.getChunk();
        long key = key(chunk.getWorld(), chunk.getX(), chunk.getZ());
        if (markedChunks.contains(key)) return;

        BlockState[] tileEntities = chunk.getTileEntities();
        if (tileEntities.length > 0) {
            // Un four, coffre, lit, panneau... presence quasi certaine d'une construction
            mark(chunk.getWorld(), chunk.getX(), chunk.getZ());
        }
    }

    private void mark(World world, int chunkX, int chunkZ) {
        long key = key(world, chunkX, chunkZ);
        if (markedChunks.add(key)) {
            dirty = true;
        }
    }

    private long key(World world, int chunkX, int chunkZ) {
        int worldId = worldIds.computeIfAbsent(world.getName(), w -> worldIds.size());
        return ((long) worldId << 40) | (((long) chunkX & 0xFFFFF) << 20) | ((long) chunkZ & 0xFFFFF);
    }

    // ==================== Persistance disque ====================

    private void loadFromDisk() {
        if (!saveFile.exists()) return;
        try (DataInputStream in = new DataInputStream(new BufferedInputStream(new FileInputStream(saveFile)))) {
            int worldCount = in.readInt();
            for (int i = 0; i < worldCount; i++) {
                String name = in.readUTF();
                worldIds.put(name, i);
            }
            int chunkCount = in.readInt();
            for (int i = 0; i < chunkCount; i++) {
                markedChunks.add(in.readLong());
            }
            plugin.getLogger().info("BuildProtection : " + chunkCount + " chunks proteges charges.");
        } catch (IOException ex) {
            plugin.getLogger().warning("Impossible de charger protected-chunks.dat : " + ex.getMessage());
        }
    }

    public void saveToDisk() {
        if (!dirty) return;
        try {
            Files.createDirectories(saveFile.getParentFile().toPath());
        } catch (IOException ignored) {
        }
        try (DataOutputStream out = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(saveFile)))) {
            out.writeInt(worldIds.size());
            List<String> names = new java.util.ArrayList<>(worldIds.keySet());
            names.sort((a, b) -> worldIds.get(a) - worldIds.get(b));
            for (String name : names) {
                out.writeUTF(name);
            }
            out.writeInt(markedChunks.size());
            for (long key : markedChunks) {
                out.writeLong(key);
            }
            dirty = false;
        } catch (IOException ex) {
            plugin.getLogger().warning("Impossible de sauvegarder protected-chunks.dat : " + ex.getMessage());
        }
    }
}
