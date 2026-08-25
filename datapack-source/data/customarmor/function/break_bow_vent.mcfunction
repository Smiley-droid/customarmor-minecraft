tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Arc du Vent","color":"white"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Arc du Vent player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_bow_vent
