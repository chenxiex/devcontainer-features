
# Codex CLI (codex)

Links the OpenAI `codex` CLI and `rg` from the openai.chatgpt VS Code extension and persists `~/.codex` in a shared volume across devcontainers.

## Example Usage

```json
"features": {
    "ghcr.io/chenxiex/devcontainer-features/codex:2": {}
}
```



## Customizations

### VS Code Extensions

- `openai.chatgpt`

## Notes

This Feature does not download Codex. It links `codex` and `rg` from the
`openai.chatgpt` VS Code extension installed in the container:

- `$HOME/.vscode-server/extensions/openai.chatgpt-*/bin/*/codex`
- `$HOME/.vscode-server/extensions/openai.chatgpt-*/bin/*/rg`

If more than one `openai.chatgpt-*` extension directory exists, the latest
version is selected.

The extension may be installed after the Feature's build-time `install.sh`
runs, so the links are refreshed from lifecycle hooks. If the extension is not
present when `onCreateCommand` runs, the Feature logs a warning and tries again
on `postAttachCommand`.

Codex configuration is stored in the `codex` Docker volume mounted at
`/var/lib/codex`. The Feature symlinks `~/.codex` to that path inside the
container. This shares configuration between containers using the same Docker
volume without bind-mounting the host's `~/.codex`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/chenxiex/devcontainer-features/blob/main/src/codex/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
