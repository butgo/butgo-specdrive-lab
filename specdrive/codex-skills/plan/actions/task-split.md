# Plan Task Split

Split CAND items into Task candidates for Work Package packaging.

Common inputs: `specdrive/codex-skills/plan/inputs.md` only if parsing is unclear.
Policy fallback: `specdrive/rules/plan-policy.md` only if boundaries are unclear.

Invocation:

```text
$plan task-split
$plan task-split <project>
```

## Purpose

Create Task candidates from all CAND items in the current plan document.

These Tasks are not final implementation Tasks.
They are candidate work items used as material for `$plan wp`.
This action does not assign WP ownership, execution order, or Codex execution units.
Each Task candidate must keep an explicit link to its source CAND key.

## Fast Read Scope

Default project: `board`.

Read:

1. `docs/projects/<project>/work/work-roadmap.md`
2. `docs/projects/<project>/work/work-candidates.md` only if CAND details are unclear

Read router/registry only when project is unclear.
Read specs only when roadmap/candidates are missing or unclear.
Do not read source code, README, full policies, unrelated specs, bundle docs, `docs/history/**`, or version-control data.

## Target Scope

Default scope is all CAND items currently present in `work-roadmap.md`.
If the user names a Phase or Cycle, use only that subset.
Do not ask the user to choose a Cycle when `$plan task-split` is invoked without a Cycle.
Use CAND keys as the source anchor for every Task candidate.

## Output

~~~text
Plan action: task-split
Target project: <project>
Target Scope: all CAND items | <phase> | <cycle>
Run Mode: generate

Summary:

Plan Update Candidate:
```markdown
### Task Split Map

- CAND-001: 1 task - <reason>
- CAND-002: 2-3 tasks - <reason>

### Task Candidate Draft

- ID: TASK-CAND-001-01
  Source Candidate: CAND-001
  Goal:
  Expected Output:
  WP Packaging Note:
```

Files To Change:
docs/projects/<project>/work/work-tasks.md

Issues Found:

Next Step:

Copy-ready Prompt:
~~~

Rules:

- Keep Task candidates concise.
- Cover all CAND items in the target scope.
- Every Task candidate must include `Source Candidate: CAND-xxx`.
- Create at least one Task candidate per CAND.
- Split one CAND into multiple Task candidates when it contains multiple meaningful work items.
- Use IDs that preserve the source CAND key, such as `TASK-CAND-002-01`.
- Do not split to atomic code steps; split only enough for `$plan wp` packaging.
- First output `Task Split Map`, then `Task Candidate Draft`.
- Use compact Task fields by default: `ID`, `Source Candidate`, `Goal`, `Expected Output`, `WP Packaging Note`.
- Add `Scope`, `Verification`, or `Dependency` only when needed to disambiguate packaging.
- Do not assign Task candidates to a final WP.
- Do not define final execution order beyond obvious dependencies.
- Do not create Codex execution units in this action.
- Treat output as draft until developer confirmation.
- If no blocking issue, print one apply prompt for `work-tasks.md`.
- Do not print `$plan wp` after a new Task Candidate Draft unless the Task candidates are already confirmed.

Apply prompt:

```text
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-tasks.md` 파일에 Task Candidate Draft를 반영해줘.

변경 파일은 `docs/projects/<project>/work/work-tasks.md` 하나로 제한해줘.
문서 원문 재설계, source code 수정, 테스트 실행, history snapshot/note 생성, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

Boundaries: do not modify files, create history, set `work-index.md`, code, test, create Work Packages, or perform version-control work.
