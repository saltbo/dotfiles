## Install

```bash
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/master/install.sh | bash
```

## Agent configuration

Chezmoi manages personal Codex/Claude instructions and two Claude agents.
Home-directory references are rendered for the destination machine. RTK is
included in the Homebrew package list for the imported instructions.
Codex config.toml and Claude settings.json remain unmanaged.

Inspect and apply only these targets after installing the required tools:

```sh
chezmoi diff ~/.codex ~/.claude
chezmoi apply ~/.codex ~/.claude
```

Logins, sessions, caches, databases, project permissions and plugin downloads are
not collected. Realmroot enrollment and
plugin/skill installation remain separate from restoring these dotfiles.
