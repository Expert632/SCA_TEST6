#!/bin/bash

echo "Starting SCA scan..."

# Installer Snyk et jq
npm install -g snyk jq

# Installer les dépendances Python
python -m pip install --upgrade pip
pip install -r requirements.txt

# Lancer le scan
SCAN_RESULT=$(snyk test --json)
CRITICAL_COUNT=$(echo "$SCAN_RESULT" | jq '.vulnerabilities[] | select(.severity=="high" or .severity=="critical")' | wc -l)

if [ "$CRITICAL_COUNT" -gt 0 ]; then
    echo "Vulnerability detected!"
else
    echo "No vulnerability detected."
fi
