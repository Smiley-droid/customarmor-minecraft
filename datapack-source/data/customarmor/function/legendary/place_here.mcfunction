data modify storage customarmor:legendary active set value 1b
execute store result storage customarmor:legendary cx int 1 run data get entity @s Pos[0] 1
execute store result storage customarmor:legendary cy int 1 run data get entity @s Pos[1] 1
execute store result storage customarmor:legendary cz int 1 run data get entity @s Pos[2] 1

# Petit sanctuaire discret : socle 3x3, coffre surélevé, lanternes aux coins
fill ~-1 ~ ~-1 ~1 ~ ~1 minecraft:polished_blackstone
setblock ~ ~1 ~ minecraft:chain
setblock ~ ~2 ~ minecraft:chest
loot insert ~ ~2 ~ loot customarmor:legendary_pool
setblock ~-1 ~1 ~-1 minecraft:soul_lantern
setblock ~1 ~1 ~-1 minecraft:soul_lantern
setblock ~-1 ~1 ~1 minecraft:soul_lantern
setblock ~1 ~1 ~1 minecraft:soul_lantern

tag @s add customarmor_shrine_marker

function customarmor:legendary/announce with storage customarmor:legendary
