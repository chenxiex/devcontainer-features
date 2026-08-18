#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md
source dev-container-features-test-lib

/usr/local/share/codex/on_create.sh

# Feature-specific tests
check "codex state symlink" bash -lc '[ -L "$HOME/.codex" ] && [ "$(readlink "$HOME/.codex")" = "/var/lib/codex" ]'
check "codex state writable" bash -lc 'tmp="$HOME/.codex/.feature-test"; printf ok > "$tmp"; [ "$(cat /var/lib/codex/.feature-test)" = "ok" ]; rm -f "$tmp"'

# Report result
reportResults
