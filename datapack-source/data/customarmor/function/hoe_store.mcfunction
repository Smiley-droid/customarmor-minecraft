data modify storage customarmor:hoecache hx set from entity @s Pos[0]
data modify storage customarmor:hoecache hy set from entity @s Pos[1]
data modify storage customarmor:hoecache hz set from entity @s Pos[2]
data modify storage customarmor:hoecache crop set value ""
data modify storage customarmor:hoecache seed set value ""

execute if block ~ ~ ~ minecraft:wheat[age=7] run data modify storage customarmor:hoecache crop set value "minecraft:wheat"
execute if block ~ ~ ~ minecraft:wheat[age=7] run data modify storage customarmor:hoecache seed set value "minecraft:wheat_seeds"

execute if block ~ ~ ~ minecraft:carrots[age=7] run data modify storage customarmor:hoecache crop set value "minecraft:carrots"
execute if block ~ ~ ~ minecraft:carrots[age=7] run data modify storage customarmor:hoecache seed set value "minecraft:carrot"

execute if block ~ ~ ~ minecraft:potatoes[age=7] run data modify storage customarmor:hoecache crop set value "minecraft:potatoes"
execute if block ~ ~ ~ minecraft:potatoes[age=7] run data modify storage customarmor:hoecache seed set value "minecraft:potato"

execute if block ~ ~ ~ minecraft:beetroots[age=3] run data modify storage customarmor:hoecache crop set value "minecraft:beetroots"
execute if block ~ ~ ~ minecraft:beetroots[age=3] run data modify storage customarmor:hoecache seed set value "minecraft:beetroot_seeds"

execute if block ~ ~ ~ minecraft:nether_wart[age=3] run data modify storage customarmor:hoecache crop set value "minecraft:nether_wart"
execute if block ~ ~ ~ minecraft:nether_wart[age=3] run data modify storage customarmor:hoecache seed set value "minecraft:nether_wart"
