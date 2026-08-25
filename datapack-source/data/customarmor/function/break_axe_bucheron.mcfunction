tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Hache du Bûcheron","color":"dark_green"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Hache du Bûcheron player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_axe_bucheron
