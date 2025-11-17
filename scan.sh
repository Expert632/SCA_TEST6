#!/bin/bash
set -e

echo "Starting SCA scan..."

# 1. Installer Snyk
npm install -g snyk

# 2. Installer les dépendances Python
python -m pip install --upgrade pip
pip install -r requirements.txt

# 3. Lancer Snyk et afficher LES LIGNES DU SCAN
echo "Running snyk test..."
SCAN_OUTPUT=$(snyk test || true)

echo "===== RAW SNYK OUTPUT START ====="
echo "$SCAN_OUTPUT"
echo "===== RAW SNYK OUTPUT END ====="

# 4. Décider du message final en fonction de la sévérité
if echo "$SCAN_OUTPUT" | grep -i -E "High severity|Critical severity|high severity|critical severity" >/dev/null; then
    echo "Vulnerability detected!"
else
    echo "No vulnerability detected."
fi
