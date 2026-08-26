$execute store result score #hoe customarmor_rng run clear @s $(seed) 1
execute if score #hoe customarmor_rng matches 1 run function customarmor:hoe_do_place with storage customarmor:hoecache
