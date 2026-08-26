data modify storage customarmor:legendary active set value 1b

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

tellraw @a {"text":"✦ Une relique légendaire est apparue quelque part dans le monde... ✦","color":"gold","bold":true}
