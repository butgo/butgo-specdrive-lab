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

1. `docs/AI_CONTEXT.compact.md`
2. `specdrive/rules/plan-policy.md`
3. project `work/work-roadmap.md`
4. selected Work Package
5. directly related design/API/DB docs
6. needed minimal target specs

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
