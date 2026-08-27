data modify storage customarmor:legendary active set value 1b
execute store result storage customarmor:legendary cx int 1 run data get entity @s Pos[0] 1
execute store result storage customarmor:legendary cy int 1 run data get entity @s Pos[1] 1
execute store result storage customarmor:legendary cz int 1 run data get entity @s Pos[2] 1

# Petit sanctuaire discret : socle 3x3, coffre, lanternes aux coins
fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:polished_blackstone
setblock ~ ~1 ~ minecraft:chest
loot insert ~ ~1 ~ loot customarmor:legendary_pool
setblock ~-1 ~1 ~-1 minecraft:soul_lantern
setblock ~1 ~1 ~-1 minecraft:soul_lantern
setblock ~-1 ~1 ~1 minecraft:soul_lantern
setblock ~1 ~1 ~1 minecraft:soul_lantern

tag @s add customarmor_shrine_marker

# Coordonnées volontairement imprécises annoncées dans le chat (décalage 200-300 blocs)
execute store result score #legendary_cx customarmor_rng run data get storage customarmor:legendary cx
execute store result score #legendary_cz customarmor_rng run data get storage customarmor:legendary cz

execute store result score #legendary customarmor_dx run random value 200..300
execute store result score #legendary customarmor_dz run random value 200..300
execute store result score #legendary_signx customarmor_rng run random value 0..1
execute if score #legendary_signx customarmor_rng matches 0 run scoreboard players operation #legendary customarmor_dx *= #neg1 customarmor_const
execute store result score #legendary_signz customarmor_rng run random value 0..1
execute if score #legendary_signz customarmor_rng matches 0 run scoreboard players operation #legendary customarmor_dz *= #neg1 customarmor_const

scoreboard players operation #legendary_cx customarmor_rng += #legendary customarmor_dx
scoreboard players operation #legendary_cz customarmor_rng += #legendary customarmor_dz

execute store result storage customarmor:legendary rx int 1 run scoreboard players get #legendary_cx customarmor_rng
execute store result storage customarmor:legendary rz int 1 run scoreboard players get #legendary_cz customarmor_rng

function customarmor:legendary/announce with storage customarmor:legendary
