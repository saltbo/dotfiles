## Install

```bash
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/master/install.sh | bash
```

## Agent configuration

Chezmoi manages personal Codex/Claude instructions, two Claude agents and selected
settings. Home-directory references are rendered for the destination machine.
Codex's model, reasoning, permission and memory preferences match the current
setup, including `approval_policy = "never"` and `sandbox_mode = "danger-full-access"`.

The `modify_` templates merge selected settings into existing config files. They
preserve unrelated project records, MCP definitions, credentials and hooks.
Claude's RTK hook is added once; RTK is included in the Homebrew package list.
Existing config bytes are retained when managed values already match. When values
change, JSON/TOML is reserialized, so comments and formatting may change.

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
not collected. Close agents before applying settings. Realmroot enrollment and
plugin/skill installation remain separate from restoring these dotfiles.
