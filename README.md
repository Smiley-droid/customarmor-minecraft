# CustomArmor - Minecraft (Paper 26.2)

Datapack + texture pack pour un serveur entre potes. Sans mods côté client.

## Fichiers prêts à l'emploi

- `customarmor.zip` → datapack, à mettre dans `world/datapacks/` sur le serveur.
- `customarmor-resourcepack.zip` → texture pack (textures placeholder), à mettre dans `.minecraft/resourcepacks/` côté client, ou à héberger pour un push serveur automatique.

## SHA1 (pour server.properties si vous poussez le resource pack automatiquement)

- `customarmor-resourcepack.zip` : `b50d3c2c6854dee5dafa50daf0fb937408c36c19`

Voir `server.properties` :
```
resource-pack=<url_directe_vers_le_zip>
resource-pack-sha1=b50d3c2c6854dee5dafa50daf0fb937408c36c19
```

## Dossiers source

- `datapack-source/` : code source complet du datapack (fonctions, advancements). Contient un `build.sh` / `build.bat` pour regénérer le zip après modification.
- `texturepack-source/` : source du texture pack (textures PNG + fichiers de modèle). Remplacez les PNG dans `assets/customarmor/textures/item/` par vos propres dessins puis rezippez le dossier (`pack.mcmeta` + `assets/` à la racine du zip).

## Contenu

- Épée "Lame du Néant" : feu + faiblesse à chaque coup
- Épée "Épée de Zeus" : invoque la foudre sur l'ennemi touché
- Pioche "Foreuse Divine" : stats boostées
- Pioche "Marteau Sismique" : mine en 3x3
- Casque de Poséidon : respiration infinie sous l'eau
- Casque de Luffy : renvoie les dégâts, quasi incassable
- Palmes de Poséidon : vitesse de nage extrême
- Set du Gardien (armure complète) : régénération + résistance au feu si porté en entier
- Set Pegasus (armure complète, cuir blanc) : planeur intégré sur le plastron

Menu en jeu : `/function customarmor:menu`
