## Notes

Claude Code configuration is stored in the `claude` Docker volume mounted at
`/var/lib/claude`. When the container is created, the Feature replaces
`~/.claude` with a symlink to that path. This shares settings, credentials and
session history between containers using the same Docker volume without
bind-mounting the host's `~/.claude`.

This Feature installs the Claude Code VS Code extension but does not install
the Claude Code CLI. `~/.claude.json` is not shared.
