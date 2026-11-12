---
name: manage-dotfiles
description: 通过 chezmoi 维护用户级 dotfiles，包括纳管范围、应用验证和 Git 交付。修改或新增个人配置、Shell 配置、工具配置、全局 Agent 指令或用户维护的 skills 时使用。
---

# Dotfiles 维护

用户级持久配置通过 chezmoi 保存。使用 chezmoi 命令管理配置，Git 操作通过 `chezmoi git` 执行。

## 确认范围

修改前，用 `chezmoi managed`、`chezmoi status` 和 `chezmoi git -- status --short` 确认管理状态及已有改动。
已有文件和新增文件以 dotfiles 仓库的 Git 跟踪状态区分；仅执行过 `chezmoi add`、尚未进入 Git 的文件仍算新增。

按具体文件确定纳管和提交范围，不整目录收录无关数据，也不提交其他任务的改动。

## 纳管标准

- 需要长期保留、用于重建环境的个人配置纳管，包括全局 Agent 指令和用户维护的 skills。
- 凭据、私钥、会话、历史、缓存、日志、工具数据库等运行状态不纳管；临时实验文件也不纳管。
- 需要保留的机器差异通过模板或条件处理；配置中的敏感值通过本机配置或秘密引用提供。
- 工具维护的运行状态通过所属工具操作，不直接编辑。

## 保存与验证

- 新增配置：在实际使用的位置创建文件后，用 `chezmoi add <文件>` 纳管。
- 修改受管配置：使用 `chezmoi edit <文件>` 编辑源状态，用 `chezmoi diff <文件>` 检查，再用 `chezmoi apply <文件>` 应用。非交互编辑使用 chezmoi 支持的方式完成，并将改动保存到源状态。
- 保留已有模板、链接及机器差异的处理方式，不把渲染结果当作模板源文件覆盖。
- 应用后验证实际配置，检查本次涉及文件的 chezmoi 差异和 Git diff。

## 提交与推送

- 修改 Git 已跟踪的文件：验证后 commit 并直接 push，无需 PR。
- 新增纳管文件：在独立分支 commit、push 并创建 PR，合并等待明确指令。与新增文件属于同一项改动的已有文件修改可以一起进入该 PR。
- 使用 `chezmoi git -- <Git 参数>` 完成分支、暂存、提交和推送操作。保存到 chezmoi 不等于已经完成 Git 提交或远程推送。

目录布局、配置来源或工具入口发生变化时，同步维护相关用户级指令。
