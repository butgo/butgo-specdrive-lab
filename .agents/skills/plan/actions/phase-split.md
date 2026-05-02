# Plan Phase Split

Use this action to place extracted work candidates into Phase ranges.

Common inputs follow `.agents/skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan phase-split
```

## Purpose

Create a draft Phase structure from extracted work candidates.

Phase is the feature-scope axis: it describes what meaningful product or project scope will be built.

## Read First

Read only what is needed:

1. `docs/AI_CONTEXT.compact.md`
2. `specdrive/rules/plan-policy.md`
3. project `work/work-candidates.md`
4. project `work/work-roadmap.md` if it exists
5. needed minimal target specs

## Output

Provide a draft Phase structure.

Use this shape:

```text
Plan action: phase-split
Target project: <project>

Summary:

Plan Update Candidate:

Phase Draft:

- Phase 1 - <name>
  Goal:
  Included Candidates:
  Excluded / Deferred:
  Open Questions:

Files To Change:

Issues Found:

Next Step:

Copy-ready Prompt:
- Include only when the Next Prompt condition is satisfied.
```

## Next Prompt

Print a `$plan cycle-split` copy-ready prompt only when:

- the target Phase is clear;
- the Phase draft can proceed to the next step;
- the next step is clearly `$plan cycle-split`.

Do not print it when human review or Phase confirmation is needed first.

## Boundaries

- Do not assign current execution pointer.
- Do not split Cycle, Work Package, or Task details in this action.
- Do not code.
- Treat the Phase structure as a draft until developer confirmation.
