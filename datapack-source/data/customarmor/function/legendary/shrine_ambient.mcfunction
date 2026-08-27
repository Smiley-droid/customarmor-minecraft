execute as @e[tag=customarmor_shrine_marker] at @s run particle minecraft:end_rod ~ ~2.5 ~ 0.3 0.3 0.3 0.01 2
execute as @e[tag=customarmor_shrine_marker] at @s if data block ~ ~1 ~ {Items:[]} run function customarmor:legendary/on_collected
execute as @e[tag=customarmor_shrine_marker,tag=!customarmor_shrine_triggered] at @s if entity @a[distance=..15] run function customarmor:legendary/spawn_guards
