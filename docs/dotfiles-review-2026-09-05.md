# 本机 dotfiles 审查（2026-09-05）

基于 `chezmoi` 分支 `95cc82c`，对照当前 Mac 的 18 项 chezmoi 差异及 3 项 Git 未提交变动。此 PR 只更新配置源，不自动 apply，也不执行安装、密钥上传或集群访问。

| 文件/项目 | 处理 | 原因 |
| --- | --- | --- |
| packages.yaml | 收录 Bitwarden | 已有本机未提交的安装清单变更 |
| .sleep / .wakeup | 新增为 executable_dot_* | 保留现有灯控脚本，并确保 chezmoi 生成可执行文件 |
| .cargo/config | 移除配置源 | 本机已删除，且不存在 config.toml；不擅自恢复 git-fetch-with-cli 偏好。若以后需要恢复，使用 config.toml |
| iTerm2 plist | 收录本机偏好 | 保留当前 AI、键盘、tmux 和字体设置，去除旧 Coprocess MRU 历史；未新增 API 密钥 |
| iTerm2 zmodem 脚本 | 收发脚本均改为架构模板 | 当前 ARM Mac 使用 /opt/homebrew，Intel 使用 /usr/local |
| .docker/daemon.json | 保留仓库 | 唯一差异为 registry-mirrors 的 null 与 []；保留明确的空列表 |
| .gitconfig | 暂缓整份同步 | 本机包含作者身份、关闭签名及凭据助手配置，不能整份搬到公共仓库。仓库当前空 name/email 与强制签名也不能直接判定为期望值；现有 include 文件需单独规划 |
| .gitignore_global | 收录 | 忽略 .claude/settings.local.json |
| gpg-agent.conf | 仅修正 pinentry 路径 | 架构模板兼容 ARM/Intel；仓库缓存时长配置仍有效，保留 |
| gpg.conf | 保留仓库，待确认偏好 | 本机只把四个选项全部注释；没有证据证明这些选项过时 |
| Kubernetes saltbo.conf | 不提交本机证书 | 仓库客户端证书于 2025-08-30 过期，本机版于 2026-06-21 过期；需要重新签发后再使用现有 age 加密方式更新。未访问集群验证连接 |
| gpg-pk-update | 暂缓 | 仓库使用旧 key ID，本机换了 ID 但仍先删除远程公钥；不能仅替换 ID 就认为安全可用。需要单独改为 Realmroot 身份操作并验证 GitHub key ID，不执行该脚本 |
| .npmrc | 收录为 private_dot_npmrc | 去除旧镜像、企业 registry 和旧 token 配置，保留本机 Buf registry 与 release-age 设置；保留 600 权限 |
| .ssh/config | 收录 | 保留 Colima/OrbStack includes、连接保活，去除强制连接本地 6666 代理；Colima 路径改用 ~ |
| .vimrc | 收录 | 去掉本机已移除的强制 zellner 配色 |
| .zprofile | 选择性同步 | .env 在代理变量之前读取；收录 lan/local 例外、Docker/OrbStack 集成；去除旧 GOPROXY、测试 TAG、重复 direnv 和空 npm token 覆盖 |
| .zshenv | 保留仓库 | 不收录不存在的 Flutter 路径或注释掉的 PATH；保留 .local/bin 和 krew 路径，Rust 初始化统一保留在 .zprofile |
| .zshrc | 选择性同步 | 收录 opencli/Dart 补全、pnpm、Homebrew Ruby；用户目录改用 HOME，去除重复 .local/bin 添加 |

本机 `.zprofile` 中 Rust 条件块为空，但 `zsh -n` 通过，因此不是语法错误。PR 保留仓库中有效的条件式 Cargo 初始化。没有收录本机临时 gh-claude 模型别名、重复 Volta 初始化、安装器注入的重复 PATH，或不存在的 Flutter SDK 路径。

## 合并后

先查看 `chezmoi diff`，逐项应用已审查文件。暂缓项目仍会显示差异，尤其不要用整目录 apply 覆盖本机 Git 凭据设置或 Kubernetes 配置。原 chezmoi 工作目录的 3 项未提交变动原样保留，PR 在独立 worktree 中创建。

本次没有安装软件、重新签发证书、访问集群、执行灯控脚本或更改系统现用配置。

## 参考

- [chezmoi 架构变量](https://www.chezmoi.io/reference/templates/variables/)
- [chezmoi 机器差异模板](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/)
- [Cargo 配置文件](https://doc.rust-lang.org/cargo/reference/config.html)
