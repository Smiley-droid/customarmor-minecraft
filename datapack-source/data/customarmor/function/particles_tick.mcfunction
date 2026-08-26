# --- Armes en main ---
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{sword:"neant"}}] run particle minecraft:witch ~ ~1.2 ~ 0.15 0.15 0.15 0 1
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{sword:"zeus"}}] run particle minecraft:electric_spark ~ ~1.2 ~ 0.15 0.15 0.15 0 1
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{pickaxe:"divine"}}] run particle minecraft:end_rod ~ ~1.2 ~ 0.1 0.1 0.1 0 1
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{pickaxe:"omni"}}] run particle minecraft:crit ~ ~1.2 ~ 0.15 0.15 0.15 0 1
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{axe:"bucheron"}}] run particle minecraft:composter ~ ~1.2 ~ 0.15 0.15 0.15 0 1
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{bow:"vent"}}] run particle minecraft:cloud ~ ~1.2 ~ 0.15 0.15 0.15 0 1
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{hoe:"fertile"}}] run particle minecraft:happy_villager ~ ~1.2 ~ 0.15 0.15 0.15 0 1

# --- Casques portés ---
execute as @a at @s if items entity @s armor.head *[custom_data~{customarmor:{helmet:"poseidon"}}] run particle minecraft:dripping_water ~ ~2.2 ~ 0.15 0.05 0.15 0 1
execute as @a at @s if items entity @s armor.head *[custom_data~{customarmor:{helmet:"luffy"}}] run particle minecraft:flame ~ ~2.2 ~ 0.1 0.05 0.1 0 1

# --- Bottes portées ---
execute as @a at @s if items entity @s armor.feet *[custom_data~{customarmor:{boots:"maree"}}] run particle minecraft:bubble ~ ~0.2 ~ 0.2 0.05 0.2 0 1

# --- Amulette / Cape ---
execute as @a at @s if items entity @s weapon.offhand *[custom_data~{customarmor:{amulet:"berserker"}}] run particle minecraft:soul_fire_flame ~ ~1 ~ 0.2 0.3 0.2 0 1
execute as @a at @s if items entity @s armor.chest *[custom_data~{customarmor:{cape:"vent"}}] run particle minecraft:cloud ~ ~1.5 ~ 0.2 0.1 0.2 0 1

# --- Sets complets (effet plus marqué quand toutes les pièces sont réunies) ---
execute as @a at @s if items entity @s armor.head *[custom_data~{customarmor:{gardien:"casque"}}] if items entity @s armor.chest *[custom_data~{customarmor:{gardien:"plastron"}}] if items entity @s armor.legs *[custom_data~{customarmor:{gardien:"jambieres"}}] if items entity @s armor.feet *[custom_data~{customarmor:{gardien:"bottes"}}] run particle minecraft:totem_of_undying ~ ~1 ~ 0.3 0.5 0.3 0 1

execute as @a at @s if items entity @s armor.head *[custom_data~{customarmor:{pegasus:"casque"}}] if items entity @s armor.chest *[custom_data~{customarmor:{pegasus:"plastron"}}] if items entity @s armor.legs *[custom_data~{customarmor:{pegasus:"jambieres"}}] if items entity @s armor.feet *[custom_data~{customarmor:{pegasus:"bottes"}}] run particle minecraft:cloud ~ ~2 ~ 0.3 0.3 0.3 0 2

# --- Un objet légendaire brille toujours plus fort, peu importe lequel ---
execute as @a at @s if items entity @s weapon.mainhand *[custom_data~{customarmor:{legendary:1}}] run particle minecraft:end_rod ~ ~1.2 ~ 0.2 0.2 0.2 0.01 2
execute as @a at @s if items entity @s armor.head *[custom_data~{customarmor:{legendary:1}}] run particle minecraft:end_rod ~ ~2.2 ~ 0.2 0.2 0.2 0.01 2
execute as @a at @s if items entity @s armor.chest *[custom_data~{customarmor:{legendary:1}}] run particle minecraft:end_rod ~ ~1.4 ~ 0.2 0.2 0.2 0.01 2
execute as @a at @s if items entity @s armor.legs *[custom_data~{customarmor:{legendary:1}}] run particle minecraft:end_rod ~ ~0.9 ~ 0.2 0.2 0.2 0.01 2
execute as @a at @s if items entity @s armor.feet *[custom_data~{customarmor:{legendary:1}}] run particle minecraft:end_rod ~ ~0.2 ~ 0.2 0.2 0.2 0.01 2
