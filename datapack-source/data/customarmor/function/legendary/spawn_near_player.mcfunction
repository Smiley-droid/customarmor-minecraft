# Magnitude aléatoire entre 500 et 1000 sur chaque axe
execute store result score #legendary customarmor_dx run random value 500..1000
execute store result score #legendary customarmor_dz run random value 500..1000

# Signe aléatoire (0 ou 1) pour chaque axe, pour couvrir les 4 directions autour du joueur
scoreboard players operation #legendary_signx customarmor_rng = #legendary customarmor_rng
execute store result score #legendary_signx customarmor_rng run random value 0..1
execute if score #legendary_signx customarmor_rng matches 0 run scoreboard players operation #legendary customarmor_dx *= #neg1 customarmor_const

execute store result score #legendary_signz customarmor_rng run random value 0..1
execute if score #legendary_signz customarmor_rng matches 0 run scoreboard players operation #legendary customarmor_dz *= #neg1 customarmor_const

execute store result storage customarmor:legendary dx int 1 run scoreboard players get #legendary customarmor_dx
execute store result storage customarmor:legendary dz int 1 run scoreboard players get #legendary customarmor_dz

function customarmor:legendary/goto_spawn with storage customarmor:legendary
