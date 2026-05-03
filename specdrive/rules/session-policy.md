# specdrive/rules/session-policy.md

## 1. Purpose

이 문서는 SpecDrive의 session 전용 작업 규칙을 정의한다.

session은 작업 자체를 수행하는 단계가 아니라, 세션 시작, 복구, 상태 확인, 저장을 돕는 메타 운영 단계다.

목적은 다음과 같다.

- 세션 시작과 종료를 가볍게 유지한다.
- `session save`의 토큰 사용량을 줄인다.
- session이 doc, plan, dev 작업을 대신하지 않도록 한다.
- 현재 상태와 다음 진입점을 빠르게 복구할 수 있게 한다.

공통 wizard 출력 규칙은 `specdrive/rules/skill-wizard-rule.md`를 따른다.
이 문서는 필요 시 `core-collaboration-rules.md`와 `read-scope-policy.md`를 따른다.
단순 session status / start / restore / save는 기본적으로 이 문서 하나만 읽어도 수행 가능해야 한다.

---

## 2. Session Principle

session 계열 명령은 다음 원칙을 따른다.

- session은 메타 운영 단계다.
- session은 문서 보강을 수행하지 않는다.
- session은 개발 작업을 수행하지 않는다.
- session은 task 분해를 수행하지 않는다.
- session은 history-save를 대신하지 않는다.
- session은 Git write 작업을 수행하지 않는다.
- session은 현재 상태와 다음 진입점만 다룬다.
- 기본은 compact 문서만 읽는다.

---

## 3. Session Commands

session 계열 명령은 다음으로 나눈다.

- `session status`
- `session restore`
- `session start`
- `session start-full`
- `session save`
- `session save-full` (후속 후보)

기본 명령은 가벼운 동작을 우선한다.

`session save`는 기본적으로 가벼운 save로 취급한다.

---

## 4. Session Context Target

session 계열 명령은 workspace router와 target context를 구분한다.

기본 target:

- `specdrive`
- `board`

기본 routing:

- `$session status`: `docs/AI_CONTEXT.compact.md`만 읽고 active area를 출력한다.
- `$session status specdrive`: router와 `specdrive/AI_CONTEXT.compact.md`를 읽는다.
- `$session status board`: router와 `docs/projects/board/AI_CONTEXT.compact.md`를 읽는다.
- `$session start`: router의 active/default target을 기준으로 target context 하나만 읽는다.
- `$session start specdrive`: router와 `specdrive/AI_CONTEXT.compact.md`를 읽는다.
- `$session start board`: router와 `docs/projects/board/AI_CONTEXT.compact.md`를 읽는다.
- `$session restore`: `$session start`와 같은 target routing을 따른다.
- `$session save specdrive`: `specdrive/AI_CONTEXT.compact.md` patch 후보만 준비한다.
- `$session save board`: `docs/projects/board/AI_CONTEXT.compact.md` patch 후보만 준비한다.

target이 불명확한 `$session save`는 target context patch를 만들지 않고 target 확인을 요청한다.

session target은 실제로 수정하거나 정리한 작업 대상 기준으로 정한다.

SpecDrive skill, rule, policy를 개발하면서 project 문서를 테스트 입력으로만 사용한 경우에는 project context를 저장하지 않는다.
예를 들어 `$plan` 기능을 board 문서로 테스트했지만 수정 대상이 SpecDrive skill이면 `$session save specdrive`만 사용한다.

SpecDrive context와 project context를 동시에 읽는 것은 cross-context consistency review를 사용자가 명시적으로 요청한 경우로 제한한다.

---

## 5. session status

### 5.1 Purpose

현재 상태를 읽기 전용으로 확인한다.

### 5.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md` (workspace router)
- target이 명시된 경우 target compact context 하나
- target이 project이고 현재 포인터 확인이 필요한 경우 현재 project의 `work/work-index.md`
- `temp/last-note.md` (있을 때만)

읽지 않기:

- full `AGENTS.md`
- full `docs/AI_CONTEXT.md`
- README 계열 문서
- specs 문서
- history 문서
- bundle 문서

### 5.3 Allowed

- 현재 focus 확인
- 현재 project 확인
- active area 확인
- 현재 Phase / Cycle / Work Package 확인
- 다음 진입점 확인
- open question 확인

### 5.4 Forbidden

- 문서 수정
- 코드 수정
- task 재분해
- history 저장
- Git write 작업
- full 문서 재검토

### 5.5 Output

기본 출력:

- Active Area:
- Current Focus:
- Current Project:
- Current Work Pointer:
- Next Entry Point:
- Issues Found:

---

## 6. session start

### 6.1 Purpose

최소 문맥으로 빠르게 세션을 시작한다.

### 6.2 Read Scope

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (workspace router)
- active/default target compact context 하나
- `specdrive/rules/session-policy.md`
- target이 project인 경우 현재 project의 `AGENTS.compact.md`
- target이 project인 경우 현재 project의 `work/work-index.md`

읽지 않기:

- full `AGENTS.md`
- full README
- 전체 specs
- history
- bundle

### 6.3 Allowed

- 현재 상태 요약
- 현재 작업 포인터 확인
- 다음 진입점 제안
- 필요한 후속 명령 제안

### 6.4 Forbidden

- 문서 보강
- 문서 반영
- 코드 수정
- 작업 분해
- history 저장
- Git write 작업

### 6.5 Output

기본 출력:

- Current State:
- Active Scope:
- Next Entry Point:
- Recommended Command:
- Issues Found:

---

## 7. session restore

### 7.1 Purpose

VS Code, Codex, 터미널, 대화 세션 재시작 후 이어갈 위치를 복구한다.

### 7.2 Read Scope

읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (workspace router)
- active/default target compact context 하나
- `specdrive/rules/session-policy.md`
- target이 project인 경우 현재 project의 `AGENTS.compact.md`
- target이 project인 경우 현재 project의 `work/work-index.md`
- 필요 시 개발자가 제공한 작업트리 메모

읽지 않기:

- README 전체
- specs 전체
- history 전체
- bundle

### 7.3 Allowed

- 현재 focus 복구
- 개발자가 제공한 작업트리 상태 메모 확인
- 현재 Work Package 확인
- 다음 진입점 정리
- 충돌 가능성 표시

### 7.4 Forbidden

- 자동 수정
- 자동 저장
- 문서 재작성
- 코드 수정
- Git write 작업

### 7.5 Output

기본 출력:

- Restored Focus:
- Worktree Note:
- Active Work Pointer:
- Recommended Next Step:
- Issues Found:

---

## 8. session start-full

### 8.1 Purpose

전체 복구용 copy prompt를 준비하는 예외적 세션 시작 명령이다.

기본적으로 `session start`를 우선한다.  
필요한 경우에만 추가 문서를 제안한다.

### 8.2 Read Scope

기본 읽기:

- `AGENTS.compact.md`
- `docs/AI_CONTEXT.compact.md` (workspace router)
- active/default target compact context 하나
- `specdrive/rules/session-policy.md`
- target이 project인 경우 현재 project의 `AGENTS.compact.md`
- target이 project인 경우 현재 project의 `work/work-index.md`

추가 읽기 가능:

- 사용자가 지정한 대상 문서
- 사용자가 지정한 작업 policy
- 필요한 직접 참조 문서

기본 읽기 금지:

- full AGENTS
- full README
- 전체 specs
- history
- bundle

### 8.3 Allowed

- 현재 상태 복구
- 다음 작업 후보 제안
- 필요한 읽기 문서 제안
- 후속 작업 command 추천

### 8.4 Forbidden

- 사용자가 요청하지 않은 작업 착수
- 문서 수정
- 코드 수정
- history 저장
- Git write 작업

### 8.5 Additional Read Proposal

추가 문서가 필요하면 다음 형식으로 제안한다.

### Additional Read Proposal

- Needed File:
- Reason:
- Expected Use:
- Risk If Not Read:

---

## 9. session save

### 9.1 Purpose

현재 세션 결과를 최소 상태 정보로 저장한다.

`session save`는 기본적으로 가벼운 save다.

### 9.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md` (workspace router)
- target이 명확한 경우 target compact context 하나
- `temp/last-note.md` (있을 때만)
- target이 project이고 필요한 경우 현재 project의 `work/work-index.md`
- target이 project이고 필요한 경우 현재 project의 `work/work-log.md` 마지막 항목

읽지 않기:

- full `AGENTS.md`
- full `docs/AI_CONTEXT.md`
- README 계열 문서
- specs 전체
- history 전체
- bundle 전체

### 9.3 Allowed

- target context의 현재 focus 갱신안 작성
- target context의 현재 project 또는 active area 갱신안 작성
- 현재 Phase / Cycle / Work Package 갱신안 작성
- 마지막 완료 작업 요약
- 다음 진입점 정리
- open question 정리
- target compact context patch 제안

### 9.4 Forbidden

- `docs/AI_CONTEXT.md` 전체 재작성
- `docs/AI_CONTEXT.compact.md` router를 target context처럼 갱신
- full 문서 정합성 검토
- README/AGENTS 재검토
- specs 전체 요약
- history 저장
- task 재분해
- roadmap 재작성
- 신규 문서 생성
- 코드 수정
- Git write 작업

### 9.5 Output

기본 출력:

- Summary:
- State Patch:
- Next Entry Point:
- Issues Found:

출력 제한:

- 100줄 이하
- 문제가 없으면 `Issues Found: None`

---

## 10. session save-full

### 10.1 Purpose

상세 상태 문서를 갱신해야 할 때 사용하는 후속 후보 예외 명령이다.

현재 `$session` skill의 기본 action으로 확정하지 않는다.
AI는 먼저 `session save-full`을 제안하지 않는다.
큰 단계 전환, project focus 변경, 문서 구조 변경이 있어도 AI는 먼저 `session save-full`을 제안하지 않는다.
필요한 경우에도 일반 `session save` 또는 사람 검토를 우선한다.

### 10.2 Use Conditions

다음 경우에만 사용한다.

- 사용자가 명시적으로 `session save-full`을 요청한 경우

AI는 다음 경우에도 먼저 `session save-full`을 제안하지 않는다.

- 큰 단계 전환이 발생한 경우
- project focus가 바뀐 경우
- 문서 구조 또는 workflow 구조가 변경된 경우
- compact와 full 상태 문서의 동기화가 필요해 보이는 경우

### 10.3 Read Scope

읽기:

- `docs/AI_CONTEXT.md`
- `docs/AI_CONTEXT.compact.md` (workspace router, 있을 때만)
- target compact context (있을 때만)
- `temp/last-note.md` (있을 때만)
- 현재 project의 `work/work-index.md`
- 현재 project의 `work/work-log.md`
- 필요한 full AGENTS 또는 README

읽지 않기:

- 사용자가 명시하지 않은 bundle
- 무관 project 문서
- 무관 specs
- 전체 history

### 10.4 Allowed

- `docs/AI_CONTEXT.md` 갱신안 작성
- `docs/AI_CONTEXT.compact.md`가 있으면 갱신안 작성
- compact와 full 상태 비교
- 다음 진입점 상세 정리

### 10.5 Forbidden

- 대상 외 문서 수정
- specs 전체 재작성
- README 재작성
- AGENTS 재작성
- history 저장
- 코드 수정
- Git write 작업

### 10.6 Output

기본 출력:

- Summary:
- Workspace Router Patch: (router 변경이 명시된 경우에만)
- Target AI_CONTEXT Patch:
- Target AI_CONTEXT.compact Patch: (target compact 파일이 있을 때만)
- Next Entry Point:
- Issues Found:

---

## 11. temp/last-note.md

### 11.1 Purpose

`temp/last-note.md`는 직전 작업의 짧은 요약 파일 후보이다.

현재 파일이 없으면 session은 이 파일을 요구하지 않는다.

파일이 있으면 session save가 우선 참고한다.

### 11.2 Recommended Content

권장 항목:

- 작업 일시
- 작업 모드
- 대상 project
- 대상 문서 또는 코드
- 수행 내용
- 변경 요약
- 남은 이슈
- 다음 진입점

### 11.3 Example Structure

- Mode:
- Project:
- Target:
- Completed:
- Changed Files:
- Issues:
- Next Entry Point:

### 11.4 Rule

`temp/last-note.md`는 긴 보고서가 아니다.

짧은 세션 전달 메모로 유지한다.

---

## 12. AI_CONTEXT.compact.md

### 12.1 Purpose

`docs/AI_CONTEXT.compact.md`는 workspace-level compact context router이다.

현재 파일이 없으면 `docs/AI_CONTEXT.md`의 현재 focus / 다음 진입점 섹션만 제한적으로 읽는다.

session 계열 명령은 router를 읽은 뒤 target context 하나만 읽는다.

target context 예:

- `specdrive/AI_CONTEXT.compact.md`
- `docs/projects/{project}/AI_CONTEXT.compact.md`

### 12.2 Recommended Sections

router compact 권장 섹션:

- Purpose
- Current Workspace
- Context Routing
- Default Read Rule
- Active Context Hint
- Next Entry Point

target compact 권장 섹션:

- Purpose
- Current Focus
- Current Project 또는 Current Area
- Current Phase / Cycle / Work Package (project에만 필요할 때)
- Next Entry Point
- Open Questions
- Read Scope Hint

### 12.3 Rule

compact 문서는 100~150줄 이내를 목표로 한다.

세부 설명은 full `docs/AI_CONTEXT.md`에 둔다.

---

## 13. Session vs Doc / Plan / Dev

session은 다른 작업 단계를 대신하지 않는다.

### 13.1 session이 하지 않는 것

- 문서 보강
- 문서 검토
- 문서 반영
- history 저장
- 후보 작업 추출
- Work Package 분해
- Task 분해
- 코드 구현
- 테스트 실행
- Git commit / push

### 13.2 연결 방식

필요하면 session은 다음 명령을 추천할 수 있다.

- `doc reinforce`
- `doc confirm`
- `doc apply`
- `plan extract-candidates`
- `plan task-split`
- `dev start`
- `dev run`
- `dev sync`

하지만 session 자체가 해당 작업을 수행하지 않는다.

---

## 14. Session Save Patch Rule

session save는 전체 파일을 다시 쓰지 않는다.

기본은 patch 제안이다.

### 14.1 Allowed Patch Target

- `specdrive/AI_CONTEXT.compact.md`
- `docs/projects/{project}/AI_CONTEXT.compact.md`
- 단, 해당 target compact context가 없으면 full `docs/AI_CONTEXT.md`에 대체 반영하지 않고 target compact context 생성 또는 target 확인을 제안한다.

`docs/AI_CONTEXT.compact.md` router는 active target 변경 자체가 작업 대상일 때만 patch 대상으로 삼는다.

### 14.2 Full Patch Target

`session save-full`에서만 다음을 대상으로 할 수 있다.

- `docs/AI_CONTEXT.md`
- `docs/AI_CONTEXT.compact.md` (있을 때만)
- target compact context (있을 때만)

### 14.3 Patch Format

출력 형식:

- Target File:
- Section:
- Replace With:

또는:

- Target File:
- Append To:
- Content:

---

## 15. Issues Rule

session 계열에서 문제가 없으면 다음만 출력한다.

- `Issues Found: None`

문제가 있으면 최대 5개까지만 출력한다.

형식:

- Issue:
- Impact:
- Recommended Action:

---

## 16. Final Rule

session은 가벼워야 한다.

session의 목적은 전체 문서를 다시 이해하는 것이 아니다.

session의 목적은 다음이다.

- 지금 어디에 있는지 확인한다.
- 무엇을 했는지 짧게 저장한다.
- 다음에 어디서 시작할지 남긴다.

따라서 session은 compact 문서와 현재 작업 포인터만 읽는 것을 기본으로 한다.
