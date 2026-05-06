# Plan Phase Split

Use this action to group extracted work candidates into Phase ranges.

Common inputs: `.agents/skills/plan/inputs.md` only if input parsing is unclear.
Policy fallback: `specdrive/rules/plan-policy.md` only if boundaries are unclear.

Preferred invocation:

```text
$plan phase-split
$plan phase-split <project>
```

## Purpose

Create a Phase Draft from project `work/work-candidates.md`.

Phase is the largest plan layer: a product/project scope or milestone.
This action must not split Cycle, Work Package, or Task details.

## Fast Read Scope

Default project is `board` unless the user provides another project.

Read only:

1. `docs/projects/<project>/work/work-candidates.md`
2. Check whether `docs/projects/<project>/work/work-roadmap.md` exists

Read `docs/AI_CONTEXT.compact.md` or `specdrive/config/project-registry.json` only when the project is unclear.
Read specs only when `work-candidates.md` is missing, incomplete, or has unclear anchors.

Do not read source code, README, full policies, unrelated specs, bundle docs, `docs/history/**`, or version-control data.

## Output

Output one compact Phase Draft and one apply prompt when there is no blocking issue.

Shape:

~~~text
Plan action: phase-split
Target project: <project>
Run Mode: generate

Summary:

Plan Update Candidate:
```markdown
### Phase Draft

- Phase 1 - <name>
  Goal:
  Included Candidates:
  Excluded / Deferred:
  Dependency:
  Exit Criteria:
```

Files To Change:
docs/projects/<project>/work/work-roadmap.md

Issues Found:

Next Step:

Copy-ready Prompt:
~~~

## Phase Draft Rules

- Use only candidate IDs, titles, dependencies, priorities, and deferred flags from `work-candidates.md`.
- Keep each Phase concise.
- Do not invent implementation details.
- Keep deferred candidates deferred unless the candidate file says otherwise.
- Treat the output as a draft until developer confirmation.

## Copy-ready Prompt Rule

After generating a Phase Draft with no blocking issue, print exactly one apply prompt:

```text
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-roadmap.md` 파일에 반영해줘.

변경 파일은 `docs/projects/<project>/work/work-roadmap.md` 하나로 제한해줘.
문서 원문 재설계, source code 수정, 테스트 실행, history snapshot/note 생성, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

Do not print a `$plan cycle-split` prompt after a newly generated Phase Draft.

## Boundaries

- Do not modify files in this action.
- Do not create history snapshot or note.
- Do not set `work-index.md`.
- Do not code or run tests.
- Do not perform version-control work.
