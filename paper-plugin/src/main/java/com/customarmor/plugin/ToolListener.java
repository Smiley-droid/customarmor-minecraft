package com.customarmor.plugin;

import org.bukkit.Bukkit;
import org.bukkit.Material;
import org.bukkit.NamespacedKey;
import org.bukkit.block.Block;
import org.bukkit.block.data.Ageable;
import org.bukkit.enchantments.Enchantment;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.block.BlockBreakEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;
import org.bukkit.persistence.PersistentDataType;
import org.bukkit.util.Vector;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.HashSet;
import java.util.Set;

public class ToolListener implements Listener {

    private final CustomArmorPlugin plugin;

    private final NamespacedKey AXE_KEY;
    private final NamespacedKey PICKAXE_KEY;
    private final NamespacedKey HOE_KEY;

    private static final int MAX_TREE_BLOCKS = 80;

    public ToolListener(CustomArmorPlugin plugin) {
        this.plugin = plugin;
        this.AXE_KEY = new NamespacedKey(plugin, "axe_bucheron");
        this.PICKAXE_KEY = new NamespacedKey(plugin, "pickaxe_omni");
        this.HOE_KEY = new NamespacedKey(plugin, "hoe_fertile");
    }

    // ==================== Création des items (appelée par les commandes) ====================

    public ItemStack createAxeBucheron() {
        ItemStack item = new ItemStack(Material.NETHERITE_AXE);
        ItemMeta meta = item.getItemMeta();
        meta.setDisplayName("§2Hache du Bûcheron");
        meta.setLore(java.util.List.of("§7Abat un arbre entier d'un coup", "§8Mais frappe moins fort au combat"));
        meta.getPersistentDataContainer().set(AXE_KEY, PersistentDataType.BYTE, (byte) 1);
        meta.addAttributeModifier(
                org.bukkit.attribute.Attribute.ATTACK_DAMAGE,
                new org.bukkit.attribute.AttributeModifier(
                        new NamespacedKey(plugin, "bucheron_malus"),
                        -4.0,
                        org.bukkit.attribute.AttributeModifier.Operation.ADD_NUMBER,
                        org.bukkit.inventory.EquipmentSlotGroup.HAND
                )
        );
        item.setItemMeta(meta);
        return item;
    }

    public ItemStack createPickaxeOmni() {
        ItemStack item = new ItemStack(Material.NETHERITE_PICKAXE);
        ItemMeta meta = item.getItemMeta();
        meta.setDisplayName("§cMarteau Sismique");
        meta.setLore(java.util.List.of("§7Fait trembler la roche sur 3x3"));
        meta.addEnchant(Enchantment.EFFICIENCY, 6, true);
        meta.addEnchant(Enchantment.FORTUNE, 4, true);
        meta.addEnchant(Enchantment.UNBREAKING, 5, true);
        meta.getPersistentDataContainer().set(PICKAXE_KEY, PersistentDataType.BYTE, (byte) 1);
        item.setItemMeta(meta);
        return item;
    }

    public ItemStack createHoeFertile() {
        ItemStack item = new ItemStack(Material.NETHERITE_HOE);
        ItemMeta meta = item.getItemMeta();
        meta.setDisplayName("§aHoue Fertile");
        meta.setLore(java.util.List.of("§7Replante automatiquement ce que tu récoltes", "§8Consomme la graine correspondante dans ton inventaire"));
        meta.getPersistentDataContainer().set(HOE_KEY, PersistentDataType.BYTE, (byte) 1);
        item.setItemMeta(meta);
        return item;
    }

    // ==================== Gestion des évènements ====================

    @EventHandler(ignoreCancelled = true)
    public void onBlockBreak(BlockBreakEvent event) {
        Player player = event.getPlayer();
        ItemStack item = player.getInventory().getItemInMainHand();
        if (item.getItemMeta() == null) return;

        var pdc = item.getItemMeta().getPersistentDataContainer();

        if (pdc.has(AXE_KEY, PersistentDataType.BYTE)) {
            handleTreeFelling(event, player);
        } else if (pdc.has(PICKAXE_KEY, PersistentDataType.BYTE)) {
            handle3x3Mining(event, player, item);
        } else if (pdc.has(HOE_KEY, PersistentDataType.BYTE)) {
            handleAutoReplant(event, player);
        }
    }

    // ==================== Hache du Bûcheron : abat l'arbre entier ====================

    private void handleTreeFelling(BlockBreakEvent event, Player player) {
        Block origin = event.getBlock();
        if (!origin.getType().name().endsWith("_LOG") && !origin.getType().name().endsWith("_STEM")) {
            return; // pas du bois, comportement normal
        }

        Set<Block> visited = new HashSet<>();
        Deque<Block> queue = new ArrayDeque<>();
        queue.add(origin);
        visited.add(origin);

        int broken = 0;
        while (!queue.isEmpty() && broken < MAX_TREE_BLOCKS) {
            Block current = queue.poll();
            boolean isLog = current.getType().name().endsWith("_LOG") || current.getType().name().endsWith("_STEM");
            if (!isLog) continue;

            if (!current.equals(origin)) {
                current.breakNaturally(player.getInventory().getItemInMainHand());
            }
            broken++;

            for (int dx = -1; dx <= 1; dx++) {
                for (int dy = -1; dy <= 1; dy++) {
                    for (int dz = -1; dz <= 1; dz++) {
                        if (dx == 0 && dy == 0 && dz == 0) continue;
                        Block neighbor = current.getRelative(dx, dy, dz);
                        if (!visited.contains(neighbor)
                                && (neighbor.getType().name().endsWith("_LOG") || neighbor.getType().name().endsWith("_STEM"))) {
                            visited.add(neighbor);
                            queue.add(neighbor);
                        }
                    }
                }
            }
        }
        // Le bloc d'origine est cassé normalement par l'évènement vanilla (on ne l'annule pas).
    }

    // ==================== Marteau Sismique : mine un carré 3x3 ====================

    private void handle3x3Mining(BlockBreakEvent event, Player player, ItemStack tool) {
        Block origin = event.getBlock();
        Vector dir = player.getEyeLocation().getDirection();

        double ax = Math.abs(dir.getX());
        double ay = Math.abs(dir.getY());
        double az = Math.abs(dir.getZ());

        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                if (i == 0 && j == 0) continue; // le bloc d'origine est déjà cassé par l'évènement
                Block target;
                if (ay >= ax && ay >= az) {
                    // Le joueur vise plutôt haut/bas : plan horizontal (X/Z)
                    target = origin.getRelative(i, 0, j);
                } else if (ax >= az) {
                    // Visée plutôt Est/Ouest : plan Y/Z
                    target = origin.getRelative(0, i, j);
                } else {
                    // Visée plutôt Nord/Sud : plan X/Y
                    target = origin.getRelative(i, j, 0);
                }
                if (target.getType() != Material.AIR && target.getType() != Material.BEDROCK) {
                    target.breakNaturally(tool);
                }
            }
        }
    }

    // ==================== Houe Fertile : replante automatiquement ====================

    private void handleAutoReplant(BlockBreakEvent event, Player player) {
        Block block = event.getBlock();
        if (!(block.getBlockData() instanceof Ageable ageable)) return;
        if (ageable.getAge() != ageable.getMaximumAge()) return; // pas encore mûre

        Material cropType = block.getType();
        Material seedType = seedFor(cropType);
        if (seedType == null) return;

        if (!player.getInventory().containsAtLeast(new ItemStack(seedType), 1)) {
            return; // pas de graine, pas de replantage
        }

        player.getInventory().removeItem(new ItemStack(seedType, 1));

        // On laisse le bloc casser normalement (drops), puis on replante au tick suivant.
        Bukkit.getScheduler().runTask(plugin, () -> {
            block.setType(cropType);
            if (block.getBlockData() instanceof Ageable newAgeable) {
                newAgeable.setAge(0);
                block.setBlockData(newAgeable);
            }
        });
    }

    private Material seedFor(Material crop) {
        return switch (crop) {
            case WHEAT -> Material.WHEAT_SEEDS;
            case CARROTS -> Material.CARROT;
            case POTATOES -> Material.POTATO;
            case BEETROOTS -> Material.BEETROOT_SEEDS;
            case NETHER_WART -> Material.NETHER_WART;
            default -> null;
        };
    }
}
