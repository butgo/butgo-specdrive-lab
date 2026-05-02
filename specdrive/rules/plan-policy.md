# specdrive/rules/plan-policy.md

## 1. Purpose

이 문서는 SpecDrive의 plan 계열 작업 규칙을 정의한다.

plan은 확정된 기획/설계 문서를 바탕으로, 실제 개발(dev)이 가능하도록 작업을 계층별로 나누고 정렬하는 단계다.

목적은 다음과 같다.

- 기획(doc)과 구현(dev) 사이의 실행 가능한 징검다리를 만든다.
- AI가 구현 방법론(How)에 빠지지 않고 작업 단위(What)를 분해하도록 통제한다.
- Spec-to-Anchor 추적성을 작업 단위에 연결한다.
- 토큰 소모를 줄이기 위해 하향식(Top-down)으로 한 계층씩 분해한다.

이 문서는 필요 시 다음 규칙을 따른다.

- `specdrive/rules/core-collaboration-rules.md`
- `specdrive/rules/read-scope-policy.md`
- `specdrive/rules/skill-wizard-rule.md`

이 문서는 plan 전용 정책을 정의한다.  
공통 wizard 출력 규칙은 `specdrive/rules/skill-wizard-rule.md`를 따른다.

---

## 2. Plan Principle

plan 계열 명령은 다음 원칙을 따른다.

- plan은 코드를 구현하지 않는다.
- plan은 pseudocode를 작성하지 않는다.
- plan은 기획/설계 문서를 임의로 수정하지 않는다.
- plan은 확정된 문서를 기준으로 작업 구조만 만든다.
- plan은 대상 스펙의 Anchor(예: `[REQ-001]`, `[API-001]`)를 가능한 범위에서 작업에 연결한다.
- plan은 작업의 선행/후행 관계를 판단한다.
- plan은 한 번에 한 계층만 분해한다.
- plan은 doc, dev, history-save, version-control 작업을 대신하지 않는다.
- plan은 현재 action의 결과만 만들고, 후속 action은 자동 실행하지 않는다.

---

## 3. Work Hierarchy Definition

작업은 다음 계층을 따른다.

1. Phase
   - 가장 큰 목표 또는 마일스톤 단위다.
   - 예: MVP, v1.1, 인증 기반 정리, 운영 준비

2. Cycle
   - Phase 안에서 반복적으로 확인 가능한 기능 또는 안정화 묶음이다.
   - 예: Minimal Implementation, Stability, Operational Readiness

3. Work Package (WP)
   - dev가 실행할 수 있는 의미 있는 작업 묶음이다.
   - 하나의 기능 흐름, 변경 묶음, 또는 검증 가능한 개발 단위다.
   - 너무 작게 쪼개지 않고, 실패 시 되돌리기 쉬운 범위로 유지한다.

4. Task
   - Work Package 안의 최소 실행 단위다.
   - dev agent가 순서대로 처리할 수 있는 작업 항목이다.
   - 하나의 명확한 입력, 출력, 검증 기준을 가진다.

---

## 4. Plan Commands

plan 계열 명령은 다음으로 나눈다.

- `plan extract-candidates`
- `plan phase-split`
- `plan cycle-split`
- `plan wp-split`
- `plan task-split`

권장 실행 순서:

1. `plan extract-candidates`
2. `plan phase-split`
3. `plan cycle-split`
4. `plan wp-split`
5. `plan task-split`

단, 이미 상위 계층이 확정되어 있으면 필요한 하위 action부터 실행할 수 있다.

---

## 5. plan extract-candidates

### 5.1 Purpose

요구사항 또는 설계 문서에서 개발해야 할 후보 작업을 추출한다.

### 5.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md`
- 현재 project의 `PROJECT.compact.md`가 있으면 해당 문서
- 대상 specs 문서
- 사용자가 명시한 참조 문서

읽지 않기:

- source code
- README 전체
- history
- bundle
- 무관 specs
- version-control 정보

### 5.3 Allowed

- 요구사항/설계 기반 구현 후보 추출
- Anchor 매핑
- Candidate ID 부여
- 간단한 우선순위 표시
- 의존성 후보 표시
- 제외 또는 후순위 후보 표시

### 5.4 Forbidden

- Phase/Cycle/WP/Task까지 한 번에 분해
- 기술 스택 재선정
- 구현 로직 작성
- source code 수정
- version-control 작업
- 파일 직접 수정

### 5.5 Output Focus

- Candidate ID
- Source Anchor
- Summary
- Type
- Priority
- Dependency
- Deferred 여부

### 5.6 Next Prompt Condition

다음 조건을 모두 만족할 때만 `plan phase-split`용 copy-ready prompt를 출력할 수 있다.

- 후보 목록이 충분히 정리된 경우
- 사람 검토 또는 확정이 먼저 필요하지 않은 경우
- 다음 단계가 Phase 분해로 명확한 경우

조건을 만족하지 않으면 copy-ready prompt를 출력하지 않는다.

---

## 6. plan phase-split

### 6.1 Purpose

추출된 후보 목록을 큰 목표 단위인 Phase로 그룹화한다.

### 6.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md`
- 현재 project의 `work/work-candidates.md`
- 필요한 최소 대상 문서

읽지 않기:

- source code
- README 전체
- history
- bundle
- 무관 specs
- version-control 정보

### 6.3 Allowed

- 후보 항목의 Phase 그룹화
- Phase 목표 정의
- Phase별 포함/제외 범위 정리
- 선행/후행 관계 설정
- 후속 후보 분리

### 6.4 Forbidden

- Cycle/WP/Task 수준의 세부 분해
- 구현 로직 설명
- 문서 원문 수정
- source code 수정
- version-control 작업
- 파일 직접 수정

### 6.5 Output Focus

- Phase ID
- Phase Goal
- Included Candidates
- Excluded or Deferred Candidates
- Dependency
- Exit Criteria

### 6.6 Next Prompt Condition

다음 조건을 모두 만족할 때만 `plan cycle-split`용 copy-ready prompt를 출력할 수 있다.

- 대상 Phase가 명확한 경우
- Phase 구성이 사용자 검토 없이 다음 단계로 진행 가능하다고 판단되는 경우
- 다음 단계가 특정 Phase의 Cycle 분해로 명확한 경우

사람 검토 또는 Phase 확정이 먼저 필요하면 copy-ready prompt를 출력하지 않는다.

---

## 7. plan cycle-split

### 7.1 Purpose

특정 Phase를 검증 가능한 Cycle 단위로 나눈다.

### 7.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md`
- 현재 project의 `work/work-roadmap.md`
- 대상 Phase
- 필요한 최소 참조 문서

읽지 않기:

- source code
- README 전체
- history
- bundle
- 무관 specs
- version-control 정보

### 7.3 Allowed

- Phase 내부 Cycle 분리
- Cycle별 목표 정의
- Cycle별 검증 기준 정의
- 선행/후행 관계 정리

### 7.4 Forbidden

- WP/Task 수준의 세부 분해
- 구현 로직 설명
- source code 수정
- version-control 작업
- 파일 직접 수정

### 7.5 Output Focus

- Cycle ID
- Cycle Goal
- Included Phase Items
- Verification Focus
- Dependency
- Exit Criteria

### 7.6 Next Prompt Condition

다음 조건을 모두 만족할 때만 `plan wp-split`용 copy-ready prompt를 출력할 수 있다.

- 대상 Cycle이 명확한 경우
- Cycle 구성이 사용자 검토 없이 다음 단계로 진행 가능하다고 판단되는 경우
- 다음 단계가 특정 Cycle의 WP 분해로 명확한 경우

사람 검토 또는 Cycle 확정이 먼저 필요하면 copy-ready prompt를 출력하지 않는다.

---

## 8. plan wp-split

### 8.1 Purpose

특정 Cycle을 dev가 실행 가능한 Work Package 단위로 분해한다.

### 8.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md`
- 현재 project의 `work/work-roadmap.md`
- 대상 Cycle
- 필요한 최소 참조 문서

읽지 않기:

- source code 전체
- 현재 Cycle과 무관한 specs
- README 전체
- history
- bundle
- version-control 정보

### 8.3 Allowed

- WP ID 부여
- WP 목표 정의
- 포함 작업 범위 정리
- Affected Area 후보 표시
- 검증 기준 정리
- 선행/후행 관계 정리

### 8.4 Forbidden

- Task 수준의 세부 분해
- 소스 코드 레벨 구현 지시
- 구체 코드 작성
- 실제 파일 수정
- version-control 작업

### 8.5 Output Focus

- WP ID
- WP Goal
- Source Anchor
- Scope
- Affected Area
- Verification
- Dependency
- Out of Scope

### 8.6 Next Prompt Condition

다음 조건을 모두 만족할 때만 `plan task-split`용 copy-ready prompt를 출력할 수 있다.

- 대상 WP가 명확한 경우
- WP 범위가 충분히 작고 dev 실행 단위로 적합한 경우
- 다음 단계가 특정 WP의 Task 분해로 명확한 경우

사람 검토 또는 WP 확정이 먼저 필요하면 copy-ready prompt를 출력하지 않는다.

---

## 9. plan task-split

### 9.1 Purpose

특정 Work Package를 dev agent가 순서대로 실행할 수 있는 Task 단위로 분해한다.

### 9.2 Read Scope

읽기:

- `docs/AI_CONTEXT.compact.md`
- 대상 Work Package
- 해당 WP와 직접 연관된 설계/API/DB 문서
- 필요한 최소 참조 문서

읽지 않기:

- 전체 프로젝트 문서
- 무관한 설계 문서
- README 전체
- history
- bundle
- version-control 정보

### 9.3 Allowed

- Task ID 부여
- 실행 순서 정리
- 의존 Task 명시
- 검증 항목 추가
- 예상 변경 영역 표시
- dev handoff 후보 작성

### 9.4 Forbidden

- pseudocode 작성
- 실제 파일 수정
- 코드 구현
- 테스트 실행
- version-control 작업
- 문서 원문 임의 수정

### 9.5 Output Focus

- Task ID
- Task Goal
- Source Anchor
- Input
- Expected Output
- Verification
- Dependency
- Dev Handoff Note

### 9.6 Next Prompt Condition

`plan task-split`은 plan 계열의 마지막 분해 action이다.

기본적으로 copy-ready prompt를 출력하지 않는다.

단, 사용자가 명시적으로 dev 전환을 요청한 경우에만 dev handoff용 copy-ready prompt를 출력할 수 있다.

사람 검토 또는 Task 확정이 먼저 필요하면 copy-ready prompt를 출력하지 않는다.

---

## 10. Version Control Boundary

현재 SpecDrive의 plan 단계는 version-control 작업을 다루지 않는다.

plan은 작업 구조를 만드는 단계이며, branch, commit, PR, push, merge, release 판단을 수행하지 않는다.

필요한 경우 version-control 작업은 개발자가 별도로 처리한다.

---

## 11. Output Rule

plan 계열 명령의 기본 출력은 짧게 유지한다.

기본 출력 형식:

1. Summary
2. Plan Update Candidate
3. Files To Change
4. Issues Found
5. Next Step
6. Copy-ready Prompt

`Copy-ready Prompt`는 기본 출력에 포함하지 않는다.

`Copy-ready Prompt`는 `specdrive/rules/skill-wizard-rule.md`와 각 action의 Next Prompt Condition을 모두 만족할 때만 출력한다.

후속 작업이 없거나 사람 검토가 먼저 필요하면 `Copy-ready Prompt` 섹션 자체를 출력하지 않는다.

---

## 12. Plan Update Candidate Rule

`Plan Update Candidate`는 반영 후보일 뿐이다.

규칙:

- 직접 파일을 수정하지 않는다.
- 사용자의 승인 전에는 상태 문서, roadmap, candidates, task 문서를 변경하지 않는다.
- 하나의 action은 하나의 계층만 반영 후보로 만든다.
- 기존 확정 항목을 임의로 삭제하지 않는다.
- 불명확한 항목은 `Open Questions` 또는 `Issues Found`에 남긴다.

권장 반영 대상 예:

- `docs/projects/{project}/work/work-candidates.md`
- `docs/projects/{project}/work/work-roadmap.md`
- `docs/projects/{project}/work/work-packages.md`
- `docs/projects/{project}/work/work-tasks.md`

---

## 13. Files To Change Rule

`Files To Change`에는 실제 반영 후보 파일만 적는다.

규칙:

- 대상 파일은 최소화한다.
- 하나의 action에서 여러 파일을 바꾸지 않는 것을 기본으로 한다.
- 대상 외 파일 변경이 필요하면 먼저 제안한다.
- source code 파일은 `Files To Change`에 포함하지 않는다.
- version-control 관련 파일은 포함하지 않는다.

---

## 14. Save / Apply Boundary

plan은 파일 반영을 자동 수행하지 않는다.

규칙:

- plan action은 기본적으로 반영 후보만 출력한다.
- 사용자의 승인 전에는 파일을 수정하지 않는다.
- 파일 반영은 별도 승인 또는 별도 action으로 수행한다.
- 반영 prompt는 사용자가 요청했거나, 다음 action으로 파일 반영이 명확할 때만 출력한다.
- 반영 prompt는 하나의 대상 파일만 다루는 것을 기본으로 한다.

반영 prompt가 필요한 경우에는 다음처럼 짧게 출력한다.

제공된 Plan Update Candidate를 기준으로 `[대상 파일 경로]` 파일에 반영해줘.  
변경 파일은 Files To Change 목록으로 제한해줘.  
문서 원문 재설계, source code 수정, version-control 작업은 하지 마.

---

## 15. Issues Rule

문제가 없으면 다음 한 줄만 출력한다.

- Issues Found: None

문제가 있으면 최대 5개까지만 출력한다.

형식:

- Issue:
- Impact:
- Recommended Action:

---

## 16. Final Rule

plan은 문서를 새로 확정하는 단계가 아니다.

plan은 코드를 구현하는 단계도 아니다.

plan의 목적은 확정된 문서를 기준으로 dev가 실행 가능한 작업 구조를 만드는 것이다.

따라서 plan은 적게 읽고, 한 계층만 나누고, 짧게 출력한다.

후속 action이 명확할 때만 하나의 copy-ready prompt를 출력한다.
