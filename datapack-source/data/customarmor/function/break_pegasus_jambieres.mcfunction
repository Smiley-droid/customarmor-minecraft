tellraw @a [{"text":"[CustomArmor] ","color":"dark_red","bold":true},{"text":"Jambières de Pegasus","color":"white"},{"text":" de "},{"selector":"@s"},{"text":" vient de se casser !"}]
tellraw @a [{"text":"[customarmor-break] item=Jambières de Pegasus player=","color":"dark_gray","italic":true},{"selector":"@s","color":"dark_gray","italic":true}]
advancement revoke @s only customarmor:break_pegasus_jambieres
