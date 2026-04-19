#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ ${1:-} == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/compose.yaml"
ENV_FILE="$SCRIPT_DIR/.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo ".env file is required at: $ENV_FILE" >&2
  exit 1
fi

PROJECT_PATH="$(grep -E '^[[:space:]]*SERENA_PROJECT_PATH[[:space:]]*=' "$ENV_FILE" | tail -n 1 | sed -E 's/^[[:space:]]*SERENA_PROJECT_PATH[[:space:]]*=[[:space:]]*//')"
PROJECT_PATH="${PROJECT_PATH%$'\r'}"

if [[ -z "${PROJECT_PATH// }" ]]; then
  echo "SERENA_PROJECT_PATH must be set in $ENV_FILE" >&2
  exit 1
fi

if [[ ( "$PROJECT_PATH" == \"*\" && "$PROJECT_PATH" == *\" ) || ( "$PROJECT_PATH" == \'*\' && "$PROJECT_PATH" == *\' ) ]]; then
  PROJECT_PATH="${PROJECT_PATH:1:${#PROJECT_PATH}-2}"
fi

# On POSIX paths, validate the directory exists early.
if [[ ! "$PROJECT_PATH" =~ ^[A-Za-z]:[\\/].* ]] && [[ ! -d "$PROJECT_PATH" ]]; then
  echo "Project path from .env does not exist or is not a directory: $PROJECT_PATH" >&2
  exit 1
fi

cd "$SCRIPT_DIR"
CMD_PULL=(docker compose -f "$COMPOSE_FILE" pull)
CMD_UP=(docker compose -f "$COMPOSE_FILE" up -d)

if (( DRY_RUN )); then
  printf "Dry run with SERENA_PROJECT_PATH=%q\n" "$PROJECT_PATH"
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
echo "Activated project path: $PROJECT_PATH"
echo "Serena MCP should be reachable at http://localhost:9121"
