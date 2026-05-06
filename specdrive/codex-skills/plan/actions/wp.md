# Plan WP

Package Task candidates into AI-executable Work Packages.

Common inputs: `specdrive/codex-skills/plan/inputs.md` only if parsing is unclear.
Policy fallback: `specdrive/rules/plan-policy.md` only if boundaries are unclear.

Invocation:

```text
$plan wp
$plan wp <project>
$plan wp <project> <scope>
```

## Purpose

Create Work Package candidates from Task candidates.

At the current SpecDrive standard, a Work Package is an AI execution unit.
It packages related Task candidates into a scope that Codex/Gemini/Ollama/Antigravity Runner can implement.

This action does not split work further. It packages Task candidates.

## Fast Read Scope

Default project: `board`.

Read:

1. `docs/projects/<project>/work/work-tasks.md`
2. `docs/projects/<project>/work/work-roadmap.md` only if Task candidate phase/cycle context is unclear
3. `docs/projects/<project>/work/work-candidates.md` only if Task candidate sources are unclear

Read router/registry only when project is unclear.
Read specs only when roadmap/candidates are missing or unclear.
Do not read source code, README, full policies, unrelated specs, bundle docs, `docs/history/**`, or version-control data.

## Target Scope

Default scope is all Task candidates currently present in `work-tasks.md`.
If the user names a Phase or Cycle, use only that subset.
Use Task candidate IDs and their linked CAND keys when packaging Work Packages.

## Output

~~~text
Plan action: wp
Target project: <project>
Target Scope: all Task candidates | <phase> | <cycle>
Run Mode: generate

Summary:

Plan Update Candidate:
```markdown
### Work Package Draft

- ID: WP-001
  Goal:
  Source Tasks:
  Source Candidates:
  Scope:
  Target Files:
  Reference Docs:
  Verification:
  Dependency:
  Out of Scope:
```

Files To Change:
docs/projects/<project>/work/work-roadmap.md

Issues Found:

Next Step:

Copy-ready Prompt:
~~~

Rules:

- Keep Work Package candidates concise.
- Use `Needs Clarification` when Task candidates or their CAND links are unclear.
- Do not include items outside the target scope.
- Do not create final implementation Tasks.
- Treat output as draft until developer confirmation.
- If no blocking issue, print one apply prompt for `work-roadmap.md`.
- Do not print `$dev impl-run` after a new Work Package Draft unless the user explicitly asks for dev transition.

Apply prompt:

```text
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-roadmap.md` 파일에 선택한 Cycle의 Work Package Draft를 반영해줘.

변경 파일은 `docs/projects/<project>/work/work-roadmap.md` 하나로 제한해줘.
문서 원문 재설계, source code 수정, 테스트 실행, history snapshot/note 생성, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

Boundaries: do not modify files, create history, set `work-index.md`, code, test, split Tasks, or perform version-control work.
