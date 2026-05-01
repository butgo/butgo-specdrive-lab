# Plan WP Split

Use this action to split work candidates into Work Package candidates.

Common inputs follow `specdrive/codex-skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan wp-split
```

## Purpose

Create dev coding bundle candidates from work candidates or development documents.

At the current SpecDrive standard, a Work Package is a dev coding bundle.  
It should leave at least one meaningful behavior, structure, or verification result when completed.

## Read First

Read only what is needed for the selected project:

1. root `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. project `AGENTS.md`
4. project overview and relevant specs
5. project `work/work-candidates.md` if it exists

Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

## Output

Provide a draft list of Work Package candidates.

Use this shape:

```text
Plan action: wp-split
Target project: <project>

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
```

## Boundaries

- Do not create confirmed Tasks.
- Do not set current work pointer.
- Do not code.
- Do not edit files unless the developer explicitly asks to apply the draft.
- Mark unclear candidates as `Needs Clarification`.
