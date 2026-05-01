# Work Candidates

## 1. 문서 목적

이 문서는 아직 `work-roadmap.md`로 승격되지 않은 작업 후보를 관리한다.

`work-candidates.md`는 확정된 작업 계획 문서가 아니다.  
프로젝트 문서에서 도출된 후보를 수집하고, 사람이 검토한 뒤 `work-roadmap.md`로 승격할지 판단하기 위한 문서다.

Candidate는 바로 Task가 아니다.

~~~text
Candidate
  ↓ review

Accepted Candidate
  ↓ promote

work-roadmap.md
  ↓ select current scope

work-index.md
~~~

---

## 2. 생성 원칙

`work-candidates.md`는 사람이 처음부터 직접 작성하기보다, Codex가 프로젝트 문서를 기준으로 초안을 생성하고 사람이 검토하는 것을 기본 흐름으로 한다.

Codex는 다음 원칙을 따른다.

- 문서를 새로 설계하지 않는다.
- 현재 프로젝트 문서에 있는 내용에서만 후보를 추출한다.
- 요구사항, 설계, API, DB, 운영 문서에서 유도되는 작업 후보를 찾는다.
- Candidate를 바로 Task로 확정하지 않는다.
- Phase / Cycle은 확정하지 않고 제안만 한다.
- 현재 범위를 넘는 항목은 Deferred 후보로 분리한다.
- 불명확한 항목은 `Needs Clarification`으로 표시한다.
- specs와 충돌하는 항목은 후보로 만들지 않거나 `Rejected` 사유로 남긴다.

---

## 3. Candidate 추출 기준 문서

Codex는 프로젝트 상황에 맞게 다음 문서를 기준으로 후보를 추출한다.

필수 기준 문서:

- `AGENTS.md`
- `AGENTS.compact.md`
- `index.md`
- `01-overview.md`
- `specs/*.md`

선택 기준 문서:

- `README.md`
- `README.ko.md`
- `status/current-status.md`
- `rules/affected-docs-rules.md`
- 기존 `work/work-roadmap.md`
- 기존 `work/work-index.md`
- 기존 `work/work-log.md`

주의:

- Candidate 생성 단계에서는 `work-index.md`보다 `01-overview.md`와 `specs/*.md`를 우선한다.
- `work-index.md`는 현재 실행 포인터이므로, 후보 생성의 기준 문서가 아니라 중복 방지와 현재 범위 확인용으로만 사용한다.
- `work-roadmap.md`가 이미 존재한다면, 기존 roadmap과 중복되는 후보를 만들지 않는다.

---

## 4. Candidate 상태 기준

| Status | 의미 | 처리 기준 |
|---|---|---|
| Proposed | 후보로 제안됨 | 아직 승격 여부가 결정되지 않음 |
| Accepted | roadmap 승격 대상 | `work-roadmap.md`로 승격 가능 |
| Deferred | 후속 검토 | 현재 Phase/Cycle에서는 제외 |
| Rejected | 제외 | 현재 프로젝트 범위와 맞지 않거나 specs와 충돌 |
| Merged | 병합됨 | 다른 Candidate 또는 Roadmap 항목에 병합 |
| Needs Clarification | 추가 확인 필요 | 요구사항, 범위, 완료 기준이 불명확 |

---

## 5. Candidate 승격 기준

Candidate는 다음 조건을 만족할 때 `Accepted`로 표시할 수 있다.

- 현재 프로젝트 목표와 맞는다.
- 관련 기준 문서가 존재한다.
- Phase / Cycle로 분해할 수 있다.
- Work Package 또는 Task로 구체화할 수 있다.
- 완료 기준을 정의할 수 있다.
- 검증 기준을 정의할 수 있다.
- 현재 범위를 과도하게 흔들지 않는다.
- specs와 충돌하지 않는다.

`Accepted` 상태가 된 Candidate만 `work-roadmap.md`로 승격할 수 있다.

---

## 6. Candidate 보류 기준

다음 항목은 `Deferred`로 표시한다.

- 현재 Phase 범위를 명확히 넘는 작업
- 장기 확장 후보
- 요구사항은 있으나 구현 시점이 아직 이른 작업
- 현재 구조가 안정된 뒤 검토해야 하는 작업
- 외부 도구, CLI, TUI, MCP, SaaS 등 후속 확장 후보
- 지금 결정하면 과설계가 될 가능성이 큰 작업

---

## 7. Candidate 제외 기준

다음 항목은 `Rejected`로 표시한다.

- 현재 프로젝트 목표와 직접 관련 없는 작업
- 기준 문서에서 근거를 찾을 수 없는 작업
- specs와 충돌하는 작업
- 현재 아키텍처 원칙을 위반하는 작업
- 이미 roadmap에 반영되어 중복되는 작업
- 별도 프로젝트로 분리해야 할 작업
- 구현보다 먼저 정책 결정이 필요한데 결정 근거가 없는 작업

---

## 8. Candidate 병합 기준

다음 경우 `Merged`로 표시한다.

- 동일한 목적의 Candidate가 이미 존재하는 경우
- 더 큰 Work Package에 포함되는 경우
- 기존 Roadmap 항목에 흡수되는 경우
- 표현만 다르고 실질적으로 같은 작업인 경우

병합 시 `Merged To`에 병합 대상 ID를 기록한다.

---

## 9. Candidate 목록

| ID | Candidate | Source | Suggested Phase | Suggested Cycle | Status | Reason | Note | Merged To |
|---|---|---|---|---|---|---|---|---|
| CAND-001 |  |  |  |  | Proposed |  |  |  |

작성 기준:

- `ID`는 `CAND-001` 형식을 사용한다.
- `Candidate`는 작업 후보 이름을 짧게 적는다.
- `Source`에는 근거 문서를 적는다.
- `Suggested Phase`는 확정값이 아니라 제안값이다.
- `Suggested Cycle`은 확정값이 아니라 제안값이다.
- `Status`는 상태 기준에 따라 작성한다.
- `Reason`에는 후보로 추출한 이유를 적는다.
- `Note`에는 주의사항, 불확실성, 검토 필요 사항을 적는다.
- `Merged To`는 `Merged` 상태일 때만 사용한다.

---

## 10. Candidate 상세

필요한 경우 Candidate별 상세 내용을 아래에 작성한다.

### CAND-001. {{candidate-name}}

| 항목 | 내용 |
|---|---|
| Status | Proposed |
| Source |  |
| Suggested Phase |  |
| Suggested Cycle |  |
| Merged To |  |

#### 후보 설명

<!-- 이 후보가 무엇인지 간단히 설명한다. -->

#### 근거

<!-- 어떤 문서의 어떤 내용에서 유도되었는지 적는다. -->

#### 기대 효과

<!-- 이 후보가 프로젝트에 반영될 경우 어떤 효과가 있는지 적는다. -->

#### 검토 필요 사항

<!-- 불명확하거나 사람이 판단해야 할 내용을 적는다. -->

#### 승격 조건

<!-- 어떤 조건을 만족하면 work-roadmap.md로 승격할 수 있는지 적는다. -->

---

## 11. Codex Candidate 생성 프롬프트 기준

Codex에게 `work-candidates.md` 생성을 요청할 때는 다음 기준을 사용한다.

~~~text
다음 문서를 기준으로 현재 프로젝트의 작업 후보를 추출해줘.

참조 문서:
- AGENTS.md
- AGENTS.compact.md
- index.md
- 01-overview.md
- specs/*.md
- 필요한 경우 README.md, status/current-status.md

작업 원칙:
- 문서를 새로 설계하지 말 것
- 현재 문서에 있는 요구사항과 설계에서만 후보를 추출할 것
- Candidate를 바로 Task로 확정하지 말 것
- Phase / Cycle은 제안만 할 것
- 기존 roadmap과 중복되는 후보는 만들지 말 것
- 현재 범위를 넘는 항목은 Deferred 후보로 분리할 것
- 불명확한 항목은 Needs Clarification으로 표시할 것
- specs와 충돌하는 항목은 Rejected 사유로 남길 것

출력 대상:
- work/work-candidates.md

출력 형식:
- Candidate 목록 표
- 필요한 경우 Candidate 상세
~~~

---

## 12. 검토 체크리스트

Candidate 검토 시 다음을 확인한다.

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 기준 문서에 근거가 있는가? |  |  |
| 현재 프로젝트 목표와 맞는가? |  |  |
| 기존 roadmap과 중복되지 않는가? |  |  |
| Phase / Cycle 제안이 타당한가? |  |  |
| 완료 기준을 만들 수 있는가? |  |  |
| 검증 기준을 만들 수 있는가? |  |  |
| 현재 범위를 과도하게 흔들지 않는가? |  |  |
| specs와 충돌하지 않는가? |  |  |
| Accepted / Deferred / Rejected / Merged 판단이 필요한가? |  |  |

---

## 13. 금지 사항

다음을 금지한다.

- Candidate를 바로 구현하는 것
- Candidate를 개발자 검토 없이 Task로 확정하는 것
- Candidate를 `work-index.md`에 직접 넣는 것
- `Accepted`가 아닌 Candidate를 `work-roadmap.md`로 승격하는 것
- 기준 문서에 근거가 없는 후보를 만드는 것
- 기존 roadmap과 중복되는 후보를 반복 생성하는 것
- 현재 Phase 범위를 넘는 후보를 Accepted로 처리하는 것
- specs와 충돌하는 후보를 Accepted로 처리하는 것
- 후보 문서를 상세 구현 계획 문서처럼 사용하는 것