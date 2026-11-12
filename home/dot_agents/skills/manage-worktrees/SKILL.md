---
name: manage-worktrees
description: Manage manually created Git worktrees, including location, naming, and cleanup after a task. Use when creating an isolated working copy manually or cleaning up a worktree created for the current task.
---

# Manual worktrees

## Create

- Inspect existing working copies with `git worktree list`.
- Place manually created worktrees at `~/Develop/worktrees/<repo>-<task>/`.
- Use a short task name with lowercase letters, digits, and hyphens, such as `zpan-fix-upload`.
- Use `git worktree add` to create the working copy from the base branch needed for the task. Follow the project's conventions for task branches.

## Clean up

- When the task is complete, ensure the work is safely preserved and remove the worktree created for this task with `git worktree remove <path>`.
- After the task branch has been merged, remove the local branch with `git branch -d <branch>`.
- Resolve unsaved work before removal; do not force deletion. Only clean up working copies created for this task.
- Confirm the result with `git worktree list`.

Manage software-owned working copies through the owning software's workflow.
