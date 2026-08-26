# Commande de dépannage : force la remise à zéro du système de reliques,
# au cas où le statut serait resté bloqué sur "en circulation".
data modify storage customarmor:legendary active set value 0b
kill @e[tag=customarmor_shrine_marker]
tellraw @s {"text":"Système de reliques réinitialisé.","color":"green"}
