#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [--dry-run] <input-path> <output-format>" >&2
  exit 1
}

DRY_RUN=0
if [[ ${1:-} == "--dry-run" ]]; then
  DRY_RUN=1
  shift || true
fi

if [[ $# -ne 2 ]]; then
  usage
fi

INPUT_PATH="$1"
OUTPUT_FORMAT="$2"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/compose.yaml"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
OUTPUT_DIR="$REPO_ROOT/output"

mkdir -p "$OUTPUT_DIR"

# Resolve input to an absolute path (without requiring realpath)
if [[ "$INPUT_PATH" = /* ]]; then
  INPUT_ABS="$INPUT_PATH"
else
  INPUT_ABS="$(cd "$PWD" && pwd)/$INPUT_PATH"
fi

if [[ ! -f "$INPUT_ABS" ]]; then
  echo "Input file not found: $INPUT_ABS" >&2
  exit 1
fi

BASENAME="$(basename "$INPUT_ABS")"
STEM="${BASENAME%.*}"
OUTPUT_HOST="$OUTPUT_DIR/$STEM.$OUTPUT_FORMAT"
OUTPUT_CONTAINER="/workspace/output/$STEM.$OUTPUT_FORMAT"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required but was not found in PATH" >&2
  exit 1
fi

cd "$SCRIPT_DIR"

# Map the host input path into the container
case "$INPUT_ABS" in
  "$REPO_ROOT"/*)
    INPUT_CONTAINER="/workspace${INPUT_ABS#$REPO_ROOT}"
    ;;
  *)
    INPUT_CONTAINER="/host$INPUT_ABS"
    ;;
esac

CMD=(docker compose -f "$COMPOSE_FILE" run --rm
  pandoc
  "$INPUT_CONTAINER" -o "$OUTPUT_CONTAINER")

if (( DRY_RUN )); then
  printf "Dry run: "
  printf "%q " "${CMD[@]}"
  printf "\n"
  exit 0
fi

echo "Converting '$INPUT_ABS' to format '$OUTPUT_FORMAT'..."
"${CMD[@]}"

echo "Conversion complete. Output written to: $OUTPUT_HOST"
