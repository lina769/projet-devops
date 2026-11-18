#!/bin/sh
# Smoke test : vérifie que l'application répond.
# Usage : sh scripts/smoke.sh [url]   (par défaut http://localhost:5000)
# Code de sortie : 0 = tout Passed, 1 = au moins un Failed

BASE_URL=${1:-http://localhost:5000}
RETRIES=${SMOKE_RETRIES:-10}
REPORT_DIR=reports
REPORT="$REPORT_DIR/smoke-results.txt"
FAILED=0

mkdir -p "$REPORT_DIR"
: > "$REPORT"

log() {
  echo "$1" | tee -a "$REPORT"
}

# check <nom> <chemin> : attend un code HTTP 200 (plusieurs essais, 2 s entre chaque)
check() {
  name=$1
  path=$2
  code=000
  i=1
  while [ "$i" -le "$RETRIES" ]; do
    code=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL$path")
    [ "$code" = "200" ] && break
    i=$((i + 1))
    sleep 2
  done
  if [ "$code" = "200" ]; then
    log "[Passed] $name ($path) -> HTTP $code"
  else
    log "[Failed] $name ($path) -> HTTP $code"
    FAILED=1
  fi
}

log "=== Smoke test sur $BASE_URL ==="
check "Health" "/health"
check "Accueil" "/"

if [ "$FAILED" -eq 0 ]; then
  log "RESULTAT : Passed"
  exit 0
else
  log "RESULTAT : Failed"
  exit 1
fi
