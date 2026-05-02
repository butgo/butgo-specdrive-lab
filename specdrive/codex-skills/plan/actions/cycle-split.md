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

1. `docs/AI_CONTEXT.compact.md`
2. `specdrive/rules/plan-policy.md`
3. project `work/work-roadmap.md`
4. selected Phase
5. project `work/work-candidates.md` if needed
6. needed minimal target specs

## Output

Provide a draft Cycle allocation.

Use this shape:

```text
Plan action: cycle-split
Target project: <project>
Target Phase: <phase>

Cycle Draft:

- Cycle 1 - Minimal Implementation
  Included Phase Items:
  Completion Criteria:

- Cycle 2 - Stability
  Included Phase Items:
  Completion Criteria:

- Cycle 3 - Operational Readiness
  Included Phase Items:
  Completion Criteria:
```

## Boundaries

- Do not set current execution pointer.
- Do not code.
- Do not treat Cycle placement as confirmed until developer approval.
- Do not split Work Package or Task details in this action.
- Keep future extension ideas out of Cycle 1 unless required for minimum operation.
