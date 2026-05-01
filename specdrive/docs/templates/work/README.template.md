# Work

## 1. 문서 목적

이 문서는 이 프로젝트의 `work/` 디렉터리 사용 방법을 설명한다.

`work/` 디렉터리는 단순 구현 계획을 보관하는 곳이 아니라, SpecDrive Work System을 프로젝트에 적용하기 위한 작업 운영 공간이다.

이 디렉터리는 다음을 관리한다.

- 작업 후보 수집
- Phase / Cycle / Work Package / Task 구조
- 현재 작업 포인터
- Codex 실행 기준
- 작업 결과 요약
- 다음 작업 전환 기준

상세한 공통 기준은 SpecDrive Core의 `work-system.md`를 따른다.

---

## 2. Work 폴더 역할

`work/`는 현재 프로젝트의 작업을 다음 흐름으로 관리한다.

~~~text
work-candidates.md
  ↓ promote

work-roadmap.md
  ↓ select current scope

work-index.md
  ↓ run

Codex execution
  ↓ sync

work-index.md / work-log.md
  ↓ 필요 시

status/current-status.md
manual/phases/*.md
rules/affected-docs-rules.md
~~~

즉 `work/`는 다음 질문에 답하기 위한 폴더다.

~~~text
무엇이 후보인가?
무엇이 확정된 작업인가?
현재 Phase는 무엇인가?
현재 Cycle은 무엇인가?
현재 Work Package는 무엇인가?
현재 Focus Task는 무엇인가?
작업 후 어디를 갱신해야 하는가?
다음 작업으로 넘어가도 되는가?
~~~

---

## 3. 기본 처리 흐름

### 3.1 Collect

후보 작업은 `work-candidates.md`에 기록한다.

`work-candidates.md`는 사람이 처음부터 직접 작성하는 문서라기보다, Codex가 프로젝트 문서를 읽고 초안을 생성한 뒤 사람이 검토하는 문서다.

Codex는 다음 문서를 기준으로 후보를 추출할 수 있다.

- `AGENTS.md`
- `AGENTS.compact.md`
- `index.md`
- `01-overview.md`
- `specs/*.md`
- 필요한 경우 프로젝트별 README 문서

Candidate는 바로 Task가 아니다.

Candidate는 현재 또는 후속 Phase/Cycle에 포함하기로 확정되었을 때만 `work-roadmap.md`로 승격한다.

---

### 3.2 Review

개발자는 Codex가 생성한 Candidate를 검토한다.

검토 결과는 다음 중 하나로 정리한다.

- Accepted
- Deferred
- Rejected
- Merged
- Needs Clarification

Accepted 상태가 된 Candidate만 `work-roadmap.md`로 승격할 수 있다.

---

### 3.3 Promote

후보를 현재 또는 후속 Phase에 포함하기로 결정하면 `work-roadmap.md`에 반영한다.

이때 후보는 Phase / Cycle / Work Package / Task 구조로 분해되어야 한다.

Promote 과정에서 다음을 확인한다.

- 현재 프로젝트 목표와 맞는가?
- 현재 Phase 범위에 포함할 수 있는가?
- Cycle 기준으로 나눌 수 있는가?
- 완료 기준을 정의할 수 있는가?
- 검증 기준을 정의할 수 있는가?
- specs와 충돌하지 않는가?

---

### 3.4 Split

작업은 다음 순서로 분해한다.

~~~text
Phase
  ↓
Cycle
  ↓
Work Package
  ↓
Task
~~~

Task를 먼저 만들지 않는다.

Phase와 Cycle 기준이 먼저 확정되어야 한다.

---

### 3.5 Focus

현재 실행 위치는 `work-index.md`에서 관리한다.

`work-index.md`는 전체 작업 목록을 반복하지 않고, 현재 작업 포인터만 관리한다.

포함 대상은 다음과 같다.

- Current Phase
- Current Cycle
- Current Work Package
- Current Focus
- Next Task
- 최근 완료 항목
- 다음 진입점

---

### 3.6 Run

Codex 또는 개발자는 `work-index.md`의 Current Phase / Cycle / Work Package / Focus를 기준으로 작업한다.

현재 Work Package와 현재 Cycle 범위를 임의로 넘어가지 않는다.

---

### 3.7 Sync

작업 후에는 다음을 판단한다.

- 현재 Task가 완료되었는가?
- 현재 Work Package가 완료되었는가?
- 다음 Work Package로 넘어갈 수 있는가?
- Cycle 전환이 필요한가?
- Phase 전환이 필요한가?
- `work-log.md`에 결과를 남겨야 하는가?
- `status/current-status.md` 갱신이 필요한가?
- `manual/` 문서 갱신이 필요한가?
- `rules/affected-docs-rules.md` 기준으로 영향 문서 점검이 필요한가?

---

## 4. 문서 구성

### 4.1 work-candidates.md

아직 확정되지 않은 작업 후보를 관리한다.

이 문서는 Codex가 프로젝트 문서를 기준으로 초안을 생성하고, 개발자가 검토하여 상태를 확정하는 것을 기본 흐름으로 한다.

포함 대상:

- 후속 기능 후보
- 보류 작업
- 현재 Phase 밖 작업
- 나중에 검토할 개선 사항
- 아직 우선순위가 정해지지 않은 항목
- specs에서 유도되지만 아직 roadmap에 반영되지 않은 작업

원칙:

~~~text
Candidate는 바로 Task가 아니다.
Candidate는 검토 대상이다.
Accepted Candidate만 Roadmap에 승격된다.
Roadmap에 승격되어야 작업이 된다.
Index에 잡혀야 현재 작업이 된다.
~~~

---

### 4.2 work-policy.md

프로젝트별 Work System 적용 정책을 관리한다.

포함 대상:

- Phase 정의 기준
- Cycle 정의 기준
- Work Package 정의 기준
- Task 분해 기준
- Candidate 승격 기준
- Codex 실행 기준
- 상태 이동 기준
- 전환 기준
- 금지 사항

이 문서는 자주 바뀌지 않는 운영 정책 문서다.

---

### 4.3 work-roadmap.md

확정된 전체 작업 구조를 관리한다.

포함 대상:

- Phase
- Cycle
- Work Package
- Task
- 완료 기준
- 검증 기준

`work-roadmap.md`는 전체 작업 목록 문서다.

현재 작업 포인터는 `work-index.md`가 담당한다.

---

### 4.4 work-index.md

현재 작업 포인터를 관리한다.

포함 대상:

- Current Phase
- Current Cycle
- Current Work Package
- Current Focus
- Next Task
- 최근 완료 Work Package
- 다음 진입점

`work-index.md`는 짧게 유지한다.

전체 작업 목록을 반복하지 않는다.

---

### 4.5 work-log.md

최근 작업 실행 결과를 요약한다.

포함 대상:

- 완료된 Work Package
- sync 결과
- 다음 작업 판단
- 보류 이슈
- status 갱신 필요 여부
- manual 갱신 필요 여부
- rules 점검 필요 여부

상세 history는 기존 history 관리 방식을 따른다.

---

## 5. 읽는 순서

### 5.1 사람이 처음 읽는 순서

~~~text
1. README.md
2. work-policy.md
3. work-roadmap.md
4. work-index.md
5. 필요한 specs 문서
~~~

### 5.2 Codex가 작업 전 읽는 순서

~~~text
1. AGENTS.compact.md
2. work/README.md
3. work/work-policy.md
4. work/work-index.md
5. work/work-roadmap.md
6. 현재 작업에 필요한 specs 문서
~~~

### 5.3 Codex가 Candidate 생성 시 읽는 순서

~~~text
1. AGENTS.md
2. AGENTS.compact.md
3. index.md
4. 01-overview.md
5. specs/*.md
6. 필요한 경우 README.md
~~~

Candidate 생성 단계에서는 `work-index.md`보다 specs와 overview를 우선한다.

Candidate 생성은 현재 작업 실행이 아니라 후보 수집 단계이기 때문이다.

### 5.4 매번 읽지 않아도 되는 문서

~~~text
work-candidates.md
- 후보 생성, 후보 검토, 후보 승격 단계에서만 확인

work-log.md
- sync 또는 회고 단계에서만 확인

manual/
- Cycle 3 또는 실행 절차 작성 시 확인

rules/
- 문서 변경 전파 점검 시 확인

history/
- 명시 요청 시만 확인
~~~

---

## 6. Codex 실행 기준

Codex는 다음 기준을 따른다.

- 현재 작업은 `work-index.md`를 기준으로 판단한다.
- 전체 작업 구조는 `work-roadmap.md`를 기준으로 판단한다.
- 후보 작업은 `work-candidates.md`에서 직접 구현하지 않는다.
- Candidate 생성은 구현 작업이 아니다.
- Candidate를 Task로 확정하려면 개발자 검토와 roadmap 승격이 필요하다.
- 현재 Work Package 범위를 임의로 넘지 않는다.
- 현재 Cycle 범위를 임의로 넘지 않는다.
- specs와 충돌하는 구조 변경을 하지 않는다.
- 작업 후 sync 결과를 제안한다.
- 필요한 경우 `work-log.md`, `status/current-status.md`, `manual/` 갱신 여부를 제안한다.

---

## 7. Candidate 처리 기준

### 7.1 Candidate 상태

Candidate는 다음 상태 중 하나를 가진다.

| Status | 의미 |
|---|---|
| Proposed | 후보로 제안됨 |
| Accepted | roadmap 승격 대상 |
| Deferred | 후속 검토 |
| Rejected | 제외 |
| Merged | 다른 후보에 병합됨 |
| Needs Clarification | 추가 확인 필요 |

---

### 7.2 Candidate 승격 기준

Candidate는 다음 조건을 만족할 때 `work-roadmap.md`로 승격할 수 있다.

- 현재 프로젝트 목표와 맞는다.
- Phase / Cycle로 분해할 수 있다.
- 완료 기준을 정의할 수 있다.
- 검증 기준을 정의할 수 있다.
- 현재 범위를 과도하게 흔들지 않는다.
- specs와 충돌하지 않는다.

---

### 7.3 Candidate 제외 기준

다음 항목은 Rejected 또는 Deferred 처리한다.

- 현재 Phase 범위를 명확히 넘는 작업
- 아직 요구사항이 불명확한 작업
- 과도한 미래 확장
- specs와 충돌하는 작업
- 구현보다 먼저 설계 결정이 필요한 작업
- 현재 프로젝트 목표와 직접 관련 없는 작업

---

## 8. 상태 갱신 기준

작업 후 문서 갱신 기준은 다음과 같다.

~~~text
work-candidates.md
- 새로운 후보가 발견되었을 때
- 후보 상태가 바뀌었을 때
- 후보가 roadmap으로 승격되었을 때
- 후보가 보류 또는 제외되었을 때

work-roadmap.md
- Candidate가 Accepted되어 작업 구조에 반영될 때
- Phase / Cycle / Work Package / Task 구조가 바뀔 때
- 완료 기준이나 검증 기준이 바뀔 때

work-index.md
- 현재 포인터가 바뀌었을 때
- Work Package가 완료되었을 때
- 다음 Focus가 확정되었을 때

work-log.md
- 의미 있는 작업 결과가 나왔을 때
- sync 판단을 남길 필요가 있을 때
- 보류 이슈가 생겼을 때

status/current-status.md
- 사람이 보는 현재 상태 요약이 바뀌었을 때

manual/
- 실행 방법, 설정 절차, 복구 절차, 운영 재현 절차가 정리되어야 할 때

rules/
- 문서 변경 전파 기준에 따라 영향 문서 점검이 필요할 때
~~~

---

## 9. 관련 문서

### 9.1 specs

`specs/`는 무엇을 만들 것인지 정의한다.

`work/`는 specs를 기준으로 작업을 수집, 분해, 실행한다.

~~~text
specs = 기준
work = 실행 제어
~~~

---

### 9.2 manual

`manual/`은 실행자 관점의 문서다.

Cycle 3의 실행 방법, 설정 절차, 복구 절차, 운영 재현 절차는 `manual/` 문서로 정리하는 것을 우선한다.

~~~text
work = 작업 진행
manual = 실행 재현
~~~

---

### 9.3 status

`status/`는 사람이 보는 현재 상태 요약이다.

~~~text
work-index.md
= 작업 실행 포인터

status/current-status.md
= 사람이 보는 현재 상태판
~~~

---

### 9.4 rules

`rules/`는 변경 전파나 운영 규칙을 관리한다.

~~~text
work-policy.md
= 작업 운영 정책

rules/affected-docs-rules.md
= 문서 변경 전파 규칙
~~~

---

### 9.5 history

history는 기존 프로젝트의 history 관리 방식을 따른다.

`work-log.md`는 상세 history를 대체하지 않는다.

---

## 10. 금지 사항

다음을 금지한다.

- Candidate를 바로 구현하는 것
- Candidate를 개발자 검토 없이 Task로 확정하는 것
- `work-index.md` 없이 현재 작업을 추측하는 것
- 현재 Work Package 범위를 임의로 넘는 것
- 현재 Cycle 범위를 임의로 넘는 것
- specs와 충돌하는 구조 변경을 하는 것
- `work-roadmap.md`에 없는 대규모 작업을 임의로 추가하는 것
- `work-index.md`에 전체 task 목록을 반복하는 것
- `work-log.md`를 상세 history 저장소처럼 사용하는 것
- Cycle 3 산출물을 status 문서에만 남기고 manual 문서를 작성하지 않는 것