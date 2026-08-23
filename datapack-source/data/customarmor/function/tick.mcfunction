execute as @a if items entity @s armor.head *[custom_data~{customarmor:{gardien:"casque"}}] if items entity @s armor.chest *[custom_data~{customarmor:{gardien:"plastron"}}] if items entity @s armor.legs *[custom_data~{customarmor:{gardien:"jambieres"}}] if items entity @s armor.feet *[custom_data~{customarmor:{gardien:"bottes"}}] run function customarmor:armor_effect

execute as @a at @s if block ~ ~ ~ water if items entity @s armor.feet *[custom_data~{customarmor:{boots:"maree"}}] run effect give @s minecraft:dolphins_grace 2 4 true

# Respiration infinie sous l'eau avec le Casque de Luffy (léger, ne coûte rien si personne n'en porte)
execute as @a if items entity @s armor.head *[custom_data~{customarmor:{helmet:"poseidon"}}] run effect give @s minecraft:water_breathing 2 0 true

# Set complet Pegasus = planer (chute lente + un peu de vitesse en l'air)
execute as @a if items entity @s armor.head *[custom_data~{customarmor:{pegasus:"casque"}}] if items entity @s armor.chest *[custom_data~{customarmor:{pegasus:"plastron"}}] if items entity @s armor.legs *[custom_data~{customarmor:{pegasus:"jambieres"}}] if items entity @s armor.feet *[custom_data~{customarmor:{pegasus:"bottes"}}] run function customarmor:pegasus_effect
