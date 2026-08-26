# Suit en continu le bloc visé par le joueur tant qu'il tient la Houe Fertile,
# pour connaître le type de culture AVANT qu'elle soit récoltée.
execute at @s anchored eyes rotated as @s run summon minecraft:marker ~ ~ ~ {Tags:["customarmor_ray"]}
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] run scoreboard players set @s customarmor_mode 3
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] at @s run function customarmor:ray_init
