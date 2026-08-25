execute if score @s customarmor_yaw matches -4499..4499 run data modify storage customarmor:cache face set value "south"
execute if score @s customarmor_yaw matches 4500..13500 run data modify storage customarmor:cache face set value "west"
execute if score @s customarmor_yaw matches -13500..-4500 run data modify storage customarmor:cache face set value "east"
execute unless score @s customarmor_yaw matches -13499..13499 run data modify storage customarmor:cache face set value "north"
