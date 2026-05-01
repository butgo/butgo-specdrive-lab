# Plan Task Split

Use this action to split a selected Work Package into executable Tasks.

Common inputs follow `specdrive/codex-skills/plan/inputs.md`.

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

1. project `work/work-roadmap.md`
2. project `work/work-policy.md` if it exists
3. relevant project specs
4. `specdrive/docs/work-system.md`
5. `specdrive/docs/stages/plan-stage.md`
6. `specdrive/docs/stages/dev-stage.md`

## Output

Provide a draft Task split.

Use this shape:

```text
Plan action: task-split
Target project: <project>
Target Work Package: <wp>

Task Draft:

- T-001:
  Purpose:
  Inputs:
  Expected Output:
  Verification:
  Notes:
```

## Boundaries

- Do not code.
- Do not run tests.
- Do not set `work-index.md`.
- Do not split beyond the selected Work Package.
- Keep Tasks tied to verification or visible completion where possible.
