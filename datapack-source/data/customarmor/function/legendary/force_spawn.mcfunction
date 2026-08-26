# Commande de test : force un spawn immédiatement, sans probabilité ni délai.
# Respecte quand même la règle "une seule relique en circulation à la fois".
execute unless data storage customarmor:legendary {active:1b} run function customarmor:legendary/do_spawn
execute if data storage customarmor:legendary {active:1b} run tellraw @s {"text":"Une relique est déjà en circulation quelque part dans le monde.","color":"red"}
