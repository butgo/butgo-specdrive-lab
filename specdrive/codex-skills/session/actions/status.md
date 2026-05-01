# Session Status

Use this action to show a compact status snapshot for the current specdrive session.

Preferred argument-based invocation:

```text
$session status
```

## Read First

Read only what is needed:

1. `docs/AI_CONTEXT.md`

From `docs/AI_CONTEXT.md`, check only:

1. last updated date
2. current one-line summary
3. next entry point heading or first candidate

Do not read the full recovery document set. Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

## Output

Reply in about six lines. Use this shape:

```text
AI_CONTEXT: <last-updated or unknown>, <one-line freshness note>
focus: <one short focus line from AI_CONTEXT>
next: <one short next-entry line from AI_CONTEXT>
git: developer-managed, not checked unless explicitly requested
note: <one caution or "no file changes made">
```

Keep each line short. This action is for quick orientation, not full session recovery.

## Boundaries

- Do not edit files.
- Do not generate a copy prompt.
- Do not perform `doc`, `dev`, `git`, or `session save` work.
- Git is handled directly by the developer. Do not check Git status unless the developer explicitly asks.
