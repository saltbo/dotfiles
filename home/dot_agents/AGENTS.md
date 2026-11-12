## Directories

- `~/Develop/bogit/`: repositories owned by the user.
- `~/Develop/oss/`: open-source repositories. Clone open-source projects here for research or fork-related work.

## Package management

Prefer Homebrew for command-line tools. Use uv for the Python ecosystem and Volta for the Node.js ecosystem.

## Dotfiles

User-level dotfiles are managed with chezmoi. Use the `manage-dotfiles` skill when changing personal configuration or global agent instructions.

## Realmroot

Realmroot provides agents with their own identity. Use the `realmroot` skill to work under that identity.
Read operations may use the owner's credentials. Prefer the agent's own identity for writes and deletions; if it is unavailable, the owner's credentials may also be used.
Whenever the owner's credentials are used, disclose the identity, reason, and operations performed in the final report.

## Worktrees

Use the `manage-worktrees` skill when manually creating or cleaning up worktrees.

## Reusable commands

Reusable commands can be maintained in `~/Develop/bogit/bbox/` and installed locally through uv. See the repository README for development and installation.

## Command output

RTK compresses output for integrated commands; run commands normally. If output is truncated, follow its recovery instructions to read the full result. If output is unusable, rerun with `rtk bypass <command>`.

## Eat your shit

Clean up temporary files, downloads, build artifacts, test data, and temporary environments created during your work as soon as they are no longer needed. Do not leave unused artifacts consuming disk space.
