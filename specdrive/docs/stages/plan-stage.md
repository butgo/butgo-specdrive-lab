# Plan Stage

## 1. 문서 목적

이 문서는 SpecDrive의 `plan` 단계 책임과 경계를 정의한다.

`plan` 단계는 `doc` 단계에서 준비한 기준 문서를 dev 실행 가능한 작업 구조로 분해하는 단계다.
이 단계는 코딩을 시작하지 않고, `work-candidates.md` 와 `work-roadmap.md` 중심의 계획 구조를 만든다.

---

## 2. 단계 책임

`plan` 단계는 다음을 다룬다.

- 작업 후보를 dev 코딩 묶음인 Work Package 후보로 분해
- 개발 문서에서 일반 작업 후보 추출
- Work Package 후보를 Phase 범위에 배치
- Work Package 후보를 Cycle 완성도 단계에 배치
- 선택된 Work Package 내부 Task 분해
- `work-candidates.md`, `work-roadmap.md` 갱신 후보 작성

---

## 3. 현재 action 후보

현재 `plan` 단계는 다음 action 후보를 기준으로 본다.

- `$plan extract-candidates`
- `$plan wp-split`
- `$plan phase-split`
- `$plan cycle-split`
- `$plan task-split`

### 3.1 `$plan extract-candidates`

개발 문서에서 일반 작업 후보를 추출한다.

이 action은 Work Package, Task, 문서 작업, 운영 작업, 후속 아이디어를 바로 확정하지 않는다.  
가능한 작업 후보를 `Proposed` 또는 `Needs Clarification` 상태로 제안한다.

### 3.2 `$plan wp-split`

작업 후보를 dev 코딩 한 묶음으로 볼 수 있는 Work Package 후보로 분해한다.

이 action은 확정 Task를 만들지 않는다.  
문서에 근거가 있는 코딩 묶음 후보를 `Proposed` 상태로 제안한다.

### 3.3 `$plan phase-split`

Work Package 후보를 사용자/제품 관점의 Phase 범위에 배치한다.

Phase는 “무엇을 만들 것인가”에 가까운 기능 범위다.

### 3.4 `$plan cycle-split`

Work Package 후보를 Cycle 완성도 단계에 배치한다.

기본 Cycle은 다음 세 단계를 사용한다.

- Cycle 1 - Minimal Implementation
- Cycle 2 - Stability
- Cycle 3 - Operational Readiness

### 3.5 `$plan task-split`

선택된 Work Package 내부를 실제 실행 Task로 분해한다.

Task는 Work Package를 완료하기 위한 세부 실행 단위이며, dev 실행의 기본 묶음은 Task 하나가 아니라 Work Package다.

---

## 4. Work Package 기준

Work Package는 dev 코딩의 한 묶음이다.

좋은 Work Package는 완료 시 다음 중 하나 이상의 결과가 남아야 한다.

- 의미 있는 동작 흐름
- 구조적으로 연결된 구현 단위
- 테스트 또는 수동 검증 가능한 결과
- 다음 Work Package로 넘어갈 수 있는 명확한 완료 기준

예:

```text
WP-02 게시글 등록/조회 최소 흐름
- 게시글 생성 API
- 게시글 단건 조회 API
- 최소 persistence 연결
- 등록 후 조회 검증
```

---

## 5. 경계

- `plan` 단계는 코딩하지 않는다.
- `plan` 단계는 현재 실행 포인터를 확정하지 않는다.
- `work-index.md` 설정은 dev 시작 시점의 책임으로 본다.
- Work Package 후보는 바로 확정 Task가 아니다.
- 문서에 근거가 약한 항목은 `Needs Clarification` 으로 둔다.

---

## 6. 다음 단계

개발자가 plan 결과를 승인하면 `dev` 단계에서 현재 실행할 Work Package를 선택하고 `work-index.md` 를 설정한다.
