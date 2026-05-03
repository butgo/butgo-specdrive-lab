# Plan Task Split

Use this action to split a selected Work Package into executable Tasks.

Common inputs follow `.agents/skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan task-split
```

## Purpose

Create a draft Task list inside a selected Work Package.

Work Package remains the dev coding bundle.  
Tasks are the smaller execution steps needed to finish that Work Package.

## Read First

Read only what is needed:

1. `docs/AI_CONTEXT.compact.md`
2. `specdrive/rules/plan-policy.md`
3. project `work/work-roadmap.md`
4. selected Work Package
5. directly related design/API/DB docs
6. needed minimal target specs

## Output

Provide a draft Task split.

`generate` creates a new Task draft from the selected Work Package.
`revise` prints an editable Preview Prompt for revising the Task draft.
It still does not apply files.

Use this shape:

~~~text
Plan action: task-split
Target project: <project>
Target Work Package: <wp>
Run Mode: <generate|revise>

Summary:

Plan Update Candidate:
```markdown
### Task Draft

- ID: T-001
  Goal:
  Source Anchor:
  Input:
  Expected Output:
  Verification:
  Dependency:
  Dev Handoff Note:
```

Files To Change:
docs/projects/<project>/work/work-tasks.md

Issues Found:

Next Step:
~~~

## Next Prompt

Do not print a copy-ready prompt by default.

Print a dev handoff copy-ready prompt only when the user explicitly asks to transition to dev.
Do not print it when human review or Task confirmation is needed first.

## Boundaries

- Do not code.
- Do not run tests.
- Do not set `work-index.md`.
- Do not split beyond the selected Work Package.
- Keep Tasks tied to verification or visible completion where possible.
