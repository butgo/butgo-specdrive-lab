# Dev Sync

Use this action to summarize dev results and prepare project work/status/manual updates.

Preferred argument-based invocation:

```text
$dev sync
```

## Purpose

Sync the result of `$dev run` and `$dev test` back into project work documents.

## Read First

Read only what is needed:

1. project `work/work-index.md`
2. project `work/work-roadmap.md`
3. project `work/work-log.md` if it exists
4. project `status/current-status.md` if it exists
5. project `rules/affected-docs-rules.md` if it exists
6. relevant changed files or test output summary

## Output

Provide a sync draft.

Use this shape:

```text
Dev action: sync
Target project: <project>

Work Log Draft:
- Work Package:
- Completed:
- Tests:
- Remaining:
- Next:

Update Candidates:
- work-log.md:
- work-index.md:
- status/current-status.md:
- manual/**:
- rules/affected-docs-rules.md check:
```

## Boundaries

- Do not commit changes.
- Do not move to the next Work Package without developer confirmation.
- Do not treat failed tests as completed work.
- Do not edit files unless the developer explicitly asks to apply the sync draft.

