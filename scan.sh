#!/bin/bash

echo "Début du scan SCA..."

if ! command -v snyk &> /dev/null
then
    echo "Snyk non installé. Installer avec : npm install -g snyk jq"
    exit
fi

SCAN_RESULT=$(snyk test --json)
CRITICAL_COUNT=$(echo "$SCAN_RESULT" | jq '.vulnerabilities[] | select(.severity=="high" or .severity=="critical")' | wc -l)

if [ "$CRITICAL_COUNT" -gt 0 ]; then
    echo "Vulnérabilité détectée !"
else
    echo "No vulnérabilité détectée."
fi
