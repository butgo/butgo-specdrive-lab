# Session Start

Use this action for a lightweight session re-entry.

Preferred argument-based invocation:

```text
$session start
$session start specdrive
$session start board
```

## Read First

Read only the minimum needed from:

```text
docs/AI_CONTEXT.compact.md
<target AI_CONTEXT.compact.md>
specdrive/rules/session-policy.md
```

`docs/AI_CONTEXT.compact.md` is the workspace router. Use it to choose one target context.

Target mapping:

- `specdrive` -> `specdrive/AI_CONTEXT.compact.md`
- `board` -> `docs/projects/board/AI_CONTEXT.compact.md`

If no target is provided, use the router's active/default target.

From the selected target context, focus on:

1. current focus
2. next entry point
3. read scope hint
4. open questions

Do not read `README.md`, root `AGENTS.md`, `specdrive/docs/AGENTS.md`, or `specdrive/docs/stages/session-stage.md` unless the user explicitly asks for deeper recovery.

## Output

Reply with only a short recovery summary:

1. active target
2. current focus
3. next entry point
4. caution areas for changes

Keep the response brief. This action is intended to avoid heavy first-run context loading.

## Stop Points

Ask for confirmation before:

- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

Do not edit files until the user explicitly asks you to do so.

## Boundaries

- Do not perform `doc`, `dev`, `session save`, or `git` work.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not treat undecided ideas as confirmed decisions.
- Do not print a large copy prompt; that belongs to `$session start-full`.
