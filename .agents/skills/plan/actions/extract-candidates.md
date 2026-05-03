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

1. `docs/AI_CONTEXT.compact.md`
2. `specdrive/rules/plan-policy.md`
3. `specdrive/config/project-registry.json`

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

## Existing Candidates Rule

Check only whether `docs/projects/<project>/work/work-candidates.md` exists.

If it exists, do not assume the generated candidates should be applied directly.
In `Next Step`, print three short copy-ready prompts:

```text
기존 `docs/projects/<project>/work/work-candidates.md` 파일이 있습니다.

Overwrite Prompt:
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-candidates.md`를 덮어써줘.
덮어쓰기 전에 기존 파일은 history 파일로 백업해줘.
변경 파일은 `docs/projects/<project>/work/work-candidates.md`와 생성되는 history 백업 파일로 제한해줘.
문서 원문 재설계, source code 수정, version-control 작업은 하지 마.

Keep Existing Prompt:
기존 `docs/projects/<project>/work/work-candidates.md` 파일은 유지해줘.
이번 Plan Update Candidate는 참고용으로만 사용하고 파일은 수정하지 마.
다음 단계로 `$plan phase-split` 진행 가능 여부만 짧게 검토해줘.

Revise Prompt:
$plan extract-candidates revise
```

If overwrite is later approved, create a history backup before replacing `work-candidates.md`.
Do not read existing `docs/history/**` file bodies just to prepare this choice.

## Output

Provide a generated list of work candidate drafts.

Follow `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.
`generate` prints candidate drafts only by default.
`revise` prints an editable Preview Prompt for revising candidate drafts.
If the user invokes `$plan extract-candidates revise` without a concrete revision request, do not revise candidate drafts immediately.
Output only one copy-ready Preview Prompt.
Do not include detailed review, file apply, approval prompt, or history snapshot/note work by default.

For revise, use this shape:

~~~text
아래 프롬프트를 사용해주세요.

```text
Plan extract-candidates revise 실행 기준으로 진행해줘.

## Target

- target project: <project>
- target document: docs/projects/<project>/work/work-candidates.md
- source scope: <current|all|file>
- run mode: revise

## Developer Revision Request

아래 영역에는 확정된 수정 요청, 논의하고 싶은 방향, 질문, 메모 중 현재 준비된 내용을 적는다.
아직 범위가 분명하지 않으면 Codex와 대화하면서 수정 범위를 먼저 맞춰간다.

<수정 요청 또는 논의하고 싶은 방향을 작성>

## Codex Task

대상 work-candidates 문서와 직전 Plan Update Candidate가 있으면 함께 기준으로 삼아,
Developer Revision Request를 반영한 revised Plan Update Candidate를 만들어줘.
수정 범위가 충분히 분명하면 파일 수정 없이 revised Plan Update Candidate만 출력해줘.
수정 범위가 불분명하면 파일 수정 없이 먼저 확인 질문, 범위 후보, 선택지를 제시해줘.

## Codex Must Do

- 현재 action은 extract-candidates로 유지한다.
- Candidate 계층만 다룬다.
- 기존 후보를 임의로 삭제하지 않는다.
- 중복, 병합, 보류가 필요한 항목은 Issues Found에 짧게 표시한다.
- Plan Update Candidate는 markdown 코드블록으로 감싼다.

## Codex Must Not Do

- Phase, Cycle, Work Package, Task로 분해하지 않는다.
- 파일을 수정하지 않는다.
- docs/history/** 기존 파일 본문을 읽지 않는다.
- history snapshot이나 note를 생성하지 않는다.
- source code 수정, 테스트 실행, version-control 작업을 하지 않는다.
```
~~~

Use this shape:

~~~text
Plan action: extract-candidates
Target project: <project>
Source Scope: <current|all|file>
Run Mode: <generate|revise>

Summary:

Plan Update Candidate:
```markdown
### Work Candidates

- ID: CAND-001
  Title:
  Source Anchor:
  Summary:
  Type: Feature | Fix | Refactor | Test | Documentation | Operation | Needs Classification
  Priority: High | Medium | Low
  Dependency:
  Deferred: Yes | No
```

Files To Change:
docs/projects/<project>/work/work-candidates.md

Issues Found:

Next Step:
~~~

## Next Prompt

Print a `$plan phase-split` copy-ready prompt only when:

- candidate drafts are sufficiently organized;
- human review or confirmation is not needed first;
- the next step is clearly `$plan phase-split`.

Do not print a copy-ready prompt otherwise.

## Boundaries

- Do not create confirmed Work Packages or Tasks.
- Do not confirm Phase, Cycle, or implementation location.
- Treat Source Anchor as evidence for the candidate, not as confirmation that the work is ready for dev.
- Do not set current work pointer.
- Do not code.
- Do not edit files unless the developer explicitly asks to apply the generated candidate draft.
- When applying to `work-candidates.md`, handle history snapshot/note paths only as optional follow-up candidates after developer approval.
- Mark unclear candidates as `Needs Clarification`.
