# Suivi continu de la pioche 3x3 (mémorise le bloc visé avant qu'il casse)
execute as @a if items entity @s weapon.mainhand *[custom_data~{customarmor:{pickaxe:"omni"}}] run function customarmor:pickaxe_track

# Suivi continu de la Houe Fertile (mémorise la culture visée avant récolte)
execute as @a if items entity @s weapon.mainhand *[custom_data~{customarmor:{hoe:"fertile"}}] run function customarmor:hoe_track

execute as @a if items entity @s armor.head *[custom_data~{customarmor:{gardien:"casque"}}] if items entity @s armor.chest *[custom_data~{customarmor:{gardien:"plastron"}}] if items entity @s armor.legs *[custom_data~{customarmor:{gardien:"jambieres"}}] if items entity @s armor.feet *[custom_data~{customarmor:{gardien:"bottes"}}] run function customarmor:armor_effect

execute as @a at @s if block ~ ~ ~ water if items entity @s armor.feet *[custom_data~{customarmor:{boots:"maree"}}] run effect give @s minecraft:dolphins_grace 2 4 true

# Respiration infinie sous l'eau avec le Casque de Luffy (léger, ne coûte rien si personne n'en porte)
execute as @a if items entity @s armor.head *[custom_data~{customarmor:{helmet:"poseidon"}}] run effect give @s minecraft:water_breathing 2 0 true

# Set complet Pegasus = planer (chute lente + un peu de vitesse en l'air)
execute as @a if items entity @s armor.head *[custom_data~{customarmor:{pegasus:"casque"}}] if items entity @s armor.chest *[custom_data~{customarmor:{pegasus:"plastron"}}] if items entity @s armor.legs *[custom_data~{customarmor:{pegasus:"jambieres"}}] if items entity @s armor.feet *[custom_data~{customarmor:{pegasus:"bottes"}}] run function customarmor:pegasus_effect

# Amulette du Berserker : +dégâts si vie basse (8 PV = 4 coeurs ou moins)
execute as @a if items entity @s weapon.offhand *[custom_data~{customarmor:{amulet:"berserker"}}] if score @s customarmor_health matches 0..8 run effect give @s minecraft:strength 2 1 true

# Cape du Vent : petit boost de saut + chute plus douce (double-saut non simulable en vanilla)
execute as @a if items entity @s armor.chest *[custom_data~{customarmor:{cape:"vent"}}] run effect give @s minecraft:jump_boost 2 1 true

# Sanctuaires de reliques légendaires : particules d'ambiance + détection de récupération
function customarmor:legendary/shrine_ambient

# Particules sur les items customs tenus/portés
function customarmor:particles_tick
