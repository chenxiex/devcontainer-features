#!/usr/bin/env bash

set -euo pipefail

GEMINI_STATE_DIR="${GEMINI_STATE_DIR:-/var/lib/gemini}"
GEMINI_HOME_LINK="$HOME/.gemini"

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

ensure_state_dir "$GEMINI_STATE_DIR"

if ! [ -L "$GEMINI_HOME_LINK" ] || [ "$(readlink "$GEMINI_HOME_LINK")" != "$GEMINI_STATE_DIR" ]; then
    if [ -e "$GEMINI_HOME_LINK" ] || [ -L "$GEMINI_HOME_LINK" ]; then
        rm -rf "$GEMINI_HOME_LINK"
    fi

    ln --symbolic --force --no-dereference "$GEMINI_STATE_DIR" "$GEMINI_HOME_LINK"
fi
