## Notes

Codex configuration is stored in the `codex` Docker volume mounted at
`/var/lib/codex`. When the container is created, the Feature replaces
`~/.codex` with a symlink to that path. This shares configuration between
containers using the same Docker volume without bind-mounting the host's
`~/.codex`.

This Feature does not install or link the Codex CLI.
