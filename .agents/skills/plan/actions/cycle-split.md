# Plan Cycle Split

Split one Phase from `work-roadmap.md` into Cycle stages.

Common inputs: `.agents/skills/plan/inputs.md` only if parsing is unclear.
Policy fallback: `specdrive/rules/plan-policy.md` only if boundaries are unclear.

Invocation:

```text
$plan cycle-split
$plan cycle-split <project>
$plan cycle-split <project> <phase>
```

## Purpose

Create a Cycle Draft for one selected Phase.

Default Cycles:

- Cycle 1 - Minimal Implementation
- Cycle 2 - Stability
- Cycle 3 - Operational Readiness

Do not split Work Package or Task details.

## Fast Read Scope

Default project: `board`.

Read:

1. `docs/projects/<project>/work/work-roadmap.md`
2. `docs/projects/<project>/work/work-candidates.md` only if Phase items are unclear

Read router/registry only when project is unclear.
Read specs only when roadmap/candidates are missing or unclear.
Do not read source code, README, full policies, unrelated specs, bundle docs, `docs/history/**`, or version-control data.

## Target Phase

If Phase is omitted, use Phase 1 only when it is the only implementation-ready Phase.
Otherwise ask the user to choose one Phase.

## Output

~~~text
Plan action: cycle-split
Target project: <project>
Target Phase: <phase>
Run Mode: generate

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

Copy-ready Prompt:
~~~

Rules:

- Use only the selected Phase and its candidate references.
- Keep Cycle Draft concise.
- Keep future extension ideas out of Cycle 1 unless required.
- Treat output as draft until developer confirmation.
- If no blocking issue, print one apply prompt for `work-roadmap.md`.
- Do not print `$plan task-split` after a new Cycle Draft.

Apply prompt:

```text
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-roadmap.md` 파일에 선택한 Phase의 Cycle Draft를 반영해줘.

변경 파일은 `docs/projects/<project>/work/work-roadmap.md` 하나로 제한해줘.
문서 원문 재설계, source code 수정, 테스트 실행, history snapshot/note 생성, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

Boundaries: do not modify files, create history, set `work-index.md`, code, test, or perform version-control work.
