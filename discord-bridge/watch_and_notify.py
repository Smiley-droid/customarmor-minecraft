"""
Pont Discord pour CustomArmor.

Un datapack Minecraft NE PEUT PAS envoyer de message Discord directement
(aucune commande vanilla ne fait de requête web). Ce petit script contourne
ça : il surveille le fichier de log du serveur en continu, repère les lignes
"[customarmor-break] ..." que le datapack imprime, et les envoie sur un
salon Discord via un webhook.

Installation :
1. Dans Discord : Paramètres du salon > Intégrations > Webhooks > Nouveau webhook.
   Copie l'URL du webhook.
2. pip install requests
3. Modifie WEBHOOK_URL et LOG_PATH ci-dessous.
4. Lance ce script en même temps que ton serveur (dans un terminal séparé,
   ou comme tâche de fond / service).

Le script ne modifie rien sur le serveur, il ne fait que LIRE le log.
"""

import time
import re
import requests

# === À MODIFIER ===
WEBHOOK_URL = "https://discord.com/api/webhooks/TON_ID/TON_TOKEN"
LOG_PATH = r"C:\chemin\vers\ton\serveur\logs\latest.log"
# ===================

PATTERN = re.compile(r"\[customarmor-break\] item=(.+?) player=(\S+)")


def send_to_discord(item_name: str, player_name: str) -> None:
    message = f"💥 **{item_name}** de **{player_name}** vient de se casser !"
    try:
        requests.post(WEBHOOK_URL, json={"content": message}, timeout=5)
    except requests.RequestException as e:
        print(f"[discord-bridge] Erreur d'envoi : {e}")


def follow(path: str):
    """Suit un fichier comme `tail -f`."""
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        f.seek(0, 2)  # se place à la fin du fichier
        while True:
            line = f.readline()
            if not line:
                time.sleep(0.5)
                continue
            yield line


def main():
    print(f"[discord-bridge] Surveillance de {LOG_PATH}...")
    for line in follow(LOG_PATH):
        match = PATTERN.search(line)
        if match:
            item_name, player_name = match.group(1), match.group(2)
            print(f"[discord-bridge] Casse détectée : {item_name} ({player_name})")
            send_to_discord(item_name, player_name)


if __name__ == "__main__":
    main()
