# Work Candidates

## 1. 문서 목적

이 문서는 board 프로젝트의 개발 작업 후보를 관리한다.

현재 문서는 `$plan extract-candidates` 결과를 기준으로 생성한 후보 초안이다.
아래 후보는 아직 Phase, Cycle, Work Package, Task로 확정된 실행 단위가 아니다.

---

## 2. Work Candidates

- ID: CAND-001
  Title: Spring Boot board 프로젝트 기본 구조 준비
  Source Anchor: `01-overview.md`, `specs/04-application-structure.md`
  Summary: 단일 Spring Boot 애플리케이션 기준으로 기본 프로젝트 구조와 `post`, `common`, `auth` 후보 패키지 경계를 준비한다.
  Type: Feature
  Priority: High
  Dependency: None
  Deferred: No

- ID: CAND-002
  Title: 게시글 Entity와 Repository 저장 구조 구현
  Source Anchor: `specs/05-domain-model.md`, `specs/07-db-design.md`
  Summary: `PostEntity`, `PostRepository`, `posts` 테이블 기준의 최소 persistence 구조를 구현한다.
  Type: Feature
  Priority: High
  Dependency: CAND-001
  Deferred: No

- ID: CAND-003
  Title: 게시글 등록 기능 구현
  Source Anchor: `specs/02-requirements.md`, `specs/06-api-spec.md`
  Summary: 제목과 본문을 받아 게시글을 등록하고 생성 결과를 조회 가능하게 만든다.
  Type: Feature
  Priority: High
  Dependency: CAND-001, CAND-002
  Deferred: No

- ID: CAND-004
  Title: 게시글 목록 및 상세 조회 기능 구현
  Source Anchor: `specs/02-requirements.md`, `specs/06-api-spec.md`
  Summary: `/api/posts`, `/api/posts/{postId}` 기준으로 목록 조회와 상세 조회 흐름을 구현한다.
  Type: Feature
  Priority: High
  Dependency: CAND-001, CAND-002
  Deferred: No

- ID: CAND-005
  Title: 게시글 수정 기능 구현
  Source Anchor: `specs/02-requirements.md`, `specs/05-domain-model.md`, `specs/06-api-spec.md`
  Summary: 기존 게시글의 제목과 본문을 수정하고 수정 시각을 갱신하는 흐름을 구현한다.
  Type: Feature
  Priority: High
  Dependency: CAND-002, CAND-004
  Deferred: No

- ID: CAND-006
  Title: 게시글 삭제 기능 구현
  Source Anchor: `specs/02-requirements.md`, `specs/05-domain-model.md`, `specs/06-api-spec.md`
  Summary: 게시글 식별자를 기준으로 삭제하고 삭제된 게시글이 일반 조회 흐름에 다시 나타나지 않게 한다.
  Type: Feature
  Priority: High
  Dependency: CAND-002, CAND-004
  Deferred: No

- ID: CAND-007
  Title: 입력 검증과 오류 응답 최소 처리
  Source Anchor: `specs/02-requirements.md`, `specs/03-design.md`, `specs/06-api-spec.md`
  Summary: 제목/본문 필수 검증, 존재하지 않는 게시글, 잘못된 식별자에 대한 최소 오류 처리를 구현한다.
  Type: Feature
  Priority: High
  Dependency: CAND-003, CAND-004, CAND-005, CAND-006
  Deferred: No

- ID: CAND-008
  Title: 게시글 CRUD 최소 테스트 작성
  Source Anchor: `specs/04-application-structure.md`, `specs/07-db-design.md`
  Summary: 현재 CRUD 검증에 필요한 Repository, Service, Controller 후보 테스트를 최소 범위로 작성한다.
  Type: Test
  Priority: Medium
  Dependency: CAND-003, CAND-004, CAND-005, CAND-006, CAND-007
  Deferred: No

- ID: CAND-009
  Title: Flyway 최초 migration 적용 여부 결정
  Source Anchor: `specs/07-db-design.md`
  Summary: Flyway 즉시 적용 여부를 결정하고, 적용 시 `V1__create_posts_table.sql` 후보를 기준으로 migration을 준비한다.
  Type: Needs Classification
  Priority: Medium
  Dependency: CAND-002
  Deferred: No

- ID: CAND-010
  Title: 후속 확장 후보 분리 유지
  Source Anchor: `01-overview.md`, `specs/02-requirements.md`, `specs/06-api-spec.md`
  Summary: auth, 댓글, 검색, 첨부파일, 독립 배포, 헥사고날 전환 등은 현재 CRUD 범위와 분리해 후속 후보로 유지한다.
  Type: Documentation
  Priority: Low
  Dependency: None
  Deferred: Yes

---

## 3. 다음 검토

- 후보를 유지할지, 병합할지, 분할할지 검토한다.
- Phase / Cycle / Work Package / Task 확정은 후속 `$plan` action에서 다룬다.
