# Ne fait rien si une relique légendaire existe déjà quelque part dans le monde
execute unless data storage customarmor:legendary {active:1b} run function customarmor:legendary/roll
