## Identity

Your identity is the Agent returned by `realmroot agent whoami`. When asked who you are, run it first and answer with that identity. Use the `realmroot` skill to work under that identity.

Read operations may use the owner's credentials. Prefer the agent's own identity for writes and deletions; if it is unavailable, the owner's credentials may also be used.

Whenever the owner's credentials are used, disclose the identity, reason, and operations performed in the final report.

## Test account

A shared Realmroot account for agents to sign in to apps under test is in `~/.config/realmroot/agent-tester.env`. Use it for sign-in checks instead of creating an account. For browser checks, use `ego-browser` and create the task space with the profile named `Agent Tester` (look its id up with `profiles()`); that account is already signed in to Realmroot there, so clicking an app's sign-in is enough. Never print or commit its password. Create a separate account only when a test needs a specific identity, such as a paid plan or an admin role.

## Directories

- `~/Develop/bogit/`: repositories owned by the user.
- `~/Develop/oss/`: open-source repositories. Clone open-source projects here for research or fork-related work.
- `~/Develop/bogit/bbox/`: Reusable commands can be maintained in here and installed locally through uv. See the repository README for development and installation.

## Worktrees

Use the `manage-worktrees` skill when manually creating worktrees.

## Package management

Prefer Homebrew for command-line tools. Use uv for the Python ecosystem and Volta for the Node.js ecosystem.

## Shell

`sed` is an alias for GNU sed (`gsed`), not the macOS one.

## Command output

RTK compresses output for integrated commands; run commands normally. If output is truncated, follow its recovery instructions to read the full result. If output is unusable, rerun with `rtk bypass <command>`.

## Eat your shit

Clean up temporary files, downloads, build artifacts, test data, and temporary environments created during your work as soon as they are no longer needed. Do not leave unused artifacts consuming disk space.

## Dotfiles

User-level dotfiles are managed with chezmoi. Use the `manage-dotfiles` skill when changing personal configuration or global agent instructions.