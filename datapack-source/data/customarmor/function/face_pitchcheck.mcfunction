# pitch proche de -90 (x100 = -9000) = regarde vers le haut
execute if score @s customarmor_pitch matches -9000..-4500 run function customarmor:face_up
# pitch proche de 90 (x100 = 9000) = regarde vers le bas
execute if score @s customarmor_pitch matches 4500..9000 run function customarmor:face_down
# sinon, visée à l'horizontale : on regarde le yaw
execute if score @s customarmor_pitch matches -4499..4499 run function customarmor:face_yawcheck
