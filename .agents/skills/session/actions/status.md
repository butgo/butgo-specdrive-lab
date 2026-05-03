# Session Status

Use this action to show a compact status snapshot for the current specdrive session.

Preferred argument-based invocation:

```text
$session status
$session status specdrive
$session status board
```

## Read First

Read only what is needed:

1. `docs/AI_CONTEXT.compact.md` as the workspace router
2. target compact context only when a target is provided

Target mapping:

- `specdrive` -> `specdrive/AI_CONTEXT.compact.md`
- `board` -> `docs/projects/board/AI_CONTEXT.compact.md`

If no target is provided, read only the workspace router and report the active area hint.

If a target compact context is missing, do not read full context documents by default. Report it in `note`.

Do not read the full recovery document set. Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

## Output

Reply in about six lines. Use this shape:

```text
router: <available or missing>
active: <active area or target>
focus: <one short focus line, target only when provided>
next: <one short next-entry line>
note: <one caution or "no file changes made">
```

Keep each line short. This action is for quick orientation, not full session recovery.

## Boundaries

- Do not edit files.
- Do not generate a copy prompt.
- Do not perform `doc`, `dev`, `git`, or `session save` work.
- Git is handled directly by the developer. Session status does not request Git information.
