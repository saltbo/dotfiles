## Install

```bash
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/master/install.sh | bash
```

## Agent configuration

Chezmoi manages personal Codex/Claude instructions and two Claude agents.
Home-directory references are rendered for the destination machine. RTK is
included in the Homebrew package list for the imported instructions.
Codex config.toml and Claude settings.json remain unmanaged.

`agent-skills.json` records the 51 shared skills and available source metadata.
Ten Flutter skills have no source in the local installer lock and are marked
`not-recorded`. This is an inventory, not a version lock or automatic installer;
folder hashes are recorded provenance, not commit pins. Verify sources through
Realmroot where authentication is required before restoring skills. The generated
installer lock, downloaded skill copies and broken gstack links are not managed.

Inspect and apply only these targets after installing the required tools:

```sh
chezmoi diff ~/.codex ~/.claude
chezmoi apply ~/.codex ~/.claude
```

Logins, sessions, caches, databases, project permissions and plugin downloads are
not collected. Realmroot enrollment and
plugin/skill installation remain separate from restoring these dotfiles.
