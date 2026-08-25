# Déclenché quand la Hache du Bûcheron coupe une bûche.
execute at @s anchored eyes rotated as @s run summon minecraft:marker ~ ~ ~ {Tags:["customarmor_ray"]}
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] run scoreboard players set @s customarmor_mode 1
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] at @s run function customarmor:ray_init

advancement revoke @s only customarmor:axe_hit
