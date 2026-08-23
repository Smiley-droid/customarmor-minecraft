#!/bin/bash
# Build script pour le datapack "CustomArmor"
# Usage : ./build.sh
# Génère customarmor.zip prêt à mettre dans world/datapacks/

set -e

PACK_NAME="customarmor"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_FILE="$SRC_DIR/${PACK_NAME}.zip"

echo "Build du datapack '$PACK_NAME'..."

rm -f "$OUT_FILE"
cd "$SRC_DIR"

zip -r "$OUT_FILE" pack.mcmeta data -x ".*" -x "__MACOSX/*"

echo "OK : $OUT_FILE généré."
echo "Copie ce fichier (ou son contenu décompressé) dans world/datapacks/ sur ton serveur Paper 26.2, puis /reload."
