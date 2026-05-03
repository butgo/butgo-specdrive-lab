# Plan Cycle Split

Use this action to place Work Package candidates or Phase items into Cycle stages.

Common inputs follow `.agents/skills/plan/inputs.md`.

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

`generate` creates a new Cycle draft from the selected Phase.
`revise` prints an editable Preview Prompt for revising the Cycle draft.
It still does not apply files.

Use this shape:

~~~text
Plan action: cycle-split
Target project: <project>
Target Phase: <phase>
Run Mode: <generate|revise>

Summary:

Plan Update Candidate:
```markdown
### Cycle Draft

- Cycle 1 - Minimal Implementation
  Goal:
  Included Phase Items:
  Verification Focus:
  Dependency:
  Exit Criteria:

- Cycle 2 - Stability
  Goal:
  Included Phase Items:
  Verification Focus:
  Dependency:
  Exit Criteria:

- Cycle 3 - Operational Readiness
  Goal:
  Included Phase Items:
  Verification Focus:
  Dependency:
  Exit Criteria:
```

Files To Change:
docs/projects/<project>/work/work-roadmap.md

Issues Found:

Next Step:
~~~

## Next Prompt

Print a `$plan wp-split` copy-ready prompt only when:

- the target Cycle is clear;
- the Cycle draft can proceed to the next step;
- the next step is clearly `$plan wp-split`.

Do not print it when human review or Cycle confirmation is needed first.

## Boundaries

- Do not set current execution pointer.
- Do not code.
- Do not treat Cycle placement as confirmed until developer approval.
- Do not split Work Package or Task details in this action.
- Keep future extension ideas out of Cycle 1 unless required for minimum operation.
