# Affected Docs Rules

## 1. 문서 목적

이 문서는 프로젝트 문서 또는 작업 문서가 변경되었을 때 함께 검토해야 할 영향 문서를 정의한다.

`affected-docs-rules.md`는 모든 문서를 항상 수정하라는 문서가 아니다.  
변경된 문서가 다른 문서와 충돌하지 않는지 확인하기 위한 변경 전파 기준 문서다.

이 문서는 다음 상황에서 사용한다.

- specs 문서 변경
- work 문서 변경
- manual 문서 변경
- status 문서 변경
- AGENTS 문서 변경
- README 또는 index 문서 변경
- Phase / Cycle / Work Package 전환
- Candidate 승격 또는 보류
- Codex 작업 후 sync 판단

---

## 2. 기본 원칙

문서 변경 전파는 다음 원칙을 따른다.

- 변경 문서가 기준 문서인지 실행 문서인지 먼저 구분한다.
- 모든 문서를 무조건 수정하지 않는다.
- 영향을 받을 가능성이 높은 문서만 검토한다.
- 검토 결과 수정이 필요 없으면 “No Change”로 기록한다.
- 기준 문서와 실행 문서가 충돌하면 기준 문서를 우선한다.
- specs는 “무엇을 만들 것인가”의 기준이다.
- work는 “어떻게 진행할 것인가”의 실행 제어다.
- manual은 “어떻게 실행/검증/복구할 것인가”의 재현 절차다.
- status는 “현재 상태를 빠르게 파악하기 위한 요약”이다.
- history는 상세 변경 이력을 저장한다.
- Codex는 영향 문서를 임의로 재설계하지 않고, 필요한 최소 검토와 수정만 제안한다.

---

## 3. 문서 역할 구분

| 문서/폴더 | 역할 |
|---|---|
| `README.md` | 프로젝트 또는 폴더의 첫 진입 문서 |
| `index.md` | 문서 카탈로그와 읽는 경로 |
| `AGENTS.md` | AI/개발 작업 규칙 |
| `AGENTS.compact.md` | Codex용 압축 작업 규칙 |
| `01-overview.md` | 프로젝트 목적, 범위, 제외 범위 |
| `specs/` | 요구사항, 설계, API, DB 등 기준 문서 |
| `work/` | 후보, roadmap, 현재 작업 포인터, 작업 결과 |
| `manual/` | 실행, 검증, 복구, 재현 절차 |
| `status/` | 사람이 보는 현재 상태 요약 |
| `rules/` | 변경 전파 및 운영 규칙 |
| `history` | 상세 변경 이력 |

---

## 4. 영향도 판단 기준

문서 변경 시 다음 질문으로 영향도를 판단한다.

| 질문 | 영향 가능 문서 |
|---|---|
| 프로젝트 목적이나 범위가 바뀌었는가? | `README.md`, `index.md`, `01-overview.md`, `specs/`, `work/`, `status/` |
| 요구사항이 바뀌었는가? | `specs/`, `work-roadmap.md`, `work-index.md`, `manual/`, `status/` |
| 설계나 구조가 바뀌었는가? | `specs/`, `work-roadmap.md`, `manual/`, `AGENTS.md` |
| API가 바뀌었는가? | `specs/06-api-spec.md`, `manual/`, 테스트/검증 절차, `status/` |
| DB가 바뀌었는가? | `specs/07-db-design.md`, `manual/`, migration/seed 문서, `status/` |
| 작업 후보가 추가되었는가? | `work-candidates.md`, 필요 시 `work-roadmap.md` |
| Candidate가 Accepted 되었는가? | `work-roadmap.md`, `work-index.md`, `work-log.md` |
| 현재 작업 포인터가 바뀌었는가? | `work-index.md`, `status/current-status.md`, `work-log.md` |
| Work Package가 완료되었는가? | `work-index.md`, `work-log.md`, `status/current-status.md`, `manual/` |
| Cycle 또는 Phase 전환이 필요한가? | `phase-transition-checklist.md`, `work-roadmap.md`, `work-index.md`, `work-log.md`, `status/`, `manual/` |
| 실행 방법이 바뀌었는가? | `manual/`, `README.md`, `status/` |
| 운영/복구 절차가 바뀌었는가? | `manual/`, `status/`, `work-log.md` |
| AI 작업 규칙이 바뀌었는가? | `AGENTS.md`, `AGENTS.compact.md`, `README.md`, `index.md` |

---

## 5. 변경 문서별 영향 규칙

### 5.1 README.md 변경 시

함께 검토할 문서:

- `index.md`
- `01-overview.md`
- `AGENTS.md`
- `status/current-status.md`
- 필요한 경우 `manual/project-manual.md`

검토 기준:

- 첫 진입 설명이 실제 문서 구조와 맞는가?
- 읽는 순서가 맞는가?
- 현재 프로젝트 상태와 충돌하지 않는가?
- AGENTS의 작업 규칙과 충돌하지 않는가?

---

### 5.2 index.md 변경 시

함께 검토할 문서:

- `README.md`
- `AGENTS.md`
- `AGENTS.compact.md`
- 새로 추가되거나 제거된 문서
- 필요한 경우 `status/current-status.md`

검토 기준:

- 문서 목록이 실제 파일 구조와 맞는가?
- 문서 역할 설명이 정확한가?
- 읽는 순서가 README와 충돌하지 않는가?
- Codex가 참조해야 하는 문서가 누락되지 않았는가?

---

### 5.3 AGENTS.md 변경 시

함께 검토할 문서:

- `AGENTS.compact.md`
- `README.md`
- `index.md`
- `work/work-policy.md`
- 필요한 경우 `manual/project-manual.md`

검토 기준:

- AI/개발 작업 규칙이 compact 문서에 반영되었는가?
- Work System 기준과 충돌하지 않는가?
- Codex 실행 정책과 충돌하지 않는가?
- 문서/코드 작업 경계가 명확한가?

---

### 5.4 AGENTS.compact.md 변경 시

함께 검토할 문서:

- `AGENTS.md`
- `work/work-policy.md`
- `work/work-index.md`

검토 기준:

- compact 문서가 원본 AGENTS의 핵심 규칙을 누락하지 않는가?
- Codex 작업에 필요한 최소 규칙이 포함되어 있는가?
- 현재 작업 포인터 기준과 충돌하지 않는가?

---

### 5.5 01-overview.md 변경 시

함께 검토할 문서:

- `README.md`
- `index.md`
- `specs/*.md`
- `work/work-candidates.md`
- `work/work-roadmap.md`
- `status/current-status.md`

검토 기준:

- 프로젝트 목적, 범위, 제외 범위가 specs와 일치하는가?
- 변경된 범위가 roadmap에 반영되어야 하는가?
- 새 후보가 필요한가?
- 기존 Candidate 또는 Work Package가 더 이상 유효하지 않은가?
- 현재 status 요약과 충돌하지 않는가?

---

## 6. Specs 변경 규칙

### 6.1 specs/02-requirements.md 변경 시

함께 검토할 문서:

- `01-overview.md`
- `specs/03-design.md`
- `work/work-candidates.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `manual/project-manual.md`
- `status/current-status.md`

검토 기준:

- 요구사항 변경이 설계에 영향을 주는가?
- 새 Candidate가 필요한가?
- 기존 Roadmap 항목의 완료 기준이 바뀌는가?
- 현재 Work Package가 변경 요구사항과 충돌하는가?
- manual의 실행/검증 절차가 바뀌는가?

---

### 6.2 specs/03-design.md 변경 시

함께 검토할 문서:

- `specs/04-application-structure.md`
- `specs/05-domain-model.md`
- `specs/06-api-spec.md`
- `specs/07-db-design.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `manual/project-manual.md`
- `manual/phases/*.md`

검토 기준:

- 애플리케이션 구조가 바뀌는가?
- 도메인 모델에 영향이 있는가?
- API 또는 DB 설계에 영향이 있는가?
- 현재 Work Package 범위가 바뀌는가?
- 실행/검증 절차가 바뀌는가?

---

### 6.3 specs/04-application-structure.md 변경 시

함께 검토할 문서:

- `specs/03-design.md`
- `specs/05-domain-model.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `AGENTS.md`
- `manual/project-manual.md`

검토 기준:

- 패키지/모듈/레이어 구조가 바뀌는가?
- AI 작업 규칙에 구조 제한을 반영해야 하는가?
- 현재 Work Package가 구조 변경과 충돌하는가?
- 실행 절차나 빌드 절차가 바뀌는가?

---

### 6.4 specs/05-domain-model.md 변경 시

함께 검토할 문서:

- `specs/03-design.md`
- `specs/06-api-spec.md`
- `specs/07-db-design.md`
- `work/work-roadmap.md`
- `manual/project-manual.md`
- 필요한 경우 테스트 문서

검토 기준:

- 도메인 개념, 엔티티, 값 객체, 규칙이 바뀌었는가?
- API 요청/응답에 영향이 있는가?
- DB 테이블/컬럼에 영향이 있는가?
- 검증 기준이 바뀌는가?

---

### 6.5 specs/06-api-spec.md 변경 시

함께 검토할 문서:

- `specs/02-requirements.md`
- `specs/05-domain-model.md`
- `manual/project-manual.md`
- `manual/phases/*.md`
- 테스트/검증 절차
- `status/current-status.md`

검토 기준:

- API 엔드포인트, 요청, 응답, 에러 형식이 바뀌었는가?
- 수동/API 검증 절차가 바뀌는가?
- 현재 구현 상태와 status가 충돌하는가?

---

### 6.6 specs/07-db-design.md 변경 시

함께 검토할 문서:

- `specs/05-domain-model.md`
- `specs/03-design.md`
- `manual/project-manual.md`
- `manual/phases/*.md`
- migration/seed 관련 문서
- `status/current-status.md`

검토 기준:

- 테이블/컬럼/인덱스/제약 조건이 바뀌었는가?
- 도메인 모델과 충돌하지 않는가?
- DB 초기화, migration, seed 절차가 바뀌는가?
- 복구/롤백 절차가 필요한가?

---

## 7. Work 문서 변경 규칙

### 7.1 work/README.md 변경 시

함께 검토할 문서:

- `work/work-policy.md`
- `work/work-candidates.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `work/work-log.md`

검토 기준:

- Work System 설명이 실제 문서 구성과 맞는가?
- 읽는 순서가 work-policy와 충돌하지 않는가?
- Candidate / Roadmap / Index / Log 역할 설명이 일관되는가?

---

### 7.2 work/work-candidates.md 변경 시

함께 검토할 문서:

- `work/work-roadmap.md`
- `work/work-index.md`
- `work/work-log.md`

검토 기준:

- Accepted Candidate가 생겼는가?
- Accepted Candidate를 roadmap에 승격해야 하는가?
- Deferred 또는 Rejected 사유가 명확한가?
- 현재 Work Package에 영향을 주는 후보가 있는가?
- 새 후보가 현재 작업 범위를 흔들지는 않는가?

---

### 7.3 work/work-policy.md 변경 시

함께 검토할 문서:

- `work/README.md`
- `work/work-candidates.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `work/work-log.md`
- `AGENTS.md`
- `AGENTS.compact.md`

검토 기준:

- Candidate 처리 기준이 바뀌었는가?
- Phase / Cycle / Work Package / Task 기준이 바뀌었는가?
- Codex 실행 기준이 바뀌었는가?
- AGENTS 규칙과 충돌하지 않는가?

---

### 7.4 work/work-roadmap.md 변경 시

함께 검토할 문서:

- `work/work-index.md`
- `work/work-log.md`
- `status/current-status.md`
- `manual/phase-transition-checklist.md`
- 필요한 경우 `manual/phases/*.md`

검토 기준:

- 현재 작업 포인터가 유효한가?
- Work Package 상태가 바뀌었는가?
- 완료 기준 또는 검증 기준이 바뀌었는가?
- Cycle/Phase 전환 판단이 필요한가?
- manual 갱신이 필요한가?

---

### 7.5 work/work-index.md 변경 시

함께 검토할 문서:

- `work/work-roadmap.md`
- `work/work-log.md`
- `status/current-status.md`

검토 기준:

- Current Phase/Cycle/Work Package가 roadmap과 일치하는가?
- 다음 작업 진입점이 명확한가?
- status 요약이 바뀌어야 하는가?
- work-log에 sync 기록이 필요한가?

---

### 7.6 work/work-log.md 변경 시

함께 검토할 문서:

- `work/work-index.md`
- `status/current-status.md`
- 필요한 경우 `work/work-candidates.md`
- 필요한 경우 `manual/`
- 필요한 경우 `history`

검토 기준:

- sync 결과에 따라 현재 포인터가 바뀌어야 하는가?
- 새 Candidate가 발견되었는가?
- manual 갱신이 필요한가?
- status 갱신이 필요한가?
- history 저장이 필요한가?

---

## 8. Manual 문서 변경 규칙

### 8.1 manual/project-manual.md 변경 시

함께 검토할 문서:

- `manual/phases/*.md`
- `manual/phase-transition-checklist.md`
- `README.md`
- `status/current-status.md`

검토 기준:

- 프로젝트 공통 실행/검증 절차가 Phase별 manual과 충돌하지 않는가?
- README의 실행 안내와 충돌하지 않는가?
- 현재 상태 요약과 충돌하지 않는가?

---

### 8.2 manual/phases/*.md 변경 시

함께 검토할 문서:

- `manual/project-manual.md`
- `manual/phase-transition-checklist.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `work/work-log.md`
- `status/current-status.md`

검토 기준:

- Phase 결과물과 roadmap 상태가 일치하는가?
- 실행/검증/복구 절차가 현재 상태와 일치하는가?
- Cycle 3 완료 조건을 만족하는가?
- status 갱신이 필요한가?

---

### 8.3 manual/phase-transition-checklist.md 변경 시

함께 검토할 문서:

- `work/work-policy.md`
- `work/work-roadmap.md`
- `work/work-index.md`
- `work/work-log.md`
- `status/current-status.md`
- `manual/phases/*.md`

검토 기준:

- 전환 기준이 work-policy와 충돌하지 않는가?
- 완료/검증/manual 기준이 일관되는가?
- Phase/Cycle 전환 흐름이 roadmap/index/log와 맞는가?

---

## 9. Status / Rules / History 변경 규칙

### 9.1 status/current-status.md 변경 시

함께 검토할 문서:

- `work/work-index.md`
- `work/work-log.md`
- `work/work-roadmap.md`
- `manual/project-manual.md`
- 필요한 경우 `README.md`

검토 기준:

- 사람이 보는 현재 상태가 work-index와 일치하는가?
- 최근 작업 결과가 work-log와 일치하는가?
- 실행 가능 상태가 manual과 충돌하지 않는가?

---

### 9.2 rules/affected-docs-rules.md 변경 시

함께 검토할 문서:

- `AGENTS.md`
- `AGENTS.compact.md`
- `work/work-policy.md`
- 필요한 경우 `index.md`

검토 기준:

- 변경 전파 규칙이 AI 작업 규칙과 충돌하지 않는가?
- work-policy의 문서 갱신 정책과 충돌하지 않는가?
- 문서 목록이 index와 맞는가?

---

### 9.3 history 변경 시

함께 검토할 문서:

- 필요한 경우 `work/work-log.md`
- 필요한 경우 `status/current-status.md`
- 필요한 경우 `index.md`

검토 기준:

- history에 남긴 변경이 현재 상태 요약에도 반영되어야 하는가?
- work-log 요약이 필요한가?
- 새 문서가 생겼다면 index 갱신이 필요한가?

---

## 10. 변경 결과 기록 양식

문서 변경 후 영향 문서 점검 결과를 아래 형식으로 기록할 수 있다.

| Date | Changed Doc | Affected Docs Checked | Result | Follow-up |
|---|---|---|---|---|
| YYYY-MM-DD |  |  | No Change / Updated / Needs Review |  |

Result 기준:

| Result | 의미 |
|---|---|
| No Change | 검토했지만 수정 필요 없음 |
| Updated | 영향 문서 수정 완료 |
| Needs Review | 사람 검토 필요 |
| Deferred | 후속 작업으로 보류 |
| Not Checked | 아직 확인하지 않음 |

---

## 11. Codex 사용 기준

Codex는 문서 변경 후 이 규칙을 기준으로 영향 문서를 제안할 수 있다.

Codex는 다음을 수행할 수 있다.

- 변경 문서 기준 영향 문서 목록 제안
- 영향 가능성이 큰 문서 우선순위 제안
- No Change / Updated / Needs Review 판단 제안
- `work-log.md` 기록 필요 여부 제안
- `status/current-status.md` 갱신 필요 여부 제안
- `history` 저장 필요 여부 제안

Codex는 다음을 수행하지 않는다.

- 모든 문서를 무조건 수정하지 않는다.
- 영향이 없는 문서를 억지로 수정하지 않는다.
- 기준 문서를 임의로 재설계하지 않는다.
- specs와 충돌하는 변경을 전파하지 않는다.
- 사람 판단이 필요한 결정을 임의로 확정하지 않는다.
- history 저장이 필요한 변경을 work-log로만 대체하지 않는다.

---

## 12. 금지 사항

다음을 금지한다.

- 변경 전파 규칙을 이유로 불필요하게 모든 문서를 수정하는 것
- 기준 문서 변경 없이 실행 문서만 맞추는 것
- specs와 충돌하는 상태를 그대로 두는 것
- work-index와 status가 서로 다른 현재 상태를 말하는 것
- work-roadmap과 work-index가 서로 다른 작업 위치를 말하는 것
- manual 없이 Cycle 3 완료 상태를 선언하는 것
- history가 필요한 변경을 기록 없이 끝내는 것
- 사람 판단이 필요한 영향 변경을 Codex가 임의로 확정하는 것