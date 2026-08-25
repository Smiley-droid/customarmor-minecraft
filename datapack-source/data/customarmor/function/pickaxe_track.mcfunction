# Suit en continu le bloc visé par le joueur tant qu'il tient la pioche 3x3.
# Ça évite le bug où le raycast, lancé APRÈS que le bloc soit cassé, traverse
# le trou et vise un bloc complètement différent (mur fin, bloc isolé, etc).
execute at @s anchored eyes rotated as @s run summon minecraft:marker ~ ~ ~ {Tags:["customarmor_ray"]}
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] run scoreboard players set @s customarmor_mode 2
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] at @s run function customarmor:ray_init
