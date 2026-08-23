# Le casque a déjà Épines III pour un renvoi de dégâts passif vanilla.
# En plus : dégâts bonus infligés à l'attaquant le plus proche.
execute as @e[type=!player,distance=..4,sort=nearest,limit=1] at @s run damage @s 4 minecraft:magic

advancement revoke @s only customarmor:luffy_hit
