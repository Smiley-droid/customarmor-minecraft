package com.customarmor.plugin;

import org.bukkit.Color;
import org.bukkit.Material;
import org.bukkit.NamespacedKey;
import org.bukkit.enchantments.Enchantment;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;
import org.bukkit.inventory.meta.LeatherArmorMeta;
import org.bukkit.persistence.PersistentDataType;

import java.util.List;
import java.util.Random;

/**
 * Cree les 18 reliques legendaires possibles. Chaque item est marque avec une
 * cle PersistentDataContainer "customarmor:legendary_id" identifiant son type,
 * utilisee pour le comptage de circulation et la detection de casse.
 */
public class LegendaryItemFactory {

    public static final String[] ITEM_IDS = {
            "sword_neant", "sword_zeus", "pickaxe_divine", "pickaxe_omni",
            "axe_bucheron", "bow_vent", "helmet_poseidon", "helmet_luffy",
            "boots_maree", "gardien_casque", "gardien_plastron", "gardien_jambieres",
            "gardien_bottes", "pegasus_casque", "pegasus_plastron", "pegasus_jambieres",
            "pegasus_bottes", "cape_vent"
    };

    private final NamespacedKey idKey;
    private final Random random = new Random();

    public LegendaryItemFactory(CustomArmorPlugin plugin) {
        this.idKey = new NamespacedKey(plugin, "legendary_id");
    }

    public String randomItemId() {
        return ITEM_IDS[random.nextInt(ITEM_IDS.length)];
    }

    public String randomItemId(List<String> excludeFull) {
        List<String> available = List.of(ITEM_IDS).stream()
                .filter(id -> !excludeFull.contains(id))
                .toList();
        if (available.isEmpty()) return null;
        return available.get(random.nextInt(available.size()));
    }

    public ItemStack create(String id) {
        ItemStack item = switch (id) {
            case "sword_neant" -> named(Material.NETHERITE_SWORD, "§5Lame du Néant",
                    e(Enchantment.SHARPNESS, 7, Enchantment.FIRE_ASPECT, 2));
            case "sword_zeus" -> named(Material.NETHERITE_SWORD, "§eÉpée de Zeus",
                    e(Enchantment.SHARPNESS, 7));
            case "pickaxe_divine" -> named(Material.NETHERITE_PICKAXE, "§bForeuse Divine",
                    e(Enchantment.EFFICIENCY, 6, Enchantment.FORTUNE, 4, Enchantment.UNBREAKING, 5));
            case "pickaxe_omni" -> named(Material.NETHERITE_PICKAXE, "§cMarteau Sismique",
                    e(Enchantment.EFFICIENCY, 6, Enchantment.FORTUNE, 4, Enchantment.UNBREAKING, 5));
            case "axe_bucheron" -> named(Material.NETHERITE_AXE, "§2Hache du Bûcheron", e());
            case "bow_vent" -> named(Material.BOW, "§fArc du Vent",
                    e(Enchantment.PUNCH, 2, Enchantment.UNBREAKING, 2));
            case "helmet_poseidon" -> named(Material.NETHERITE_HELMET, "§bCasque de Poséidon",
                    e(Enchantment.RESPIRATION, 3, Enchantment.PROTECTION, 4));
            case "helmet_luffy" -> named(Material.LEATHER_HELMET, "§cCasque de Luffy",
                    e(Enchantment.THORNS, 3, Enchantment.PROTECTION, 4));
            case "boots_maree" -> named(Material.NETHERITE_BOOTS, "§bPalmes de Poséidon",
                    e(Enchantment.DEPTH_STRIDER, 3));
            case "gardien_casque" -> named(Material.NETHERITE_HELMET, "§6Casque du Gardien",
                    e(Enchantment.PROTECTION, 4, Enchantment.RESPIRATION, 3));
            case "gardien_plastron" -> named(Material.NETHERITE_CHESTPLATE, "§6Plastron du Gardien",
                    e(Enchantment.PROTECTION, 4, Enchantment.THORNS, 3));
            case "gardien_jambieres" -> named(Material.NETHERITE_LEGGINGS, "§6Jambières du Gardien",
                    e(Enchantment.PROTECTION, 4, Enchantment.SWIFT_SNEAK, 1));
            case "gardien_bottes" -> named(Material.NETHERITE_BOOTS, "§6Bottes du Gardien",
                    e(Enchantment.PROTECTION, 4, Enchantment.FEATHER_FALLING, 4, Enchantment.DEPTH_STRIDER, 3));
            case "pegasus_casque" -> dyed(Material.LEATHER_HELMET, "§fCasque de Pegasus",
                    e(Enchantment.PROTECTION, 2, Enchantment.UNBREAKING, 3), 1000);
            case "pegasus_plastron" -> dyed(Material.LEATHER_CHESTPLATE, "§fPlastron de Pegasus",
                    e(Enchantment.PROTECTION, 2, Enchantment.UNBREAKING, 3), 1000);
            case "pegasus_jambieres" -> dyed(Material.LEATHER_LEGGINGS, "§fJambières de Pegasus",
                    e(Enchantment.PROTECTION, 2, Enchantment.UNBREAKING, 3), 1000);
            case "pegasus_bottes" -> dyed(Material.LEATHER_BOOTS, "§fBottes de Pegasus",
                    e(Enchantment.PROTECTION, 2, Enchantment.FEATHER_FALLING, 4, Enchantment.UNBREAKING, 3), 1000);
            case "cape_vent" -> dyed(Material.LEATHER_CHESTPLATE, "§bCape du Vent", e(), null);
            default -> new ItemStack(Material.BARRIER);
        };

        ItemMeta meta = item.getItemMeta();
        meta.setLore(List.of("§6★ Relique légendaire ★"));
        meta.getPersistentDataContainer().set(idKey, PersistentDataType.STRING, id);
        item.setItemMeta(meta);
        return item;
    }

    public NamespacedKey getIdKey() {
        return idKey;
    }

    // ---- Utilitaires internes ----

    private ItemStack named(Material material, String name, java.util.Map<Enchantment, Integer> enchants) {
        ItemStack item = new ItemStack(material);
        ItemMeta meta = item.getItemMeta();
        meta.setDisplayName(name);
        enchants.forEach((ench, lvl) -> meta.addEnchant(ench, lvl, true));
        item.setItemMeta(meta);
        return item;
    }

    private ItemStack dyed(Material material, String name, java.util.Map<Enchantment, Integer> enchants, Integer maxDamage) {
        ItemStack item = new ItemStack(material);
        LeatherArmorMeta meta = (LeatherArmorMeta) item.getItemMeta();
        meta.setDisplayName(name);
        meta.setColor(Color.WHITE);
        enchants.forEach((ench, lvl) -> meta.addEnchant(ench, lvl, true));
        item.setItemMeta(meta);
        if (maxDamage != null) {
            item.setData(io.papermc.paper.datacomponent.DataComponentTypes.MAX_DAMAGE, maxDamage);
        }
        return item;
    }

    private java.util.Map<Enchantment, Integer> e() {
        return new java.util.HashMap<>();
    }

    private java.util.Map<Enchantment, Integer> e(Enchantment e1, int l1) {
        var m = e(); m.put(e1, l1); return m;
    }

    private java.util.Map<Enchantment, Integer> e(Enchantment e1, int l1, Enchantment e2, int l2) {
        var m = e(e1, l1); m.put(e2, l2); return m;
    }

    private java.util.Map<Enchantment, Integer> e(Enchantment e1, int l1, Enchantment e2, int l2, Enchantment e3, int l3) {
        var m = e(e1, l1, e2, l2); m.put(e3, l3); return m;
    }
}
