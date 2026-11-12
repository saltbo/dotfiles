# dotfiles

Personal configuration managed with [chezmoi](https://www.chezmoi.io/). Source files are in `home/`.

## Installation

```sh
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/main/install.sh | bash
```

## Update configuration

```sh
chezmoi diff
chezmoi apply
```

## Personal tools

Command-line tools are maintained in [bbox](https://github.com/saltbo/bbox) and installed with uv during setup. To update:

```sh
uv tool upgrade saltbo-bbox
```

## Shell configuration

PATH settings are in `home/dot_config/shell/path.sh`, deployed to `~/.config/shell/path.sh`.

Interactive settings and completion setup are in `home/dot_zshrc`, which loads the zsh completions provided by bbox.

## Agent configuration

Shared user instructions live at `~/.agents/AGENTS.md`. Codex (`~/.codex/AGENTS.md`), Claude Code (`~/.claude/CLAUDE.md`), and Pi (`~/.pi/agent/AGENTS.md`) use relative symlinks to this file.

The `manage-dotfiles` and `manage-worktrees` skills live under `~/.agents/skills/`. Claude Code discovers them through symlinks in `~/.claude/skills/`; Codex and Pi support the shared skills directory directly. Claude agent definitions are also managed here.

To inspect or apply the managed agent configuration:

```sh
chezmoi diff ~/.agents ~/.codex ~/.claude ~/.pi
chezmoi apply ~/.agents ~/.codex ~/.claude ~/.pi
```
