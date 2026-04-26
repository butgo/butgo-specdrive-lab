---
name: session
description: Route specdrive session actions by argument. Use when the user invokes $session, $session start-lite, $session start, $session status, or $session save.
---

# Session

Use this skill as the argument-based entry point for specdrive session work.

Supported actions:

- `start-lite`
- `start`
- `status`
- `save`

Aliases:

- `lite` -> `start-lite`
- `start-lite` -> `start-lite`
- `start` -> `start`
- `status` -> `status`
- `save` -> `save`

If the user did not provide an action, list the action choices and stop.

## Dispatch

Follow the matching repo-local skill instructions:

- `start-lite`: `.agents/skills/session-start-lite/SKILL.md`
- `start`: `.agents/skills/session-start/SKILL.md`
- `status`: `.agents/skills/session-status/SKILL.md`
- `save`: `.agents/skills/session-save/SKILL.md`

Do not combine actions in one response unless the user explicitly asks.

## Output: No Action

Reply with:

1. available actions
2. short descriptions
3. copy-ready examples

Examples:

```text
$session start-lite
$session start
$session status
$session save
```

## Boundaries

- Session work is meta operation work.
- Do not perform `doc`, `dev`, or `git` work through this skill.
- Do not edit files unless the dispatched action explicitly allows it and the user approves.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
