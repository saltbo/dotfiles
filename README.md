# dotfiles

使用 [chezmoi](https://www.chezmoi.io/) 管理个人配置，源文件位于 `home/`。

## 安装

```sh
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/chezmoi/install.sh | bash
```

## 更新配置

```sh
chezmoi diff
chezmoi apply
```

## 个人工具

命令行工具由 [bbox](https://github.com/saltbo/bbox) 管理，初始化时通过 uv 安装。更新工具：

```sh
uv tool upgrade saltbo-bbox
```

## Shell 配置

PATH 配置位于 `home/dot_config/shell/path.sh`，部署到 `~/.config/shell/path.sh`。

交互配置和补全位于 `home/dot_zshrc`，其中加载 bbox 提供的 zsh 补全。

## Agent 配置

管理 Codex、Claude 的个人指令和 Claude agents。查看或应用：

```sh
chezmoi diff ~/.codex ~/.claude
chezmoi apply ~/.codex ~/.claude
```
