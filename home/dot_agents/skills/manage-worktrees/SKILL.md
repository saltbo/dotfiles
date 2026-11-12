---
name: manage-worktrees
description: 管理手动创建的 Git worktree，包括存放位置、命名和任务结束后的清理。需要为任务手动创建隔离工作副本，或清理本次创建的 worktree 时使用。
---

# 手动 Worktree

## 创建

- 用 `git worktree list` 查看仓库已有的工作副本。
- 手动创建的 worktree 统一放在 `~/Develop/worktrees/<仓库名>-<任务名>/`。
- 任务名使用简短的小写英文、数字和连字符，例如 `zpan-fix-upload`。
- 从任务需要的基准分支创建工作副本，任务分支遵循项目约定。通过 `git worktree add` 创建。

## 清理

- 任务结束后，确认成果已妥善保存，用 `git worktree remove <路径>` 清理本次创建的 worktree。
- 对应的本地任务分支在合并后用 `git branch -d <分支>` 清理。
- 有未保存的工作时先处理，不强制删除；只清理本次任务创建的工作副本。
- 用 `git worktree list` 确认清理结果。

由软件管理的工作副本按对应软件的流程管理。
