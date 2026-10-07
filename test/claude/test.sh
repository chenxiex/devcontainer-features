#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md
source dev-container-features-test-lib

/usr/local/share/claude/on_create.sh

# Feature-specific tests
check "claude state symlink" bash -lc '[ -L "$HOME/.claude" ] && [ "$(readlink "$HOME/.claude")" = "/var/lib/claude" ]'
check "claude state writable" bash -lc 'tmp="$HOME/.claude/.feature-test"; printf ok > "$tmp"; [ "$(cat /var/lib/claude/.feature-test)" = "ok" ]; rm -f "$tmp"'

# Report result
reportResults
