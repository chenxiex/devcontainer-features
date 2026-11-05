#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="/var/lib/gemini"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(id -u)" -ne 0 ]; then
    echo "Script must run as root."
    exit 1
fi

main() {
    install -d -m 0700 "$STATE_DIR"
    install -d -m 0755 /usr/local/share/antigravity
    install -m 0755 "$SCRIPT_DIR/on_create.sh" /usr/local/share/antigravity/on_create.sh

    echo "Antigravity state will be persisted in a shared volume on container creation."
}

main "$@"
