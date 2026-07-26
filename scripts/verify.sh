#!/usr/bin/env bash
# Single "definition of done" gate. Run before opening a PR.
# Mirrors CI so local green == CI green.
#
#   bash scripts/verify.sh            # inside the docker `app` container
#   NATIVE=1 bash scripts/verify.sh   # on the host
set -euo pipefail

cd "$(dirname "$0")/.."

if [ "${NATIVE:-0}" = "1" ]; then
  app() { "$@"; }
else
  app() { docker compose exec -T app "$@"; }
fi

run() { printf '\n\033[1m> %s\033[0m\n' "$1"; shift; "$@"; }

run "bundle check"        app bundle check
run "db:test:prepare"     app env RAILS_ENV=test bin/rails db:test:prepare
run "tests"               app env RAILS_ENV=test bin/rails test

printf '\n\033[1;32mAll checks passed.\033[0m\n'
