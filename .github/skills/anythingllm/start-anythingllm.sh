#!/usr/bin/env bash
# Pull latest images, generate .env if missing, then start the stack.
# Pass --dry-run to print commands without executing.
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

DRY_RUN=0
for arg in "$@"; do
    [ "$arg" = "--dry-run" ] && DRY_RUN=1
done

run() {
    echo "+ $*"
    [ "$DRY_RUN" -eq 1 ] || "$@"
}

if [ ! -f .env ]; then
    if command -v openssl >/dev/null 2>&1; then
        jwt="$(openssl rand -base64 32 | tr -d '\n')"
    else
        jwt="$(head -c 32 /dev/urandom | base64 | tr -d '\n')"
    fi
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "+ write .env with generated JWT_SECRET"
    else
        printf 'JWT_SECRET=%s\n' "$jwt" > .env
    fi
fi

run docker compose pull
run docker compose up -d

if [ "$DRY_RUN" -eq 0 ]; then
    echo
    echo "AnythingLLM UI: http://localhost:3001"
    echo "Ollama API:     http://localhost:11434"
fi
