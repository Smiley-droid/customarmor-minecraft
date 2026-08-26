scoreboard players add #legendary customarmor_elapsed 1

# Compte le nombre de joueurs connectés
scoreboard players set #legendary_count customarmor_rng 0
execute as @a run scoreboard players add #legendary_count customarmor_rng 1

# Ne fait rien si une relique est déjà en circulation, ou s'il y a moins de 2 joueurs
execute unless data storage customarmor:legendary {active:1b} if score #legendary_count customarmor_rng matches 2.. run function customarmor:legendary/spawn_gate
