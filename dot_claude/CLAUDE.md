# Global Context

## Workspaces

| Path | Purpose |
|------|---------|
| `~/code/aircall/` | Existing Aircall development workspace (has its own CLAUDE.md) |
| `~/Documents/Airbrain/` | Airbrain Mind: direct-edit, non-Git Obsidian knowledge and planning vault |
| `~/aircall/airbrain-runtime/` | Source-controlled Airbrain schemas, validation, migrations and CLI |
| `~/aircall/airbrain-skills/` | Source-controlled Airbrain cross-harness skills |
| `~/aircall/airbrain-heartbeat/` | Source-controlled Jira/GitLab reconciliation and dispatch |
| `~/Library/Application Support/Airbrain/` | Mutable Airbrain logs, indexes, caches and databases |

## Airbrain Mind

When a request involves Airbrain product direction, prior decisions, continuing plans, capturing ideas, recording learning, or recalling repository-specific context:

1. Read `~/Documents/Airbrain/08-Operations/2026-09-15--airbrain-harness-sop.md`.
2. Follow `~/Documents/Airbrain/08-Operations/2026-09-15--airbrain-mind-sop.md`.
3. Search Mind narrowly before creating another record.

Do not consult Mind for every trivial coding question. Repository source and repository-local instructions remain authoritative for current code behavior.

The Mind vault is not a Git repository. Edit it directly; never initialize Git, create worktrees, commits, or merge requests there. Software changes to Runtime, Skills and Heartbeat use their own worktree/test/MR processes.

When an installed `airbrain-*` skill matches, invoke it before generic personal, team or AirCode workflows. For deterministic automation, use the exact plugin-qualified `/airbrain:airbrain-*` command.

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

**Grep before read.** Before opening any file, confirm it contains what you need with grep/search first. Don't read whole files (or directories) to find a thing — locate it, then read the relevant span. Exception: a file you're about to edit and need full context on.

**Tool-call cap.** After ~10 tool calls without visible progress toward the goal, stop and explain the blocker instead of continuing. Sunk cost is not a reason to keep iterating on a broken approach.

**Model delegation.** Sonnet is the default orchestrator. Delegate mechanical, high-volume, low-judgment steps — bulk renames, find/replace across many files, applying a known pattern, scraping command output — to the `mechanic` agent (Haiku). For research or planning that needs deeper reasoning, dispatch the `researcher` agent (Opus) with a tight, self-contained prompt and only the relevant context — not the whole conversation. Keep judgment, design, and risky or irreversible steps yourself.

<!-- icm:start -->
## Persistent memory (ICM) — MANDATORY

This project uses [ICM](https://github.com/rtk-ai/icm) for persistent memory across sessions.
You MUST use it actively. Not optional.

### Recall (before starting work)
```bash
icm recall "query"                        # search memories
icm recall "query" -t "topic-name"        # filter by topic
icm recall-context "query" --limit 5      # formatted for prompt injection
```

### Store — MANDATORY triggers
You MUST call `icm store` when ANY of the following happens:
1. **Error resolved** → `icm store -t errors-resolved -c "description" -i high -k "keyword1,keyword2"`
2. **Architecture/design decision** → `icm store -t decisions-{project} -c "description" -i high`
3. **User preference discovered** → `icm store -t preferences -c "description" -i critical`
4. **Significant task completed** → `icm store -t context-{project} -c "summary of work done" -i high`
5. **Conversation exceeds ~20 tool calls without a store** → store a progress summary

Do this BEFORE responding to the user. Not after. Not later. Immediately.

Do NOT store: trivial details, info already in CLAUDE.md, ephemeral state (build logs, git status).

### Other commands
```bash
icm update <id> -c "updated content"     # edit memory in-place
icm health                                # topic hygiene audit
icm topics                                # list all topics
```
<!-- icm:end -->
