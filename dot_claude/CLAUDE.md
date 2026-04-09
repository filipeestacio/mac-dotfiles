# Global Context

## Personal Knowledge Base

My personal knowledge base is an Obsidian vault at `~/secondbrain`. For anything not related to the Aircall workspace (`~/code/aircall`), use this vault as the working context:

- **Read from it** to find context on my ideas, investigations, computer setup, and notes
- **Write to it** when I ask you to capture notes, document something, or save research
- **Search it** when I reference something I've written before or ask about a topic I may have notes on

When starting a conversation from `~` or any non-Aircall directory and the task involves notes, documentation, or personal knowledge work, default to operating within `~/Documents/secondbrain`.

## Dotfiles

Dotfiles are managed with [chezmoi](https://www.chezmoi.io/) and stored in `filipeestacio/mac-dotfiles`. Chezmoi is configured with `autoCommit` and `autoPush` enabled (`~/.config/chezmoi/chezmoi.toml`).

- To add/update a dotfile: `chezmoi add <file>` (auto-commits and pushes)
- To sync local edits back: `chezmoi re-add`
- Source dir: `~/.local/share/chezmoi/`

## Workspaces

| Path | Purpose |
|------|---------|
| `~/code/aircall/` | Aircall development workspace (has its own CLAUDE.md) |
| `~/secondbrain/` | Personal Obsidian vault for everything else |
