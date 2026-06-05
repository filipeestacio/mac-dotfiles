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

## ECC rules precedence

ECC rule packs live at `~/.claude/rules/ecc/` (common, typescript, react, python, ruby). Treat them as **advisory defaults, subordinate** to: (1) this file, (2) the active project's CLAUDE.md, (3) superpowers skills. Where they conflict, the higher authority wins. Specifically:

- **Surgical-changes and no-cosmetic-churn override the ECC quality checklist** (immutability, function/file-size caps, "split long functions"). Don't refactor untouched or unowned code to satisfy an ECC rule.
- **ECC `patterns.md` "Skeleton Projects / clone best match" does not apply in Aircall** — work inside existing `modules/`/`trees/`.
- **ECC mandatory-TDD and planner/code-reviewer agents are advisory, not blanket.** Follow project + growth-path guidance on when to apply them.
- **Project "no new comments" overrides ECC** — ECC permits comments; the project forbids new ones.

## Coding behavior

**Surgical changes.** Touch only what the request requires. Don't "improve" adjacent code, comments, formatting, or quote style. Don't refactor things that aren't broken. Match existing style even if you'd do it differently. Pre-existing dead code stays unless the user asks — mention it, don't delete it. Clean up only orphans *your* changes created. Every changed line should trace directly to the request.

**Verify each step.** For multi-step tasks, pair each step with a concrete check before moving on:

```
1. [step] → verify: [what confirms it worked]
2. [step] → verify: [what confirms it worked]
```

Weak criteria ("make it work") force round-trips. Strong criteria ("test X passes", "endpoint returns 200") let the loop close itself.

**Grep before read.** Before opening any file, confirm it contains what you need with grep/search first. Don't read whole files (or directories) to find a thing — locate it, then read the relevant span. Exception: a file you're about to edit and need full context on.

**Tool-call cap.** After ~10 tool calls without visible progress toward the goal, stop and explain the blocker instead of continuing. Sunk cost is not a reason to keep iterating on a broken approach.
