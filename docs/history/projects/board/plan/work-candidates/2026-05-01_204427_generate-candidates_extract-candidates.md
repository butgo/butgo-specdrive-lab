# Work Candidates Snapshot

## 1. Snapshot Purpose

이 문서는 `$plan extract-candidates apply` 승인에 따라 `docs/projects/board/work/work-candidates.md` 에 반영한 plan 단계 후보 추가 이력이다.

이 snapshot은 현재 기준 문서를 대체하지 않는다.  
현재 기준은 `docs/projects/board/work/work-candidates.md` 를 따른다.

---

## 2. Applied Candidates

| ID | Candidate | Source | Suggested Phase | Suggested Cycle | Status | Reason | Note | Merged To |
|---|---|---|---|---|---|---|---|---|
| CAND-013 | API DTO와 Controller/Facade 연결 흐름 구체화 | `specs/04-application-structure.md`, `specs/06-api-spec.md`, `specs/07-db-design.md` | 미정 | 미정 | Proposed | `PostController`, `PostFacade`, 요청/응답 DTO, API-DB 매핑 기준이 문서에 직접 명시되어 있음 | 구현 위치 확정이 아니라 API 연결 작업 후보임 |  |
| CAND-014 | 공통 예외 처리와 오류 응답 구조 결정 후보 정리 | `specs/03-design.md`, `specs/04-application-structure.md`, `specs/06-api-spec.md` | 미정 | 미정 | Needs Clarification | 오류 처리 대상, `GlobalExceptionHandler`, `ErrorResponse`, 오류 코드 후보가 있으나 최종 응답 포맷은 미확정임 | 기존 `CAND-005`와 중복 가능성이 있어 별도 후보로 둘지 검토 필요 |  |
| CAND-015 | DB 제품, Flyway, ID 생성 전략 결정 후보 정리 | `specs/04-application-structure.md`, `specs/07-db-design.md` | 미정 | 미정 | Needs Clarification | DB 제품 후보, Flyway 적용 기준, migration 위치, ID 생성 전략이 후속 결정 항목으로 명시되어 있음 | 구현 작업이 아니라 구현 전 결정 후보임 |  |
| CAND-016 | PostEntity와 PostRepository 매핑 기준 구체화 | `specs/04-application-structure.md`, `specs/05-domain-model.md`, `specs/07-db-design.md` | 미정 | 미정 | Proposed | `PostEntity`, `PostRepository`, `posts` 테이블, 컬럼 매핑 기준이 직접 제시됨 | 기존 `CAND-006`의 하위 또는 구체화 후보로 볼 수 있음 |  |
| CAND-017 | 게시글 삭제 방식 결정 후보 정리 | `specs/02-requirements.md`, `specs/05-domain-model.md`, `specs/07-db-design.md` | 미정 | 미정 | Needs Clarification | 논리 삭제와 물리 삭제의 장단점, 삭제 컬럼 후보, 현재 미확정 상태가 명시되어 있음 | 기존 `CAND-004`와 연결되지만 삭제 정책 결정 후보로 분리 가능함 |  |
| CAND-018 | CRUD 검증용 테스트 데이터와 검증 시나리오 준비 | `specs/04-application-structure.md`, `specs/06-api-spec.md`, `specs/07-db-design.md` | 미정 | 미정 | Proposed | 테스트 구조 방향, API 오류/성공 흐름, DB 테스트 데이터 예시가 있으나 테스트 방식은 구현 계획에서 정하도록 되어 있음 | 기존 `CAND-007`과 연결되는 검증 후보임 |  |

---

## 3. Boundaries

- 기존 `CAND-001`부터 `CAND-012`는 유지했다.
- `work-index.md`는 수정하지 않았다.
- Phase, Cycle, Work Package, Task는 확정하지 않았다.
- `CAND-014`, `CAND-016`, `CAND-018`은 기존 후보와 연결 또는 중복 가능성을 Notes에 남겼다.
