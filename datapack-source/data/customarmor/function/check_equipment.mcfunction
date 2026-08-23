# Ne tourne QUE quand un item bouge dans l'inventaire (équipement, enchantement, craft...)
# au lieu de scanner en permanence chaque tick - beaucoup plus léger pour le serveur.
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{}}] run item modify entity @s weapon.mainhand customarmor:strip_mending
execute if items entity @s weapon.offhand *[custom_data~{customarmor:{}}] run item modify entity @s weapon.offhand customarmor:strip_mending
execute if items entity @s armor.head *[custom_data~{customarmor:{}}] run item modify entity @s armor.head customarmor:strip_mending
execute if items entity @s armor.chest *[custom_data~{customarmor:{}}] run item modify entity @s armor.chest customarmor:strip_mending
execute if items entity @s armor.legs *[custom_data~{customarmor:{}}] run item modify entity @s armor.legs customarmor:strip_mending
execute if items entity @s armor.feet *[custom_data~{customarmor:{}}] run item modify entity @s armor.feet customarmor:strip_mending

advancement revoke @s only customarmor:inventory_check
