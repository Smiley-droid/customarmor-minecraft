execute at @s run particle minecraft:electric_spark ~ ~1 ~ 0.3 0.3 0.3 0.01 20
execute if entity @e[type=!player,distance=..3,sort=nearest,limit=1] at @e[type=!player,distance=..3,sort=nearest,limit=1] run summon minecraft:lightning_bolt ~ ~ ~

advancement revoke @s only customarmor:zeus_hit
