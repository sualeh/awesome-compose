#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ ${1:-} == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/compose.yaml"
ENV_FILE="$SCRIPT_DIR/paperless.env"
DATA_ROOT="$SCRIPT_DIR/.paperless"

CMD_PULL=(docker compose -f "$COMPOSE_FILE" pull)
CMD_UP=(docker compose -f "$COMPOSE_FILE" up -d)

if (( DRY_RUN )); then
  printf "Dry run: "
  printf "%q " "${CMD_PULL[@]}"
  printf " && "
  printf "%q " "${CMD_UP[@]}"
  printf "\n"
  exit 0
fi

if [[ ! -f "$ENV_FILE" ]]; then
  echo "paperless.env not found. Copy paperless.env.example to paperless.env and set PAPERLESS_SECRET_KEY." >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required but was not found in PATH" >&2
  exit 1
fi

mkdir -p \
  "$DATA_ROOT/data" \
  "$DATA_ROOT/media" \
  "$DATA_ROOT/export" \
  "$DATA_ROOT/consume" \
  "$DATA_ROOT/paperless-ai-data"

echo "Pulling latest Paperless-ngx images with Docker Compose..."
"${CMD_PULL[@]}"
echo "Starting Paperless-ngx stack with Docker Compose..."
"${CMD_UP[@]}"
echo "Paperless-ngx should be reachable at http://localhost:8000"
echo "Paperless AI should be reachable at http://localhost:3000"
