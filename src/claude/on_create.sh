#!/usr/bin/env bash

set -euo pipefail

CLAUDE_STATE_DIR="${CLAUDE_STATE_DIR:-/var/lib/claude}"
CLAUDE_HOME_LINK="$HOME/.claude"

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

ensure_state_dir "$CLAUDE_STATE_DIR"

if ! [ -L "$CLAUDE_HOME_LINK" ] || [ "$(readlink "$CLAUDE_HOME_LINK")" != "$CLAUDE_STATE_DIR" ]; then
    if [ -e "$CLAUDE_HOME_LINK" ] || [ -L "$CLAUDE_HOME_LINK" ]; then
        rm -rf "$CLAUDE_HOME_LINK"
    fi

    ln --symbolic --force --no-dereference "$CLAUDE_STATE_DIR" "$CLAUDE_HOME_LINK"
fi
