# Buff pour le joueur qui frappe
effect give @s minecraft:speed 3 0 true
particle minecraft:soul_fire_flame ~ ~1 ~ 0.3 0.3 0.3 0.01 15

# Effet infligé à l'ennemi le plus proche touché (feu + faiblesse)
execute at @s run effect give @e[type=!player,distance=..3,sort=nearest,limit=1] minecraft:weakness 5 1 true
execute at @s run effect give @e[type=!player,distance=..3,sort=nearest,limit=1] minecraft:wither 3 0 true

# Reset de l'advancement pour pouvoir la redéclencher
advancement revoke @s only customarmor:on_hit
