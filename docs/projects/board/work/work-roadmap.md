# Work Roadmap

## 1. 문서 목적

이 문서는 board 프로젝트의 개발 작업 후보를 Phase 단위로 배치한 roadmap 초안이다.

현재 문서는 `$plan phase-split` 결과를 기준으로 생성한 Phase Draft다.
아래 Phase는 아직 Cycle, Work Package, Task로 확정된 실행 단위가 아니다.

---

## 2. Phase Draft

- Phase 1 - Minimal Board CRUD Foundation
  Goal: 게시글 CRUD 구현에 필요한 Spring Boot 기본 구조, 저장 구조, 핵심 CRUD 기능, 최소 오류 처리를 만든다.
  Included Candidates:
    - CAND-001: Spring Boot board 프로젝트 기본 구조 준비
    - CAND-002: 게시글 Entity와 Repository 저장 구조 구현
    - CAND-003: 게시글 등록 기능 구현
    - CAND-004: 게시글 목록 및 상세 조회 기능 구현
    - CAND-005: 게시글 수정 기능 구현
    - CAND-006: 게시글 삭제 기능 구현
    - CAND-007: 입력 검증과 오류 응답 최소 처리
    - CAND-009: Flyway 최초 migration 적용 여부 결정
  Excluded / Deferred:
    - CAND-008: 게시글 CRUD 최소 테스트 작성
    - CAND-010: 후속 확장 후보 분리 유지
  Dependency:
    - CAND-001 -> CAND-002 -> CAND-003/CAND-004 -> CAND-005/CAND-006 -> CAND-007
    - CAND-009는 CAND-002 이후 결정한다.
  Exit Criteria:
    - 기본 프로젝트 구조와 게시글 저장 구조가 준비되어 있다.
    - 게시글 등록, 목록 조회, 상세 조회, 수정, 삭제 흐름이 최소 기준으로 정리되어 있다.
    - 입력 검증과 최소 오류 응답 기준이 정리되어 있다.
    - Flyway 적용 여부가 결정되어 있다.
  Cycle Draft:
    - Cycle 1 - Minimal Implementation
      Goal: Spring Boot 기본 구조와 게시글 저장/등록/조회의 최소 흐름을 만든다.
      Included Phase Items:
        - CAND-001: Spring Boot board 프로젝트 기본 구조 준비
        - CAND-002: 게시글 Entity와 Repository 저장 구조 구현
        - CAND-003: 게시글 등록 기능 구현
        - CAND-004: 게시글 목록 및 상세 조회 기능 구현
      Verification Focus: 기본 구조, 저장 구조, 등록/조회 흐름이 서로 연결되는지 확인한다.
      Dependency: CAND-001 -> CAND-002 -> CAND-003/CAND-004
      Exit Criteria: 게시글을 저장하고 목록/상세로 조회할 수 있는 최소 CRUD 기반이 준비되어 있다.
    - Cycle 2 - Stability
      Goal: 게시글 수정/삭제와 최소 입력 검증, 오류 응답 흐름을 보강한다.
      Included Phase Items:
        - CAND-005: 게시글 수정 기능 구현
        - CAND-006: 게시글 삭제 기능 구현
        - CAND-007: 입력 검증과 오류 응답 최소 처리
      Verification Focus: 수정, 삭제, 필수 입력값, 존재하지 않는 게시글 처리 흐름을 확인한다.
      Dependency: Cycle 1 완료 후 진행한다.
      Exit Criteria: 게시글 수정/삭제와 최소 오류 처리 기준이 동작 가능한 형태로 정리되어 있다.
    - Cycle 3 - Operational Readiness
      Goal: 게시글 저장 구조를 기준으로 Flyway 최초 migration 적용 여부를 결정한다.
      Included Phase Items:
        - CAND-009: Flyway 최초 migration 적용 여부 결정
      Verification Focus: 현재 저장 구조에 migration을 바로 적용할지, 후속으로 미룰지 판단한다.
      Dependency: CAND-002 이후 진행한다.
      Exit Criteria: Flyway 적용 여부가 구현 기준으로 결정되어 있다.

- Phase 2 - CRUD Verification
  Goal: Phase 1의 게시글 CRUD 흐름을 최소 테스트로 검증한다.
  Included Candidates:
    - CAND-008: 게시글 CRUD 최소 테스트 작성
  Excluded / Deferred:
    - CAND-010: 후속 확장 후보 분리 유지
  Dependency:
    - CAND-003, CAND-004, CAND-005, CAND-006, CAND-007 완료 후 진행한다.
  Exit Criteria:
    - Repository, Service, Controller 후보 테스트 범위가 정리되어 있다.
    - 등록, 조회, 수정, 삭제, 오류 처리 흐름의 최소 검증이 가능하다.

- Phase 3 - Future Scope Boundary Management
  Goal: 현재 CRUD 범위 밖의 확장 후보를 후속 범위로 분리해 유지한다.
  Included Candidates:
    - CAND-010: 후속 확장 후보 분리 유지
  Excluded / Deferred:
    - auth, 댓글, 검색, 첨부파일, 독립 배포, 헥사고날 전환 등은 현재 CRUD 구현 범위에 포함하지 않는다.
  Dependency:
    - None
  Exit Criteria:
    - 현재 CRUD 구현 범위와 후속 확장 후보가 섞이지 않는다.

---

## 3. 다음 검토

- Phase 구성을 유지할지, 병합할지, 분할할지 검토한다.
- Cycle / Work Package / Task 확정은 후속 `$plan` action에서 다룬다.
