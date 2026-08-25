scoreboard players add @s customarmor_fell 1
execute if score @s customarmor_fell matches ..60 if block ~ ~ ~ #minecraft:logs run function customarmor:tree_fell_break
