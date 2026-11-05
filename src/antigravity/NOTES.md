## Notes

Antigravity configuration is stored in the `gemini` Docker volume mounted at
`/var/lib/gemini`. When the container is created, the Feature replaces
`~/.gemini` with a symlink to that path. This shares settings, credentials and
session history between containers using the same Docker volume without
bind-mounting the host's `~/.gemini`.

This Feature installs the Google Antigravity VS Code extension.
