# dotfiles

使用 chezmoi 管理个人配置；`.chezmoiroot` 指向 `home/`。

## Install

```bash
curl -sfL https://raw.githubusercontent.com/saltbo/dotfiles/master/install.sh | bash
```

安装入口选择 `chezmoi` 分支。个人工具从公开仓库 `saltbo/bbox` 安装，需要 uv 和 Git。

## 个人命令

个人命令已经迁入独立仓库 <https://github.com/saltbo/bbox>，包名为 `saltbo-bbox`。chezmoi 不再管理 `~/.local/bin` 中的脚本源码、Python 虚拟环境或命令包装器。

`run_onchange_after_install-bbox.sh` 在尚未安装时通过 uv 安装工具集；已有安装（包括 editable 安装）会被保留。日常更新执行：

```sh
uv tool upgrade saltbo-bbox
```

本地开发可在 bbox checkout 中执行 `uv tool install --editable .`。增加命令或变更依赖后重新安装。zsh 在 compinit 之后通过 `source <(bbox completion zsh)` 加载 bbox 自带补全，无需独立的 `completion-install`，也不再在 dotfiles 保存 `_git-cm` 副本。更新 bbox 后重新打开终端即可加载新版规则。

安装钩子只安装工具，不移动或覆盖已有文件。其他旧机器如有同名脚本，需先备份并移开冲突入口，再执行安装。自建 `kubectl` 版本保存在 `~/.local/share/bbox/kubectl/`，活动入口仍为 `~/.local/bin/kubectl`。

## PATH

所有个人 PATH 规则集中在 `home/dot_config/shell/path.sh`，部署到 `~/.config/shell/path.sh`：

- `~/.zshenv`：为包括非交互调用在内的 zsh 加载基础环境。
- `~/.zprofile`：在 macOS `path_helper`、Homebrew 和登录集成之后重新应用优先级。
- `~/.zshrc`：加载交互补全和插件，最后统一 PATH。
- `~/.profile`：POSIX 登录 shell 使用相同规则。

显式维护 `~/.local/bin`（uv/bbox）、`~/.volta/bin`、Homebrew（含 Ruby）、`$GOPATH/bin`、`~/.cargo/bin` 和 Docker CLI helper 目录。用户入口保留 uv Python、原生 Claude 和手动选定 kubectl 的优先级；Node/pnpm 统一经 Volta。其他应用继承的有效目录保留在后面，自动去重和跳过失效目录。

移除 OpenClaw 专属入口、空的 pnpm 全局入口目录，以及链接已失效的 OrbStack 初始化。过滤这些从旧终端继承的路径；不加载旧 Flutter checkout，Flutter 使用 Homebrew 入口。工具本身未卸载。

补全初始化仅在交互 shell 执行。zplug 保留真实终端检测，避免 GUI 的登录 shell 环境探测超时。

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
