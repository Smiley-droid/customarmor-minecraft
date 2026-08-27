# Compte le nombre de joueurs connectés
scoreboard players set #legendary_count customarmor_rng 0
execute as @a run scoreboard players add #legendary_count customarmor_rng 1

# Spawn garanti (pas de hasard) si : personne n'a déjà de relique en circulation, ET 2+ joueurs co
execute unless data storage customarmor:legendary {active:1b} if score #legendary_count customarmor_rng matches 2.. run function customarmor:legendary/do_spawn

schedule function customarmor:legendary/hourly_check 3600s replace
