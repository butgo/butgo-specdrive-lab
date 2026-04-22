# docs/projects/board/03-design.md

## 1. 문서 목적

이 문서는 board 프로젝트의 **현재 단계 최소 설계 문서**다.

목적은 다음과 같다.

- `02-requirements.md` 의 최소 요구사항을 구현 가능한 구조로 옮긴다.
- Spring Boot 기반 레이어드 구조에서 각 계층의 책임을 고정한다.
- board에서 공통 standards를 어떻게 적용할지 정리한다.
- 후속 구현 계획 문서가 작업 단위를 나눌 수 있는 기준을 제공한다.

이 문서는 상세 구현 계획 문서가 아니다.
또한 전체 API 명세서나 전체 DB 스키마 문서도 아니다.
현재는 **최소 게시글 CRUD 흐름을 어떤 구조로 만들지**를 고정하는 데 집중한다.

---

## 2. 현재 설계 한 줄 요약

board는 현재 단계에서 `Post` 중심의 최소 게시글 CRUD를
Spring Boot 레이어드 구조로 구현하는 방향을 채택한다.

---

## 3. 설계 기준 문서

이 문서는 다음 문서를 기준으로 한다.

- `docs/projects/board/01-overview.md`
- `docs/projects/board/02-requirements.md`
- `docs/projects/board/AGENTS.md`
- `docs/projects/standards/naming-standard.md`
- `docs/projects/standards/package-structure-standard.md`
- `docs/projects/standards/api-standard.md`
- `docs/projects/standards/db-standard.md`

공통 standards 본문을 이 문서에 길게 반복하지 않는다.
이 문서는 board에서 현재 채택하는 적용 판단만 기록한다.

---

## 4. 현재 포함 설계 범위

현재 설계 범위는 다음과 같다.

- 게시글 목록 조회
- 게시글 상세 조회
- 게시글 등록
- 게시글 수정
- 게시글 삭제
- 게시글 기본 데이터 구조
- 게시글 API 경로 기준
- 레이어드 패키지 및 계층 책임

현재 설계 범위에 직접 포함하지 않는 것은 다음과 같다.

- 사용자 회원가입 / 로그인
- 권한 관리
- 댓글
- 첨부파일
- 검색 고도화
- 정렬 / 필터 고도화
- 관리자 기능
- 배포/운영 구조

위 항목은 후속 요구사항이 확정될 때 별도 문서에서 다룬다.

---

## 5. 현재 채택 구조

현재 board는 계층 우선 패키지 구조를 채택한다.

기본 호출 흐름은 다음과 같다.

```text
controller -> facade -> service -> repository
```

현재 단계에서 이 구조를 선택하는 이유는 다음과 같다.

- 첫 구현 범위가 `Post` 중심으로 작다.
- 레이어 책임을 빠르게 검증하기 쉽다.
- standards의 초기 권장 구조와 일치한다.
- 이후 기능이 늘어나면 도메인 하위 분리로 전환할 여지를 남길 수 있다.

현재 단계에서는 `port`, `adapter`, `application` 같은 헥사고날 구조를 먼저 도입하지 않는다.

---

## 6. 패키지 구조

현재 기준 루트 패키지는 다음을 우선한다.

```text
kr.co.butgo.board
```

현재 추천 패키지 구조는 다음과 같다.

```text
kr.co.butgo.board
 ├─ controller
 ├─ facade
 ├─ service
 ├─ repository
 ├─ entity
 ├─ dto
 │   ├─ request
 │   └─ response
 ├─ domain
 ├─ exception
 └─ config
```

현재는 내부 전달 모델이 꼭 필요하다고 확정되지 않았으므로 `dto.internal` 은 먼저 만들지 않는다.
필요성이 생기면 구현 계획 단계에서 추가한다.

---

## 7. 계층별 책임

### 7.1 Controller

`PostController` 는 HTTP 요청 진입점을 담당한다.

책임은 다음과 같다.

- API 요청 수신
- path variable, request body 바인딩
- validation 진입점 연결
- `PostFacade` 호출
- response DTO 반환

Controller는 repository를 직접 호출하지 않는다.

### 7.2 Facade

`PostFacade` 는 요청 단위 흐름을 조합한다.

책임은 다음과 같다.

- 목록 / 상세 / 등록 / 수정 / 삭제 요청 흐름 조합
- request DTO를 service 입력으로 전달할 형태로 정리
- service 결과를 response DTO로 변환하는 흐름 관리

Facade는 업무 규칙의 원천이 아니다.
업무 규칙은 service에서 처리한다.

### 7.3 Service

`PostService` 는 게시글 업무 규칙을 담당한다.

책임은 다음과 같다.

- 게시글 조회
- 게시글 등록
- 게시글 수정
- 게시글 삭제
- 게시글 존재 여부 확인
- 제목/본문 같은 핵심 값의 업무상 유효성 확인

Service는 HTTP 응답 형식을 직접 알지 않는다.

### 7.4 Repository

`PostRepository` 는 게시글 영속성 접근을 담당한다.

책임은 다음과 같다.

- 게시글 목록 조회
- 게시글 단건 조회
- 게시글 저장
- 게시글 삭제

Repository는 비즈니스 흐름을 조합하지 않는다.

---

## 8. 도메인 모델

현재 핵심 도메인 용어는 `Post` 다.

현재 단계의 영속 모델은 `PostEntity` 로 시작한다.

`PostEntity` 의 최소 필드는 다음과 같다.

- `postId`
- `title`
- `content`
- `createdAt`
- `updatedAt`

현재는 작성자, 게시판 분류, 상태값을 필수로 확정하지 않는다.
사용자와 권한 요구사항이 확정되면 작성자 관련 필드를 후속 설계에서 추가한다.

---

## 9. API 설계 기준

현재 게시글 API는 `/posts` 리소스를 기준으로 한다.

현재 단계의 최소 API 후보는 다음과 같다.

| 기능 | Method | Path |
| --- | --- | --- |
| 목록 조회 | GET | `/posts` |
| 상세 조회 | GET | `/posts/{postId}` |
| 등록 | POST | `/posts` |
| 수정 | PATCH | `/posts/{postId}` |
| 삭제 | DELETE | `/posts/{postId}` |

수정은 현재 요구사항이 제목/본문 부분 변경에 가깝기 때문에 `PATCH` 를 우선 채택한다.
전체 교체 의미가 필요해지면 `PUT` 전환을 후속 검토한다.

현재 단계에서는 API 버전 prefix를 두지 않는다.
필요성이 생기면 `/api/v1` 같은 버전 정책을 별도로 판단한다.

---

## 10. DTO 설계 기준

현재 request DTO 후보는 다음과 같다.

- `PostCreateRequest`
- `PostUpdateRequest`

현재 response DTO 후보는 다음과 같다.

- `PostListItemResponse`
- `PostDetailResponse`
- `PostCreateResponse`
- `PostUpdateResponse`

삭제는 현재 단계에서 응답 본문 없이 `204 No Content` 를 우선 검토한다.

DTO는 `dto.request`, `dto.response` 아래에 둔다.
Entity를 외부 응답으로 직접 노출하지 않는다.

---

## 11. DB 설계 기준

현재 게시글 테이블은 `post` 를 기준으로 한다.

현재 최소 컬럼 후보는 다음과 같다.

| 컬럼 | 의미 |
| --- | --- |
| `post_id` | 게시글 식별자 |
| `title` | 게시글 제목 |
| `content` | 게시글 본문 |
| `created_at` | 생성 시각 |
| `updated_at` | 수정 시각 |

현재 삭제 정책은 hard delete를 우선 검토한다.
삭제 복구나 감사 요구가 아직 없기 때문이다.

목록 조회 정렬은 `created_at` 내림차순을 기본 후보로 둔다.
인덱스는 실제 조회 패턴을 확인한 뒤 구현 계획이나 DB 상세 설계에서 확정한다.

---

## 12. 입력 검증과 예외

현재 입력 검증은 다음을 최소 기준으로 둔다.

- 제목은 비어 있으면 안 된다.
- 본문은 비어 있으면 안 된다.

잘못된 입력은 `400 Bad Request` 계열로 처리한다.
존재하지 않는 게시글 조회, 수정, 삭제는 `404 Not Found` 계열로 처리한다.

상세 에러 응답 구조는 공통 `exception-standard.md` 가 아직 없으므로,
현재는 `api-standard.md` 의 기본 에러 응답 구조를 따른다.

---

## 13. 후속 구현 계획으로 넘길 항목

후속 구현 계획 문서에서는 다음을 작업 단위로 나눈다.

- Spring Boot 프로젝트 기본 구조 확인 또는 생성
- `PostEntity` 작성
- `PostRepository` 작성
- `PostService` 작성
- `PostFacade` 작성
- `PostController` 작성
- request / response DTO 작성
- validation 적용
- 기본 CRUD 테스트 작성

구현 계획 문서에서는 작업 순서와 검증 방법을 다루고,
이 문서에서는 구조 판단만 유지한다.

---

## 14. 보류 사항

현재 보류 사항은 다음과 같다.

- 공통 응답 envelope를 지금 도입할지 여부
- paging 기본값과 page 시작 번호 확정
- hard delete 유지 여부
- exception 표준 문서 작성 시 에러 응답 구조 재정렬
- 테스트 표준 문서 작성 시 테스트 범위 재정렬
- 작성자 / 사용자 요구사항 도입 시 `User` 관계 추가 여부

---

## 15. 최종 정리

현재 board 설계는 `Post` 중심 최소 CRUD를
Spring Boot 레이어드 구조로 구현하는 방향을 채택한다.

핵심은 다음과 같다.

- `controller -> facade -> service -> repository` 흐름을 유지한다.
- API는 `/posts` 리소스 중심으로 설계한다.
- DB는 `post` 테이블과 기본 컬럼에서 시작한다.
- 현재 요구가 없는 사용자, 댓글, 첨부파일, 권한 구조는 먼저 넣지 않는다.
- 후속 구현 계획 문서는 이 설계를 기준으로 작업 단위를 나눈다.
