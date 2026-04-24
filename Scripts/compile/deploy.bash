#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/internal/ensure_python.bash"
ensure_python_runtime

exec "$GEN_PYTHON_BIN" "$SCRIPT_DIR/deploy.py" "$@"
