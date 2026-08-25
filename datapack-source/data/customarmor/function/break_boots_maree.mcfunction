tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Palmes de Poséidon","color":"aqua"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Palmes de Poséidon player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_boots_maree
