tag @s add customarmor_shrine_triggered
tellraw @a {"text":"⚠ Des morts-vivants gardent la relique ! ⚠","color":"red","bold":true}

summon minecraft:zombie ~2 ~ ~2 {CustomName:'{"text":"Gardien de la relique","color":"red"}',ArmorItems:[{},{},{},{id:"minecraft:iron_helmet",Count:1b}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}]}
summon minecraft:zombie ~-2 ~ ~-2 {CustomName:'{"text":"Gardien de la relique","color":"red"}'}
summon minecraft:zombie ~2 ~ ~-2 {CustomName:'{"text":"Gardien de la relique","color":"red"}'}
summon minecraft:zombie ~-2 ~ ~2 {CustomName:'{"text":"Gardien de la relique","color":"red"}'}
