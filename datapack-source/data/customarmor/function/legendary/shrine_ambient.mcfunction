execute as @e[tag=customarmor_shrine_marker] at @s run particle minecraft:end_rod ~ ~2.5 ~ 0.3 0.3 0.3 0.01 2
execute as @e[tag=customarmor_shrine_marker] at @s if data block ~ ~2 ~ {Items:[]} run function customarmor:legendary/on_collected
