# yaw : 0=sud, 90=ouest, 180/-180=nord, -90=est
execute if score @s customarmor_yaw matches -4499..4499 run function customarmor:face_south
execute if score @s customarmor_yaw matches 4500..13500 run function customarmor:face_west
execute if score @s customarmor_yaw matches -13500..-4500 run function customarmor:face_east
execute unless score @s customarmor_yaw matches -13499..13499 run function customarmor:face_north
