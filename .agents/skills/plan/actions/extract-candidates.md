# Plan Extract Candidates

Use this action to extract general work candidates from development documents.

Common inputs follow `.agents/skills/plan/inputs.md`.

Preferred argument-based invocation:

```text
$plan extract-candidates
```

## Purpose

Extract work candidates from development documents before deciding whether they are Phase items, Work Packages, Tasks, documentation work, or deferred ideas.

This action is broader than `$plan wp`.  
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
In `Next Step`, show the follow-up choices in this exact split:

- `overwrite`: print a copy-ready prompt for replacing the existing file.
- `keep`: print a copy-ready prompt for keeping the existing file and reviewing whether phase-split can proceed.
- `revise`: print guidance only, not a copy-ready prompt.

The overwrite and keep prompts are choice prompts, not automatic execution.
Do not run either prompt inside the current action.
`revise` remains a separate `$plan extract-candidates revise <option number or revision request>` invocation.

~~~text
기존 `docs/projects/<project>/work/work-candidates.md` 파일이 있습니다.

overwrite: 이번 Plan Update Candidate를 기준으로 기존 파일 덮어쓰기
```text
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-candidates.md`를 덮어써줘.
덮어쓰기 전에 기존 파일은 history 파일로 백업해줘.
변경 파일은 `docs/projects/<project>/work/work-candidates.md`와 생성되는 history 백업 파일로 제한해줘.
문서 원문 재설계, source code 수정, 테스트 실행, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

keep: 기존 파일 유지
```text
기존 `docs/projects/<project>/work/work-candidates.md` 파일은 유지해줘.
이번 Plan Update Candidate는 참고용으로만 사용하고 파일은 수정하지 마.
다음 단계로 `$plan phase-split` 진행 가능 여부만 짧게 검토해줘.
문서 원문 재설계, source code 수정, 테스트 실행, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

revise: `$plan extract-candidates revise <option number or revision request>`
~~~

If overwrite is later approved, create a history backup before replacing `work-candidates.md`.
Do not read existing `docs/history/**` file bodies just to prepare this choice.

If `docs/projects/<project>/work/work-candidates.md` does not exist, the clear next action is to create it from the Plan Update Candidate.
When the generated candidates have no blocking issue, print one copy-ready prompt in a `Copy-ready Prompt` section:

```text
위 Plan Update Candidate를 기준으로 `docs/projects/<project>/work/work-candidates.md` 파일을 생성해줘.

변경 파일은 `docs/projects/<project>/work/work-candidates.md` 하나로 제한해줘.
문서 원문 재설계, source code 수정, 테스트 실행, version-control 작업은 하지 마.
`docs/history/**` 기존 파일 본문은 읽지 마.
```

## Output

Provide a generated list of work candidate drafts.

Follow `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.
`generate` prints candidate drafts and Revise Options by default.
`revise` reorganizes the existing Plan Update Candidate from the selected option number or directly entered revision requirement.
`revise` is not an AI-only re-review step.
If the user invokes `$plan extract-candidates revise` without an option number or concrete revision request, do not revise candidate drafts immediately.
Output only the Revise Options again.
Do not include detailed review, file apply, approval prompt, or history snapshot/note work by default.

Use these Revise Options:

~~~text
Revise Options:

다음 중 원하는 수정 방향을 선택하거나 직접 입력하면 revise를 진행합니다.

1. 📦 통합
   "너무 잘게 쪼개졌어. 연관된 후보들을 더 큰 덩어리(Feature 단위)로 합쳐줘."

2. 🔪 분할
   "CAND-001이 너무 커. 프론트/백엔드, 계층, 단계별로 더 잘게 쪼개줘."

3. 🎯 필터링
   "현재는 특정 범위만 보고 싶어. 예: UI 작업만 남기고 DB/인프라 관련 후보는 제외해줘."

4. 🧭 우선순위 조정
   "MVP/Cycle 1에 필요한 항목만 High로 두고, 나머지는 Medium/Low 또는 Deferred로 낮춰줘."

5. ✍️ 직접 입력
   "[여기에 수정 요건 작성]"
~~~

For revise, follow these rules:

- Revise targets the existing Plan Update Candidate.
- If the user selected an option number, reorganize the candidates according to that option's intent.
- If the user directly entered a revision requirement, prioritize that requirement over the option menu.
- Keep the action as `extract-candidates` and handle only the Candidate layer.
- Do not arbitrarily delete existing candidates; mark merge, split, filtering, priority, or deferred decisions in the revised candidate draft or Issues Found.
- The revise result is still a Plan Update Candidate draft.
- Do not modify files, create history snapshot/note, transition to dev, set `work-index.md`, code, run tests, or perform version-control work.

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

Revise Options:

Next Step:

Copy-ready Prompt:
~~~

For `generate`, put the Revise Options near the end of the output.
In `Next Step`, state:

- If the candidates are appropriate, the developer can request file apply or continue to `$plan phase-split`.
- If the candidates need adjustment, the developer can run `$plan extract-candidates revise` with an option number or direct revision requirement.
- If the source range is wrong, regenerate with a different Source Scope or Scope Note.
- If `work-candidates.md` does not exist and candidate creation is the clear next action, include the file creation copy-ready prompt.
- If `work-candidates.md` already exists, show overwrite and keep as copy-ready choice prompts, and show revise as guidance only.

## Next Prompt

Follow `specdrive/rules/skill-wizard-rule.md`: print only one copy-ready prompt when a clear next action exists.

For missing `work-candidates.md`, print the file creation copy-ready prompt when the Plan Update Candidate has no blocking issue.

For existing `work-candidates.md`, print overwrite and keep as explicit choice prompts, then print revise as guidance only.
These choice prompts must not combine actions and must not be executed automatically.

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
