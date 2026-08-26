# Verrouille les enchantements de TOUS les items customs : si un joueur ajoute
# ou modifie un enchantement (table, enclume...), il est annulé au prochain
# changement d'inventaire, et l'item reprend sa liste d'enchantements d'origine.

# Main
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{sword:"neant"}}] run item modify entity @s weapon.mainhand customarmor:reset_sword_neant
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{sword:"zeus"}}] run item modify entity @s weapon.mainhand customarmor:reset_sword_zeus
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{pickaxe:"divine"}}] run item modify entity @s weapon.mainhand customarmor:reset_pickaxe_divine
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{pickaxe:"omni"}}] run item modify entity @s weapon.mainhand customarmor:reset_pickaxe_omni
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{axe:"bucheron"}}] run item modify entity @s weapon.mainhand customarmor:reset_axe_bucheron
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{bow:"vent"}}] run item modify entity @s weapon.mainhand customarmor:reset_bow_vent
execute if items entity @s weapon.mainhand *[custom_data~{customarmor:{hoe:"fertile"}}] run item modify entity @s weapon.mainhand customarmor:reset_hoe_fertile

# Main secondaire
execute if items entity @s weapon.offhand *[custom_data~{customarmor:{amulet:"berserker"}}] run item modify entity @s weapon.offhand customarmor:reset_amulette_berserker

# Casque
execute if items entity @s armor.head *[custom_data~{customarmor:{helmet:"poseidon"}}] run item modify entity @s armor.head customarmor:reset_helmet_poseidon
execute if items entity @s armor.head *[custom_data~{customarmor:{helmet:"luffy"}}] run item modify entity @s armor.head customarmor:reset_helmet_luffy
execute if items entity @s armor.head *[custom_data~{customarmor:{gardien:"casque"}}] run item modify entity @s armor.head customarmor:reset_gardien_casque
execute if items entity @s armor.head *[custom_data~{customarmor:{pegasus:"casque"}}] run item modify entity @s armor.head customarmor:reset_pegasus_casque

# Plastron
execute if items entity @s armor.chest *[custom_data~{customarmor:{gardien:"plastron"}}] run item modify entity @s armor.chest customarmor:reset_gardien_plastron
execute if items entity @s armor.chest *[custom_data~{customarmor:{pegasus:"plastron"}}] run item modify entity @s armor.chest customarmor:reset_pegasus_plastron
execute if items entity @s armor.chest *[custom_data~{customarmor:{cape:"vent"}}] run item modify entity @s armor.chest customarmor:reset_cape_vent

# Jambières
execute if items entity @s armor.legs *[custom_data~{customarmor:{gardien:"jambieres"}}] run item modify entity @s armor.legs customarmor:reset_gardien_jambieres
execute if items entity @s armor.legs *[custom_data~{customarmor:{pegasus:"jambieres"}}] run item modify entity @s armor.legs customarmor:reset_pegasus_jambieres

# Bottes
execute if items entity @s armor.feet *[custom_data~{customarmor:{boots:"maree"}}] run item modify entity @s armor.feet customarmor:reset_boots_maree
execute if items entity @s armor.feet *[custom_data~{customarmor:{gardien:"bottes"}}] run item modify entity @s armor.feet customarmor:reset_gardien_bottes
execute if items entity @s armor.feet *[custom_data~{customarmor:{pegasus:"bottes"}}] run item modify entity @s armor.feet customarmor:reset_pegasus_bottes

advancement revoke @s only customarmor:inventory_check
