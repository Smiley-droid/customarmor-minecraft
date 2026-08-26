# 180 vérifications de 20s = 1 heure. Si ce délai est dépassé, on force un spawn
# (garantie : au moins une relique par heure quand 2+ joueurs sont connectés).
execute if score #legendary customarmor_elapsed matches 180.. run function customarmor:legendary/force_trigger
execute if score #legendary customarmor_elapsed matches ..179 run function customarmor:legendary/roll
