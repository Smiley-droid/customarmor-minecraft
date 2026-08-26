execute store result score #legendary customarmor_rng run random value 1..100
execute if score #legendary customarmor_rng matches 1..3 run function customarmor:legendary/trigger_random
