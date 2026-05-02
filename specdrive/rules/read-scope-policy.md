# specdrive/rules/read-scope-policy.md

## 1. Purpose

이 문서는 SpecDrive 작업에서 AI가 읽어야 할 문서 범위와 읽지 말아야 할 문서 범위를 정의한다.

목적은 다음과 같다.

- 토큰 사용량을 줄인다.
- 작업별로 필요한 문서만 읽는다.
- full 문서와 bundle 문서의 무분별한 주입을 막는다.
- session, doc, plan, dev, bundle review의 읽기 범위를 분리한다.

이 문서는 `core-collaboration-rules.md`의 하위 정책이다.

---

## 2. Default Principle

AI는 항상 다음 원칙을 따른다.

- 기본은 compact 문서를 먼저 읽는다.
- full 문서는 필요할 때만 읽는다.
- bundle 문서는 명시 요청 시에만 읽는다.
- `docs/history/**`는 기본 읽기 범위에서 제외한다.
- 작업 대상 문서가 명확하면 해당 문서와 직접 참조 문서만 읽는다.
- 판단이 어렵다고 전체 문서를 먼저 읽지 않는다.
- 추가 문서가 필요하면 먼저 이유를 짧게 제안한다.

---

## 3. Document Layers

### 3.1 Compact Layer

AI 기본 주입용 최소 문서다.

예:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- `docs/projects/{project}/AGENTS.compact.md`
- `docs/projects/{project}/PROJECT.compact.md`
- `docs/projects/{project}/work/work-index.md`

기본 작업에서는 compact layer를 우선한다.

---

### 3.2 Policy Layer

작업별 세부 규칙 문서다.

예:

- `specdrive/rules/core-collaboration-rules.md`
- `specdrive/rules/read-scope-policy.md`
- `specdrive/rules/session-policy.md`
- doc-work / dev / bundle policy 후보

현재 작업에 필요한 policy만 읽는다.

후속 후보 policy가 아직 없으면 해당 파일을 찾지 않는다.
없는 policy는 active rules와 각 skill action 문서를 기준으로 대체한다.

---

### 3.3 Full Document Layer

사람이 보는 원본 기준 문서다.

예:

- `AGENTS.md`
- `README.md`
- `docs/AI_CONTEXT.md`
- `specdrive/docs/AGENTS.md`
- `specdrive/docs/README.md`
- `docs/projects/{project}/AGENTS.md`
- `docs/projects/{project}/README.md`
- `docs/projects/{project}/specs/**`

full 문서는 기본 읽기 대상이 아니다.

---

### 3.4 Bundle / Review Layer

전체 정합성 검토용 묶음 문서다.

예:

- `agents-all.md`
- `readme-all.md`
- `readme-ko-all.md`
- `project-dev-docs.md`
- `board-dev-docs.md`
- `context-bundle.md`
- `phase-bundle.md`

bundle은 review 전용이다.

일반 session, doc, plan, dev 작업에서는 읽지 않는다.

---

## 4. Global Default Read Scope

모든 작업에서 기본적으로 다음을 우선한다.

읽기 허용:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 현재 작업에 필요한 policy 문서
- 현재 project의 `AGENTS.compact.md`
- 현재 project의 `work/work-index.md`
- 현재 대상 문서
- 사용자가 명시한 참조 문서

기본 읽기 금지:

- full `AGENTS.md`
- full README 계열 문서
- 전체 specs bundle
- 전체 agents bundle
- 전체 readme bundle
- `docs/history/**`
- 과거 backup 문서
- build 결과물
- 대량 로그 파일
- 현재 작업과 무관한 source 파일

---

## 5. Session Read Scope

session 작업의 기본 policy는 `session-policy.md` 하나다.
단순 session status / start / restore / save에서는 `core-collaboration-rules.md`와 이 문서를 함께 읽지 않는다.

### 5.1 session status

읽기:

- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 현재 project의 `work/work-index.md`
- `temp/last-note.md` (있을 때만)

읽지 않기:

- full `AGENTS.md`
- full `docs/AI_CONTEXT.md`
- README 계열 문서
- specs 문서
- history 문서
- bundle 문서

목적:

- 현재 상태를 읽기 전용으로 확인한다.

---

### 5.2 session start

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- `specdrive/rules/session-policy.md`
- 현재 project의 `AGENTS.compact.md`
- 현재 project의 `work/work-index.md`

읽지 않기:

- full `AGENTS.md`
- full README
- 전체 specs
- history
- bundle

목적:

- 최소 문맥으로 세션을 빠르게 복구한다.

---

### 5.3 session restore

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- `specdrive/rules/session-policy.md`
- 현재 project의 `AGENTS.compact.md`
- 현재 project의 `work/work-index.md`
- 필요 시 개발자가 제공한 작업트리 메모

읽지 않기:

- README 전체
- specs 전체
- history 전체
- bundle

목적:

- VS Code 또는 Codex 재시작 후 이어갈 위치를 복구한다.

---

### 5.4 session save

`session save`는 기본적으로 가벼운 save로 동작한다.

읽기:

- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- `temp/last-note.md` (있을 때만)
- 현재 project의 `work/work-index.md`
- 현재 project의 `work/work-log.md` 마지막 항목

읽지 않기:

- full `AGENTS.md`
- full `docs/AI_CONTEXT.md`
- README 계열 문서
- specs 전체
- history 전체
- bundle 전체

`docs/AI_CONTEXT.compact.md`가 없더라도 full `docs/AI_CONTEXT.md` 전체를 읽지 않는다.
현재 focus / 다음 진입점 섹션만 제한적으로 읽는다.

목적:

- 현재 focus, 마지막 작업, 다음 진입점만 저장한다.

---

### 5.5 session save-full

읽기:

- `docs/AI_CONTEXT.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- `temp/last-note.md` (있을 때만)
- 현재 project의 `work/work-index.md`
- 현재 project의 `work/work-log.md`
- 필요한 full AGENTS 또는 README

읽지 않기:

- 사용자가 명시하지 않은 bundle
- 무관 project 문서
- 무관 specs
- 전체 history

목적:

- 큰 단계 전환 또는 구조 변경 후 상세 상태 문서를 갱신한다.

조건:

- 사용자가 명시적으로 `save-full`을 요청한 경우에만 사용한다.

---

## 6. Doc Work Read Scope

### 6.1 doc reinforce

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `AGENTS.compact.md`
- 현재 대상 문서
- 사용자가 명시한 참조 문서

읽지 않기:

- 전체 specs bundle
- full README
- history
- 무관 standards
- 무관 project 문서

목적:

- 현재 대상 문서만 최소 보강한다.

---

### 6.2 doc confirm

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `AGENTS.compact.md`
- 현재 대상 문서
- 직접 상위 문서
- 직접 후속 문서

읽지 않기:

- 전체 bundle
- history
- 무관 README
- 무관 specs

목적:

- 대상 문서가 다음 단계로 넘어갈 수 있는지 검토한다.

---

### 6.3 doc apply

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 대상 문서
- 승인된 변경 요청
- 필요 시 직접 참조 문서

읽지 않기:

- 전체 bundle
- history
- 무관 문서

목적:

- 승인된 변경만 반영한다.

---

### 6.4 doc history-save

읽기:

- 현재 대상 문서
- 승인된 변경 요약
- `temp/last-note.md` (있을 때만)

읽지 않기:

- 전체 history
- 전체 bundle
- 무관 specs

목적:

- 확정된 문서 변경 이력만 저장한다.

---

## 7. Plan Read Scope

### 7.1 plan extract-candidates

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `AGENTS.compact.md`
- 현재 project의 `PROJECT.compact.md`
- 대상 요구사항 또는 설계 문서

읽지 않기:

- 전체 specs bundle
- README 전체
- history 전체

목적:

- 개발 후보 작업을 추출한다.

---

### 7.2 plan wp-split

읽기:

- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `work/work-candidates.md`
- 필요한 직접 참조 문서

읽지 않기:

- 무관 specs
- full README
- history
- bundle

목적:

- 후보 작업을 Work Package 후보로 나눈다.

---

### 7.3 plan task-split

읽기:

- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `work/work-roadmap.md`
- 현재 선택된 Work Package
- 필요한 직접 참조 문서

읽지 않기:

- 전체 project 문서
- 전체 README
- history
- bundle

목적:

- 선택된 Work Package를 실행 가능한 Task로 나눈다.

---

## 8. Dev Read Scope

### 8.1 dev start

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `AGENTS.compact.md`
- 현재 project의 `work/work-roadmap.md`
- 현재 project의 `work/work-index.md`

읽지 않기:

- 전체 specs bundle
- full README
- history

목적:

- 현재 실행할 Work Package를 선택하고 작업 포인터를 확인한다.

---

### 8.2 dev run

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `AGENTS.compact.md`
- 현재 project의 `work/work-index.md`
- 현재 Work Package 관련 문서
- 대상 코드 파일

읽지 않기:

- 전체 specs bundle
- 전체 README
- history
- 무관 코드

목적:

- 현재 Work Package 범위 안에서만 구현한다.

---

### 8.3 dev test

읽기:

- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `work/work-index.md`
- 현재 Work Package 관련 테스트 파일
- 대상 코드 파일

읽지 않기:

- 전체 specs
- README
- history
- bundle

목적:

- 현재 Work Package 기준으로 테스트 또는 검증을 수행한다.

---

### 8.4 dev sync

읽기:

- `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)
- 해당 policy가 있으면 그 문서
- 현재 project의 `work/work-index.md`
- 현재 project의 `work/work-log.md`
- 현재 Work Package 관련 변경 요약
- `temp/last-note.md` (있을 때만)

읽지 않기:

- 전체 specs
- 전체 README
- history
- bundle

목적:

- 개발 결과를 작업 로그와 다음 진입점으로 정리한다.

---

## 9. Git Handoff Read Scope

Git은 현재 repo-local skill 대상에서 제외한다.

Git 관련 정보가 필요하면 사용자가 직접 제공한 범위만 읽는다.

읽기:

- 사용자가 붙여넣은 branch / status / diff 요약
- 사용자가 명시한 변경 파일 목록
- 필요한 경우 `docs/AI_CONTEXT.compact.md` (없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만)

읽지 않기:

- specs 전체
- README 전체
- history
- bundle

목적:

- commit message 또는 PR description 초안 보조

금지:

- Git skill 호출
- 명시 승인 없는 `git add`
- 명시 승인 없는 `git commit`
- 명시 승인 없는 `git push`

---

## 10. Bundle Review Read Scope

bundle review는 예외적으로 큰 문서를 읽을 수 있다.

조건:

- 사용자가 명시적으로 bundle review를 요청한 경우
- phase 종료 검토가 필요한 경우
- 큰 구조 변경 전후 정합성 검토가 필요한 경우
- 전체 문서 묶음 검토가 필요한 경우

읽기:

- 사용자가 지정한 bundle
- 필요한 full AGENTS
- 필요한 full README
- 대상 project 문서 묶음

읽지 않기:

- 무관 project bundle
- 무관 history
- source code 전체

목적:

- 전체 정합성 검토
- 문서 역할 충돌 확인
- 구조 변경 영향 확인

---

## 11. History Read Scope

`docs/history/**`는 기본적으로 읽지 않는다.

읽는 경우:

- 사용자가 특정 이력을 요청한 경우
- 과거 판단 근거 확인이 필요한 경우
- 변경 전후 비교가 필요한 경우
- history 문서 자체를 정리하는 작업인 경우

읽지 않는 경우:

- session status
- session save
- doc reinforce
- dev run
- dev sync
- Git handoff message 보조

---

## 12. Escalation Rule

기본 읽기 범위만으로 판단이 어려우면 AI는 즉시 전체 문서를 읽지 않는다.

먼저 다음 형식으로 제안한다.

### Additional Read Proposal

- Needed File:
- Reason:
- Expected Use:
- Risk If Not Read:

개발자가 승인하면 추가로 읽는다.

---

## 13. Final Rule

SpecDrive의 기본은 전체 문서를 많이 읽는 것이 아니다.

기본은 다음이다.

- compact 먼저
- policy는 필요한 것만
- 대상 문서만
- bundle은 명시 요청 시만
- history는 예외적으로만

AI는 적게 읽고, 작게 바꾸고, 짧게 보고한다.
