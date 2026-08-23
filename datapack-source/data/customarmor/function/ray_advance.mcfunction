scoreboard players add @s customarmor_dist 1

# Portée max ~6 blocs (30 pas de 0.2 bloc)
execute if score @s customarmor_dist matches ..30 run function customarmor:ray_move
execute if score @s customarmor_dist matches 31.. run function customarmor:ray_cleanup
