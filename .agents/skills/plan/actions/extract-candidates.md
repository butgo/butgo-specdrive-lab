# Plan Extract Candidates

Use this action to extract general work candidates from development documents.

Common inputs follow `.agents/skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan extract-candidates
```

## Purpose

Extract work candidates from development documents before deciding whether they are Phase items, Work Packages, Tasks, documentation work, or deferred ideas.

This action is broader than `wp-split`.  
It collects possible work candidates and keeps them as candidates, not confirmed execution units.

## Read First

Read only what is needed for the selected project.

First read:

1. `specdrive/config/project-registry.json`

Project Name means the `{project}` key in `docs/projects/{project}`.
Resolve it through `specdrive/config/project-registry.json` when possible.
For the current repository, `board` resolves to `docs/projects/board`.

Then resolve Source Scope only from:

```text
specdrive/config/project-registry.json
projects.<project>.plan.extract_candidates.source_scopes
```

Default Source Scope, scope meanings, and document lists all follow `project-registry.json`.

Do not use a hardcoded document list when a registry entry exists.
Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

## Output

Provide a generated list of work candidate drafts.

Follow the common Skill output UX rules in `specdrive/docs/skill-wizard-manual.md`.
If generated candidates should be created or updated in `work-candidates.md`, treat that as follow-up work:

- include an Apply Draft with target file, change summary, history snapshot path, and history note path;
- include a copy-ready approval prompt asking the developer to approve applying the generated candidates;
- do not edit `work-candidates.md` or history files before that explicit approval.

History filenames must use the common context/action rule:

```text
yyyy-MM-dd_HHmmss_generate-candidates_extract-candidates.md
yyyy-MM-dd_HHmmss_generate-candidates_extract-candidates.note.md
```

Use this shape:

```text
Plan action: extract-candidates
Target project: <project>
Project root: docs/projects/<project>
Source Scope: <current|all|file>
Source Docs:
Run Mode: <generate|review|apply>
Output Mode: <table|markdown|prompt>

Work Candidates:

- ID: CAND-001
  Title:
  Source Docs:
  Candidate Type: Feature | Fix | Refactor | Test | Documentation | Operation | Needs Classification
  Impact Area:
  Impact Confidence: High | Medium | Low
  Impact Evidence:
  Suggested Next Action: wp-split | phase-split | defer | clarify
  Status: Proposed | Needs Clarification
  Notes:

Review Notes:
- Duplicate / Existing Items:
- Possible Missing Items:
- Needs Clarification:

Apply Draft:
- Target file:
- Changes:
- History snapshot:
- History note:
- Approval required: yes

Approval Prompt:
- Include only when generated candidates need to be applied to `work-candidates.md`.
```

## Boundaries

- Do not create confirmed Work Packages or Tasks.
- Do not confirm Phase, Cycle, or implementation location.
- Treat Impact Area as a broad affected area, not only as a Java module or confirmed package/module.
- Treat Impact Confidence as evidence-based estimation. Include Impact Evidence when possible.
- Do not set current work pointer.
- Do not code.
- Do not edit files unless the developer explicitly asks to apply the generated candidate draft.
- When applying to `work-candidates.md`, propose and create history snapshot/note paths from `project-registry.json` only after developer approval.
- Mark unclear candidates as `Needs Clarification`.
