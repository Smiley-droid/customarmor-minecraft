# Déclenché quand la Foreuse Divine mine un bloc.
# On lance un marker invisible depuis les yeux du joueur, dans sa direction de visée,
# qui va avancer pas à pas jusqu'à retrouver le bloc miné.
execute at @s anchored eyes rotated as @s run summon minecraft:marker ~ ~ ~ {Tags:["customarmor_ray"]}
execute as @e[tag=customarmor_ray,limit=1,sort=nearest] at @s run function customarmor:ray_init

# On réarme la détection pour le prochain coup de pioche
advancement revoke @s only customarmor:pickaxe_hit
