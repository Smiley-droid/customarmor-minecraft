# Touche les joueurs entre 1 et 5 blocs (exclut l'utilisateur lui-même)
execute as @a[distance=1..5] at @s run function customarmor:chaos_effect

advancement revoke @s only customarmor:chaos_use
