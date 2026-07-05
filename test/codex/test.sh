#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md
source dev-container-features-test-lib

mkdir -p "$HOME/.vscode-server/extensions/openai.chatgpt-1.0.0/bin/linux-x86_64"
mkdir -p "$HOME/.vscode-server/extensions/openai.chatgpt-2.0.0/bin/linux-x86_64"
printf '#!/usr/bin/env bash\necho old codex\n' > "$HOME/.vscode-server/extensions/openai.chatgpt-1.0.0/bin/linux-x86_64/codex"
printf '#!/usr/bin/env bash\necho old rg\n' > "$HOME/.vscode-server/extensions/openai.chatgpt-1.0.0/bin/linux-x86_64/rg"
printf '#!/usr/bin/env bash\necho codex from latest extension\n' > "$HOME/.vscode-server/extensions/openai.chatgpt-2.0.0/bin/linux-x86_64/codex"
printf '#!/usr/bin/env bash\necho rg from latest extension\n' > "$HOME/.vscode-server/extensions/openai.chatgpt-2.0.0/bin/linux-x86_64/rg"
chmod +x "$HOME/.vscode-server/extensions/openai.chatgpt-"*/bin/linux-x86_64/codex
chmod +x "$HOME/.vscode-server/extensions/openai.chatgpt-"*/bin/linux-x86_64/rg
/usr/local/share/codex/on_create.sh

# Feature-specific tests
check "codex linked from latest extension" bash -lc '[ "$(readlink /usr/local/bin/codex)" = "$HOME/.vscode-server/extensions/openai.chatgpt-2.0.0/bin/linux-x86_64/codex" ]'
check "rg linked from latest extension" bash -lc '[ "$(readlink /usr/local/bin/rg)" = "$HOME/.vscode-server/extensions/openai.chatgpt-2.0.0/bin/linux-x86_64/rg" ]'
check "codex state symlink" bash -lc '[ -L "$HOME/.codex" ] && [ "$(readlink "$HOME/.codex")" = "/var/lib/codex" ]'
check "codex state writable" bash -lc 'tmp="$HOME/.codex/.feature-test"; printf ok > "$tmp"; [ "$(cat /var/lib/codex/.feature-test)" = "ok" ]; rm -f "$tmp"'

# Report result
reportResults
