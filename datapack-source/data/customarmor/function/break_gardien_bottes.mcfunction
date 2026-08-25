tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Bottes du Gardien","color":"gold"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Bottes du Gardien player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_gardien_bottes
