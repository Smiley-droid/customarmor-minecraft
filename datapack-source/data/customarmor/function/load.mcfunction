scoreboard objectives add customarmor_dist dummy
scoreboard objectives add customarmor_yaw dummy
scoreboard objectives add customarmor_pitch dummy
scoreboard objectives add customarmor_mode dummy
scoreboard objectives add customarmor_fell dummy
scoreboard objectives add customarmor_health health
scoreboard objectives add customarmor_rng dummy
scoreboard objectives add customarmor_const dummy
scoreboard players set #neg1 customarmor_const -1

# Initialisation du cache de ciblage de la pioche 3x3
data modify storage customarmor:cache hx set value 0.0d
data modify storage customarmor:cache hy set value 0.0d
data modify storage customarmor:cache hz set value 0.0d
data modify storage customarmor:cache face set value "north"

# Initialisation du système de relique légendaire
execute unless data storage customarmor:legendary active run data modify storage customarmor:legendary active set value 0b

# Boucle stricte : une vérification toutes les heures pile, spawn garanti si conditions réunies
schedule function customarmor:legendary/hourly_check 1h replace

tellraw @a {"text":"[CustomArmor] Datapack chargé avec succès !","color":"green"}
