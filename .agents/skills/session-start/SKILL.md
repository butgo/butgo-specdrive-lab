---
name: session-start
description: Recover the current specdrive working context at the start of a session. Use when the user invokes $session-start or asks Codex to restore the current focus, next entry point, and caution areas from repository documents without modifying files.
---

# Session Start

Use this skill to recover the current specdrive session state before doing any document or implementation work.

## Read First

Read these files directly from the repository:

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/session-stage.md`

If the target area is already known, also read:

1. the target area's `AGENTS.md`
2. the target area's `README.md`
3. the target area's `index.md`
4. the current target document

Do not ask the user to paste document bodies. Use the files in the workspace.

## Output

First reply with only a short recovery summary:

1. current focus
2. next entry point
3. caution areas for changes

Mention branch or Git status only when it is already provided or needed for the summary.

## Stop Points

Ask for confirmation before:

- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

Do not edit files until the user explicitly asks you to do so.

## Boundaries

- Do not perform `doc`, `dev`, or `git` work as part of session recovery.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not treat undecided ideas as confirmed decisions.
- Keep the response brief; this skill is for safe re-entry, not full review.
