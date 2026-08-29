package com.customarmor.plugin;

import org.bukkit.*;
import org.bukkit.block.Block;
import org.bukkit.block.Chest;
import org.bukkit.configuration.file.FileConfiguration;
import org.bukkit.entity.Player;
import org.bukkit.entity.Zombie;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerItemBreakEvent;
import org.bukkit.inventory.Inventory;
import org.bukkit.inventory.ItemStack;
import org.bukkit.persistence.PersistentDataType;

import java.io.*;
import java.util.*;

/**
 * Gere l'apparition aleatoire des reliques legendaires, leur comptage en
 * circulation (configurable par type dans config.yml), et leur persistance.
 */
public class LegendaryManager implements Listener {

    private final CustomArmorPlugin plugin;
    private final BuildProtection buildProtection;
    private final LegendaryItemFactory factory;
    private final Random random = new Random();

    // Combien d'exemplaires de chaque relique existent actuellement "en circulation"
    // (spawnee et pas encore cassee). Sauvegarde sur disque, jamais garde en double.
    private final Map<String, Integer> circulation = new HashMap<>();
    // Emplacements des sanctuaires actifs (pour la detection d'approche + nettoyage)
    private final List<ShrineRecord> activeShrines = new ArrayList<>();

    private final File stateFile;

    public LegendaryManager(CustomArmorPlugin plugin, BuildProtection buildProtection) {
        this.plugin = plugin;
        this.buildProtection = buildProtection;
        this.factory = new LegendaryItemFactory(plugin);
        this.stateFile = new File(plugin.getDataFolder(), "legendary-state.dat");
        loadFromDisk();
    }

    public void start() {
        FileConfiguration cfg = plugin.getConfig();
        long periodTicks = cfg.getLong("legendary.check-interval-seconds", 3600) * 20L;
        Bukkit.getScheduler().runTaskTimer(plugin, this::guaranteedCheck, periodTicks, periodTicks);
        // Verification legere (particules + zombies + coffre vide) toutes les secondes
        Bukkit.getScheduler().runTaskTimer(plugin, this::ambientTick, 20L, 20L);
    }

    // ==================== Commande /legendary ====================

    public boolean handleCommand(Player player, String[] args) {
        if (args.length == 0) {
            player.sendMessage("§eUtilisation: /legendary <spawn|reset|setmax|status>");
            return true;
        }
        switch (args[0].toLowerCase()) {
            case "spawn" -> {
                attemptSpawn(true);
                player.sendMessage("§aTentative de spawn forcee.");
            }
            case "reset" -> {
                circulation.clear();
                for (ShrineRecord s : activeShrines) {
                    if (s.chestLocation.getBlock().getState() instanceof Chest) {
                        s.chestLocation.getBlock().setType(Material.AIR);
                    }
                }
                activeShrines.clear();
                saveToDisk();
                player.sendMessage("§aSysteme de reliques reinitialise.");
            }
            case "setmax" -> {
                if (args.length < 3) {
                    player.sendMessage("§cUtilisation: /legendary setmax <item_id|default> <nombre>");
                    return true;
                }
                try {
                    int max = Integer.parseInt(args[2]);
                    plugin.getConfig().set("legendary.max-circulation." + args[1], max);
                    plugin.saveConfig();
                    player.sendMessage("§aLimite pour '" + args[1] + "' fixee a " + max + ".");
                } catch (NumberFormatException ex) {
                    player.sendMessage("§cNombre invalide.");
                }
            }
            case "status" -> {
                player.sendMessage("§6=== Reliques en circulation ===");
                for (String id : LegendaryItemFactory.ITEM_IDS) {
                    int count = circulation.getOrDefault(id, 0);
                    int max = maxFor(id);
                    player.sendMessage("§7- " + id + " : " + count + " / " + max);
                }
            }
            default -> player.sendMessage("§eUtilisation: /legendary <spawn|reset|setmax|status>");
        }
        return true;
    }

    // ==================== Boucle de spawn ====================

    private void guaranteedCheck() {
        attemptSpawn(false);
    }

    private void attemptSpawn(boolean forced) {
        FileConfiguration cfg = plugin.getConfig();
        int minPlayers = cfg.getInt("legendary.min-players", 2);
        if (!forced && Bukkit.getOnlinePlayers().size() < minPlayers) return;
        if (Bukkit.getOnlinePlayers().isEmpty()) return;

        List<String> full = new ArrayList<>();
        for (String id : LegendaryItemFactory.ITEM_IDS) {
            if (circulation.getOrDefault(id, 0) >= maxFor(id)) {
                full.add(id);
            }
        }
        String chosenId = factory.randomItemId(full);
        if (chosenId == null) return; // tout est deja au maximum

        List<Player> online = new ArrayList<>(Bukkit.getOnlinePlayers());
        Player chosen = online.get(random.nextInt(online.size()));

        int minDist = cfg.getInt("legendary.spawn-min-distance", 500);
        int maxDist = cfg.getInt("legendary.spawn-max-distance", 1000);

        int dx = minDist + random.nextInt(maxDist - minDist + 1);
        if (random.nextBoolean()) dx = -dx;
        int dz = minDist + random.nextInt(maxDist - minDist + 1);
        if (random.nextBoolean()) dz = -dz;

        Location base = chosen.getLocation();
        World world = base.getWorld();
        int targetX = base.getBlockX() + dx;
        int targetZ = base.getBlockZ() + dz;

        // On tente jusqu'a 5 emplacements si le premier n'est pas sur (zone construite)
        for (int attempt = 0; attempt < 5; attempt++) {
            if (buildProtection.isSafe(world, targetX, targetZ)) {
                int y = world.getHighestBlockYAt(targetX, targetZ);
                buildShrine(world, targetX, y, targetZ, chosenId);
                return;
            }
            targetX += random.nextInt(200) - 100;
            targetZ += random.nextInt(200) - 100;
        }
        // Aucun emplacement sur trouve cette fois-ci : on retentera au prochain cycle.
    }

    private void buildShrine(World world, int x, int y, int z, String itemId) {
        Block base = world.getBlockAt(x, y, z);
        for (int dx = -1; dx <= 1; dx++) {
            for (int dz = -1; dz <= 1; dz++) {
                base.getRelative(dx, 0, dz).setType(Material.POLISHED_BLACKSTONE);
            }
        }
        Block chestBlock = base.getRelative(0, 1, 0);
        chestBlock.setType(Material.CHEST);
        base.getRelative(-1, 1, -1).setType(Material.SOUL_LANTERN);
        base.getRelative(1, 1, -1).setType(Material.SOUL_LANTERN);
        base.getRelative(-1, 1, 1).setType(Material.SOUL_LANTERN);
        base.getRelative(1, 1, 1).setType(Material.SOUL_LANTERN);

        if (chestBlock.getState() instanceof Chest chest) {
            chest.getInventory().setItem(0, factory.create(itemId));
        }

        circulation.merge(itemId, 1, Integer::sum);
        activeShrines.add(new ShrineRecord(chestBlock.getLocation(), itemId));
        saveToDisk();

        int fuzzMin = plugin.getConfig().getInt("legendary.announce-fuzz-min", 200);
        int fuzzMax = plugin.getConfig().getInt("legendary.announce-fuzz-max", 300);
        int fuzz = fuzzMin + random.nextInt(fuzzMax - fuzzMin + 1);
        int rx = x + (random.nextBoolean() ? fuzz : -fuzz);
        int rz = z + (random.nextBoolean() ? fuzz : -fuzz);

        Bukkit.broadcastMessage("§6§l✦ Une relique légendaire est apparue ! §eCherche vers X=" + rx + " Z=" + rz + " (à " + fuzzMin + "-" + fuzzMax + " blocs près) §6§l✦");
    }

    // ==================== Tick léger (particules, gardiens, ramassage) ====================

    private void ambientTick() {
        Iterator<ShrineRecord> it = activeShrines.iterator();
        while (it.hasNext()) {
            ShrineRecord shrine = it.next();
            Location loc = shrine.chestLocation;
            if (loc.getWorld() == null || !loc.isChunkLoaded()) continue;

            loc.getWorld().spawnParticle(Particle.END_ROD, loc.clone().add(0.5, 1.5, 0.5), 2, 0.3, 0.3, 0.3, 0.01);

            if (!shrine.guardsSpawned) {
                for (Player p : loc.getWorld().getPlayers()) {
                    if (p.getLocation().distanceSquared(loc) <= 15 * 15) {
                        spawnGuards(loc);
                        shrine.guardsSpawned = true;
                        Bukkit.broadcastMessage("§c§l⚠ Des morts-vivants gardent la relique ! ⚠");
                        break;
                    }
                }
            }

            if (loc.getBlock().getState() instanceof Chest chest && isEmpty(chest.getInventory())) {
                loc.getBlock().setType(Material.AIR);
                Bukkit.broadcastMessage("§7La relique légendaire a été récupérée par un aventurier chanceux !");
                it.remove();
                saveToDisk();
            }
        }
    }

    private boolean isEmpty(Inventory inv) {
        for (ItemStack item : inv.getContents()) {
            if (item != null && item.getType() != Material.AIR) return false;
        }
        return true;
    }

    private void spawnGuards(Location center) {
        int[][] offsets = {{2, 2}, {-2, -2}, {2, -2}, {-2, 2}};
        for (int[] off : offsets) {
            Location spot = center.clone().add(off[0], 0, off[1]);
            Zombie zombie = (Zombie) center.getWorld().spawnEntity(spot, EntityType.ZOMBIE);
            zombie.setCustomName("§cGardien de la relique");
            zombie.setCustomNameVisible(true);
        }
    }

    // ==================== Detection de casse ====================

    @EventHandler
    public void onItemBreak(PlayerItemBreakEvent event) {
        ItemStack broken = event.getBrokenItem();
        if (broken.getItemMeta() == null) return;
        String id = broken.getItemMeta().getPersistentDataContainer()
                .get(factory.getIdKey(), PersistentDataType.STRING);
        if (id == null) return;

        circulation.merge(id, -1, Integer::sum);
        if (circulation.get(id) <= 0) circulation.remove(id);
        saveToDisk();

        Bukkit.broadcastMessage("§4§l[CustomArmor] §cUne relique légendaire (" + id + ") appartenant à §f"
                + event.getPlayer().getName() + "§c vient de se casser !");
    }

    private int maxFor(String id) {
        FileConfiguration cfg = plugin.getConfig();
        return cfg.getInt("legendary.max-circulation." + id, cfg.getInt("legendary.max-circulation.default", 1));
    }

    // ==================== Persistance disque ====================

    private void loadFromDisk() {
        if (!stateFile.exists()) return;
        try (DataInputStream in = new DataInputStream(new BufferedInputStream(new FileInputStream(stateFile)))) {
            int count = in.readInt();
            for (int i = 0; i < count; i++) {
                String id = in.readUTF();
                int qty = in.readInt();
                circulation.put(id, qty);
            }
            int shrineCount = in.readInt();
            for (int i = 0; i < shrineCount; i++) {
                String worldName = in.readUTF();
                double x = in.readDouble(), y = in.readDouble(), z = in.readDouble();
                String itemId = in.readUTF();
                boolean guards = in.readBoolean();
                World world = Bukkit.getWorld(worldName);
                if (world != null) {
                    ShrineRecord shrine = new ShrineRecord(new Location(world, x, y, z), itemId);
                    shrine.guardsSpawned = guards;
                    activeShrines.add(shrine);
                }
            }
            plugin.getLogger().info("LegendaryManager : etat charge (" + count + " types, " + shrineCount + " sanctuaires actifs).");
        } catch (IOException ex) {
            plugin.getLogger().warning("Impossible de charger legendary-state.dat : " + ex.getMessage());
        }
    }

    public void saveToDisk() {
        try {
            java.nio.file.Files.createDirectories(stateFile.getParentFile().toPath());
        } catch (IOException ignored) {
        }
        try (DataOutputStream out = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(stateFile)))) {
            out.writeInt(circulation.size());
            for (var entry : circulation.entrySet()) {
                out.writeUTF(entry.getKey());
                out.writeInt(entry.getValue());
            }
            out.writeInt(activeShrines.size());
            for (ShrineRecord shrine : activeShrines) {
                out.writeUTF(shrine.chestLocation.getWorld().getName());
                out.writeDouble(shrine.chestLocation.getX());
                out.writeDouble(shrine.chestLocation.getY());
                out.writeDouble(shrine.chestLocation.getZ());
                out.writeUTF(shrine.itemId);
                out.writeBoolean(shrine.guardsSpawned);
            }
        } catch (IOException ex) {
            plugin.getLogger().warning("Impossible de sauvegarder legendary-state.dat : " + ex.getMessage());
        }
    }

    private static class ShrineRecord {
        final Location chestLocation;
        final String itemId;
        boolean guardsSpawned = false;

        ShrineRecord(Location loc, String itemId) {
            this.chestLocation = loc;
            this.itemId = itemId;
        }
    }
}
