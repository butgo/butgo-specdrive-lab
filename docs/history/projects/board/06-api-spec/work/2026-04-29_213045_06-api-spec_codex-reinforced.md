# specs/06-api-spec.md

## 1. 문서 목적

이 문서는 board 프로젝트의 API 명세 문서다.

현재 단계에서 게시글 CRUD 기능을 외부에서 어떤 HTTP API로 사용할 수 있는지 정의한다.  
이 문서는 상세 DB 설계 문서, 구현 계획 문서, 테스트 계획 문서가 아니다.

목적은 다음과 같다.

- 게시글 CRUD API의 엔드포인트를 정의한다.
- 요청 경로, HTTP Method, 요청 DTO, 응답 DTO의 기준을 정리한다.
- 성공 응답과 오류 응답의 최소 기준을 정리한다.
- Controller, Facade, Service가 이어받을 API 경계를 제공한다.
- 후속 DB 설계와 구현 계획에서 구체화할 항목을 분리한다.

---

## 2. API 명세 한 줄 요약

board의 현재 API는 게시글 CRUD를 위한 최소 REST 스타일 HTTP API다.

현재 API는 다음 흐름을 제공한다.

- 게시글 목록 조회
- 게시글 상세 조회
- 게시글 등록
- 게시글 수정
- 게시글 삭제

API 진입점은 Spring Boot Controller이며, Controller는 Facade를 통해 게시글 기능 흐름을 위임한다.

---

## 3. 현재 API 결정

현재 확정한 API 결정은 다음과 같다.

- 현재 단계에서는 게시글 CRUD API만 정의한다.
- 기본 경로는 `/api/posts`로 둔다.
- 게시글 단건 경로는 `/api/posts/{postId}`로 둔다.
- API는 REST 스타일을 우선한다.
- API 요청과 응답에는 DTO를 사용한다.
- Entity를 외부 API 응답으로 직접 노출하지 않는다.
- 게시글 수정은 현재 `PUT`을 우선 사용한다.
- 게시글 삭제 성공은 응답 본문 없이 `204 No Content`로 처리할 수 있다.
- 인증과 권한은 현재 API 범위에 포함하지 않는다.
- 공통 응답 포맷과 상세 오류 응답 구조는 현재 확정하지 않는다.

---

## 4. 현재 API 범위

현재 문서에서 다루는 범위는 다음과 같다.

- 게시글 목록 조회 API
- 게시글 상세 조회 API
- 게시글 등록 API
- 게시글 수정 API
- 게시글 삭제 API
- 게시글 등록 요청 DTO
- 게시글 수정 요청 DTO
- 게시글 목록 응답 DTO
- 게시글 상세 응답 DTO
- 기본 성공 상태 코드
- 기본 오류 상태 코드
- 최소 입력 검증 기준
- Controller, Facade, Service 연결 기준

---

## 5. 현재 API 제외 범위

현재 문서에서 직접 정의하지 않는 범위는 다음과 같다.

- 사용자 회원가입, 로그인, 인증 토큰 API
- 작성자 기반 권한 API
- 댓글, 대댓글, 첨부파일 API
- 좋아요, 추천, 조회수 API
- 관리자 API
- 알림 API
- 통계 API
- 멀티테넌시 API
- 모바일 앱 전용 API
- 외부 연동 API
- Swagger/OpenAPI 상세 문서화 방식

위 항목은 현재 API 결정이 아니다.  
필요성이 검증되면 요구사항 또는 별도 API 문서에서 다룬다.

---

## 6. API 기본 경로

게시글 API의 기본 경로는 `/api/posts`로 둔다.

게시글 단건 API는 게시글 식별자를 경로 변수로 사용한다.

- 기본 경로: `/api/posts`
- 단건 경로: `/api/posts/{postId}`

현재 단계에서는 API 버전 경로를 확정하지 않는다.  
`/api/v1/posts` 같은 버전 경로는 후속 후보로 둔다.

---

## 7. API 목록

| 기능 | Method | URL | 성공 상태 |
|---|---:|---|---:|
| 게시글 목록 조회 | GET | `/api/posts` | `200 OK` |
| 게시글 상세 조회 | GET | `/api/posts/{postId}` | `200 OK` |
| 게시글 등록 | POST | `/api/posts` | `201 Created` |
| 게시글 수정 | PUT | `/api/posts/{postId}` | `200 OK` |
| 게시글 삭제 | DELETE | `/api/posts/{postId}` | `204 No Content` |

현재 단계에서는 `PUT`을 게시글 전체 수정 기준으로 사용한다.  
부분 수정이 필요하면 후속 단계에서 `PATCH` 도입을 검토한다.

---

## 8. 게시글 목록 조회 API

### 8.1 기본 정보

| 항목 | 값 |
|---|---|
| Method | `GET` |
| URL | `/api/posts` |
| Request Body | 없음 |
| Response Body | 게시글 목록 응답 |

### 8.2 요청

현재 단계에서는 목록 조회 요청에 Query Parameter를 확정하지 않는다.

페이징, 정렬, 검색 조건은 후속 후보로 둔다.

### 8.3 응답

목록 응답은 게시글 목록을 반환한다.

목록 항목은 최소한 다음 정보를 포함한다.

- 게시글 식별자
- 제목
- 생성 시각
- 수정 시각

응답 DTO 후보는 `PostListResponse`다.

응답 예시는 다음과 같다.

    [
      {
        "id": 1,
        "title": "첫 번째 게시글",
        "createdAt": "2026-01-01T10:00:00",
        "updatedAt": "2026-01-01T10:00:00"
      }
    ]

---

## 9. 게시글 상세 조회 API

### 9.1 기본 정보

| 항목 | 값 |
|---|---|
| Method | `GET` |
| URL | `/api/posts/{postId}` |
| Request Body | 없음 |
| Response Body | 게시글 상세 응답 |

### 9.2 경로 변수

| 이름 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| postId | Long | 예 | 조회할 게시글 식별자 |

### 9.3 응답

상세 응답은 최소한 다음 정보를 포함한다.

- 게시글 식별자
- 제목
- 본문
- 생성 시각
- 수정 시각

응답 DTO 후보는 `PostDetailResponse`다.

응답 예시는 다음과 같다.

    {
      "id": 1,
      "title": "첫 번째 게시글",
      "content": "게시글 본문입니다.",
      "createdAt": "2026-01-01T10:00:00",
      "updatedAt": "2026-01-01T10:00:00"
    }

### 9.4 오류

| 상황 | HTTP Status |
|---|---:|
| 게시글이 존재하지 않음 | `404 Not Found` |
| 게시글 식별자가 잘못됨 | `400 Bad Request` |

---

## 10. 게시글 등록 API

### 10.1 기본 정보

| 항목 | 값 |
|---|---|
| Method | `POST` |
| URL | `/api/posts` |
| Request Body | 게시글 등록 요청 |
| Response Body | 게시글 상세 응답 또는 생성 결과 응답 |

### 10.2 요청

요청 DTO 후보는 `PostCreateRequest`다.

| 필드 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| title | String | 예 | 게시글 제목 |
| content | String | 예 | 게시글 본문 |

요청 예시는 다음과 같다.

    {
      "title": "첫 번째 게시글",
      "content": "게시글 본문입니다."
    }

### 10.3 검증

- 제목은 비어 있으면 안 된다.
- 본문은 비어 있으면 안 된다.

제목과 본문의 최대 길이, 공백 문자열 처리 기준은 현재 확정하지 않는다.

### 10.4 응답

등록 성공 시 생성된 게시글 정보를 반환할 수 있다.

| 상황 | HTTP Status |
|---|---:|
| 게시글 등록 성공 | `201 Created` |

오류 상태는 다음과 같다.

| 상황 | HTTP Status |
|---|---:|
| 필수 입력값 누락 | `400 Bad Request` |
| 요청 형식 오류 | `400 Bad Request` |

---

## 11. 게시글 수정 API

### 11.1 기본 정보

| 항목 | 값 |
|---|---|
| Method | `PUT` |
| URL | `/api/posts/{postId}` |
| Request Body | 게시글 수정 요청 |
| Response Body | 게시글 상세 응답 |

### 11.2 경로 변수

| 이름 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| postId | Long | 예 | 수정할 게시글 식별자 |

### 11.3 요청

요청 DTO 후보는 `PostUpdateRequest`다.

| 필드 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| title | String | 예 | 수정할 게시글 제목 |
| content | String | 예 | 수정할 게시글 본문 |

요청 예시는 다음과 같다.

    {
      "title": "수정된 제목",
      "content": "수정된 본문입니다."
    }

### 11.4 검증

- 수정 대상 게시글이 존재해야 한다.
- 제목은 비어 있으면 안 된다.
- 본문은 비어 있으면 안 된다.

### 11.5 응답

수정 성공 시 수정된 게시글 정보를 반환할 수 있다.

| 상황 | HTTP Status |
|---|---:|
| 게시글 수정 성공 | `200 OK` |

오류 상태는 다음과 같다.

| 상황 | HTTP Status |
|---|---:|
| 게시글이 존재하지 않음 | `404 Not Found` |
| 게시글 식별자가 잘못됨 | `400 Bad Request` |
| 필수 입력값 누락 | `400 Bad Request` |
| 요청 형식 오류 | `400 Bad Request` |

---

## 12. 게시글 삭제 API

### 12.1 기본 정보

| 항목 | 값 |
|---|---|
| Method | `DELETE` |
| URL | `/api/posts/{postId}` |
| Request Body | 없음 |
| Response Body | 없음 |

### 12.2 경로 변수

| 이름 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| postId | Long | 예 | 삭제할 게시글 식별자 |

### 12.3 검증

- 삭제 대상 게시글이 존재해야 한다.
- 게시글 식별자는 유효해야 한다.

### 12.4 응답

삭제 성공 시 응답 본문 없이 처리한다.

| 상황 | HTTP Status |
|---|---:|
| 게시글 삭제 성공 | `204 No Content` |

오류 상태는 다음과 같다.

| 상황 | HTTP Status |
|---|---:|
| 게시글이 존재하지 않음 | `404 Not Found` |
| 게시글 식별자가 잘못됨 | `400 Bad Request` |

---

## 13. DTO 정의

### 13.1 PostCreateRequest

| 필드 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| title | String | 예 | 게시글 제목 |
| content | String | 예 | 게시글 본문 |

검증 기준은 다음과 같다.

- `title`은 비어 있으면 안 된다.
- `content`는 비어 있으면 안 된다.

### 13.2 PostUpdateRequest

| 필드 | 타입 후보 | 필수 | 설명 |
|---|---|---|---|
| title | String | 예 | 게시글 제목 |
| content | String | 예 | 게시글 본문 |

검증 기준은 다음과 같다.

- `title`은 비어 있으면 안 된다.
- `content`는 비어 있으면 안 된다.

### 13.3 PostListResponse

| 필드 | 타입 후보 | 설명 |
|---|---|---|
| id | Long | 게시글 식별자 |
| title | String | 게시글 제목 |
| createdAt | LocalDateTime | 생성 시각 |
| updatedAt | LocalDateTime | 수정 시각 |

현재 목록 응답에는 본문을 포함하지 않는다.

### 13.4 PostDetailResponse

| 필드 | 타입 후보 | 설명 |
|---|---|---|
| id | Long | 게시글 식별자 |
| title | String | 게시글 제목 |
| content | String | 게시글 본문 |
| createdAt | LocalDateTime | 생성 시각 |
| updatedAt | LocalDateTime | 수정 시각 |

---

## 14. 오류 응답 기준

현재 단계에서는 공통 오류 응답 구조를 확정하지 않는다.

다만 오류 응답은 최소한 다음 정보를 표현할 수 있어야 한다.

- 오류 코드 또는 오류 유형
- 오류 메시지
- 요청 경로
- 발생 시각

오류 응답 예시는 다음과 같다.

    {
      "code": "POST_NOT_FOUND",
      "message": "게시글을 찾을 수 없습니다.",
      "path": "/api/posts/1",
      "timestamp": "2026-01-01T10:00:00"
    }

최종 오류 응답 구조와 필드별 검증 오류 응답 구조는 후속 후보로 둔다.

---

## 15. 오류 코드 후보

현재 단계에서 사용할 수 있는 오류 코드 후보는 다음과 같다.

| 코드 | 설명 | HTTP Status |
|---|---|---:|
| INVALID_REQUEST | 잘못된 요청 | `400 Bad Request` |
| VALIDATION_ERROR | 입력 검증 실패 | `400 Bad Request` |
| POST_NOT_FOUND | 게시글을 찾을 수 없음 | `404 Not Found` |
| INTERNAL_ERROR | 서버 내부 오류 | `500 Internal Server Error` |

오류 코드는 후보이며 구현 단계에서 최소 범위로 조정할 수 있다.

---

## 16. 입력 검증 기준

현재 API 입력 검증 기준은 다음과 같다.

- 게시글 등록 시 `title`은 비어 있으면 안 된다.
- 게시글 등록 시 `content`는 비어 있으면 안 된다.
- 게시글 수정 시 `title`은 비어 있으면 안 된다.
- 게시글 수정 시 `content`는 비어 있으면 안 된다.
- 상세 조회, 수정, 삭제 시 `postId`는 유효한 식별자여야 한다.
- 존재하지 않는 `postId`는 정상 처리하지 않는다.

현재 확정하지 않는 검증 항목은 다음과 같다.

- 제목 최대 길이
- 본문 최대 길이
- 공백만 있는 문자열 허용 여부
- HTML 입력 허용 여부
- 상세 검증 메시지
- 필드별 오류 응답 구조

---

## 17. 인증과 권한 기준

현재 단계의 게시글 CRUD API는 인증 없이 검증 가능해야 한다.

현재 기준은 다음과 같다.

- 사용자 로그인은 현재 API 범위에 포함하지 않는다.
- 작성자 기반 권한 검사는 현재 API 범위에 포함하지 않는다.
- 게시글 등록, 수정, 삭제 권한은 현재 단계에서 확정하지 않는다.
- 인증 연계는 후속 후보로 둔다.

---

## 18. Controller, Facade, Service 연결 기준

### 18.1 Controller

- `PostController`는 `/api/posts` 기본 경로를 가진다.
- Controller는 요청 DTO와 경로 변수 `postId`를 받는다.
- Controller는 Facade를 호출한다.
- Controller는 Facade 결과를 API 응답으로 반환한다.
- Controller는 비즈니스 로직을 직접 처리하지 않는다.

### 18.2 Facade

- `PostFacade`는 Controller 요청을 받아 Service를 호출한다.
- Facade는 응답 DTO를 조립할 수 있다.
- Facade는 Entity를 외부 응답으로 직접 노출하지 않도록 경계를 제공한다.
- Facade는 Repository를 직접 호출하지 않는다.
- Facade는 핵심 업무 검증을 과도하게 담당하지 않는다.

### 18.3 Service

- `PostService`는 게시글 목록 조회를 처리한다.
- `PostService`는 게시글 상세 조회를 처리한다.
- `PostService`는 게시글 등록을 처리한다.
- `PostService`는 게시글 수정을 처리한다.
- `PostService`는 게시글 삭제를 처리한다.
- Service는 존재하지 않는 게시글을 정상 처리하지 않는다.
- Service는 트랜잭션 경계를 담당한다.

---

## 19. 후속 후보

현재 API 명세에서 확정하지 않고 후속 후보로 남기는 항목은 다음과 같다.

- API 버전 경로 도입 여부
- 공통 응답 포맷 적용 여부
- 오류 응답 상세 구조
- 필드별 검증 오류 응답 구조
- 제목 최대 길이
- 본문 최대 길이
- 공백 문자열 처리 기준
- 페이징 기본 적용 여부
- 정렬 기본 기준
- 검색 API 도입 여부
- 인증 API 연계 여부
- 작성자 필드 응답 포함 여부
- 삭제 성공 응답 본문 포함 여부
- `PUT`과 `PATCH` 병행 여부
- Swagger/OpenAPI 문서화 방식

---

## 20. 관련 문서

상위 기준 문서:

- `01-overview.md`
- `specs/02-requirements.md`
- `specs/03-design.md`
- `specs/04-application-structure.md`
- `specs/05-domain-model.md`

후속 문서:

- `specs/07-db-design.md`
- `impl/01-implementation-plan.md`
- `status/current-status.md`

---

## 21. 다음 방향

이 문서 이후에는 후속 문서에서 상세 결정을 나눈다.

- DB 설계 문서: 게시글 Entity와 테이블 구조
- 구현 계획 문서: API 구현 순서와 테스트 범위
- 현재 상태 문서: 진행 위치와 다음 진입점

즉 이 문서는 board의 게시글 CRUD 기능을 HTTP API로 구현하기 위한 API 기준 문서다.
