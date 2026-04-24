---
name: session-start-lite
description: Quickly recover the current specdrive focus and next entry point from docs/AI_CONTEXT.md with minimal document reads. Use when VSCode or Codex has just started and the full $session-start flow feels heavy.
---

# Session Start Lite

Use this skill for a lightweight session re-entry before running the full session recovery flow.

## Read First

Read only the minimum needed from:

```text
docs/AI_CONTEXT.md
```

Focus on these sections first:

1. current one-line summary
2. next session start checklist
3. next entry point
4. current focus
5. work caution principles

Do not read `README.md`, root `AGENTS.md`, `docs/specdrive/AGENTS.md`, or `docs/specdrive/session-stage.md` unless the user explicitly asks for deeper recovery.

## Output

Reply with only a short recovery summary:

1. current focus
2. next entry point
3. caution areas for changes

Keep the response brief. This skill is intended to avoid heavy first-run context loading in VSCode.

## Stop Points

Ask for confirmation before:

- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

Do not edit files until the user explicitly asks you to do so.

## Boundaries

- Do not perform `doc`, `dev`, `session-save`, or `git` work.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not treat undecided ideas as confirmed decisions.
- Do not print a large copy prompt; that belongs to `$session-start`.
