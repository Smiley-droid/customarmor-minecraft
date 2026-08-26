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

# Démarre la boucle de vérification périodique (toutes les 20s) si pas déjà lancée
schedule function customarmor:legendary/tick_check 20s replace

tellraw @a {"text":"[CustomArmor] Datapack chargé avec succès !","color":"green"}
