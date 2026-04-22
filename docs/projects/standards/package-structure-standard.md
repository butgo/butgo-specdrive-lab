# package-structure-standard.md

## 1. 문서 목적

이 문서는 초기 게시판 프로젝트에서 사용할 패키지 구조 표준을 정의한다.

주요 목적은 다음과 같다.

- 레이어드 구조 기준의 패키지 배치 원칙을 통일한다.
- controller, facade, service, repository의 책임 혼선을 줄인다.
- Spring Boot 기반 프로젝트에서 소스 위치와 역할 구분을 일관되게 유지한다.
- 초기 게시판 구현을 빠르게 시작하되, 이후 헥사고날 전환이 가능하도록 최소한의 경계 기준을 남긴다.
- AI 협업 시 파일 위치와 클래스 배치 판단 기준을 통일한다.

이 문서는 특정 프레임워크의 전체 디렉토리 구조를 설명하는 문서가 아니라,  
프로젝트 전반에서 어떤 기준으로 패키지를 나누고 클래스를 배치할지 정의하는 공통 표준 문서이다.

---

## 2. 기본 원칙

이 프로젝트의 패키지 구조는 다음 원칙을 따른다.

- 패키지는 기술 종류보다 책임과 의미를 기준으로 나눈다.
- 같은 역할의 클래스는 가능한 한 같은 계층에 모은다.
- controller, facade, service, repository의 책임을 패키지에서도 드러낸다.
- 지금 필요한 구조를 우선하고, 미래 구조를 과하게 미리 만들지 않는다.
- 공통 패키지는 꼭 필요한 경우에만 사용한다.
- `util`, `common`, `base` 같은 모호한 패키지 남용을 지양한다.
- 파일 위치만 보고도 역할을 대략 추론할 수 있어야 한다.
- 이후 헥사고날 전환 시 이동 가능한 경계를 메모 수준으로 남긴다.

---

## 3. 현재 단계 구조 원칙

현재 단계는 레이어드 아키텍처를 기준으로 시작한다.

기본 흐름은 아래를 따른다.

- controller
- facade
- service
- repository

즉, 현재 기본 호출 흐름은 아래를 기준으로 한다.

`controller -> facade -> service -> repository`

현재 단계에서는 위 구조를 흔들리지 않게 유지하는 것이 우선이며,  
처음부터 port / adapter / application / domain 계층을 완성형으로 미리 만들지는 않는다.

---

## 4. 기본 패키지 기준

루트 패키지는 프로젝트 기준 패키지를 따른다.

예:
- `kr.co.butgo.board`

이 아래에서 역할별 패키지를 둔다.

예시 기준:

    kr.co.butgo.board
     ├─ controller
     ├─ facade
     ├─ service
     ├─ repository
     ├─ domain
     ├─ entity
     ├─ dto
     ├─ exception
     ├─ config
     └─ support

현재 단계에서는 위 수준이면 충분하며,  
구현이 커지면 도메인별 하위 패키지 분리를 검토한다.

---

## 5. 패키지 분리 방식

현재 단계에서는 아래 두 방식 중 하나를 선택할 수 있다.

### 5.1 계층 우선 방식

예:

    kr.co.butgo.board
     ├─ controller
     ├─ facade
     ├─ service
     ├─ repository
     ├─ entity
     ├─ dto
     ├─ exception
     └─ config

장점:
- 레이어드 구조가 한눈에 보인다.
- 초기 프로젝트에서 이해가 쉽다.
- controller, facade, service 책임 분리가 선명하다.

권장 시점:
- 현재처럼 게시판 최소 구현을 빠르게 시작할 때

---

### 5.2 도메인 하위 분리 방식

예:

    kr.co.butgo.board
     ├─ post
     │   ├─ controller
     │   ├─ facade
     │   ├─ service
     │   ├─ repository
     │   ├─ entity
     │   └─ dto
     ├─ comment
     │   ├─ controller
     │   ├─ facade
     │   ├─ service
     │   ├─ repository
     │   ├─ entity
     │   └─ dto
     ├─ common
     ├─ config
     └─ exception

장점:
- 도메인 경계가 더 잘 드러난다.
- 기능이 많아질 때 유지보수가 쉬워진다.

주의:
- 초기에는 과할 수 있다.
- 게시판 최소 구현 단계에서는 먼저 계층 우선 방식으로 시작해도 충분하다.

---

## 6. 현재 단계 추천 구조

현재 단계에서는 계층 우선 방식을 기본으로 한다.

권장 예시:

    kr.co.butgo.board
     ├─ controller
     ├─ facade
     ├─ service
     ├─ repository
     ├─ entity
     ├─ dto
     │   ├─ request
     │   ├─ response
     │   └─ internal
     ├─ domain
     ├─ exception
     ├─ config
     └─ support

설명:
- `controller`: HTTP 진입점
- `facade`: 요청 단위 흐름 조합
- `service`: 업무 규칙 처리
- `repository`: DB 접근
- `entity`: JPA Entity
- `dto.request`: 외부 입력 DTO
- `dto.response`: 외부 응답 DTO
- `dto.internal`: 내부 전달용 DTO
- `domain`: 도메인 enum, value 성격 클래스, 규칙 모델
- `exception`: 공통 예외 및 에러 코드
- `config`: 설정
- `support`: 기술 보조성 클래스

---

## 7. 역할별 패키지 기준

### 7.1 controller

역할:
- HTTP 요청 수신
- 요청 파라미터/바인딩 처리
- 인증 정보 수집
- facade 호출
- 응답 반환

규칙:
- controller는 service나 repository를 직접 여러 개 조합하지 않는다.
- controller는 가능한 한 facade 호출을 기준으로 한다.
- controller는 HTTP 관심사에 집중한다.

예:
- `PostController`
- `CommentController`

---

### 7.2 facade

역할:
- 요청 단위 흐름 조합
- 여러 service 호출 orchestration
- 응답 생성 전 중간 흐름 조립

규칙:
- facade는 화면/요청 단위 흐름을 담당한다.
- facade는 controller와 service 사이의 흐름 조합 지점이다.
- facade가 repository를 직접 호출하는 것은 지양한다.
- facade가 domain 규칙의 원천이 되어서는 안 된다.

예:
- `PostFacade`
- `BoardAdminFacade`

---

### 7.3 service

역할:
- 업무 규칙 처리
- 도메인 처리 단위 구현
- repository 호출 및 상태 변경

규칙:
- service는 업무 규칙 단위로 나눈다.
- service는 controller 관심사를 가지지 않는다.
- service는 응답 포맷 생성 책임을 가지지 않는다.
- service끼리 무분별하게 순환 호출하지 않는다.

예:
- `PostService`
- `CommentService`

---

### 7.4 repository

역할:
- DB 접근
- 조회/저장/삭제 수행
- 필요 시 커스텀 쿼리 처리

규칙:
- repository는 비즈니스 흐름을 조합하지 않는다.
- repository는 service 하위 계층으로 유지한다.
- controller, facade에서 repository 직접 호출은 지양한다.

예:
- `PostRepository`
- `CommentRepository`

---

### 7.5 entity

역할:
- JPA 영속 모델
- DB 테이블 매핑

규칙:
- entity는 persistence 중심 모델로 둔다.
- entity에 과도한 서비스 로직을 넣지 않는다.
- 무분별한 setter 공개는 지양한다.

예:
- `PostEntity`
- `CommentEntity`

---

### 7.6 dto

역할:
- 요청/응답/내부 전달 모델

세부 구조:
- `dto.request`
- `dto.response`
- `dto.internal`

규칙:
- 외부 API 입력은 `request`
- 외부 API 출력은 `response`
- 내부 계층 전달이 필요할 때만 `internal`
- 모든 DTO를 한 패키지에 평평하게 몰아넣지 않는다.

예:
- `dto.request.PostCreateRequest`
- `dto.response.PostDetailResponse`
- `dto.internal.PostSummaryDto`

---

### 7.7 domain

역할:
- 도메인 enum
- value 성격 클래스
- 도메인 규칙 표현 모델

규칙:
- domain 패키지는 지금 단계에서 가볍게 시작한다.
- JPA Entity와 완전히 별도 도메인 모델을 지금 당장 강제하지 않는다.
- 이후 헥사고날 전환 시 이 패키지가 커질 수 있다.

예:
- `PostStatus`
- `UserRole`

---

### 7.8 exception

역할:
- 예외 클래스
- 에러 코드
- 예외 응답 변환 관련 공통 구성

규칙:
- 예외는 한 곳에 모아 관리할 수 있어야 한다.
- controller, facade, service 어느 계층이 어떤 예외를 던지는지 규칙은 별도 문서를 따른다.

예:
- `BusinessException`
- `ErrorCode`

---

### 7.9 config

역할:
- Spring Boot 설정
- Bean 등록
- Web 설정
- 직렬화/검증/보안의 최소 설정

규칙:
- 기술 설정은 config에 둔다.
- 업무 규칙성 코드는 config에 넣지 않는다.

---

### 7.10 support

역할:
- 기술 보조성 클래스
- 공통 변환기
- 보조 유틸리티

규칙:
- `support`는 정말 공통 기술 보조일 때만 사용한다.
- 업무 로직을 support로 밀어 넣지 않는다.
- `util` 대신 의미 있는 support 하위 패키지를 우선 검토한다.

예:
- `support.time`
- `support.web`
- `support.converter`

---

## 8. 패키지 배치 규칙

### 8.1 요청/응답 DTO 위치

- 요청 DTO는 `dto.request`
- 응답 DTO는 `dto.response`
- 내부 전용 모델은 `dto.internal`

혼합 배치를 지양한다.

---

### 8.2 enum 위치

- 특정 도메인에 강하게 속하면 `domain` 또는 관련 도메인 하위 패키지
- 공통 성격이면 별도 공통 domain 패키지 검토

예:
- `domain.PostStatus`
- `domain.UserRole`

---

### 8.3 mapper 위치

- 특정 계층 전환용 mapper는 관련 계층 가까이에 둔다.
- 전역 mapper 패키지를 무조건 먼저 만들지 않는다.

예:
- DTO ↔ Entity 변환이 많으면 `mapper` 패키지 검토 가능
- 현재 단계에서는 필요할 때만 도입한다

---

## 9. 의존 방향 기준

현재 레이어드 구조에서 기본 의존 방향은 아래를 따른다.

- controller -> facade
- facade -> service
- service -> repository
- service -> entity/domain
- repository -> entity

지양:
- repository -> service
- service -> controller
- facade -> controller
- controller -> repository 직접 다중 호출

즉, 상위 요청 계층에서 하위 처리 계층으로 흐르는 방향을 유지한다.

---

## 10. 공통 패키지 사용 기준

### 10.1 common 패키지

현재 단계에서는 `common` 패키지를 무분별하게 만들지 않는다.

허용 기준:
- 정말 여러 계층에서 반복적으로 쓰이고
- 특정 도메인에 속하지 않으며
- 책임이 분명한 경우

지양 예:
- `common.Util`
- `common.Helper`
- `common.Manager`

---

### 10.2 util 패키지

`util` 패키지는 원칙적으로 지양한다.

이유:
- 의미가 모호하다.
- 모든 애매한 코드를 밀어 넣기 쉽다.

대신:
- `support.time`
- `support.converter`
- `support.web`

처럼 의미를 드러내는 패키지를 우선한다.

---

## 11. 도메인별 확장 시 전환 기준

현재는 계층 우선 구조를 기본으로 하지만, 아래 경우 도메인 하위 분리를 검토한다.

- post, comment, board 기능이 커짐
- controller, service, dto 수가 빠르게 증가함
- 한 계층 패키지 안에서 파일 수가 과도하게 많아짐
- 도메인별 변경 영향 분리가 필요해짐

이 경우 예를 들어 아래처럼 옮길 수 있다.

    kr.co.butgo.board.post
    kr.co.butgo.board.comment
    kr.co.butgo.board.board

단, 현재 단계에서는 아직 미리 옮기지 않는다.

---

## 12. 헥사고날 전환 후보 메모

현재 문서는 레이어드 구조 기준이지만, 나중에 헥사고날 전환 시 아래가 이동 후보가 될 수 있다.

- facade -> application/usecase 후보
- service -> domain service 또는 application service 후보
- repository -> outbound adapter 후보
- controller -> inbound adapter 후보
- dto.request/response -> transport model 후보
- domain 패키지 -> core domain 후보

현재 단계에서는 이 수준의 메모만 남기고, 구조를 미리 나누지 않는다.

---

## 13. 금지 또는 지양 규칙

다음을 지양한다.

- controller에서 service와 repository를 뒤섞어 직접 흐름 조합
- facade와 service 책임을 이름만 다르게 두고 동일하게 쓰는 것
- `common`, `util`, `base` 패키지에 애매한 코드를 몰아넣는 것
- dto, entity, domain을 한 패키지에 섞어 두는 것
- config 패키지에 업무 로직 넣기
- support 패키지에 비즈니스 로직 넣기
- 현재 단계에서 port, adapter, application 패키지를 성급히 먼저 만드는 것

---

## 14. 현재 단계 적용 기준

현재 단계에서는 Spring Boot 기반의 레이어드 게시판을 빠르게 시작하되,  
나중에 헥사고날 전환이 가능하도록 최소한의 책임 경계를 유지하는 것을 목표로 한다.

따라서 현재는 다음을 우선한다.

- 계층 우선 패키지 구조 사용
- controller -> facade -> service -> repository 흐름 유지
- dto.request / dto.response 분리
- entity, domain, exception, config 역할 분리
- `common`, `util` 남용 방지
- 현재 필요한 수준까지만 패키지 세분화

즉, 현재 단계의 패키지 구조 표준은  
미래 구조를 미리 완성하는 것이 아니라,  
초기 게시판 구현이 흔들리지 않도록 하는 최소한의 공통 배치 기준을 먼저 고정하는 데 목적이 있다.
