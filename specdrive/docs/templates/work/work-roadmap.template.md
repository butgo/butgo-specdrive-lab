# Work Roadmap

## 1. 문서 목적

이 문서는 이 프로젝트의 확정된 작업 구조를 관리한다.

`work-roadmap.md`는 후보 목록 문서가 아니다.  
`work-candidates.md`에서 검토되어 `Accepted` 상태가 된 Candidate를 Phase / Cycle / Work Package / Task 구조로 승격한 작업 계획 문서다.

현재 작업 포인터는 이 문서가 아니라 `work-index.md`에서 관리한다.

~~~text
work-candidates.md
  ↓ review

Accepted Candidate
  ↓ promote

work-roadmap.md
  ↓ select current scope

work-index.md
~~~

---

## 2. 기본 원칙

이 문서는 다음 원칙을 따른다.

- Candidate는 바로 Roadmap 항목이 아니다.
- `Accepted` 상태가 된 Candidate만 Roadmap에 승격한다.
- 전체 작업 구조는 Phase / Cycle / Work Package / Task 순서로 작성한다.
- Task를 먼저 만들지 않는다.
- 현재 작업 위치는 `work-index.md`에서 관리한다.
- `work-roadmap.md`에는 전체 작업 구조와 완료 기준을 둔다.
- Work Package에는 필요한 경우 선행 관계, 우선순위, 검증 기준을 함께 둔다.
- specs와 충돌하는 작업은 Roadmap에 포함하지 않는다.
- 현재 Phase 밖 작업은 필요 시 후속 Phase 또는 Deferred 항목으로 분리한다.

---

## 3. Roadmap 작성 기준

Roadmap은 다음 단위로 구성한다.

~~~text
Phase
  ↓
Cycle
  ↓
Work Package
  ↓
Task
~~~

각 단위의 의미는 다음과 같다.

| 단위 | 의미 | 관리 문서 |
|---|---|---|
| Phase | 프로젝트의 큰 작업 범위 | `work-roadmap.md` |
| Cycle | Phase 안의 완성도 반복 단위 | `work-roadmap.md` |
| Work Package | Cycle 안에서 의미 있게 완료 가능한 작업 묶음 | `work-roadmap.md`, `work-index.md` |
| Task | Work Package를 수행하기 위한 최소 실행 단위 | `work-roadmap.md`, 필요 시 `work-index.md` |
| Current Focus | 현재 실행 위치 | `work-index.md` |

---

### 3.1 Work Package 권장 필드

Work Package에는 다음 정보를 우선 기록한다.

| 필드 | 의미 |
|---|---|
| Source Candidate | 어떤 Candidate에서 승격되었는지 |
| Dependencies | 먼저 끝나야 하는 Work Package 또는 기준 문서 |
| Priority | 현재 Phase/Cycle 안에서의 상대 우선순위 |
| Completion Criteria | 완료로 판단할 조건 |
| Verification Criteria | 테스트 또는 수동 검증 기준 |

`Dependencies`와 `Priority`는 복잡한 작업에서만 사용하고, 단순한 Roadmap에서는 비워 둘 수 있다.

---

## 4. 상태 기준

### 4.1 Phase 상태

| Status | 의미 |
|---|---|
| Planned | 계획됨 |
| In Progress | 진행 중 |
| Done | 완료 |
| Deferred | 후속 보류 |
| Blocked | 진행 불가 |

---

### 4.2 Cycle 상태

| Status | 의미 |
|---|---|
| Planned | 계획됨 |
| In Progress | 진행 중 |
| Done | 완료 |
| Deferred | 후속 보류 |
| Blocked | 진행 불가 |

---

### 4.3 Work Package 상태

| Status | 의미 |
|---|---|
| Planned | 계획됨 |
| In Progress | 진행 중 |
| Done | 완료 |
| Deferred | 후속 보류 |
| Blocked | 진행 불가 |

---

### 4.4 Task 상태

| Status | 의미 |
|---|---|
| Todo | 아직 시작하지 않음 |
| In Progress | 진행 중 |
| Done | 완료 |
| Deferred | 후속 보류 |
| Blocked | 진행 불가 |
| Cancelled | 제외됨 |

---

## 5. 전체 Roadmap 요약

| Phase | Goal | Status | Current Cycle | Note |
|---|---|---|---|---|
| Phase 1 |  | Planned |  |  |
| Phase 2 |  | Planned |  |  |
| Phase 3 |  | Planned |  |  |

---

## 6. Phase 1

### 6.1 Phase 개요

| 항목 | 내용 |
|---|---|
| Phase | Phase 1 |
| Goal |  |
| Status | Planned |
| Source Candidates |  |
| Related Specs |  |
| Completion Criteria |  |
| Verification Criteria |  |
| Note |  |

---

### 6.2 Cycle 1 - Minimal Implementation

#### Cycle 개요

| 항목 | 내용 |
|---|---|
| Cycle | Cycle 1 |
| Name | Minimal Implementation |
| Goal | 최소 동작 구현 |
| Status | Planned |
| Completion Criteria |  |
| Verification Criteria |  |
| Note |  |

#### Work Packages

| ID | Work Package | Status | Source Candidate | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| WP-1-1-001 |  | Planned |  |  |  |  |

#### Tasks

##### WP-1-1-001. {{work-package-name}}

| Task ID | Task | Status | Related Docs | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| T-1-1-001-01 |  | Todo |  |  |  |  |

---

### 6.3 Cycle 2 - Stability

#### Cycle 개요

| 항목 | 내용 |
|---|---|
| Cycle | Cycle 2 |
| Name | Stability |
| Goal | 구조 안정화, 테스트, 오류 처리 |
| Status | Planned |
| Completion Criteria |  |
| Verification Criteria |  |
| Note |  |

#### Work Packages

| ID | Work Package | Status | Source Candidate | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| WP-1-2-001 |  | Planned |  |  |  |  |

#### Tasks

##### WP-1-2-001. {{work-package-name}}

| Task ID | Task | Status | Related Docs | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| T-1-2-001-01 |  | Todo |  |  |  |  |

---

### 6.4 Cycle 3 - Operational Readiness

#### Cycle 개요

| 항목 | 내용 |
|---|---|
| Cycle | Cycle 3 |
| Name | Operational Readiness |
| Goal | 실행, 설정, 복구, 운영 재현 문서화 |
| Status | Planned |
| Completion Criteria |  |
| Verification Criteria |  |
| Manual Target | `manual/phases/phase-01-manual.md` |
| Note |  |

#### Work Packages

| ID | Work Package | Status | Source Candidate | Completion Criteria | Verification Criteria | Manual Impact | Note |
|---|---|---|---|---|---|---|---|
| WP-1-3-001 |  | Planned |  |  |  |  |  |

#### Tasks

##### WP-1-3-001. {{work-package-name}}

| Task ID | Task | Status | Related Docs | Completion Criteria | Verification Criteria | Manual Impact | Note |
|---|---|---|---|---|---|---|---|
| T-1-3-001-01 |  | Todo |  |  |  |  |  |

---

## 7. Phase 2

### 7.1 Phase 개요

| 항목 | 내용 |
|---|---|
| Phase | Phase 2 |
| Goal |  |
| Status | Planned |
| Source Candidates |  |
| Related Specs |  |
| Completion Criteria |  |
| Verification Criteria |  |
| Note |  |

---

### 7.2 Cycle 1 - Minimal Implementation

#### Cycle 개요

| 항목 | 내용 |
|---|---|
| Cycle | Cycle 1 |
| Name | Minimal Implementation |
| Goal | 최소 동작 구현 |
| Status | Planned |
| Completion Criteria |  |
| Verification Criteria |  |
| Note |  |

#### Work Packages

| ID | Work Package | Status | Source Candidate | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| WP-2-1-001 |  | Planned |  |  |  |  |

#### Tasks

##### WP-2-1-001. {{work-package-name}}

| Task ID | Task | Status | Related Docs | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| T-2-1-001-01 |  | Todo |  |  |  |  |

---

### 7.3 Cycle 2 - Stability

#### Cycle 개요

| 항목 | 내용 |
|---|---|
| Cycle | Cycle 2 |
| Name | Stability |
| Goal | 구조 안정화, 테스트, 오류 처리 |
| Status | Planned |
| Completion Criteria |  |
| Verification Criteria |  |
| Note |  |

#### Work Packages

| ID | Work Package | Status | Source Candidate | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| WP-2-2-001 |  | Planned |  |  |  |  |

#### Tasks

##### WP-2-2-001. {{work-package-name}}

| Task ID | Task | Status | Related Docs | Completion Criteria | Verification Criteria | Note |
|---|---|---|---|---|---|---|
| T-2-2-001-01 |  | Todo |  |  |  |  |

---

### 7.4 Cycle 3 - Operational Readiness

#### Cycle 개요

| 항목 | 내용 |
|---|---|
| Cycle | Cycle 3 |
| Name | Operational Readiness |
| Goal | 실행, 설정, 복구, 운영 재현 문서화 |
| Status | Planned |
| Completion Criteria |  |
| Verification Criteria |  |
| Manual Target | `manual/phases/phase-02-manual.md` |
| Note |  |

#### Work Packages

| ID | Work Package | Status | Source Candidate | Completion Criteria | Verification Criteria | Manual Impact | Note |
|---|---|---|---|---|---|---|---|
| WP-2-3-001 |  | Planned |  |  |  |  |  |

#### Tasks

##### WP-2-3-001. {{work-package-name}}

| Task ID | Task | Status | Related Docs | Completion Criteria | Verification Criteria | Manual Impact | Note |
|---|---|---|---|---|---|---|---|
| T-2-3-001-01 |  | Todo |  |  |  |  |  |

---

## 8. Deferred Roadmap Items

이 섹션은 Roadmap에 포함되었지만 현재 Phase/Cycle에서 진행하지 않는 확정 보류 항목을 관리한다.

Candidate 단계의 단순 후보는 `work-candidates.md`에 둔다.

| ID | Item | Source Candidate | Reason | Revisit Timing | Note |
|---|---|---|---|---|---|
| DEF-001 |  |  |  |  |  |

---

## 9. Promotion History

`work-candidates.md`에서 `work-roadmap.md`로 승격된 이력을 요약한다.

상세 history는 기존 history 관리 방식을 따른다.

| Date | Candidate ID | Roadmap Target | Decision | Note |
|---|---|---|---|---|
| YYYY-MM-DD | CAND-001 | Phase 1 / Cycle 1 / WP-1-1-001 | Promoted |  |

---

## 10. Roadmap 변경 기준

Roadmap은 다음 경우에 갱신한다.

- Candidate가 `Accepted`되어 Roadmap에 승격되었을 때
- Phase / Cycle / Work Package / Task 구조가 바뀌었을 때
- 완료 기준이 바뀌었을 때
- 검증 기준이 바뀌었을 때
- Work Package 상태가 바뀌었을 때
- Task 상태가 바뀌었을 때
- Deferred Roadmap Item이 생겼을 때
- Phase 또는 Cycle 전환 기준이 바뀌었을 때

---

## 11. Roadmap 변경 시 확인 사항

Roadmap을 변경할 때는 다음을 확인한다.

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| `work-candidates.md`에서 Accepted 상태인가? |  |  |
| Source Candidate가 기록되어 있는가? |  |  |
| Phase / Cycle / Work Package / Task 구조가 유지되는가? |  |  |
| 완료 기준이 있는가? |  |  |
| 검증 기준이 있는가? |  |  |
| 관련 specs와 충돌하지 않는가? |  |  |
| 현재 Work Package 범위를 과도하게 확장하지 않는가? |  |  |
| `work-index.md` 갱신이 필요한가? |  |  |
| `work-log.md` 기록이 필요한가? |  |  |
| `status/current-status.md` 갱신이 필요한가? |  |  |
| `manual/` 갱신이 필요한가? |  |  |
| `rules/affected-docs-rules.md` 기준 점검이 필요한가? |  |  |

---

## 12. Codex 사용 기준

Codex가 Roadmap을 생성하거나 수정할 때는 다음 기준을 따른다.

- `work-policy.md`를 우선 따른다.
- `work-candidates.md`의 `Accepted` Candidate만 Roadmap에 승격한다.
- Candidate를 임의로 추가하지 않는다.
- Phase / Cycle / Work Package / Task 순서를 유지한다.
- Task를 먼저 만들지 않는다.
- 완료 기준과 검증 기준을 함께 작성한다.
- 현재 작업 포인터를 `work-roadmap.md`에 반복하지 않는다.
- 현재 작업 포인터는 `work-index.md`에 둔다.
- specs와 충돌하는 구조 변경을 하지 않는다.
- 현재 Cycle 범위를 넘는 작업을 임의로 추가하지 않는다.
- 현재 Phase 밖 항목은 Deferred Roadmap Items 또는 `work-candidates.md`로 분리한다.

---

## 13. 금지 사항

다음을 금지한다.

- `Proposed` Candidate를 Roadmap에 승격하는 것
- `Deferred` Candidate를 현재 Phase에 포함하는 것
- `Rejected` Candidate를 Roadmap에 포함하는 것
- Candidate 근거 없이 Roadmap 항목을 만드는 것
- Task를 먼저 만들고 Phase/Cycle을 나중에 맞추는 것
- 현재 작업 포인터를 `work-roadmap.md`에 중복 관리하는 것
- 전체 Roadmap을 `work-index.md`에 복사하는 것
- specs와 충돌하는 작업을 Roadmap에 포함하는 것
- 현재 Phase/Cycle 범위를 넘는 작업을 임의로 현재 작업으로 끌어오는 것
- Cycle 3 산출물을 manual 갱신 없이 완료 처리하는 것
