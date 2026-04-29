# Session Save

Use this action to prepare a session closing summary and `docs/AI_CONTEXT.md` update candidate.

Preferred argument-based invocation:

```text
$session save
```

## Read First

Read these files directly from the repository:

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/session-stage.md`

If the session focused on a target area, also read:

1. the target area's `AGENTS.md`
2. the target area's `README.md`
3. the target area's `index.md`
4. the edited or reviewed target document

Use Git status only when needed to understand the changed areas. Do not require a full file list by default.

## Output

Prepare a draft with these sections:

1. work completed in this session
2. verification performed
3. `docs/AI_CONTEXT.md` update candidate
4. next entry point
5. pending or deferred items
6. save prompt
7. files to be changed

Keep it concise and separate confirmed facts from suggestions.

For the save prompt section, include a short copy-ready prompt that the user can paste back to approve saving. Use this shape:

```text
아래 `docs/AI_CONTEXT.md` 반영 후보를 기준으로 저장해줘.
변경되는 파일은 `docs/AI_CONTEXT.md` 로 한정해줘.
```

For the files to be changed section, list the files that would be edited if the user approves. By default, this should be:

```text
docs/AI_CONTEXT.md
```

## Stop Points

Do not directly edit `docs/AI_CONTEXT.md` or any status/history document.

After showing the draft, wait for explicit user approval such as "저장해줘" before making file changes.

## Boundaries

- This action does not replace `doc history-save`.
- This action does not create Git commit messages or PR messages.
- This action does not create new documents unless the user explicitly asks.
- This action does not inspect `docs/history/**` unless the user explicitly asks for history lookup.
