#!/usr/bin/env bash

set -euo pipefail

CODEX_STATE_DIR="${CODEX_STATE_DIR:-/var/lib/codex}"
CODEX_HOME_LINK="$HOME/.codex"

run_privileged() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1 && sudo -n true >/dev/null 2>&1; then
        sudo -n "$@"
    else
        "$@"
    fi
}

ensure_state_dir() {
    local dir="$1"
    run_privileged install -d -m 0700 "$dir"
    run_privileged chown -R "$(id -u):$(id -g)" "$dir"
    run_privileged chmod 0700 "$dir"
}

ensure_state_dir "$CODEX_STATE_DIR"

if ! [ -L "$CODEX_HOME_LINK" ] || [ "$(readlink "$CODEX_HOME_LINK")" != "$CODEX_STATE_DIR" ]; then
    if [ -e "$CODEX_HOME_LINK" ] || [ -L "$CODEX_HOME_LINK" ]; then
        rm -rf "$CODEX_HOME_LINK"
    fi

    ln --symbolic --force --no-dereference "$CODEX_STATE_DIR" "$CODEX_HOME_LINK"
fi
