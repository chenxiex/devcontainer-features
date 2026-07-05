#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
CODEX_STATE_DIR="${CODEX_STATE_DIR:-/var/lib/codex}"
CODEX_HOME_LINK="$HOME/.codex"
VSCODE_EXTENSIONS_DIR="$HOME/.vscode-server/extensions"

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

latest_chatgpt_extension() {
    local -a extension_dirs
    shopt -s nullglob
    extension_dirs=("$VSCODE_EXTENSIONS_DIR"/openai.chatgpt-*)
    shopt -u nullglob

    if [ "${#extension_dirs[@]}" -eq 0 ]; then
        return 1
    fi

    if sort -V </dev/null >/dev/null 2>&1; then
        printf '%s\n' "${extension_dirs[@]}" | sort -V | tail -n 1
    else
        printf '%s\n' "${extension_dirs[@]}" | sort | tail -n 1
    fi
}

find_extension_tool() {
    local extension_dir="$1"
    local tool_name="$2"
    local -a candidates

    shopt -s nullglob
    candidates=("$extension_dir"/bin/*/"$tool_name")
    shopt -u nullglob

    for candidate in "${candidates[@]}"; do
        if [ -x "$candidate" ]; then
            printf '%s\n' "$candidate"
            return 0
        fi
    done

    return 1
}

link_tool() {
    local tool_name="$1"
    local tool_source="$2"

    run_privileged install -d -m 0755 "$INSTALL_DIR"
    run_privileged ln --symbolic --force --no-dereference "$tool_source" "$INSTALL_DIR/$tool_name"
}

link_codex_tools() {
    local extension_dir
    if ! extension_dir="$(latest_chatgpt_extension)"; then
        echo "Unable to find openai.chatgpt extension under $VSCODE_EXTENSIONS_DIR; codex and rg links were not updated."
        return 0
    fi

    local codex_source
    if ! codex_source="$(find_extension_tool "$extension_dir" codex)"; then
        echo "Unable to find executable codex under $extension_dir/bin/*/codex; codex link was not updated."
        return 0
    fi

    local rg_source
    if ! rg_source="$(find_extension_tool "$extension_dir" rg)"; then
        echo "Unable to find executable rg under $extension_dir/bin/*/rg; rg link was not updated."
        return 0
    fi

    link_tool codex "$codex_source"
    link_tool rg "$rg_source"
}

ensure_state_dir "$CODEX_STATE_DIR"
link_codex_tools

if [ -L "$CODEX_HOME_LINK" ]; then
    if [ "$(readlink "$CODEX_HOME_LINK")" = "$CODEX_STATE_DIR" ]; then
        exit 0
    fi
    rm -f "$CODEX_HOME_LINK"
elif [ -d "$CODEX_HOME_LINK" ]; then
    cp -an "$CODEX_HOME_LINK/." "$CODEX_STATE_DIR/"
    rm -rf "$CODEX_HOME_LINK"
elif [ -e "$CODEX_HOME_LINK" ]; then
    rm -f "$CODEX_HOME_LINK"
fi

ln --symbolic --force --no-dereference "$CODEX_STATE_DIR" "$CODEX_HOME_LINK"
