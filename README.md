# CustomArmor - Minecraft (Paper 26.2)

Datapack pour un serveur entre potes. 100% vanilla côté client, aucun mod ni texture pack requis.

## Fichier prêt à l'emploi

- `customarmor.zip` → à mettre dans `world/datapacks/` sur le serveur.

## Dossier source

- `datapack-source/` : code source complet (fonctions, advancements, item_modifiers).
  Contient `build.sh` (Linux/Mac) et `build.bat` (Windows) pour regénérer le zip après modification.

## Contenu

- Épée "Lame du Néant" : feu + faiblesse à chaque coup
- Épée "Épée de Zeus" : invoque la foudre sur l'ennemi touché
- Pioche "Foreuse Divine" : stats boostées
- Pioche "Marteau Sismique" : mine en 3x3
- Hache du Bûcheron : abat un arbre entier, dégâts de combat réduits
- Arc du Vent : fort recul, pas de Puissance (dégâts réduits)
- Casque de Poséidon : respiration infinie sous l'eau
- Casque de Luffy (cuir) : renvoie les dégâts (Épines), cassable comme les autres
- Palmes de Poséidon : vitesse de nage extrême
- Set du Gardien (armure complète) : régénération + résistance au feu si porté en entier
- Set Pegasus (armure complète, cuir blanc) : planeur intégré sur le plastron
- Cape du Vent : saut amélioré, -1 coeur de vie max
- Amulette du Berserker : +dégâts si vie basse, -armure en permanence
- Steak Doré : soin instantané complet
- Pierre du Chao : sème le chaos dans l'inventaire des joueurs proches

## Sécurité / anti-triche

- **Enchantements verrouillés** : chaque item reprend automatiquement ses enchantements d'origine si un joueur essaie d'en ajouter/modifier via table d'enchantement, enclume, etc. Vérifié à chaque changement d'inventaire (pas en boucle continue, pour la performance).
- **Tout est cassable** : aucun item n'est indestructible (durabilité normale selon le matériau de base).
- **Notification de casse** : un message s'affiche dans le chat pour tous les joueurs quand un item custom se casse, avec une ligne de log dédiée (`[customarmor-break] ...`) exploitable par un script externe pour relayer l'info sur Discord (voir `discord-bridge/` — nécessite un petit script Python à faire tourner à côté du serveur, une vraie intégration Discord n'est pas possible directement depuis un datapack).

Menu en jeu : `/function customarmor:menu`
