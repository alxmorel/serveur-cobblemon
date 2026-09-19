#!/bin/bash
set -euo pipefail

PROJECT="/opt/minecraft/project"
SOURCE="$PROJECT/datapack/pokemon-world"
DEST_DIR="/opt/minecraft/dev/server/world/datapacks"
TARGET="$DEST_DIR/pokemon-world"
STAGING="$DEST_DIR/.pokemon-world.staging"
BACKUP="/opt/minecraft/dev/backups/datapacks/pokemon-world.previous"

echo "==> Validation du datapack"

test -f "$SOURCE/pack.mcmeta" || {
    echo "ERREUR: pack.mcmeta introuvable"
    exit 1
}

test -d "$SOURCE/data" || {
    echo "ERREUR: dossier data introuvable"
    exit 1
}

test -d "$DEST_DIR" || {
    echo "ERREUR: dossier datapacks DEV introuvable"
    exit 1
}

if [[ -e "$STAGING" || -e "$BACKUP" ]]; then
    echo "ERREUR: un dossier temporaire ou une sauvegarde existe déjà."
    echo "Vérifier avant de relancer : $STAGING ou $BACKUP"
    exit 1
fi

echo "==> Préparation de la nouvelle version"
cp -a "$SOURCE" "$STAGING"

echo "==> Déploiement vers DEV"

if [[ -e "$TARGET" ]]; then
    mv "$TARGET" "$BACKUP"
fi

if ! mv "$STAGING" "$TARGET"; then
    echo "ERREUR: échec du déploiement"

    if [[ -e "$BACKUP" && ! -e "$TARGET" ]]; then
        mv "$BACKUP" "$TARGET"
        echo "==> Version précédente restaurée"
    fi

    exit 1
fi

echo "==> Datapack déployé : $TARGET"

if [[ -e "$BACKUP" ]]; then
    echo "==> Version précédente conservée : $BACKUP"
fi

echo "==> Un rechargement de Minecraft DEV reste nécessaire"
