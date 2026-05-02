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
| Work Package ID | 대상 Work Package ID | `task-split`에서 주로 사용 |
| Task ID | 대상 Task ID | plan 단계에서는 기본 미사용 |
| Scope Note | 범위 제한 또는 제외 조건 | 선택 |
| Run Mode | 실행 방식 | `generate`, `review`, `apply` |
| Output Mode | 출력 형식 | `table`, `markdown`, `prompt` |

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
| `generate` | 개발자가 초안을 직접 작성하지 않아도 기준 문서에서 계획 후보를 생성한다. |
| `review` | 기존 결과와 비교 검토한다. |
| `apply` | 개발자 승인 후 반영안을 만든다. 실제 반영 전 변경 요약을 먼저 보여준다. |

`apply`는 자동 반영을 뜻하지 않는다.  
파일 수정은 action 문서가 허용하고 개발자가 명시적으로 요청한 경우에만 수행한다.

---

## 5. Common Output Contract

All plan action outputs should use the same top-level shape.

```text
Plan action: <action>
Target project: <project>
Run Mode: <generate|review|apply>
Output Mode: <table|markdown|prompt>

<Action-specific generated section>

Review Notes:
- Duplicate / Existing Items:
- Possible Missing Items:
- Needs Clarification:

Apply Draft:
- Target file:
- Changes:
- Approval required: yes
```

Run Mode controls which sections are emphasized:

- `generate`: print the action-specific generated section first. Do not include Apply Draft, approval prompt, or history snapshot/note by default.
- `review`: include Review Notes and compare against existing work documents when available.
- `apply`: include Apply Draft, target file, change summary, and approval requirement. Do not edit files or history files unless the developer explicitly asks to apply.

Follow-up prompts follow `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear: print one copy-ready prompt only when follow-up work needs another Codex prompt, and omit it when no follow-up work is needed.

Apply Draft is included only when the user requested `apply` or explicitly asked for an apply prompt.
History snapshot/note paths are not part of the default `generate` output.
History snapshot/note may be handled after apply approval as an optional follow-up candidate.
Do not inspect existing `docs/history/**` file bodies unless the developer explicitly asks for history lookup.

---

## 6. Output Mode

| Output Mode | Meaning |
|---|---|
| `table` | 표 중심 출력 |
| `markdown` | 문서 반영용 Markdown 출력 |
| `prompt` | Codex 실행 프롬프트 형태 출력 |

---

## 7. Action Input Matrix

| Action | Project Name | Source Scope | Source Files | Target Mode | Phase | Cycle | WP ID | Task ID | Scope Note | Run Mode | Output Mode |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `extract-candidates` | O | O | file일 때 | - | - | - | - | - | O | O | O |
| `phase-split` | O | - | - | `candidate`, `phase`, `roadmap` | O | - | - | - | O | O | O |
| `cycle-split` | O | - | - | `phase`, `cycle`, `roadmap` | O | O | - | - | O | O | O |
| `wp-split` | O | - | - | `cycle`, `wp`, `roadmap` | O | O | - | - | O | O | O |
| `task-split` | O | - | - | `wp`, `roadmap` | O | O | O | - | O | O | O |

---

## 8. Action Reference Targets

| Action | Primary Reference |
|---|---|
| `extract-candidates` | project overview, specs, optional `work-candidates.md` |
| `phase-split` | `work-candidates.md`, `work-roadmap.md` |
| `cycle-split` | `work-roadmap.md` |
| `wp-split` | `work-roadmap.md`, selected Cycle |
| `task-split` | `work-roadmap.md` |

---

## 9. Apply Targets

Plan actions may prepare drafts for these documents:

- `docs/projects/{project}/work/work-candidates.md`
- `docs/projects/{project}/work/work-roadmap.md`

Plan actions do not directly update:

- `docs/projects/{project}/work/work-index.md`
- actual code files
- test execution results
- version-control outputs
- session save files

---

## 10. Boundaries

- Do not code.
- Do not run tests.
- Do not set the dev current pointer.
- Do not create or modify `work-index.md`.
- Do not confirm-update `work-candidates.md` or `work-roadmap.md` without developer approval.
- Do not create plan history snapshots or notes without developer approval.
- Do not add future expansion as confirmed scope when it is not present in current documents.
- Do not change Phase / Cycle / Work Package / Task relationships arbitrarily.
