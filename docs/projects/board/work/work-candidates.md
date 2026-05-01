# Work Candidates

## 1. 문서 목적

이 문서는 board 프로젝트에서 아직 `work-roadmap.md`로 승격되지 않은 작업 후보를 모은다.

Candidate는 현재 작업이나 Task가 아니다.  
이 문서의 후보는 개발자 검토 후 `Accepted` 상태가 되었을 때만 `work-roadmap.md`로 승격할 수 있다.

---

## 2. Candidate 목록

| ID | Candidate | Source | Suggested Phase | Suggested Cycle | Status | Reason | Note | Merged To |
|---|---|---|---|---|---|---|---|---|
| CAND-001 | Spring Boot board 기본 프로젝트 구조 준비 | `01-overview.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 1 - Minimal Implementation | Proposed | layered 구조와 최소 게시판 구현을 시작하기 위한 기반 작업 | 상세 패키지 구조는 `specs/04-application-structure.md` 기준 확인 필요 |  |
| CAND-002 | 게시글 목록/상세 조회 최소 흐름 구현 | `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 1 - Minimal Implementation | Proposed | 목록 조회와 상세 조회가 CRUD 흐름의 기본 진입점임 | 페이징, 정렬, 검색 조건은 현재 확정하지 않음 |  |
| CAND-003 | 게시글 등록 최소 흐름 구현 | `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 1 - Minimal Implementation | Proposed | 제목/본문 기반 등록 후 조회 가능한 흐름이 현재 핵심 요구사항임 | 작성자, 로그인 사용자, 권한 연계는 현재 제외 |  |
| CAND-004 | 게시글 수정/삭제 최소 흐름 구현 | `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 1 - Minimal Implementation | Proposed | 최소 CRUD 완성을 위해 수정과 삭제 흐름이 필요함 | 삭제 방식은 DB 설계 또는 후속 설계에서 확인 필요 |  |
| CAND-005 | 최소 입력 검증과 오류 흐름 정리 | `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 2 - Stability | Proposed | 제목/본문 필수, 존재하지 않는 게시글 처리 등 안정화 기준이 필요함 | 오류 응답 형식과 전역 예외 처리 방식은 후속 API/설계 판단 필요 |  |
| CAND-006 | 게시글 기본 데이터와 JPA persistence 연결 | `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 1 - Minimal Implementation | Proposed | 식별자, 제목, 본문, 생성/수정 시각을 저장하고 조회해야 함 | Entity와 Domain 분리, Flyway 적용 여부는 후속 판단 필요 |  |
| CAND-007 | 최소 API 검증 또는 테스트 흐름 준비 | `01-overview.md`, `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 2 - Stability | Proposed | 문서 기반 개발 흐름 검증을 위해 구현 결과를 확인할 기준이 필요함 | 테스트 방식은 프로젝트 구조 확정 후 구체화 |  |
| CAND-008 | board 실행/검증 매뉴얼 초안 작성 | `01-overview.md`, `specdrive/docs/work-system.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 3 - Operational Readiness | Proposed | Cycle 3 결과는 실행자 관점의 manual 문서로 남기는 기준과 연결됨 | 실제 실행 방법이 생긴 뒤 갱신하는 것이 안전함 |  |
| CAND-009 | logging/auth/board 경계 검토 | `01-overview.md`, `specs/02-requirements.md`, `specs/03-design.md` | Phase 1 - 게시판 CRUD 최소 흐름 | Cycle 2 - Stability | Proposed | 재사용 후보 영역의 경계를 의식하되 현재 구조를 과도하게 복잡하게 만들지 않기 위함 | 독립 배포나 모듈 분리는 확정하지 않음 |  |
| CAND-010 | 검색/정렬/페이징 후보 검토 | `specs/02-requirements.md`, `specs/03-design.md` | 후속 Phase 후보 | 후속 Cycle 후보 | Deferred | 목록 조회와 관련되지만 현재 요구사항에서 확정하지 않음 | 현재 Phase에서는 구현 후보가 아니라 후속 검토 후보 |  |
| CAND-011 | 사용자 인증/권한 연계 후보 검토 | `01-overview.md`, `specs/02-requirements.md`, `specs/03-design.md` | 후속 Phase 후보 | 후속 Cycle 후보 | Deferred | auth 경계는 검토 대상이지만 회원가입/로그인/권한 관리는 현재 제외 범위임 | 현재 CRUD 최소 흐름에 선반영하지 않음 |  |
| CAND-012 | 댓글/첨부파일/좋아요 후보 검토 | `specs/02-requirements.md` | 후속 Phase 후보 | 후속 Cycle 후보 | Deferred | 게시판 확장 후보지만 현재 요구사항 제외 범위임 | 현재 roadmap 승격 대상 아님 |  |
| CAND-013 | API DTO와 Controller/Facade 연결 흐름 구체화 | `specs/04-application-structure.md`, `specs/06-api-spec.md`, `specs/07-db-design.md` | 미정 | 미정 | Proposed | `PostController`, `PostFacade`, 요청/응답 DTO, API-DB 매핑 기준이 문서에 직접 명시되어 있음 | 구현 위치 확정이 아니라 API 연결 작업 후보임 |  |
| CAND-014 | 공통 예외 처리와 오류 응답 구조 결정 후보 정리 | `specs/03-design.md`, `specs/04-application-structure.md`, `specs/06-api-spec.md` | 미정 | 미정 | Needs Clarification | 오류 처리 대상, `GlobalExceptionHandler`, `ErrorResponse`, 오류 코드 후보가 있으나 최종 응답 포맷은 미확정임 | 기존 `CAND-005`와 중복 가능성이 있어 별도 후보로 둘지 검토 필요 |  |
| CAND-015 | DB 제품, Flyway, ID 생성 전략 결정 후보 정리 | `specs/04-application-structure.md`, `specs/07-db-design.md` | 미정 | 미정 | Needs Clarification | DB 제품 후보, Flyway 적용 기준, migration 위치, ID 생성 전략이 후속 결정 항목으로 명시되어 있음 | 구현 작업이 아니라 구현 전 결정 후보임 |  |
| CAND-016 | PostEntity와 PostRepository 매핑 기준 구체화 | `specs/04-application-structure.md`, `specs/05-domain-model.md`, `specs/07-db-design.md` | 미정 | 미정 | Proposed | `PostEntity`, `PostRepository`, `posts` 테이블, 컬럼 매핑 기준이 직접 제시됨 | 기존 `CAND-006`의 하위 또는 구체화 후보로 볼 수 있음 |  |
| CAND-017 | 게시글 삭제 방식 결정 후보 정리 | `specs/02-requirements.md`, `specs/05-domain-model.md`, `specs/07-db-design.md` | 미정 | 미정 | Needs Clarification | 논리 삭제와 물리 삭제의 장단점, 삭제 컬럼 후보, 현재 미확정 상태가 명시되어 있음 | 기존 `CAND-004`와 연결되지만 삭제 정책 결정 후보로 분리 가능함 |  |
| CAND-018 | CRUD 검증용 테스트 데이터와 검증 시나리오 준비 | `specs/04-application-structure.md`, `specs/06-api-spec.md`, `specs/07-db-design.md` | 미정 | 미정 | Proposed | 테스트 구조 방향, API 오류/성공 흐름, DB 테스트 데이터 예시가 있으나 테스트 방식은 구현 계획에서 정하도록 되어 있음 | 기존 `CAND-007`과 연결되는 검증 후보임 |  |

---

## 3. 검토 메모

- `Proposed` 후보는 아직 확정된 Work Package가 아니다.
- `Deferred` 후보는 현재 Phase에서 구현하지 않는다.
- `work-roadmap.md`로 승격할 때는 후보별 완료 기준과 검증 기준을 함께 작성한다.
- `work-index.md`에는 `Accepted`되어 roadmap에 승격된 Work Package만 현재 포인터로 지정한다.

---

## 4. 다음 판단

다음 단계에서는 개발자가 우선 범위를 확인한 뒤 `$plan wp-split` 으로 후보를 Work Package 후보로 나눈다.

그다음 `$plan phase-split`, `$plan cycle-split` 흐름으로 Work Package 후보를 Phase / Cycle 구조에 배치한다.
