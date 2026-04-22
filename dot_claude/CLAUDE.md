# Global Context

## Workspaces

| Path | Purpose |
|------|---------|
| `~/code/aircall/` | Aircall development workspace (has its own CLAUDE.md) |
| `~/secondbrain/` | Personal Obsidian vault — everything non-Aircall |

`~/secondbrain/` is the working context for anything outside `~/code/aircall/`:

- **Read from it** to find context on my ideas, investigations, computer setup, and notes
- **Write to it** when I ask you to capture notes, document something, or save research
- **Search it** when I reference something I've written before or ask about a topic I may have notes on

When starting a conversation from `~` or any non-Aircall directory and the task involves notes, documentation, or personal knowledge work, default to operating within `~/secondbrain/`.

## Dotfiles

Dotfiles are managed with [chezmoi](https://www.chezmoi.io/) and stored in `filipeestacio/mac-dotfiles`. Chezmoi is configured with `autoCommit` and `autoPush` enabled (`~/.config/chezmoi/chezmoi.toml`).

- To add/update a dotfile: `chezmoi add <file>` (auto-commits and pushes)
- To sync local edits back: `chezmoi re-add`
- Source dir: `~/.local/share/chezmoi/`

## Coding behavior

**Surgical changes.** Touch only what the request requires. Don't "improve" adjacent code, comments, formatting, or quote style. Don't refactor things that aren't broken. Match existing style even if you'd do it differently. Pre-existing dead code stays unless the user asks — mention it, don't delete it. Clean up only orphans *your* changes created. Every changed line should trace directly to the request.

**Verify each step.** For multi-step tasks, pair each step with a concrete check before moving on:

```
1. [step] → verify: [what confirms it worked]
2. [step] → verify: [what confirms it worked]
```

Weak criteria ("make it work") force round-trips. Strong criteria ("test X passes", "endpoint returns 200") let the loop close itself.
