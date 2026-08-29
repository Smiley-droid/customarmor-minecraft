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

Menu en jeu : `/function customarmor:menu`

## Reliques légendaires (nouveau)

- Une relique aléatoire (un des 18 items customs) apparaît parfois dans un petit sanctuaire, entre 500 et 1000 blocs (coordonnées annoncées avec 200-300 blocs d imprécision volontaire) d'un joueur choisi au hasard (équitable entre tous les joueurs en ligne).
- Vérification exacte toutes les heures (plus de tirage au sort fréquent) : spawn garanti si 2+ joueurs sont connectés et qu aucune relique n est déjà en circulation.
- Une seule relique en circulation à la fois : tant qu'elle existe (récupérée ou non), aucune nouvelle ne peut apparaître. Elle redevient disponible quand la relique actuelle se casse.
- Sécurité anti-grief : ne construit que dans un chunk actuellement non chargé (pas de garantie à 100%, meilleur signal disponible en vanilla).
- Commande de test (ignore le timer et la probabilité) : `/function customarmor:legendary/force_spawn`, aussi accessible via le menu.

## Houe Fertile (nouveau)

Replante automatiquement blé, carottes, pommes de terre, betteraves et nether wart dès que tu les récoltes (uniquement les cultures mûres, pas les jeunes pousses accidentellement cassées).

## Sanctuaire des reliques : mise à jour

- **Garantie horaire** : si 2+ joueurs sont connectés, une relique apparaît au minimum toutes les heures (en plus des chances aléatoires plus fréquentes ~toutes les 11 min en moyenne).
- **Gardiens** : 4 zombies apparaissent quand un joueur s'approche à moins de 15 blocs du sanctuaire (une seule fois par relique).

## Plugin Paper (nouveau)

Depuis cette mise à jour, la pioche 3x3, la hache du bûcheron, la houe fertile et
**tout le système de reliques légendaires** sont gérés par un vrai plugin Paper
(`paper-plugin/`), plus fiables que les approximations du datapack.

### Récupérer le fichier compilé

Le plugin se compile automatiquement via GitHub Actions à chaque push. Pour le
télécharger : onglet **Actions** du repo → dernier run réussi → section
**Artifacts** en bas de page → `CustomArmorTools.zip` (contient le `.jar`).

### Installation

1. Place `CustomArmorTools.jar` dans le dossier `plugins/` de ton serveur Paper.
2. Redémarre le serveur (pas juste `/reload`, un plugin a besoin d'un vrai restart).
3. Un fichier `plugins/CustomArmorTools/config.yml` apparaît — modifie-le pour
   ajuster la fréquence de spawn des reliques ou leur nombre max en circulation
   par type (`legendary.max-circulation.<item_id>: <nombre>`).

### Commandes du plugin

- `/caxe`, `/cpickaxe`, `/choe` : donnent la Hache du Bûcheron, le Marteau
  Sismique, la Houe Fertile.
- `/legendary spawn` : force un spawn de relique.
- `/legendary reset` : réinitialise tout le système.
- `/legendary status` : affiche le nombre de chaque relique en circulation.
- `/legendary setmax <item_id|default> <nombre>` : change la limite de
  circulation d'un type de relique (persisté dans `config.yml`).

### Ce que ça corrige

- **Pioche 3x3** : mine désormais exactement les bons blocs (évènement réel de
  cassage, plus d'approximation par rayon).
- **Hache du Bûcheron** : abat vraiment l'arbre entier (parcours en largeur
  fiable, plus de raycast fragile).
- **Houe Fertile** : replante correctement en vérifiant/consommant la bonne
  graine.
- **Reliques légendaires** : sauvegardées sur disque (survivent aux
  redémarrages), nombre en circulation configurable par type, protection
  anti-grief réelle (suivi des chunks contenant des blocs posés par les
  joueurs, pas juste "chunk chargé ou non").
