tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Cape du Vent","color":"aqua"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Cape du Vent player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_cape_vent
