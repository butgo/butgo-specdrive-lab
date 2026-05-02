# Plan WP Split

Use this action to split work candidates into Work Package candidates.

Common inputs follow `.agents/skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan wp-split
```

## Purpose

Create dev coding bundle candidates from a selected Cycle.

At the current SpecDrive standard, a Work Package is a dev coding bundle.  
It should leave at least one meaningful behavior, structure, or verification result when completed.

## Read First

Read only what is needed for the selected project:

1. `docs/AI_CONTEXT.compact.md`
2. `specdrive/rules/plan-policy.md`
3. project `work/work-roadmap.md`
4. selected Cycle
5. project `work/work-candidates.md` if needed
6. needed minimal target specs

Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

## Output

Provide a draft list of Work Package candidates.

Use this shape:

```text
Plan action: wp-split
Target project: <project>

Summary:

Plan Update Candidate:

Work Package Candidates:

- ID: WP-CAND-001
  Title:
  Source Candidates:
  Source Docs:
  Expected Output:
  Suggested Phase:
  Suggested Cycle:
  Status: Proposed | Needs Clarification
  Notes:

Files To Change:

Issues Found:

Next Step:

Copy-ready Prompt:
- Include only when the Next Prompt condition is satisfied.
```

## Next Prompt

Print a `$plan task-split` copy-ready prompt only when:

- the target WP is clear;
- the WP scope is suitable as a dev execution unit;
- the next step is clearly `$plan task-split`.

Do not print it when human review or WP confirmation is needed first.

## Boundaries

- Do not create confirmed Tasks.
- Do not set current work pointer.
- Do not code.
- Do not split Task details in this action.
- Do not edit files unless the developer explicitly asks to apply the draft.
- Mark unclear candidates as `Needs Clarification`.
