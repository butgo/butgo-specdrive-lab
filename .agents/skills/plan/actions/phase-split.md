# Plan Phase Split

Use this action to place Work Package candidates into Phase ranges.

Common inputs follow `.agents/skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan phase-split
```

## Purpose

Create a draft Phase structure from Work Package candidates.

Phase is the feature-scope axis: it describes what meaningful product or project scope will be built.

## Read First

Read only what is needed:

1. project overview and relevant specs
2. project `work/work-candidates.md`
3. project `work/work-roadmap.md` if it exists
4. `specdrive/docs/work-system.md`
5. `specdrive/docs/stages/plan-stage.md`

## Output

Provide a draft Phase structure.

Use this shape:

```text
Plan action: phase-split
Target project: <project>

Phase Draft:

- Phase 1 - <name>
  Goal:
  Included WP Candidates:
  Excluded / Deferred:
  Open Questions:
```

## Boundaries

- Do not assign current execution pointer.
- Do not split Tasks yet unless the user explicitly asks to combine actions.
- Do not code.
- Treat the Phase structure as a draft until developer confirmation.
