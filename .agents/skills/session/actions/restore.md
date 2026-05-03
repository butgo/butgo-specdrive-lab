# Session Restore

Use this action when the editor, Codex UI, or conversation context was restarted and the user needs to resume the interrupted work safely.

Preferred argument-based invocation:

```text
$session restore
$session restore specdrive
$session restore board
```

## Read First

Read only what is needed for a practical restart:

1. `docs/AI_CONTEXT.compact.md`
2. selected target compact context
3. `specdrive/rules/session-policy.md`

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

Do not read `docs/history/**` unless the user explicitly asks for history lookup.
Do not load the full recovery read set unless the user explicitly asks for deeper recovery.

## Output

Reply with a compact restore summary:

1. restored target
2. restored focus
3. next entry point
4. caution areas for changes
5. suggested next session action, if useful

Keep the response brief. This action is meant for "VSCode restarted, continue from here" recovery.

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
- Git is handled directly by the developer. Session restore does not request Git information.
- Do not create a full recovery copy prompt; that belongs to `$session start-full`.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not treat undecided ideas as confirmed decisions.
