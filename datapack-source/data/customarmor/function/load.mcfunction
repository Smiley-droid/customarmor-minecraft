scoreboard objectives add customarmor_dist dummy
scoreboard objectives add customarmor_yaw dummy
scoreboard objectives add customarmor_pitch dummy
scoreboard objectives add customarmor_mode dummy
scoreboard objectives add customarmor_fell dummy
scoreboard objectives add customarmor_health health

# Initialisation du cache de ciblage de la pioche 3x3
data modify storage customarmor:cache hx set value 0.0d
data modify storage customarmor:cache hy set value 0.0d
data modify storage customarmor:cache hz set value 0.0d
data modify storage customarmor:cache face set value "north"

tellraw @a {"text":"[CustomArmor] Datapack chargé avec succès !","color":"green"}
