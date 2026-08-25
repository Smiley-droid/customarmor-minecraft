# Touche tous les joueurs dans un rayon de 5 blocs, y compris toi-même (risque assumé)
execute as @a[distance=0..5] at @s run function customarmor:chaos_effect

advancement revoke @s only customarmor:chaos_use
