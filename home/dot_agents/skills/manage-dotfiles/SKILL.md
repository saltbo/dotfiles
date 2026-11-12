---
name: manage-dotfiles
description: Maintain user-level dotfiles through chezmoi, including what to track, application and verification, and Git delivery. Use when adding or changing personal configuration, shell or tool settings, global agent instructions, or user-maintained skills.
---

# Dotfile maintenance

Save persistent user-level configuration through chezmoi. Manage configuration with chezmoi commands and run Git operations through `chezmoi git`.

## Check the scope

Before editing, use `chezmoi managed`, `chezmoi status`, and `chezmoi git -- status --short` to check management status and existing changes.
Distinguish existing and new files by whether Git already tracks them in the dotfiles repository. A file imported with `chezmoi add` but not yet tracked by Git is still new.

Select individual files for management and commits. Do not import unrelated directory contents or commit changes from other tasks.

## What to track

- Track personal configuration worth preserving to rebuild the environment, including global agent instructions and user-maintained skills.
- Exclude credentials, private keys, sessions, history, caches, logs, tool databases, and other runtime state. Exclude temporary experiments as well.
- Preserve necessary machine differences with templates or conditions. Supply sensitive values through local configuration or secret references.
- Manage tool-owned runtime state through the owning tool rather than editing it directly.

## Save and verify

- New configuration: create the file where it will be used, then import it with `chezmoi add <file>`.
- Managed configuration: edit the source state with `chezmoi edit <file>`, inspect it with `chezmoi diff <file>`, and apply it with `chezmoi apply <file>`. For noninteractive editing, use a chezmoi-supported workflow and save the changes to the source state.
- Preserve existing templates, symlinks, and machine-specific handling. Do not overwrite template sources with rendered output.
- After applying, verify the actual configuration and review both the scoped chezmoi diff and the Git diff.

## Commit and push

- Changes to files already tracked by Git: verify, commit, and push directly. No PR is required.
- Newly managed files: commit on a separate branch, push, and open a PR. Wait for an explicit instruction before merging. Related edits to existing files may be included in the same PR.
- Use `chezmoi git -- <git arguments>` for branches, staging, commits, and pushes. Saving to chezmoi does not complete the Git commit or remote push.

Update the relevant user-level instructions when directory layout, configuration sources, or tool entry points change.
