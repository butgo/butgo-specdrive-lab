# specs/04-application-structure.md

## 1. 문서 목적

이 문서는 board 프로젝트의 애플리케이션 구조 문서다.

현재 단계에서 `03-design.md`의 layered 설계를 Spring Boot 코드 구조로 어떻게 배치할지 정리한다.  
이 문서는 상세 API 명세, 상세 DB 설계, 구현 계획을 확정하지 않는다.

목적은 다음과 같다.

- 게시글 CRUD 구현을 위한 최소 패키지 구조를 정의한다.
- Controller, Facade, Service, Repository, Entity, DTO의 위치와 책임을 나눈다.
- common, logging, auth 후보 영역의 코드 경계를 정리한다.
- 후속 도메인 모델, API 명세, DB 설계, 구현 계획 문서가 이어받을 기준을 제공한다.

---

## 2. 구조 한 줄 요약

board는 단일 Spring Boot 애플리케이션으로 시작하고, 게시글 기능은 `post` 패키지 안에서 `controller`, `facade`, `service`, `repository`, `entity`, `dto` 중심으로 배치한다.

현재 핵심은 과도한 추상화 없이 게시글 CRUD를 구현할 수 있는 단순하고 명확한 코드 구조를 만드는 것이다.

---

## 3. 현재 구조 결정

현재 확정한 구조 결정은 다음과 같다.

- Spring Boot 기반 layered 구조를 우선한다.
- 헥사고날 구조는 현재 구조 기준으로 채택하지 않는다.
- 기본 기능 패키지는 `post`로 둔다.
- Controller와 Service 사이에는 Facade 계층을 둘 수 있다.
- Facade는 요청 흐름 조정과 응답 조립 경계로 사용한다.
- Service는 업무 처리, 검증, 트랜잭션 중심으로 사용한다.
- Repository는 JPA 기반 데이터 접근을 담당한다.
- Entity와 DTO는 분리하는 방향을 우선 검토한다.
- common은 예외, 응답, logging 후보를 담는 영역으로 둔다.
- auth는 현재 상세 구현하지 않고 경계만 남긴다.

---

## 4. 현재 구조 범위

현재 문서에서 다루는 범위는 다음과 같다.

- 기본 프로젝트 루트 구조
- Spring Boot 애플리케이션 진입점
- 게시글 기능 패키지 구조
- Controller, Facade, Service, Repository 위치
- Entity, DTO 위치
- 예외 처리 위치
- 공통 응답 구조 후보 위치
- logging 적용 후보 위치
- auth 연계 후보 위치
- resources 구조
- 테스트 구조 방향
- 계층 의존 방향

---

## 5. 현재 구조 제외 범위

이 문서에서 확정하지 않는 범위는 다음과 같다.

- 멀티모듈 구조
- auth 독립 모듈
- board 독립 모듈
- logging starter 구조
- 공통 모듈 제품화 구조
- 헥사고날 구조 패키지
- 마이크로서비스 분리
- 상세 API URL과 요청/응답 필드
- 상세 DB 테이블/컬럼
- 배포 구조
- 모바일 앱 연계 구조

위 항목은 필요성이 검증되면 후속 문서에서 다룬다.

---

## 6. 기본 프로젝트 구조

현재 board는 하나의 Spring Boot 애플리케이션으로 시작한다.

기본 구조 예시는 다음과 같다.

    board
      ├─ build.gradle
      ├─ settings.gradle
      ├─ src
      │  ├─ main
      │  │  ├─ java
      │  │  │  └─ com/example/board
      │  │  │     ├─ BoardApplication.java
      │  │  │     ├─ post
      │  │  │     ├─ common
      │  │  │     └─ auth
      │  │  └─ resources
      │  │     ├─ application.yml
      │  │     └─ db/migration
      │  └─ test
      │     └─ java/com/example/board

실제 base package는 프로젝트 생성 시 결정한다.  
이 문서에서는 설명을 위해 `com.example.board`를 예시로 사용한다.

---

## 7. 패키지 구성

기본 패키지 방향은 다음과 같다.

    com.example.board
      ├─ BoardApplication
      ├─ post
      │  ├─ controller
      │  ├─ facade
      │  ├─ service
      │  ├─ repository
      │  ├─ entity
      │  └─ dto
      ├─ common
      │  ├─ exception
      │  ├─ response
      │  └─ logging
      └─ auth

패키지 기준은 다음과 같다.

- `post`: 게시글 CRUD 핵심 기능
- `common`: 여러 기능에서 공유할 수 있는 예외, 응답, logging 후보
- `auth`: 현재 구현 대상은 아니지만 후속 인증/권한 연계를 위한 경계

---

## 8. post 패키지

게시글 기능은 `post` 아래에 둔다.

    post
      ├─ controller
      ├─ facade
      ├─ service
      ├─ repository
      ├─ entity
      └─ dto

역할은 다음과 같다.

- `controller`: 게시글 API 요청 진입점
- `facade`: Controller와 Service 사이의 흐름 조정, 응답 조립
- `service`: 게시글 기능 처리, 검증, 트랜잭션 경계
- `repository`: 게시글 데이터 접근
- `entity`: 게시글 JPA Entity
- `dto`: 게시글 요청/응답 객체

현재는 CRUD 구현에 필요한 최소 구조를 우선한다.

---

## 9. 계층별 위치와 책임

### 9.1 Controller

위치:

    post/controller/PostController.java

책임:

- 게시글 CRUD 요청을 받는다.
- 요청 DTO를 Facade에 전달한다.
- Facade 처리 결과를 응답 DTO 또는 응답 객체로 반환한다.
- 비즈니스 로직을 직접 처리하지 않는다.

### 9.2 Facade

위치:

    post/facade/PostFacade.java

책임:

- Controller 요청을 애플리케이션 기능 흐름으로 변환한다.
- Service 호출 순서를 조정한다.
- 응답 DTO 조립 경계를 담당한다.
- Controller가 Service 내부 구조에 과도하게 의존하지 않도록 한다.

Facade는 Repository를 직접 사용하지 않고, 트랜잭션 경계의 중심이 되지 않는다.

### 9.3 Service

위치:

    post/service/PostService.java

책임:

- 게시글 목록, 상세, 등록, 수정, 삭제 흐름을 처리한다.
- 입력값의 기본 유효성을 판단한다.
- 존재하지 않는 게시글 상황을 처리한다.
- 트랜잭션 경계를 담당한다.
- Repository와 협력한다.

인터페이스와 구현체 분리는 필요성이 확인될 때 적용한다.

### 9.4 Repository

위치:

    post/repository/PostRepository.java

현재 방향:

    PostRepository extends JpaRepository<PostEntity, Long>

책임:

- 게시글 목록 조회
- 게시글 단건 조회
- 게시글 저장
- 게시글 수정 저장
- 게시글 삭제
- JPA 기반 persistence 연계

### 9.5 Entity

위치:

    post/entity/PostEntity.java

최소 속성:

- id
- title
- content
- createdAt
- updatedAt

상세 필드명, 제약 조건, 매핑 방식은 DB 설계 문서에서 정한다.

### 9.6 DTO

위치:

    post/dto

DTO 후보:

- `PostCreateRequest`
- `PostUpdateRequest`
- `PostListResponse`
- `PostDetailResponse`

DTO 상세 필드와 검증 어노테이션은 API 명세 문서에서 정한다.  
Entity를 외부 응답으로 직접 노출하는 것은 피하는 방향을 우선 검토한다.

---

## 10. common 패키지

### 10.1 exception

위치:

    common/exception

후보 파일:

- `GlobalExceptionHandler.java`
- `ErrorResponse.java`
- `NotFoundException.java`

상세 오류 응답 형식과 HTTP 상태 코드는 API 명세 문서에서 정한다.

### 10.2 response

위치:

    common/response

후보 파일:

- `ApiResponse.java`

공통 응답 포맷은 현재 필수 결정이 아니다.  
API 응답 형식 통일 필요성이 확인되면 도입한다.

### 10.3 logging

위치:

    common/logging

기준:

- 요청 처리 흐름을 추적할 수 있는 최소 로그를 고려한다.
- Controller, Facade, Service 중심으로 로그 위치를 검토한다.
- logging starter 분리는 현재 확정하지 않는다.

---

## 11. auth 패키지

`auth`는 현재 상세 구현 범위를 확정하지 않는다.

기준은 다음과 같다.

- 게시글 CRUD는 우선 인증 없이 검증 가능해야 한다.
- 작성자, 권한, 로그인 사용자 연계는 후속 후보로 둔다.
- auth 패키지는 경계 검토용으로만 둘 수 있다.
- 실제 클래스 작성 여부는 구현 계획에서 결정한다.

---

## 12. resources 구조

resources 구조는 다음 방향을 따른다.

    src/main/resources
      ├─ application.yml
      └─ db/migration

- `application.yml`: Spring Boot 설정
- `db/migration`: Flyway 사용 시 migration SQL 위치

Flyway 사용 여부와 migration 작성 기준은 DB 설계 문서에서 정한다.

---

## 13. 테스트 구조

테스트 코드는 `src/test/java` 아래에 둔다.

예상 구조는 다음과 같다.

    src/test/java/com/example/board
      ├─ post
      │  ├─ controller
      │  ├─ facade
      │  ├─ service
      │  └─ repository
      └─ common

테스트 기준은 다음과 같다.

- 게시글 CRUD 흐름을 검증할 수 있어야 한다.
- Service 단위 테스트를 우선 고려한다.
- Facade 테스트는 조정 로직이 복잡해질 때 검토한다.
- Repository 테스트는 JPA 설정과 함께 검토한다.
- Controller 테스트는 API 명세가 정리된 뒤 구체화한다.
- 테스트 상세 범위와 순서는 구현 계획 문서에서 정한다.

---

## 14. 의존 방향

기본 의존 방향은 다음과 같다.

    Controller
      -> Facade
      -> Service
      -> Repository
      -> Entity/Persistence

원칙은 다음과 같다.

- Controller는 Facade를 사용할 수 있다.
- Facade는 Service를 사용할 수 있다.
- Service는 Repository를 사용할 수 있다.
- Repository는 Entity를 사용할 수 있다.
- Entity는 Controller, Facade, Service, Repository에 의존하지 않는다.
- Repository는 Controller나 Facade를 알지 않는다.
- Service는 Controller 요청/응답 형식에 과도하게 의존하지 않는다.
- Entity를 외부 API 응답으로 직접 노출하지 않는다.
- common은 기능별 책임을 과도하게 흡수하지 않는다.

---

## 15. Facade 적용 기준

현재 board는 Controller와 Service 사이에 Facade 계층을 둘 수 있다.

Facade를 두는 이유는 다음과 같다.

- Controller를 얇게 유지한다.
- API 요청 흐름과 업무 처리 흐름 사이에 완충 계층을 둔다.
- DTO 변환과 응답 조립 위치를 명확히 한다.
- 향후 여러 Service 조합 가능성에 대비한다.
- Controller가 Service 내부 구조에 과도하게 의존하지 않도록 한다.

적용 기준은 다음과 같다.

- 게시글 CRUD 요청은 Controller에서 Facade로 전달한다.
- Facade는 필요한 Service를 호출한다.
- Facade는 응답 DTO 조립을 담당할 수 있다.
- Service는 업무 처리, 검증, 트랜잭션 중심으로 유지한다.
- Repository 접근은 Service를 통해 수행한다.
- Facade는 흐름 조정 계층이지 핵심 업무 로직 계층이 아니다.

---

## 16. 후속 후보

현재 확정하지 않고 후속 후보로 남기는 항목은 다음과 같다.

- 멀티모듈 적용 여부
- service 인터페이스와 구현체 분리 여부
- DTO 세분화 수준
- 별도 mapper 패키지 도입 여부
- Entity와 Domain 객체 분리 여부
- 공통 응답 포맷 적용 여부
- 전역 예외 처리 방식 상세
- Bean Validation 적용 위치와 방식
- Flyway 즉시 적용 여부
- logging starter 분리 여부
- auth 패키지 실제 구현 여부
- board 독립 모듈화 여부
- 헥사고날 구조 전환 여부

---

## 17. 관련 문서

상위 기준 문서:

- `01-overview.md`
- `specs/02-requirements.md`
- `specs/03-design.md`

후속 문서:

- `specs/05-domain-model.md`
- `specs/06-api-spec.md`
- `specs/07-db-design.md`
- `impl/01-implementation-plan.md`
- `status/current-status.md`

---

## 18. 다음 방향

이 문서 다음에는 후속 문서에서 상세 결정을 나눈다.

- 도메인 모델 문서: 게시글 핵심 개념과 속성
- API 명세 문서: 요청/응답 DTO와 HTTP API 구조
- DB 설계 문서: Entity와 테이블 구조
- 구현 계획 문서: 실제 생성할 클래스와 작업 순서
- 현재 상태 문서: 진행 위치와 다음 진입점

즉 이 문서는 board 요구사항과 설계를 실제 Spring Boot 코드 구조로 옮기기 위한 애플리케이션 구조 기준 문서다.
