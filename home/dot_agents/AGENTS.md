## 目录

- `~/Develop/bogit/`：用户自己名下的仓库。
- `~/Develop/oss/`：开源项目的仓库；调研或 fork 时需要克隆的开源项目放在这里。

## 包管理

命令行工具优先通过 Homebrew 安装；Python 生态使用 uv，Node.js 生态使用 Volta。

## Dotfiles

用户级 dotfiles 由 chezmoi 管理。修改个人配置或全局 Agent 指令时，使用 `manage-dotfiles` skill。

## Realmroot

服务接入与 Agent 身份管理使用 `realmroot` skill。
读操作可以使用主人权限。写入和删除操作优先使用 Agent 自己的身份；无法使用时，也可以使用主人权限。
使用主人权限时，在最终汇报中说明所用身份、原因和执行的操作。

## Worktree

手动创建和清理 worktree 时，使用 `manage-worktrees` skill。

## 可复用命令

可复用的命令可以在 `~/Develop/bogit/bbox/` 中维护，并通过 uv 安装到本地。开发与安装方式见仓库 README。

## 命令输出

RTK 会压缩已接入命令的输出，正常执行命令即可。输出被截断时，按恢复提示读取完整结果；输出无法使用时，用 `rtk bypass <命令>` 重跑。

## Eat your shit

工作过程中产生的临时文件、下载文件、构建产物、测试数据和临时环境，不再需要时及时清理，不遗留垃圾占用磁盘空间。
