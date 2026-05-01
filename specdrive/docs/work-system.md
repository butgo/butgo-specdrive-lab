# Work System

## 1. 문서 목적

이 문서는 SpecDrive의 **Work System**을 설명하는 기준 문서다.

Work System은 단순히 문서를 작성하거나 구현 계획을 나열하는 방식이 아니라, 후보 작업을 수집하고, Phase / Cycle / Work Package / Task 단위로 분해한 뒤, 현재 작업 포인터를 기준으로 AI와 사람이 함께 실행하고 동기화하는 작업 운영 체계다.

이 문서는 다음을 설명한다.

- Work System의 목적
- Candidate → Roadmap → Index → Run → Sync 흐름
- Phase / Cycle / Work Package / Task의 의미
- 표준 work 문서 세트의 역할
- specs, status, manual, rules 문서와의 관계
- Codex가 work 문서를 읽고 실행하는 기준
- 새 프로젝트에 Work System을 적용하는 순서

이 문서는 특정 프로젝트의 실제 작업 목록을 관리하지 않는다.

특정 프로젝트의 실제 작업 목록은 각 프로젝트의 `work/` 디렉터리 아래에서 관리한다.

예:

- `docs/projects/board/work/work-candidates.md`
- `docs/projects/board/work/work-roadmap.md`
- `docs/projects/board/work/work-index.md`
- `docs/projects/board/work/work-log.md`

---

## 2. Work System 개요

SpecDrive의 Work System은 다음 흐름을 기본으로 한다.

```text
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
```

즉, Work System은 다음 질문에 답하기 위한 구조다.

```text
무엇을 할 후보로 남길 것인가?
무엇을 현재 Phase로 승격할 것인가?
현재 Cycle의 목표는 무엇인가?
현재 작업 묶음은 무엇인가?
지금 Codex가 실행해야 할 focus는 무엇인가?
작업 후 어떤 문서를 갱신해야 하는가?
완료 후 다음 작업으로 어떻게 넘어갈 것인가?
```

Work System은 문서 작성, 구현, 테스트, 검증, 전환, 운영 매뉴얼화를 하나의 흐름으로 연결한다.

---

## 3. 핵심 개념

### 3.1 Candidate

Candidate는 아직 현재 작업으로 확정되지 않은 후보 항목이다.

Candidate는 다음을 포함할 수 있다.

- 후속 기능 후보
- 보류된 구현 아이디어
- 현재 Phase 범위를 벗어난 작업
- 나중에 검토할 개선 사항
- 아직 우선순위가 확정되지 않은 작업

Candidate는 바로 Task가 아니다.

Candidate는 `work-candidates.md`에 보관하고, 현재 Phase/Cycle에 반영하기로 확정되었을 때만 `work-roadmap.md`로 승격한다.

Candidate 상태값은 다음을 기본으로 사용한다.

| Status | 의미 |
|---|---|
| Proposed | 후보로 제안됨 |
| Accepted | roadmap 승격 대상 |
| Deferred | 후속 검토 |
| Rejected | 제외 |
| Merged | 다른 후보 또는 Roadmap 항목에 병합됨 |
| Needs Clarification | 추가 확인 필요 |

```text
Candidate
= 아직 실행 확정 전의 후보

Task
= 현재 Phase / Cycle / Work Package 아래에서 실행 가능한 단위
```

---

### 3.2 Phase

Phase는 **기능 범위 축**이다.

Phase는 사용자나 프로젝트 입장에서 의미 있는 결과가 남는 구현 범위여야 한다.

Phase는 작은 작업 묶음이 아니라, 여러 Cycle과 Work Package를 포함할 수 있는 상위 작업 범위다.

좋은 Phase 예:

```text
Phase 1 - 게시판 CRUD 최소 흐름
Phase 2 - 검색 / 페이징 / 검증 안정화
Phase 3 - 운영 준비 및 재현 절차 정리
```

좋지 않은 Phase 예:

```text
Phase 1 - 파일 만들기
Phase 2 - 함수 추가하기
Phase 3 - 테스트 하나 추가하기
```

Phase는 “무엇을 만들 것인가”에 가까운 범위 기준이다.

---

### 3.3 Cycle

Cycle은 **완성도 축**이다.

모든 Phase는 기본적으로 다음 Cycle 구조를 따른다.

```text
Cycle 1 - Minimal Implementation
Cycle 2 - Stability
Cycle 3 - Operational Readiness
```

#### Cycle 1 - Minimal Implementation

Cycle 1의 목적은 최소 동작과 구조 관통이다.

주요 기준:

- 컴파일 또는 빌드 성공
- 최소 end-to-end 흐름 확인
- 핵심 구조가 실제로 연결되는지 검증
- 과도한 일반화 금지
- 미래 기능 선반영 금지

#### Cycle 2 - Stability

Cycle 2의 목적은 안정화다.

주요 기준:

- 테스트 보강
- 경계 조건 검증
- 오류 흐름 정리
- 인터페이스 정제
- 구조 정합성 강화

#### Cycle 3 - Operational Readiness

Cycle 3의 목적은 운영 준비다.

주요 기준:

- 실행 방법 정리
- 설정 절차 정리
- 로그 확인 방법 정리
- 복구 / 롤백 절차 정리
- 운영 환경 재현 절차 정리
- 지원 환경 명시

Cycle 3의 산출물은 상태 문서보다 실행자 관점의 `manual/` 문서에 우선 정리한다.

---

### 3.4 Work Package

Work Package는 현재 Phase/Cycle 안에서 의미 있게 완료할 수 있는 작업 묶음이다.

현재 기준에서 Work Package는 dev 코딩의 한 묶음이다.

Work Package는 Codex가 한 번 또는 여러 번의 실행으로 처리할 수 있는 중간 단위다.  
완료되었을 때 의미 있는 동작, 구조, 검증 결과 중 하나 이상이 남아야 한다.

예:

```text
Phase 1 - 게시판 CRUD 최소 흐름
└─ Cycle 1 - Minimal Implementation
   ├─ WP-01 프로젝트 기본 구조 생성
   ├─ WP-02 게시글 등록 / 조회 최소 흐름
   ├─ WP-03 게시글 수정 / 삭제 최소 흐름
   └─ WP-04 최소 API 검증
```

Work Package는 상세 Task보다 크고, Phase보다 작다.

작업 진행과 `dev run` 의 기본 관리 단위는 상세 Task 하나가 아니라 Work Package다.

Task는 Work Package를 완료하기 위한 세부 실행 단위다.

---

### 3.5 Task

Task는 현재 Work Package를 수행하기 위한 최소 실행 단위다.

Task는 반드시 특정 Phase / Cycle / Work Package 아래에 있어야 한다.

Task 원칙:

- 현재 Phase/Cycle 범위를 넘지 않는다.
- 가능한 경우 테스트 또는 완료 기준과 연결된다.
- 반나절에서 하루 안에 진전 확인이 가능한 수준을 기본으로 한다.
- 미래 확장을 위한 과도한 일반화 작업을 만들지 않는다.
- Candidate에서 직접 Task가 되지 않고, Roadmap으로 승격된 뒤 Task가 된다.

예:

```text
WP-02 게시글 등록 / 조회 최소 흐름

Tasks:
- T-001 게시글 Entity 초안 작성
- T-002 게시글 Repository 생성
- T-003 게시글 등록 UseCase 작성
- T-004 게시글 단건 조회 UseCase 작성
- T-005 최소 API 연결
```

---

### 3.6 Work Index

Work Index는 현재 작업 포인터다.

`work-index.md`는 전체 작업 목록을 반복하지 않는다.

`work-index.md`는 다음만 관리한다.

- 현재 Phase
- 현재 Cycle
- 현재 Work Package
- 현재 Focus Task
- 다음 Task
- 최근 완료 Work Package
- 다음 진입점

예:

```text
Current Phase:
- Phase 1 - 게시판 CRUD 최소 흐름

Current Cycle:
- Cycle 1 - Minimal Implementation

Current Work Package:
- WP-02 게시글 등록 / 조회 최소 흐름

Current Focus:
- T-003 게시글 등록 UseCase 작성

Next Task:
- T-004 게시글 단건 조회 UseCase 작성
```

Work Index는 Codex가 다음 작업을 판단할 때 가장 먼저 확인해야 하는 실행 포인터다.

---

### 3.7 Work Log

Work Log는 최근 실행 결과를 기록하는 문서다.

`work-log.md`는 모든 상세 변경 이력을 저장하는 문서가 아니다.

주요 기록 대상:

- 완료된 Work Package
- 의미 있는 실행 결과
- 다음 작업으로 넘긴 판단
- 보류된 이슈
- sync 결과
- status 또는 manual 반영 필요 여부

상세 변경 이력은 기존 history 관리 방식에 따른다.

---

## 4. 기본 처리 흐름

### 4.1 Collect

후보를 수집한다.

대상 문서:

```text
work-candidates.md
```

수집 대상:

- 새 기능 후보
- 후속 개선 후보
- 보류된 아이디어
- 현재 Phase 밖 작업
- 나중에 판단할 항목

이 단계에서는 아직 Task로 확정하지 않는다.

---

### 4.2 Promote

후보를 현재 작업 범위로 승격한다.

```text
work-candidates.md
  ↓
work-roadmap.md
```

Promote 조건:

- 현재 프로젝트 목표와 맞는다.
- 현재 또는 다음 Phase에 포함할 수 있다.
- Phase/Cycle 단위로 분해 가능하다.
- 완료 기준을 정의할 수 있다.
- 현재 작업 범위를 과도하게 흔들지 않는다.

후보가 승격되면 `work-roadmap.md`에 Phase / Cycle / Work Package / Task 구조로 반영한다.

---

### 4.3 Split

승격된 작업을 Phase / Cycle / Work Package / Task로 분해한다.

분해 순서:

```text
Phase
  ↓
Cycle
  ↓
Work Package
  ↓
Task
```

중요한 원칙:

```text
Task가 먼저가 아니다.
Phase / Cycle / Work Package가 먼저다.
```

Task 중심으로 시작하면 작업이 과도하게 늘어나고, 현재 범위를 벗어날 가능성이 커진다.

---

### 4.4 Focus

현재 실행할 위치를 정한다.

대상 문서:

```text
work-index.md
```

Focus는 현재 Work Package 안에서 먼저 착수할 상세 Task를 가리킨다.

Codex는 Focus Task 하나만 기계적으로 처리하고 멈추는 것이 아니라, 같은 Work Package 안에서 자연스럽게 이어지는 인접 Task까지 함께 처리할 수 있다.

단, 현재 Cycle 범위나 다음 Work Package를 임의로 넘어가면 안 된다.

---

### 4.5 Run

Codex 또는 개발자가 현재 Focus 기준으로 작업을 실행한다.

Run 단계에서 확인할 문서:

```text
1. AGENTS.compact.md
2. work/README.md
3. work/work-policy.md
4. work/work-index.md
5. work/work-roadmap.md
6. 현재 작업에 필요한 specs 문서
```

Run 단계에서 하지 말아야 할 것:

- 현재 Cycle 범위를 넘는 구현
- 다음 Work Package로 임의 이동
- specs와 충돌하는 구조 변경
- roadmap에 없는 대규모 작업 추가
- 후보 항목을 즉시 구현
- 상태 문서 전체를 불필요하게 갱신

---

### 4.6 Sync

작업 결과를 문서에 반영 가능한 형태로 정리한다.

Sync는 별도 작업 목록 문서가 아니라 실행 후 판단 단계다.  
`work-log.md`는 Sync 결과와 다음 처리 판단을 기록하는 산출물이며, 상세 history를 대체하지 않는다.

주요 대상:

```text
work-index.md
work-log.md
status/current-status.md
manual/phases/*.md
```

Sync 기준:

- 현재 Work Package가 완료되었는가?
- 다음 Task로 이동할 수 있는가?
- 다음 Work Package로 전환할 수 있는가?
- Cycle 전환 조건이 충족되었는가?
- Phase 전환 조건이 충족되었는가?
- status 문서 갱신이 필요한가?
- manual 문서 갱신이 필요한가?
- 변경 전파 규칙에 따라 rules 점검이 필요한가?

---

### 4.7 Transition

작업 단위가 완료되면 다음 단계로 전환한다.

전환 종류:

```text
Task 전환
Work Package 전환
Cycle 전환
Phase 전환
```

전환 우선순위:

```text
Task 완료
  ↓
Work Package 완료 여부 판단
  ↓
현재 Cycle 안의 다음 Work Package 확인
  ↓
Cycle 완료 여부 판단
  ↓
다음 Cycle 또는 다음 Phase 전환 판단
```

Phase 전환은 단순 포인터 이동이 아니다.

Phase 전환 시에는 다음이 함께 확정되어야 한다.

- 현재 Phase 완료
- 다음 Phase 활성화
- 다음 Phase의 첫 Cycle
- 첫 Work Package
- 첫 Focus Task
- 필요한 manual/status 갱신 여부

Phase 전환 절차는 프로젝트별 `manual/phase-transition-checklist.md`를 따른다.

---

## 5. 표준 문서 세트

### 5.1 work/README.md

`work/README.md`는 프로젝트별 work 폴더의 안내 문서다.

역할:

- work 폴더 목적 설명
- work 문서 읽는 순서 설명
- 처리 흐름 안내
- Codex가 기본으로 읽을 문서 안내
- 매번 읽지 않아도 되는 문서 구분

---

### 5.2 work-candidates.md

`work-candidates.md`는 아직 roadmap으로 승격되지 않은 후보를 관리한다.

역할:

- 후속 후보 보관
- 보류 작업 관리
- 현재 Phase 밖 아이디어 관리
- 나중에 검토할 개선 항목 관리

주의:

```text
candidates에 있다고 현재 task가 아니다.
roadmap에 승격되어야 작업 대상이 된다.
index에 잡혀야 현재 작업이 된다.
```

---

### 5.3 work-policy.md

`work-policy.md`는 프로젝트별 Work System 적용 정책이다.

역할:

- Phase 정의 기준
- Cycle 정의 기준
- Work Package 정의 기준
- Task 분해 기준
- Codex 실행 기준
- 상태 이동 기준
- 전환 기준
- 금지 사항

이 문서는 자주 바뀌지 않는 운영 정책 문서다.

---

### 5.4 work-roadmap.md

`work-roadmap.md`는 확정된 전체 작업 트리다.

역할:

- Phase 목록
- Cycle 목록
- Work Package 목록
- Task 목록
- 완료 기준
- 테스트 또는 검증 기준

`work-roadmap.md`는 전체 목록 문서이며, 현재 포인터를 관리하지 않는다.

현재 포인터는 `work-index.md`가 담당한다.

---

### 5.5 work-index.md

`work-index.md`는 현재 작업 포인터 문서다.

역할:

- 현재 Phase
- 현재 Cycle
- 현재 Work Package
- 현재 Focus Task
- Next Task
- 최근 완료 항목
- 다음 진입점

`work-index.md`는 짧게 유지한다.

전체 task 목록을 반복하지 않는다.

---

### 5.6 work-log.md

`work-log.md`는 작업 실행 결과 요약 문서다.

`work-log.md`는 Sync의 결과를 기록하지만, 현재 작업 포인터를 직접 관리하지 않는다.  
현재 작업 포인터는 `work-index.md`가 담당하고, 상세 변경 이력은 기존 history 관리 방식을 따른다.

역할:

- 최근 완료 Work Package 기록
- sync 결과 기록
- 다음 작업 판단 기록
- status/manual 갱신 필요 여부 기록
- 보류 이슈 기록

상세 history는 기존 history 관리 방식에 따른다.

---

## 6. 관련 문서와의 관계

### 6.1 specs

`specs/`는 무엇을 만들 것인지 정의한다.

예:

```text
specs/02-requirements.md
specs/03-design.md
specs/04-application-structure.md
specs/05-domain-model.md
specs/06-api-spec.md
specs/07-db-design.md
```

Work System은 specs를 대체하지 않는다.

Work System은 specs를 기준으로 작업을 쪼개고 실행한다.

```text
specs = 기준
work = 실행 제어
```

---

### 6.2 status

`status/`는 사람이 보는 현재 상태 요약이다.

예:

```text
status/current-status.md
```

`work-index.md`와 `status/current-status.md`는 다르다.

```text
work-index.md
= Codex와 작업자가 다음 작업을 찾기 위한 실행 포인터

status/current-status.md
= 사람이 프로젝트 상태를 빠르게 파악하기 위한 상태판
```

---

### 6.3 manual

`manual/`은 실행자 관점의 문서다.

예:

```text
manual/README.md
manual/project-manual.md
manual/phase-transition-checklist.md
manual/phases/phase-01-manual.md
```

Cycle 3의 실행 방법, 설정 절차, 복구 절차, 운영 재현 절차는 상태 문서가 아니라 manual 문서로 정리하는 것을 우선한다.

```text
work = 작업 진행
manual = 실행 재현
```

---

### 6.4 rules

`rules/`는 변경 전파나 운영 규칙을 관리한다.

예:

```text
rules/affected-docs-rules.md
```

`work-policy.md`와 `affected-docs-rules.md`는 다르다.

```text
work-policy.md
= Phase / Cycle / Task 작업 운영 정책

affected-docs-rules.md
= 문서 변경 시 어떤 문서를 함께 검토할지에 대한 변경 전파 규칙
```

---

### 6.5 history

history는 변경 이유와 의미 있는 작업 이력을 남기는 영역이다.

Work System은 history 저장 방식을 대체하지 않는다.

history는 기존 프로젝트의 history 관리 방식에 따른다.

원칙:

- 상세 변경 이력은 history에 남긴다.
- 현재 실행 포인터는 work-index에 둔다.
- 최근 실행 결과 요약은 work-log에 둔다.
- 전체 상태 요약은 status에 둔다.

---

## 7. 표준 디렉터리 구조

SpecDrive Core는 재사용 가능한 운영 체계와 템플릿을 가진다.

```text
specdrive/docs/
|-- work-system.md
|-- flows/
|   |-- README.md
|   |-- doc-reinforce-flow.md
|   |-- doc-confirm-flow.md
|   +-- doc-history-save-flow.md
|
|-- stages/
|   |-- README.md
|   |-- doc-stage.md
|   |-- plan-stage.md
|   |-- dev-stage.md
|   |-- session-stage.md
|   +-- git-stage.md
|
|-- templates/
|   |-- work/
|   |   |-- README.template.md
|   |   |-- work-candidates.template.md
|   |   |-- work-policy.template.md
|   |   |-- work-roadmap.template.md
|   |   |-- work-index.template.md
|   |   +-- work-log.template.md
|   |
|   |-- manual/
|   |   |-- README.template.md
|   |   |-- project-manual.template.md
|   |   |-- phase-transition-checklist.template.md
|   |   +-- phase-manual.template.md
|   |
|   +-- rules/
|       +-- affected-docs-rules.template.md
|
+-- rules/
    |-- README.md
    |-- affected-docs-rules.md
    |-- skill-rules.md
    |-- script-rules.md
    |-- codex-skill-rules.md
    +-- runtime-rules.md
```

프로젝트 적용본은 각 프로젝트 아래에 둔다.

```text
docs/projects/{project}/
|-- specs/
|-- work/
|   |-- README.md
|   |-- work-candidates.md
|   |-- work-policy.md
|   |-- work-roadmap.md
|   |-- work-index.md
|   +-- work-log.md
|
|-- rules/
|   +-- affected-docs-rules.md
|
|-- status/
|   +-- current-status.md
|
|-- manual/
|   |-- README.md
|   |-- project-manual.md
|   |-- phase-transition-checklist.md
|   +-- phases/
|       |-- phase-01-manual.md
|       |-- phase-02-manual.md
|       +-- phase-03-manual.md
|
|-- 01-overview.md
|-- AGENTS.md
|-- AGENTS.compact.md
|-- index.md
|-- README.md
+-- README.ko.md
```

---

## 8. Codex 작업 기준

Codex는 Work System을 사용할 때 다음 순서를 기본으로 따른다.

```text
1. 프로젝트 AGENTS.compact.md 확인
2. work/README.md 확인
3. work/work-policy.md 확인
4. work/work-index.md 확인
5. work/work-roadmap.md 확인
6. 현재 작업에 필요한 specs 문서만 확인
7. 현재 Work Package 안에서 실행
8. sync 결과 제안
```

Codex가 매번 읽지 않아도 되는 문서:

```text
work-candidates.md
- 후보 승격 또는 task-split 단계에서만 확인

work-log.md
- sync 또는 회고 단계에서만 확인

manual/
- Cycle 3 또는 실행 절차 작성 시 확인

rules/
- 문서 변경 전파 점검 시 확인

history/
- 명시 요청 시만 확인
```

Codex 금지 사항:

- 현재 Cycle 범위를 넘는 작업을 임의로 실행하지 않는다.
- Candidate를 바로 구현하지 않는다.
- Roadmap에 없는 대규모 작업을 추가하지 않는다.
- Index 없이 현재 작업을 추측하지 않는다.
- specs와 충돌하는 구조 변경을 하지 않는다.
- 구조 정책보다 테스트 통과를 우선하지 않는다.
- history를 기본 context로 읽지 않는다.

---

## 9. 새 프로젝트 적용 순서

새 프로젝트에 Work System을 적용할 때는 다음 순서를 따른다.

```text
1. 프로젝트 기본 문서 생성
   - README.md
   - README.ko.md
   - 01-overview.md
   - AGENTS.md
   - AGENTS.compact.md
   - index.md

2. specs 문서 생성
   - requirements
   - design
   - application structure
   - domain model
   - api spec
   - db design

3. work 문서 세트 생성
   - work/README.md
   - work/work-candidates.md
   - work/work-policy.md
   - work/work-roadmap.md
   - work/work-index.md
   - work/work-log.md

4. 후보 수집
   - work-candidates.md

5. Phase/Cycle 구조 작성
   - work-roadmap.md

6. 현재 포인터 지정
   - work-index.md

7. Codex 실행
   - 현재 Work Package 기준

8. Sync
   - work-index.md
   - work-log.md
   - 필요 시 status/current-status.md

9. Cycle 3에서 manual 작성
   - manual/project-manual.md
   - manual/phases/phase-xx-manual.md

10. Phase 전환
   - manual/phase-transition-checklist.md 기준 확인
```

---

## 10. Board 적용 예시

Board 프로젝트에 적용하면 다음 구조가 된다.

```text
docs/projects/board/
|-- specs/
|   |-- 02-requirements.md
|   |-- 03-design.md
|   |-- 04-application-structure.md
|   |-- 05-domain-model.md
|   |-- 06-api-spec.md
|   +-- 07-db-design.md
|
|-- work/
|   |-- README.md
|   |-- work-candidates.md
|   |-- work-policy.md
|   |-- work-roadmap.md
|   |-- work-index.md
|   +-- work-log.md
|
|-- rules/
|   +-- affected-docs-rules.md
|
|-- status/
|   +-- current-status.md
|
|-- manual/
|   |-- README.md
|   |-- board-manual.md
|   |-- phase-transition-checklist.md
|   +-- phases/
|       |-- phase-01-manual.md
|       |-- phase-02-manual.md
|       +-- phase-03-manual.md
|
|-- 01-overview.md
|-- AGENTS.md
|-- AGENTS.compact.md
|-- index.md
|-- README.md
+-- README.ko.md
```

Board에서의 역할은 다음과 같다.

```text
specs/
- 게시판에서 무엇을 만들지 정의한다.

work/
- 게시판 개발 작업을 Phase / Cycle / Work Package / Task로 관리한다.

manual/
- 게시판 실행, 검증, 복구, 전환 절차를 정리한다.

status/
- 사람이 보는 현재 상태를 정리한다.

rules/
- 문서 변경 전파 기준을 관리한다.
```

---

## 11. 후속 확장

Work System은 이후 다음 방향으로 확장할 수 있다.

```text
CLI 명령
- specdrive work status
- specdrive work next
- specdrive work split
- specdrive work run
- specdrive work sync

TUI
- Phase / Cycle / Work Package / Task 시각화
- 현재 Focus 표시
- 다음 작업 추천

MCP
- AI가 현재 작업 포인터 조회
- 다음 task 요청
- sync 후보 생성

UI
- Work Roadmap 보드
- Task 진행 상태
- Phase 전환 체크리스트
```

단, 현재 단계에서는 복잡한 UI나 자동화를 먼저 만들지 않는다.

우선순위는 다음과 같다.

```text
1. 문서 구조 확정
2. 템플릿 확정
3. board 적용
4. Codex 실행 흐름 안정화
5. CLI/TUI/MCP 확장
```

---

## 12. 결론

Work System은 SpecDrive의 핵심 실행 체계다.

SpecDrive는 단순히 문서를 작성하는 도구가 아니라, 문서를 기준으로 후보를 수집하고, 작업을 Phase / Cycle / Work Package / Task로 나누고, 현재 포인터를 기준으로 AI와 사람이 함께 실행하고, 결과를 다시 문서에 동기화하는 운영 방식이다.

핵심 원칙은 다음과 같다.

```text
Candidate는 바로 Task가 아니다.
Roadmap에 승격되어야 작업이 된다.
Index에 잡혀야 현재 작업이 된다.
Codex는 현재 Work Package 안에서 실행한다.
Cycle 3 결과는 manual 문서로 재현 가능하게 남긴다.
상세 history는 기존 history 관리 방식에 따른다.
```

즉, Work System의 목적은 작업을 많이 만드는 것이 아니라, 현재 해야 할 작업을 명확히 제한하고, AI가 현재 범위를 벗어나지 않도록 제어하며, 사람이 나중에 다시 이어갈 수 있는 실행 가능한 흐름을 남기는 것이다.
