# Codex CLI (codex)

Links the OpenAI Codex CLI from the `openai.chatgpt` VS Code extension and persists `~/.codex` in shared state across devcontainers.

The feature links these extension-provided executables into `PATH`:

- `codex`
- `rg`

## Example Usage

```json
"features": {
    "ghcr.io/sliekens/devcontainer-features/codex:2": {}
}
```

## Options

This feature has no options.

## Persistent State

| Volume | Container path | Purpose |
|--------|---------------|---------|
| `codex` | `/var/lib/codex` | Auth and configuration |

This Docker volume is shared by containers that use this feature, but it is not bind-mounted from the host home directory. The feature symlinks `~/.codex` to `/var/lib/codex` inside the container.


## License

This feature is released under the [MIT License](https://github.com/sliekens/devcontainer-features/blob/main/LICENSE).

The installed tool is subject to its own license: [Codex CLI license](https://github.com/openai/codex/blob/main/LICENSE).

## Links

- [Codex CLI documentation](https://developers.openai.com/codex)

## Release Notes

## 2.0.0 - 2026-07-05
- Link `codex` and `rg` from the `openai.chatgpt` VS Code extension instead of downloading release assets.
- Replace the host `~/.codex` bind mount with a Docker volume.
- Remove the `version` option.

## 1.1.2 - 2026-05-24
- Fix compatibility with new tarball layout

## 1.1.1 - 2026-05-14
- Add trailing slash to bind mount source path to mark it explicitly as a directory.

## 1.1.0 - 2026-03-28
- Use bind mount from host `~/.codex` instead of a Docker volume for persistent state.

## 1.0.0 - 2026-03-26
- Initial release.
