
# Codex (codex)

Persists `~/.codex` in a shared volume across devcontainers.

## Example Usage

```json
"features": {
    "ghcr.io/chenxiex/devcontainer-features/codex:3": {}
}
```



## Customizations

### VS Code Extensions

- `openai.chatgpt`

## Notes

Codex configuration is stored in the `codex` Docker volume mounted at
`/var/lib/codex`. When the container is created, the Feature replaces
`~/.codex` with a symlink to that path. This shares configuration between
containers using the same Docker volume without bind-mounting the host's
`~/.codex`.

This Feature does not install or link the Codex CLI.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/chenxiex/devcontainer-features/blob/main/src/codex/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
