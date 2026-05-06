# Plan Skill Inputs

## 1. Purpose

This document defines common input fields for `$plan` actions.

`SKILL.md` handles routing, and `actions/*.md` define action behavior.  
This file is the shared input contract used by the action documents and Skill Wizard.

---

## 2. Common Inputs

| Input | Meaning | Default / Note |
|---|---|---|
| Project Name | `docs/projects/{project}`의 `{project}` key | 생략 가능. 기준 목록은 `specdrive/config/project-registry.json` |
| Action | 실행할 plan action | 필수 |
| Source Scope | 입력 문서 범위 | `current`, `all`, `file` |
| Source Files | `Source Scope = file`일 때 대상 문서 목록 | file 모드에서만 사용 |
| Target Mode | 작업 대상 종류 | `current`, `candidate`, `wp`, `phase`, `cycle`, `roadmap` |
| Phase | 대상 Phase | 필요한 action에서만 사용 |
| Cycle | 대상 Cycle | 필요한 action에서만 사용 |
| Work Package ID | 대상 Work Package ID | `wp` 이후 dev 전환에서 주로 사용 |
| Task ID | 대상 Task ID | plan 단계에서는 기본 미사용 |
| Scope Note | 범위 제한 또는 제외 조건 | 선택 |
| Run Mode | 실행 방식 | `generate`, `revise`; 기본값은 `generate` |

`Target Mode = current`는 plan 단계에서 현재 포인터 설정으로 해석하지 않는다.  
현재 포인터 설정은 `$dev start` 책임이므로, plan 단계에서는 현재 범위 확인이 필요할 때만 조회/제한용으로 사용한다.

`Source Scope`의 프로젝트별 문서 묶음 기준은 `specdrive/config/project-registry.json` 의
`projects.<project>.plan.extract_candidates.source_scopes` 를 우선 따른다.
`extract-candidates` 의 기본 Source Scope는
`projects.<project>.plan.extract_candidates.default_source_scope` 를 따르며, 현재 기본값은 `all` 이다.

---

## 3. Project Name Resolution

Project Name은 표시 이름이 아니라 `docs/projects/{project}` 경로의 `{project}` 값이다.  
예를 들어 Project Name이 `board`이면 대상 프로젝트 root는 `docs/projects/board` 이다.

Project Name은 다음 순서로 결정한다.

1. 사용자가 입력한 Project Name
2. 현재 세션의 Active Project
3. 현재 컨텍스트에서 식별 가능한 Project
4. `specdrive/config/project-registry.json` 에 등록된 프로젝트가 하나뿐이면 해당 프로젝트
5. 그래도 불명확하면 사용자에게 질문

현재 등록된 기본 프로젝트는 `project-registry.json` 의 `default_project` 를 따른다.  
다만 기본 프로젝트는 추정 보조값이며, 사용자 입력이나 현재 작업 문맥이 더 명확하면 그 값을 우선한다.

---

## 4. Run Mode

| Run Mode | Meaning |
|---|---|
| `generate` | 기준 문서를 읽고 현재 action의 Plan Update Candidate 초안을 새로 만든다. |
| `revise` | 현재 action의 Plan Update Candidate 초안을 수정하기 위한 흐름이다. |

`generate`는 계획 후보를 만드는 기본 모드다.
대상 파일을 생성하거나 갱신하지 않고, history snapshot/note를 만들지 않으며, dev 단계로 전환하지 않는다.

`revise`는 파일 반영 모드가 아니다.
`revise`는 AI가 혼자 다시 검토하는 단계가 아니라, 기존 Plan Update Candidate를 대상으로 사용자가 선택한 수정 방향을 반영하는 단계다.
사용자가 option 번호나 구체적인 수정 요청을 함께 쓴 경우, 그 입력을 기준으로 같은 plan action 안에서 같은 계층의 revised Plan Update Candidate를 만든다.
사용자가 수정 방향을 주지 않은 경우에는 후보를 즉시 재작성하지 않고 action별 revise 선택지를 출력한다.
`revise` 역시 문서 확정, history 저장, dev 전환을 수행하지 않는다.

plan action은 기본적으로 파일 반영, 검토 보고, 승인 프롬프트 생성을 함께 수행하지 않는다.
파일 반영이나 상세 검토가 필요하면 별도 요청 또는 후속 작업으로 다룬다.

---

## 5. Common Output Contract

All plan action outputs should use the same short top-level shape.

~~~text
Plan action: <action>
Target project: <project>
Run Mode: <generate|revise>

Summary:

Plan Update Candidate:
```markdown
<Action-specific content>
```

Files To Change:

Issues Found:

Next Step:
~~~

`Plan Update Candidate` is the only action-specific content section.
Wrap its document-ready content in a `markdown` code block so it can be copied without losing structure.

Follow-up prompts follow `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear: print one copy-ready prompt only when follow-up work needs another Codex prompt, and omit it when no follow-up work is needed.

Detailed review, file apply, approval prompt, and history snapshot/note work are separate follow-up work.
Do not inspect existing `docs/history/**` file bodies unless the developer explicitly asks for history lookup.

---

## 6. Action Input Matrix

| Action | Project Name | Source Scope | Source Files | Target Mode | Phase | Cycle | WP ID | Task ID | Scope Note | Run Mode |
|---|---|---|---|---|---|---|---|---|---|---|
| `extract-candidates` | O | O | file일 때 | - | - | - | - | - | O | O |
| `phase-split` | O | - | - | `candidate`, `phase`, `roadmap` | O | - | - | - | O | O |
| `cycle-split` | O | - | - | `phase`, `cycle`, `roadmap` | O | O | - | - | O | O |
| `task-split` | O | - | - | `cycle`, `roadmap` | O | O | - | - | O | O |
| `wp` | O | - | - | `cycle`, `wp`, `roadmap` | O | O | O | - | O | O |

---

## 7. Action Reference Targets

| Action | Primary Reference |
|---|---|
| `extract-candidates` | project overview, specs, optional `work-candidates.md` |
| `phase-split` | `work-candidates.md`, `work-roadmap.md` |
| `cycle-split` | `work-roadmap.md` |
| `task-split` | `work-roadmap.md`, `work-candidates.md` when needed |
| `wp` | `work-tasks.md`, `work-roadmap.md` when context is unclear |

---

## 8. Update Candidate Targets

Plan actions may prepare drafts for these documents:

- `docs/projects/{project}/work/work-candidates.md`
- `docs/projects/{project}/work/work-roadmap.md`
- `docs/projects/{project}/work/work-packages.md`
- `docs/projects/{project}/work/work-tasks.md`

Plan actions do not directly update:

- `docs/projects/{project}/work/work-index.md`
- actual code files
- test execution results
- version-control outputs
- session save files

---

## 9. Boundaries

- Do not code.
- Do not run tests.
- Do not set the dev current pointer.
- Do not create or modify `work-index.md`.
- Do not confirm-update plan target documents without developer approval.
- Do not create plan history snapshots or notes without developer approval.
- Do not add future expansion as confirmed scope when it is not present in current documents.
- Do not change Phase / Cycle / Work Package / Task relationships arbitrarily.
