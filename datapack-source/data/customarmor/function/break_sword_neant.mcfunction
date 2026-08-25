tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Lame du Néant","color":"dark_purple"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Lame du Néant player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_sword_neant
