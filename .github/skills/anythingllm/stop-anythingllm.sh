#!/usr/bin/env bash
# Stop the stack. Preserves data in named volumes.
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

run docker compose stop

if [ "$DRY_RUN" -eq 0 ]; then
    echo "Stopped. Data preserved; run start-anythingllm.sh to bring it back up."
fi
