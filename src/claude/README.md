
# Claude (claude)

Installs the Claude Code VS Code extension and persists `~/.claude` in a shared volume across devcontainers.

## Example Usage

```json
"features": {
    "ghcr.io/chenxiex/devcontainer-features/claude:1": {}
}
```



## Customizations

### VS Code Extensions

- `anthropic.claude-code`

## Notes

Claude Code configuration is stored in the `claude` Docker volume mounted at
`/var/lib/claude`. When the container is created, the Feature replaces
`~/.claude` with a symlink to that path. This shares settings, credentials and
session history between containers using the same Docker volume without
bind-mounting the host's `~/.claude`.

This Feature installs the Claude Code VS Code extension but does not install
the Claude Code CLI. `~/.claude.json` is not shared.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/chenxiex/devcontainer-features/blob/main/src/claude/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
