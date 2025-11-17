#!/bin/bash

echo "Starting SCA scan..."

# Installer Snyk
npm install -g snyk

# Installer Python et packages
python -m pip install --upgrade pip
pip install -r requirements.txt

# Lancer Snyk et afficher toutes les vulnérabilités
SCAN_OUTPUT=$(snyk test)

# Vérifier si Snyk a trouvé au moins une vulnérabilité critique ou élevée
if echo "$SCAN_OUTPUT" | grep -q -E "High|Critical"; then
    echo "Vulnerability detected!"
else
    echo "No vulnerability detected."
fi
