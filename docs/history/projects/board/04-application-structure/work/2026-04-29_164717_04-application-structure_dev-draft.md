# specs/04-application-structure.md

## 1. 문서 목적

이 문서는 board 프로젝트의 애플리케이션 구조 문서다.

현재 단계에서 Spring Boot 기반 layered 구조를 실제 코드 구조로 어떻게 배치할지 정리한다.

이 문서는 상세 API 명세 문서가 아니다.  
또한 상세 DB 설계 문서나 구현 계획 문서도 아니다.

현재 문서의 목적은 다음과 같다.

- `03-design.md`에서 정리한 layered 설계를 코드 구조 기준으로 구체화한다.
- Controller, Facade, Service, Repository, Entity, DTO, 예외 처리 위치를 정리한다.
- 게시글 CRUD 구현을 위한 최소 패키지 구조를 정의한다.
- logging, auth, board 같은 재사용 후보 영역의 경계를 코드 구조 관점에서 검토한다.
- 후속 도메인 모델, API 명세, DB 설계, 구현 계획 문서가 이어받을 기준을 제공한다.

---

## 2. 애플리케이션 구조 한 줄 요약

board는 Spring Boot 기반 layered 구조를 사용하며,  
게시글 기능을 `controller`, `facade`, `service`, `repository`, `entity`, `dto` 중심으로 나누어 배치한다.

현재 단계의 핵심은 과도한 추상화 없이  
게시글 CRUD를 구현할 수 있는 단순하고 명확한 코드 구조를 만드는 것이다.

---

## 3. 구조 정리 기준

현재 애플리케이션 구조는 다음 기준을 따른다.

- Spring Boot 기반 layered 구조를 우선한다.
- 현재 단계에서는 헥사고날 구조를 전제로 하지 않는다.
- 게시글 CRUD 구현에 필요한 최소 패키지를 먼저 정의한다.
- Controller와 Service 사이에 Facade 계층을 둘 수 있다.
- Facade는 요청 흐름 조정과 응답 조립의 경계로 사용한다.
- Service는 게시글 업무 처리, 검증, 트랜잭션 중심으로 사용한다.
- 상세 API, DB, 구현 순서는 이 문서에서 확정하지 않는다.
- 패키지 구조는 기능 확장 가능성을 남기되 과도하게 세분화하지 않는다.
- logging, auth, board의 경계는 의식하되 즉시 독립 모듈화하지 않는다.
- 공통 모듈이나 starter 분리는 현재 단계에서 확정하지 않는다.
- AI와 사람이 함께 읽고 구현하기 쉬운 구조를 우선한다.

---

## 4. 현재 구조 범위

현재 문서에서 다루는 구조 범위는 다음과 같다.

- 기본 프로젝트 루트 구조
- Spring Boot 애플리케이션 진입점 위치
- 게시글 기능 패키지 구조
- Controller 위치
- Facade 위치
- Service 위치
- Repository 위치
- Entity 위치
- DTO 위치
- 예외 처리 위치
- 공통 응답 구조 사용 여부 검토 위치
- logging 적용 위치
- auth 연계 가능성 위치
- 테스트 구조 방향

현재는 게시글 CRUD 구현에 필요한 최소 구조를 첫 번째 범위로 본다.

---

## 5. 현재 구조 제외 범위

현재 문서에서 직접 확정하지 않는 범위는 다음과 같다.

- 멀티모듈 구조 확정
- auth 독립 모듈 확정
- board 독립 모듈 확정
- logging starter 구조 확정
- 공통 모듈 제품화 구조 확정
- 헥사고날 구조 패키지 확정
- 마이크로서비스 분리 구조 확정
- 상세 API URL 확정
- 상세 요청/응답 필드 확정
- 상세 DB 테이블/컬럼 확정
- 배포 구조 확정
- 모바일 앱 연계 구조 확정

위 항목들은 현재 단계에서 확정하지 않는다.  
필요성이 검증되면 후속 문서나 별도 후보 문서에서 다룬다.

---

## 6. 기본 프로젝트 구조 방향

현재 board는 하나의 Spring Boot 애플리케이션으로 시작한다.

기본 구조 방향은 다음과 같다.

    board
      ├─ build.gradle
      ├─ settings.gradle
      ├─ src
      │  ├─ main
      │  │  ├─ java
      │  │  │  └─ com
      │  │  │     └─ example
      │  │  │        └─ board
      │  │  │           ├─ BoardApplication.java
      │  │  │           ├─ post
      │  │  │           ├─ common
      │  │  │           └─ auth
      │  │  └─ resources
      │  │     ├─ application.yml
      │  │     └─ db
      │  │        └─ migration
      │  └─ test
      │     └─ java
      │        └─ com
      │           └─ example
      │              └─ board

실제 base package는 프로젝트 생성 시 결정한다.  
이 문서에서는 설명을 위해 `com.example.board`를 예시로 사용한다.

---

## 7. 패키지 구성 방향

현재 단계의 패키지 구성은 기능 기준과 계층 기준을 함께 고려한다.

기본 방향은 다음과 같다.

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

현재 핵심 기능은 `post` 패키지에 둔다.  
공통 예외, 응답, logging 후보는 `common` 패키지에 둔다.  
auth는 현재 상세 구현하지 않지만, 후속 연계를 고려해 경계만 남길 수 있다.

---

## 8. 게시글 기능 패키지

게시글 기능은 `post` 패키지 아래에 둔다.

기본 구조는 다음과 같다.

    post
      ├─ controller
      ├─ facade
      ├─ service
      ├─ repository
      ├─ entity
      └─ dto

현재 단계에서 `post` 패키지는 게시판의 핵심 기능 영역이다.

각 하위 패키지의 역할은 다음과 같다.

- `controller`: 게시글 API 요청 진입점
- `facade`: Controller와 Service 사이의 애플리케이션 흐름 조정
- `service`: 게시글 기능 처리, 검증, 트랜잭션 경계
- `repository`: 게시글 데이터 접근
- `entity`: 게시글 JPA Entity
- `dto`: 게시글 요청/응답 객체

현재는 단순한 CRUD 구현을 우선하므로, 패키지를 과도하게 세분화하지 않는다.

---

## 9. Controller 구조

Controller는 `post.controller` 패키지에 둔다.

예상 파일은 다음과 같다.

    post
      └─ controller
         └─ PostController.java

Controller의 책임은 다음과 같다.

- 게시글 목록 조회 요청을 받는다.
- 게시글 상세 조회 요청을 받는다.
- 게시글 등록 요청을 받는다.
- 게시글 수정 요청을 받는다.
- 게시글 삭제 요청을 받는다.
- 요청 DTO를 Facade에 전달한다.
- Facade 처리 결과를 응답 DTO 또는 응답 객체로 반환한다.

Controller는 비즈니스 로직을 직접 처리하지 않는다.  
Controller는 Service를 직접 호출하기보다 Facade를 통해 애플리케이션 흐름을 위임한다.

---

## 10. Facade 구조

Facade는 `post.facade` 패키지에 둔다.

예상 파일은 다음과 같다.

    post
      └─ facade
         └─ PostFacade.java

Facade의 책임은 다음과 같다.

- Controller 요청을 애플리케이션 기능 흐름으로 변환한다.
- Service 호출 순서를 조정한다.
- 필요 시 여러 Service의 결과를 조합한다.
- Entity 또는 내부 처리 결과를 응답 DTO로 변환하는 경계를 담당한다.
- Controller가 Service 세부 구조에 직접 의존하지 않도록 완충 역할을 한다.
- API 응답에 필요한 데이터를 조립한다.

현재 단계에서는 게시글 CRUD가 단순하므로 Facade가 과도한 로직을 갖지 않도록 한다.

Facade는 다음 책임을 갖지 않는다.

- DB 접근을 직접 수행하지 않는다.
- Repository를 직접 사용하지 않는다.
- 핵심 업무 검증을 과도하게 담당하지 않는다.
- 트랜잭션 경계의 중심이 되지 않는다.
- Entity의 영속성 상태를 직접 제어하지 않는다.

Facade는 Controller와 Service 사이의 조정 계층이다.  
게시글 업무 처리의 핵심은 Service에 둔다.

---

## 11. Service 구조

Service는 `post.service` 패키지에 둔다.

예상 파일은 다음과 같다.

    post
      └─ service
         └─ PostService.java

필요 시 인터페이스와 구현체를 분리할 수 있다.

    post
      └─ service
         ├─ PostService.java
         └─ PostServiceImpl.java

현재 단계에서는 단순 구현을 우선한다.  
인터페이스 분리는 필요성이 확인될 때 적용한다.

Service의 책임은 다음과 같다.

- 게시글 목록 조회 흐름을 처리한다.
- 게시글 상세 조회 흐름을 처리한다.
- 게시글 등록 흐름을 처리한다.
- 게시글 수정 흐름을 처리한다.
- 게시글 삭제 흐름을 처리한다.
- 입력값의 기본 유효성을 판단한다.
- 존재하지 않는 게시글에 대한 처리를 담당한다.
- 트랜잭션 경계를 담당한다.
- Repository와 협력한다.

Service는 Controller 요청/응답 형식에 과도하게 의존하지 않는다.  
Service는 Facade나 Controller에 세부 업무 책임을 과도하게 넘기지 않는다.

---

## 12. Repository 구조

Repository는 `post.repository` 패키지에 둔다.

예상 파일은 다음과 같다.

    post
      └─ repository
         └─ PostRepository.java

현재 단계에서는 Spring Data JPA Repository 사용을 우선 검토한다.

예상 방향은 다음과 같다.

    PostRepository extends JpaRepository<PostEntity, Long>

Repository의 책임은 다음과 같다.

- 게시글 목록 조회를 위한 데이터 접근
- 게시글 단건 조회를 위한 데이터 접근
- 게시글 등록 저장
- 게시글 수정 저장
- 게시글 삭제 처리
- JPA 기반 persistence 연계

Repository는 Controller 요청 형식이나 화면 흐름을 알지 않는다.  
Repository는 데이터 접근 책임에 집중한다.

---

## 13. Entity 구조

Entity는 `post.entity` 패키지에 둔다.

예상 파일은 다음과 같다.

    post
      └─ entity
         └─ PostEntity.java

현재 단계에서 게시글 Entity는 최소한 다음 속성을 가진다.

- id
- title
- content
- createdAt
- updatedAt

Entity의 상세 필드명, 제약 조건, 매핑 방식은 DB 설계 문서에서 구체화한다.

현재 단계에서는 도메인 객체와 JPA Entity를 별도로 분리하지 않을 수 있다.  
다만 후속 확장을 고려하여 분리 필요성은 도메인 모델 문서와 DB 설계 문서에서 다시 검토한다.

---

## 14. DTO 구조

DTO는 `post.dto` 패키지에 둔다.

예상 파일은 다음과 같다.

    post
      └─ dto
         ├─ PostCreateRequest.java
         ├─ PostUpdateRequest.java
         ├─ PostListResponse.java
         └─ PostDetailResponse.java

현재 단계에서 필요한 DTO 후보는 다음과 같다.

- 게시글 등록 요청 DTO
- 게시글 수정 요청 DTO
- 게시글 목록 응답 DTO
- 게시글 상세 응답 DTO

DTO의 상세 필드와 검증 어노테이션은 API 명세 문서에서 구체화한다.

Controller는 외부 요청/응답에 DTO를 사용한다.  
Entity를 외부 응답으로 직접 노출하는 것은 피하는 방향을 우선 검토한다.

DTO 변환 위치는 다음 기준으로 판단한다.

- 단순한 변환은 Facade에서 처리할 수 있다.
- 응답 조립이 복잡해지면 별도 mapper 도입을 검토할 수 있다.
- 현재 단계에서는 별도 mapper 패키지를 확정하지 않는다.

---

## 15. 예외 처리 구조

공통 예외 처리는 `common.exception` 패키지에 둔다.

예상 구조는 다음과 같다.

    common
      └─ exception
         ├─ GlobalExceptionHandler.java
         ├─ ErrorResponse.java
         └─ NotFoundException.java

현재 단계에서 필요한 예외 처리 대상은 다음과 같다.

- 필수 입력값 누락
- 존재하지 않는 게시글 조회
- 존재하지 않는 게시글 수정
- 존재하지 않는 게시글 삭제
- 잘못된 게시글 식별자
- 저장 처리 실패

현재 문서에서는 상세 오류 응답 형식을 확정하지 않는다.  
API 명세 문서에서 오류 응답 구조와 HTTP 상태 코드를 구체화한다.

---

## 16. 공통 응답 구조

공통 응답 구조는 필요 시 `common.response` 패키지에 둔다.

예상 구조는 다음과 같다.

    common
      └─ response
         └─ ApiResponse.java

현재 단계에서는 공통 응답 포맷을 반드시 확정하지 않는다.

검토 기준은 다음과 같다.

- 단순 CRUD 검증에는 직접 DTO 응답만으로 충분할 수 있다.
- API 응답 형식을 통일해야 할 필요가 있으면 `ApiResponse`를 도입한다.
- 공통 응답 구조는 API 명세 문서와 함께 결정한다.
- 과도한 공통화를 이유로 초기 구현을 복잡하게 만들지 않는다.

---

## 17. logging 구조

logging 관련 코드는 필요 시 `common.logging` 패키지에 둔다.

예상 구조는 다음과 같다.

    common
      └─ logging

현재 단계의 logging 기준은 다음과 같다.

- 요청 처리 흐름을 추적할 수 있는 최소 로그를 고려한다.
- Controller, Facade, Service 중심으로 로그 위치를 검토한다.
- 공통 logging 모듈이나 starter 분리는 현재 단계에서 확정하지 않는다.
- 향후 재사용 가능성은 남기되 초기 구현은 단순하게 유지한다.

---

## 18. auth 구조

auth는 현재 단계에서 상세 구현 범위를 확정하지 않는다.

필요 시 다음 위치를 사용할 수 있다.

    auth

현재 단계의 auth 기준은 다음과 같다.

- 게시글 CRUD는 우선 인증 없이 검증 가능해야 한다.
- 작성자, 권한, 로그인 사용자 연계는 후속 후보로 둔다.
- auth 패키지는 현재 구조에서 경계 검토용으로만 둘 수 있다.
- 실제 클래스 작성 여부는 구현 계획에서 결정한다.
- auth 독립 모듈이나 독립 배포 구조는 현재 확정하지 않는다.

---

## 19. resources 구조

resources 구조는 다음 방향을 따른다.

    src
      └─ main
         └─ resources
            ├─ application.yml
            └─ db
               └─ migration

`application.yml`은 Spring Boot 설정을 담는다.

`db/migration`은 Flyway 사용 시 migration SQL 파일을 둘 수 있는 위치다.  
Flyway 사용 여부와 migration 파일 작성 기준은 DB 설계 문서에서 구체화한다.

---

## 20. 테스트 구조

테스트 코드는 `src/test/java` 아래에 둔다.

예상 구조는 다음과 같다.

    src
      └─ test
         └─ java
            └─ com
               └─ example
                  └─ board
                     ├─ post
                     │  ├─ controller
                     │  ├─ facade
                     │  ├─ service
                     │  └─ repository
                     └─ common

현재 단계에서 테스트는 다음 기준을 따른다.

- 게시글 CRUD 흐름을 검증할 수 있어야 한다.
- Service 단위 테스트를 우선 고려한다.
- Facade 테스트는 Controller와 Service 사이의 조정이 복잡해질 때 검토한다.
- Repository 테스트는 JPA 설정과 함께 검토한다.
- Controller 테스트는 API 명세가 정리된 뒤 구체화한다.
- 테스트 상세 범위와 순서는 구현 계획 문서에서 정리한다.

---

## 21. 의존 방향

현재 layered 구조의 기본 의존 방향은 다음과 같다.

    Controller
      -> Facade
      -> Service
      -> Repository
      -> Entity/Persistence

기본 원칙은 다음과 같다.

- Controller는 Facade를 사용할 수 있다.
- Facade는 Service를 사용할 수 있다.
- Service는 Repository를 사용할 수 있다.
- Repository는 Entity를 사용할 수 있다.
- Entity는 Controller, Facade, Service, Repository에 의존하지 않는다.
- Repository는 Controller나 Facade를 알지 않는다.
- Service는 Controller 요청/응답 형식에 과도하게 의존하지 않는다.
- Entity를 외부 API 응답으로 직접 노출하는 것은 피한다.
- common은 여러 기능에서 사용할 수 있지만, 기능별 책임을 과도하게 흡수하지 않는다.

현재 단계에서는 단순 layered 구조를 기준으로 하되,  
의존 방향이 흐트러지지 않도록 유지한다.

---

## 22. Facade 적용 기준

현재 board는 Controller와 Service 사이에 Facade 계층을 둘 수 있다.

Facade를 두는 이유는 다음과 같다.

- Controller를 얇게 유지하기 위해서다.
- API 요청 흐름과 업무 처리 흐름 사이에 완충 계층을 두기 위해서다.
- DTO 변환과 응답 조립 위치를 명확히 하기 위해서다.
- 향후 여러 Service를 조합해야 할 가능성에 대비하기 위해서다.
- Controller가 Service 내부 구조에 과도하게 의존하지 않도록 하기 위해서다.

현재 단계의 Facade 적용 기준은 다음과 같다.

- 게시글 CRUD 요청은 Controller에서 Facade로 전달한다.
- Facade는 필요한 Service를 호출한다.
- Facade는 응답 DTO 조립을 담당할 수 있다.
- Service는 업무 처리, 검증, 트랜잭션 중심으로 유지한다.
- Repository 접근은 Service를 통해 수행한다.

현재 게시글 CRUD가 매우 단순하더라도,  
프로젝트 구조 검증 목적상 Facade 계층을 명시적으로 둘 수 있다.

다만 Facade가 불필요하게 비대해지면 안 된다.  
Facade는 흐름 조정 계층이지 핵심 업무 로직 계층이 아니다.

---

## 23. 구조 결정 보류 사항

현재 구조 문서에서는 다음 판단을 보류한다.

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

이 항목들은 현재 구조에서 성급히 확정하지 않는다.  
필요성이 검증되면 후속 문서에서 구체화한다.

---

## 24. 관련 문서

이 문서는 다음 문서를 상위 기준으로 참조한다.

- `01-overview.md`
- `specs/02-requirements.md`
- `specs/03-design.md`

이 문서 이후에는 보통 다음 문서로 이어진다.

- `specs/05-domain-model.md`
- `specs/06-api-spec.md`
- `specs/07-db-design.md`
- `impl/01-implementation-plan.md`
- `status/current-status.md`

---

## 25. 다음 문서로 이어지는 방향

이 문서 다음에는 다음 내용을 후속 문서에서 구체화한다.

- 도메인 모델 문서에서 게시글의 핵심 개념과 속성을 정리한다.
- API 명세 문서에서 요청/응답 DTO와 HTTP API 구조를 정리한다.
- DB 설계 문서에서 Entity와 테이블 구조를 구체화한다.
- 구현 계획 문서에서 실제 생성할 클래스와 작업 순서를 정리한다.
- 현재 상태 문서에서 현재 진행 위치와 다음 진입점을 추적한다.

즉 이 문서는  
board 요구사항과 설계를 실제 Spring Boot 코드 구조로 옮기기 위한 애플리케이션 구조 기준 문서다.