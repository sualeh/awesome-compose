#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ ${1:-} == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/compose.yaml"

cd "$SCRIPT_DIR"
CMD=(docker compose -f "$COMPOSE_FILE" down)

if (( DRY_RUN )); then
  printf "Dry run: "
  printf "%q " "${CMD[@]}"
  printf "\n"
  exit 0
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required but was not found in PATH" >&2
  exit 1
fi

echo "Stopping Orthanc with Docker Compose..."
"${CMD[@]}"
echo "Orthanc containers stopped and removed"
