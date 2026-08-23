# Exécuté par le marker juste après avoir été invoqué.
scoreboard players set @s customarmor_dist 0

# On enregistre l'angle de visée (yaw/pitch) x100 pour pouvoir comparer avec des entiers
execute store result score @s customarmor_yaw run data get entity @s Rotation[0] 100
execute store result score @s customarmor_pitch run data get entity @s Rotation[1] 100

function customarmor:ray_tick
