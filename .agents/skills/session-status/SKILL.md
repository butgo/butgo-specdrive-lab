---
name: session-status
description: Show a compact specdrive session status in about six lines. Prefer $session status; $session-status remains a compatibility command.
---

# Session Status

Use this skill to show a compact status snapshot for the current specdrive session.

Preferred argument-based invocation:

```text
$session status
```

## Read First

Read only what is needed:

1. `docs/AI_CONTEXT.md`
2. current branch
3. `git status --short`

From `docs/AI_CONTEXT.md`, check only:

1. last updated date
2. current one-line summary
3. next entry point heading or first candidate

Do not read the full recovery document set. Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

## Output

Reply in about six lines. Use this shape:

```text
AI_CONTEXT: <last-updated or unknown>, <one-line freshness note>
branch: <current branch>
workspace: <clean or changed paths count and major areas>
focus: <one short focus line from AI_CONTEXT>
next: <one short next-entry line from AI_CONTEXT>
note: <one caution or "no file changes made">
```

Keep each line short. This skill is for quick orientation, not full session recovery.

## Boundaries

- Do not edit files.
- Do not generate a copy prompt.
- Do not perform `doc`, `dev`, `git`, or `session-save` work.
- Do not treat AI_CONTEXT content as automatically up to date if Git changes suggest it may be stale.
- If local changes include `docs/AI_CONTEXT.md`, mention that the AI_CONTEXT status itself is modified locally.
