execute if score @s customarmor_pitch matches -9000..-4500 run data modify storage customarmor:cache face set value "up"
execute if score @s customarmor_pitch matches 4500..9000 run data modify storage customarmor:cache face set value "down"
execute if score @s customarmor_pitch matches -4499..4499 run function customarmor:pickaxe_facecalc_yaw
