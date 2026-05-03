# Session Save

Use this action to prepare a session closing summary and compact state update candidate.

Preferred argument-based invocation:

```text
$session save
$session save specdrive
$session save board
```

## Read First

Read these files directly from the repository:

1. `docs/AI_CONTEXT.compact.md`
2. selected target compact context when the target is explicit
3. `specdrive/rules/session-policy.md`

`docs/AI_CONTEXT.compact.md` is the workspace router. Do not patch it as the target state file unless the user explicitly asks to change the router.

Target mapping:

- `specdrive` -> `specdrive/AI_CONTEXT.compact.md`
- `board` -> `docs/projects/board/AI_CONTEXT.compact.md`

If no target is provided, do not prepare a target context patch. Ask the user to choose `specdrive` or `board`.

Choose the save target from the work that was actually changed or organized, not from every project used as test input.
For example, when testing `$plan` against board documents while editing SpecDrive skill/rule files, prepare only `specdrive/AI_CONTEXT.compact.md`.

Optional references:

- `temp/last-note.md` if it exists
- current project's `work/work-index.md` only if the user asks to confirm the current work pointer
- current project's `work/work-log.md` only when the last entry is needed

`$session save` does not read edited or reviewed target documents by default.
If target document confirmation is needed, hand it off to `$doc confirm`, `$doc history-save`, `$dev sync`, or another explicit action.

Git is handled directly by the developer. Session save does not request or inspect Git information.

## Output

Prepare a draft with these sections:

1. Summary
2. Target AI_CONTEXT.compact Update Candidate
3. Next Entry Point
4. Issues Found
5. Save Prompt

Keep it concise and separate confirmed facts from suggestions.

For the `Target AI_CONTEXT.compact Update Candidate` section, you MUST wrap the content inside a markdown code block using ` ```markdown `.

For the `Save Prompt` section, include a short copy-ready prompt only when the target is explicit. Use this shape:

```text
제공된 반영 초안을 기준으로 `<target AI_CONTEXT.compact.md>` 파일에 반영해줘.
(파일 쓰기 작업을 명시적으로 승인함. 다른 파일은 절대 수정하지 마.)
```

## Stop Points

Do not directly edit files while preparing `$session save` output.

If the user explicitly approves with wording such as "저장해줘", the default editable file is limited to:

```text
specdrive/AI_CONTEXT.compact.md
docs/projects/board/AI_CONTEXT.compact.md
```

Do not edit `docs/AI_CONTEXT.compact.md`, `docs/AI_CONTEXT.md`, status documents, history documents, target documents, or project documents unless the user invokes `$session save-full` or another explicit action.

## Boundaries

- This action does not replace `doc history-save`.
- This action does not create Git commit messages or PR messages.
- Git is handled directly by the developer. This action does not request Git information.
- This action does not create new documents unless the user explicitly asks.
- This action does not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not read target documents by default.
- Do not validate document correctness.
- Do not summarize full project docs.
- Do not inspect Git information.
- Do not create or update history files.
- Do not perform doc, dev, plan, or git work.
