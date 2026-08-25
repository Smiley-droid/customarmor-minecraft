tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Épée de Zeus","color":"yellow"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Épée de Zeus player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_sword_zeus
