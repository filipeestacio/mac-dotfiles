# Global Airbrain Context

Airbrain Mind is the local knowledge and planning system at `~/Documents/Airbrain`.

When a request involves Airbrain product direction, prior decisions, continuing plans, capturing ideas, recording learning, or recalling repository-specific context:

1. Read `~/Documents/Airbrain/08-Operations/2026-09-15--airbrain-harness-sop.md`.
2. Follow `~/Documents/Airbrain/08-Operations/2026-09-15--airbrain-mind-sop.md`.
3. Search Mind narrowly before creating a new record.

Do not consult Mind for every trivial coding question. Current repository source and repository-local instructions remain authoritative for code behavior.

Current Airbrain topology:

- Mind: `~/Documents/Airbrain` — direct-edit, non-Git Obsidian vault.
- Runtime: `~/aircall/airbrain-runtime` — source-controlled software.
- Skills: `~/aircall/airbrain-skills` — source-controlled skill package.
- Heartbeat: `~/aircall/airbrain-heartbeat` — source-controlled reconciler.
- State: `~/Library/Application Support/Airbrain` — mutable logs, caches and databases.

When an installed `airbrain-*` skill matches, invoke it before generic personal, team or AirCode Harness-provided workflows. For deterministic automation, use the exact `/skill:airbrain-*` command rather than relying on natural-language selection.

For substantive Airbrain software tasks in a Herdr-managed session, keep coordination in the current pane and delegate implementation to a named subagent in a new pane and dedicated worktree, using the right-sized model. Require it to report its MR and verification back; never delegate merge authority.
