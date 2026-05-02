# Plan Phase Split

Use this action to place extracted work candidates into Phase ranges.

Common inputs follow `specdrive/codex-skills/plan/inputs.md`.

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

Phase Draft:

- Phase 1 - <name>
  Goal:
  Included Candidates:
  Excluded / Deferred:
  Open Questions:
```

## Boundaries

- Do not assign current execution pointer.
- Do not split Cycle, Work Package, or Task details in this action.
- Do not code.
- Treat the Phase structure as a draft until developer confirmation.
