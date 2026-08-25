effect give @s minecraft:nausea 8 0 true
effect give @s minecraft:blindness 3 0 true

# Mélange la hotbar par échange de paires (0<->4, 1<->5, 2<->3),
# en utilisant un slot d'enderchest comme case temporaire (n'affecte pas la main).
item replace entity @s enderchest.0 from entity @s hotbar.0
item replace entity @s hotbar.0 from entity @s hotbar.4
item replace entity @s hotbar.4 from entity @s enderchest.0

item replace entity @s enderchest.0 from entity @s hotbar.1
item replace entity @s hotbar.1 from entity @s hotbar.5
item replace entity @s hotbar.5 from entity @s enderchest.0

item replace entity @s enderchest.0 from entity @s hotbar.2
item replace entity @s hotbar.2 from entity @s hotbar.3
item replace entity @s hotbar.3 from entity @s enderchest.0
