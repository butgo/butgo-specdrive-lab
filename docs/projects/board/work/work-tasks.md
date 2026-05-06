# Work Tasks

## 1. 문서 목적

이 문서는 board 프로젝트의 CAND 후보를 Work Package 구성을 위한 Task 후보로 나눈 초안이다.

현재 문서는 `$plan task-split` 결과를 기준으로 생성한 Task Candidate Draft다.
아래 Task 후보는 아직 Work Package 소속, 실행 순서, Codex 실행 단위로 확정된 항목이 아니다.

---

## 2. Task Candidate Draft

- ID: TASK-CAND-001
  Source Candidate: CAND-001
  Goal: Spring Boot board 프로젝트 기본 구조를 준비한다.
  Source Anchor: work-roadmap.md / CAND-001
  Scope: 애플리케이션 실행 기반, 기본 계층 구조, 최소 설정 후보 정리
  Expected Output: board 프로젝트가 개발 작업을 시작할 수 있는 기본 구조를 갖춘다.
  Verification: 프로젝트 구조와 실행 진입점이 확인 가능하다.
  Dependency: None
  WP Packaging Note: CAND-002와 함께 최소 기반 WP로 묶을 수 있다.

- ID: TASK-CAND-002
  Source Candidate: CAND-002
  Goal: 게시글 Entity와 Repository 저장 구조를 구현한다.
  Source Anchor: work-roadmap.md / CAND-002
  Scope: 게시글 도메인 모델, 식별자, 저장소 인터페이스/구현 후보
  Expected Output: 게시글 데이터를 저장하고 조회할 수 있는 persistence 기반이 생긴다.
  Verification: Repository 수준 저장/조회 흐름을 확인할 수 있다.
  Dependency: CAND-001
  WP Packaging Note: CAND-001, CAND-009와 함께 저장 기반 WP 후보가 될 수 있다.

- ID: TASK-CAND-003
  Source Candidate: CAND-003
  Goal: 게시글 등록 기능을 구현한다.
  Source Anchor: work-roadmap.md / CAND-003
  Scope: 등록 요청, 서비스 처리, 저장 호출, 등록 결과 반환
  Expected Output: 새 게시글을 생성할 수 있다.
  Verification: 등록 요청 후 게시글이 저장되는지 확인한다.
  Dependency: CAND-002
  WP Packaging Note: CAND-004와 함께 등록/조회 최소 흐름 WP 후보가 될 수 있다.

- ID: TASK-CAND-004
  Source Candidate: CAND-004
  Goal: 게시글 목록 및 상세 조회 기능을 구현한다.
  Source Anchor: work-roadmap.md / CAND-004
  Scope: 목록 조회, 단건 조회, 존재하지 않는 게시글 처리 후보
  Expected Output: 저장된 게시글을 목록과 상세로 조회할 수 있다.
  Verification: 등록된 게시글의 목록/상세 조회 흐름을 확인한다.
  Dependency: CAND-002, CAND-003
  WP Packaging Note: CAND-003과 함께 최소 CRUD 관통 WP 후보가 될 수 있다.

- ID: TASK-CAND-005
  Source Candidate: CAND-005
  Goal: 게시글 수정 기능을 구현한다.
  Source Anchor: work-roadmap.md / CAND-005
  Scope: 수정 요청, 기존 게시글 조회, 변경값 반영, 결과 반환
  Expected Output: 기존 게시글 내용을 수정할 수 있다.
  Verification: 수정 후 상세 조회에서 변경값을 확인한다.
  Dependency: CAND-004
  WP Packaging Note: CAND-006, CAND-007과 함께 안정화 WP 후보가 될 수 있다.

- ID: TASK-CAND-006
  Source Candidate: CAND-006
  Goal: 게시글 삭제 기능을 구현한다.
  Source Anchor: work-roadmap.md / CAND-006
  Scope: 삭제 요청, 기존 게시글 조회, 삭제 처리, 삭제 후 조회 처리 후보
  Expected Output: 기존 게시글을 삭제할 수 있다.
  Verification: 삭제 후 목록/상세 조회 결과를 확인한다.
  Dependency: CAND-004
  WP Packaging Note: CAND-005, CAND-007과 함께 안정화 WP 후보가 될 수 있다.

- ID: TASK-CAND-007
  Source Candidate: CAND-007
  Goal: 입력 검증과 오류 응답을 최소 처리한다.
  Source Anchor: work-roadmap.md / CAND-007
  Scope: 필수 입력값 검증, 존재하지 않는 게시글 오류, 최소 오류 응답 형식
  Expected Output: CRUD 흐름의 기본 오류 케이스가 정리된다.
  Verification: 필수값 누락과 없는 게시글 접근 시 오류 응답을 확인한다.
  Dependency: CAND-003, CAND-004, CAND-005, CAND-006
  WP Packaging Note: 수정/삭제 안정화 WP 또는 별도 오류 처리 WP로 묶을 수 있다.

- ID: TASK-CAND-008
  Source Candidate: CAND-008
  Goal: 게시글 CRUD 최소 테스트를 작성한다.
  Source Anchor: work-roadmap.md / CAND-008
  Scope: Repository, Service, Controller 후보 테스트 범위 정리 및 최소 검증
  Expected Output: CRUD 핵심 흐름의 최소 테스트 후보가 준비된다.
  Verification: 등록, 조회, 수정, 삭제, 오류 처리 흐름을 테스트로 확인한다.
  Dependency: CAND-001 ~ CAND-007
  WP Packaging Note: Phase 2 검증 전용 WP 후보로 묶는다.

- ID: TASK-CAND-009
  Source Candidate: CAND-009
  Goal: Flyway 최초 migration 적용 여부를 결정한다.
  Source Anchor: work-roadmap.md / CAND-009
  Scope: 현재 저장 구조 기준 migration 적용/보류 판단, 초기 migration 후보 정리
  Expected Output: Flyway 적용 여부와 구현 기준이 결정된다.
  Verification: 적용 여부 결정과 후속 작업 필요 여부를 확인한다.
  Dependency: CAND-002
  WP Packaging Note: 저장 기반 WP에 포함하거나 운영 준비 WP로 분리할 수 있다.

- ID: TASK-CAND-010
  Source Candidate: CAND-010
  Goal: 후속 확장 후보를 현재 구현 범위와 분리해 유지한다.
  Source Anchor: work-roadmap.md / CAND-010
  Scope: auth, 댓글, 검색, 첨부파일, 독립 배포, 헥사고날 전환 등의 범위 분리
  Expected Output: 현재 CRUD 구현 범위와 후속 확장 후보가 섞이지 않는다.
  Verification: 후속 후보가 현재 Phase의 필수 작업으로 확정되지 않았는지 확인한다.
  Dependency: None
  WP Packaging Note: 구현 WP가 아니라 scope boundary 관리 WP 또는 별도 보류 묶음으로 둔다.

---

## 3. 다음 검토

- Task 후보를 유지할지, 병합할지, 분할할지 검토한다.
- Work Package 패키징은 후속 `$plan wp` action에서 다룬다.
