#!/bin/bash

echo "Starting SCA scan..."

# Installer Snyk
npm install -g snyk

# Installer jq via apt-get (version Linux native, pas NPM)
sudo apt-get update && sudo apt-get install -y jq

# Installer Python et dépendances
python -m pip install --upgrade pip
pip install -r requirements.txt

# Lancer le scan Snyk
SCAN_RESULT=$(snyk test --json)

# Compter le nombre de vulnérabilités critiques ou élevées
CRITICAL_COUNT=$(echo "$SCAN_RESULT" | jq '.vulnerabilities[] | select(.severity=="high" or .severity=="critical")' | wc -l)

if [ "$CRITICAL_COUNT" -gt 0 ]; then
    echo "Vulnerability detected!"
else
    echo "No vulnerability detected."
fi
