# Datapack "CustomArmor" — armes et armures customs (Paper 26.2)

## Builder le datapack

Depuis ce dossier, dans un terminal (Linux/macOS, ou WSL/Git Bash sous Windows) :

```bash
./build.sh
```

Ça génère `customarmor.zip`. Mets-le (ou décompresse-le) dans :

```
<ton_serveur>/world/datapacks/
```

Puis en jeu, en op :

```
/reload
/datapack list
```

Tu dois voir "Armes et armures customs" apparaître dans la liste.

## Modifier le datapack

- `pack.mcmeta` : description et version cible (`min_format`/`max_format`, actuellement réglé sur 88-90 pour MC 26.2).
- `data/customarmor/function/` : la logique (fichiers `.mcfunction`, une commande par ligne).
  - `load.mcfunction` : message affiché au chargement.
  - `tick.mcfunction` : tourne 20x/seconde, vérifie le set d'armure du Gardien.
  - `armor_effect.mcfunction` : effets appliqués si le set est complet.
  - `on_hit.mcfunction` : effet déclenché quand on frappe avec la Lame du Néant.
- `data/customarmor/advancement/on_hit.json` : détecte le coup avec l'épée custom (via son `custom_data`).
- `data/minecraft/tags/function/` : dit à Minecraft quelles fonctions lancer automatiquement (`load` et `tick`).

Après chaque modif : relance `./build.sh`, remets le zip sur le serveur, refais `/reload`.

## Ajouter une nouvelle arme custom

1. Choisis un identifiant unique, ex. `{customarmor:{sword:"phoenix"}}`.
2. Donne l'item avec `/give ... custom_data={customarmor:{sword:"phoenix"}}`.
3. Dans `on_hit.json` (ou une copie renommée `on_hit_phoenix.json`), ajoute une condition sur ce `custom_data`.
4. Crée la fonction associée dans `function/` avec les effets voulus.
5. Rebuild et reload.

## Pas à jour Windows sans bash

Si tu n'as pas de terminal bash, tu peux juste sélectionner `pack.mcmeta` et le dossier `data/`, clic droit → "Envoyer vers" → "Dossier compressé", puis renommer en `customarmor.zip`. Le script fait juste ça automatiquement.
