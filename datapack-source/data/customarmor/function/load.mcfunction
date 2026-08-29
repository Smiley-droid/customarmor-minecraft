scoreboard objectives add customarmor_dist dummy
scoreboard objectives add customarmor_yaw dummy
scoreboard objectives add customarmor_pitch dummy
scoreboard objectives add customarmor_mode dummy
scoreboard objectives add customarmor_fell dummy
scoreboard objectives add customarmor_health health
scoreboard objectives add customarmor_rng dummy
scoreboard objectives add customarmor_const dummy
scoreboard objectives add customarmor_steak_lock dummy
scoreboard players set #neg1 customarmor_const -1

tellraw @a {"text":"[CustomArmor] Datapack chargé avec succès !","color":"green"}
