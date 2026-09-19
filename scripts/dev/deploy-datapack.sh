#!/bin/bash
set -euo pipefail

PROJECT="/opt/minecraft/project"
DATAPACK="$PROJECT/datapack/pokemon-world"
DEV_WORLD="/opt/minecraft/dev/server/world"
TARGET="$DEV_WORLD/datapacks/pokemon-world"

echo "==> Validation du datapack"

test -f "$DATAPACK/pack.mcmeta" || {
    echo "ERREUR: pack.mcmeta introuvable"
    exit 1
}

test -d "$DATAPACK/data" || {
    echo "ERREUR: dossier data introuvable"
    exit 1
}

echo "==> Déploiement vers DEV"

rm -rf "$TARGET"
cp -a "$DATAPACK" "$TARGET"

echo "==> Datapack déployé"
echo "$TARGET"
