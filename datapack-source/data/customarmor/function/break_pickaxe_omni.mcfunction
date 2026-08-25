tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Marteau Sismique","color":"red"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Marteau Sismique player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_pickaxe_omni
