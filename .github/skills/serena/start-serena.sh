#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ ${1:-} == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/compose.yaml"

cd "$SCRIPT_DIR"
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

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required but was not found in PATH" >&2
  exit 1
fi

echo "Pulling latest Serena image with Docker Compose..."
"${CMD_PULL[@]}"
echo "Starting Serena MCP server with Docker Compose..."
"${CMD_UP[@]}"
echo "Serena MCP should be reachable at http://localhost:9121"
