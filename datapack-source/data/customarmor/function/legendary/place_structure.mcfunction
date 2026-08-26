summon minecraft:marker ~ ~ ~ {Tags:["customarmor_legendary_spot"]}
execute as @e[tag=customarmor_legendary_spot,limit=1,sort=nearest] at @s run function customarmor:legendary/place_here
