#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md
source dev-container-features-test-lib

/usr/local/share/antigravity/on_create.sh

# Feature-specific tests
check "gemini state symlink" bash -lc '[ -L "$HOME/.gemini" ] && [ "$(readlink "$HOME/.gemini")" = "/var/lib/gemini" ]'
check "gemini state writable" bash -lc 'tmp="$HOME/.gemini/.feature-test"; printf ok > "$tmp"; [ "$(cat /var/lib/gemini/.feature-test)" = "ok" ]; rm -f "$tmp"'

# Report result
reportResults
