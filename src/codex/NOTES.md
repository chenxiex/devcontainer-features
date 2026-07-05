## Notes

This Feature does not download Codex. It links `codex` and `rg` from the
`openai.chatgpt` VS Code extension installed in the container:

- `$HOME/.vscode-server/extensions/openai.chatgpt-*/bin/*/codex`
- `$HOME/.vscode-server/extensions/openai.chatgpt-*/bin/*/rg`

If more than one `openai.chatgpt-*` extension directory exists, the latest
version is selected.

The extension is installed after the Feature's build-time `install.sh` runs, so
the links are refreshed from `postAttachCommand`.

Codex configuration is stored in the `codex` Docker volume mounted at
`/var/lib/codex`. On attach, the Feature replaces `~/.codex` with a symlink to
that path inside the container. This shares configuration between containers
using the same Docker volume without bind-mounting the host's `~/.codex`.
