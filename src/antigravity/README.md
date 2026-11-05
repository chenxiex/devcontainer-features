
# Antigravity (antigravity)

Installs the Google Antigravity VS Code extension and persists `~/.gemini` in a shared volume across devcontainers.

## Example Usage

```json
"features": {
    "ghcr.io/chenxiex/devcontainer-features/antigravity:1": {}
}
```



## Customizations

### VS Code Extensions

- `google.google-antigravity`

## Notes

Antigravity configuration is stored in the `gemini` Docker volume mounted at
`/var/lib/gemini`. When the container is created, the Feature replaces
`~/.gemini` with a symlink to that path. This shares settings, credentials and
session history between containers using the same Docker volume without
bind-mounting the host's `~/.gemini`.

This Feature installs the Google Antigravity VS Code extension.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/chenxiex/devcontainer-features/blob/main/src/antigravity/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
