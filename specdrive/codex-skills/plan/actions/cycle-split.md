# Plan Cycle Split

Use this action to place Work Package candidates or Phase items into Cycle stages.

Common inputs follow `specdrive/codex-skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan cycle-split
```

## Purpose

Create a draft Cycle structure for a selected Phase.

Default Cycles:

- Cycle 1 - Minimal Implementation
- Cycle 2 - Stability
- Cycle 3 - Operational Readiness

## Read First

Read only what is needed:

1. project `work/work-roadmap.md`
2. project `work/work-candidates.md` if needed
3. relevant project specs
4. `specdrive/docs/work-system.md`
5. `specdrive/docs/stages/plan-stage.md`

## Output

Provide a draft Cycle allocation.

Use this shape:

```text
Plan action: cycle-split
Target project: <project>
Target Phase: <phase>

Cycle Draft:

- Cycle 1 - Minimal Implementation
  Work Packages:
  Completion Criteria:

- Cycle 2 - Stability
  Work Packages:
  Completion Criteria:

- Cycle 3 - Operational Readiness
  Work Packages:
  Completion Criteria:
```

## Boundaries

- Do not set current execution pointer.
- Do not code.
- Do not treat Cycle placement as confirmed until developer approval.
- Keep future extension ideas out of Cycle 1 unless required for minimum operation.
