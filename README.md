# dotfiles

Personal configuration managed with [chezmoi](https://www.chezmoi.io/). Source files are in `home/`.

## Installation

```sh
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/chezmoi/install.sh | bash
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

Personal instructions for Codex and Claude, along with Claude agents, are managed here. To inspect or apply them:

```sh
chezmoi diff ~/.codex ~/.claude
chezmoi apply ~/.codex ~/.claude
```
