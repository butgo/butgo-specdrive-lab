# api-standard.md

## 1. 문서 목적

이 문서는 초기 게시판 프로젝트에서 사용할 API 표준을 정의한다.

주요 목적은 다음과 같다.

- API URL, 요청, 응답, 에러 처리 규칙을 통일한다.
- Spring Boot 기반 API 구조에서 controller/action 스타일과 URL 매핑 기준을 일관되게 유지한다.
- 프론트엔드, 백엔드, 문서 간 API 의미 불일치를 줄인다.
- 초기 레이어드 게시판 구현에서 흔들리기 쉬운 응답 구조와 예외 응답 기준을 먼저 고정한다.
- 이후 공통 모듈 분리나 구조 전환 시에도 유지 가능한 최소 API 규칙을 먼저 정리한다.

이 문서는 특정 프레임워크의 모든 웹 기능을 설명하는 문서가 아니라,  
프로젝트 전반에서 어떤 기준으로 API를 설계하고 노출할지 정의하는 공통 표준 문서이다.

---

## 2. 기본 원칙

이 프로젝트의 API는 다음 원칙을 따른다.

- API는 controller/action 이름이 아니라 리소스 의미 중심으로 설계한다.
- URL은 가능한 한 도메인 용어를 그대로 반영한다.
- 요청과 응답은 명확한 DTO로 표현한다.
- 성공 응답과 실패 응답의 구조는 일관되어야 한다.
- 지금 필요한 범위를 넘는 과도한 일반화는 피한다.
- API 구조는 프론트엔드 편의만이 아니라 장기 유지보수와 문서화를 함께 고려한다.
- Spring Boot를 사용하되 controller/action 스타일에서 Grails식 관례를 참고하더라도 외부에 노출되는 API는 프로젝트 표준을 우선한다.
- 목록, 상세, 생성, 수정, 삭제의 기본 패턴은 일관되게 유지한다.

---

## 3. 적용 범위

현재 단계에서는 초기 게시판 프로젝트를 기준으로 다음 범위에 적용한다.

- 게시판 조회 API
- 게시글 CRUD API
- 댓글 CRUD API
- 첨부파일 메타데이터 API
- 인증/권한이 필요한 경우의 최소 보호 API
- 목록 조회, 상세 조회, 작성, 수정, 삭제 흐름

현재 문서는 게시판 최소 구현에 바로 필요한 범위를 우선하며,  
파일 업로드 전송 방식, 외부 공개 API, 관리자 API 분리 정책은 필요 시 별도 확장한다.

---

## 4. URL 설계 규칙

### 4.1 기본 규칙

- URL은 리소스 중심으로 설계한다.
- URL은 복수형 명사를 기본으로 사용한다.
- URL path는 소문자만 사용한다.
- 단어 구분은 초기 단계에서는 단순 소문자 또는 kebab-case 중 하나로 고정한다.
- 현재 단계에서는 단순한 리소스 명 중심의 소문자 복수형을 기본으로 한다.

예:
- `/posts`
- `/posts/{postId}`
- `/posts/{postId}/comments`
- `/boards/{boardId}/posts`

지양 예:
- `/postController/show`
- `/boardProc/savePost`
- `/getPostList`
- `/doDeletePost`

---

### 4.2 리소스 이름 기준

URL의 리소스 이름은 도메인 용어를 따른다.

예:
- 게시글 → `/posts`
- 댓글 → `/comments`
- 게시판 → `/boards`
- 첨부파일 → `/attachments`

URL은 controller/action 이름을 직접 반영하지 않는다.

예:
- `PostController.show` 라도 외부 URL은 `/posts/{postId}` 형태를 우선한다.

---

### 4.3 하위 리소스 규칙

상위 리소스에 종속되는 개념은 하위 리소스로 표현할 수 있다.

예:
- `/posts/{postId}/comments`
- `/posts/{postId}/attachments`

단, 하위 리소스 구조가 과도하게 깊어지지 않도록 한다.

지양 예:
- `/boards/{boardId}/posts/{postId}/comments/{commentId}/attachments`

---

### 4.4 관리자/특수 기능 URL

관리 기능은 별도 prefix를 둘 수 있다.

예:
- `/admin/boards`
- `/admin/posts`

현재 단계에서는 일반 사용자 API와 관리자 API를 무리하게 분리하지 않으며,  
실제 요구가 생기면 별도 기준을 추가한다.

---

## 5. HTTP Method 규칙

### 5.1 기본 매핑 규칙

- 목록 조회 → `GET`
- 단건 조회 → `GET`
- 생성 → `POST`
- 전체 수정 또는 주요 수정 → `PUT` 또는 `PATCH`
- 부분 수정 → `PATCH`
- 삭제 → `DELETE`

초기 단계에서는 아래 기준을 우선 사용한다.

- 목록 조회 → `GET /posts`
- 상세 조회 → `GET /posts/{postId}`
- 생성 → `POST /posts`
- 수정 → `PUT /posts/{postId}` 또는 `PATCH /posts/{postId}`
- 삭제 → `DELETE /posts/{postId}`

---

### 5.2 수정 Method 선택 기준

- 리소스 전체 교체 의미가 명확하면 `PUT`
- 부분 수정이나 실제 구현 편의가 크면 `PATCH`

현재 단계에서는 게시판 CRUD 단순성을 위해 `PUT` 또는 `PATCH` 중 하나를 프로젝트 전체에서 일관되게 선택한다.  
초기에는 부분 수정 중심이면 `PATCH`를 우선 검토할 수 있다.

---

### 5.3 Action성 API

REST 기본 구조로 표현하기 어려운 경우에만 action성 endpoint를 예외적으로 사용할 수 있다.

예:
- `/posts/{postId}/publish`
- `/posts/{postId}/restore`

단, 단순 CRUD를 action API로 표현하는 것은 지양한다.

지양 예:
- `POST /posts/{postId}/delete`
- `POST /posts/save`

---

## 6. Controller 스타일 / URL 매핑 기준

### 6.1 기본 원칙

- Spring Boot 기반의 controller 메서드 구조와 외부 URL은 분리해서 본다.
- 외부 API는 명시적인 URL 매핑 기준으로 관리하는 것을 우선 검토한다.
- Grails식 메서드 관례를 참고하더라도 외부 URL은 프로젝트 표준 URL을 우선한다.

---

### 6.2 Controller 메서드 역할

controller 메서드는 다음 역할에 집중한다.

- 요청 수신
- 파라미터 바인딩
- 인증/권한 정보 수집
- facade 호출
- 응답 반환

메서드 이름 예:
- `index`
- `show`
- `save`
- `update`
- `delete`

필요 시:
- `publish`
- `downloadAttachment`

---

### 6.3 URL 매핑 기준

- URL은 명시적인 매핑 설정에서 표준 형태로 고정한다.
- controller 메서드 이름 변경이 외부 URL 변경으로 이어지지 않게 한다.
- HTTP method 조건을 함께 명시할 수 있으면 명시한다.

예시 개념:
- `GET /posts` → `PostController.index`
- `GET /posts/{postId}` → `PostController.show`
- `POST /posts` → `PostController.save`
- `PATCH /posts/{postId}` → `PostController.update`
- `DELETE /posts/{postId}` → `PostController.delete`

---

## 7. 요청(Request) 규칙

### 7.1 요청 DTO 사용 원칙

- 요청은 가능한 한 명시적 Request DTO로 받는다.
- request body를 controller에서 직접 map으로 다루는 방식은 지양한다.
- 요청 DTO 이름은 역할이 드러나야 한다.

예:
- `PostCreateRequest`
- `PostUpdateRequest`
- `CommentCreateRequest`

---

### 7.2 Path Variable 이름 규칙

- path variable 이름은 자바 필드명과 맞춘다.
- ID 변수는 `<resource>NameId` 형식을 기본으로 한다.

예:
- `{postId}`
- `{commentId}`
- `{boardId}`

---

### 7.3 Query Parameter 규칙

목록 조회에서는 아래 형태를 기본으로 한다.

- `page`
- `size`
- `sort`
- `keyword`
- `status`

예:
- `/posts?page=1&size=20`
- `/posts?keyword=grails`
- `/posts?status=PUBLISHED`

---

### 7.4 Validation 원칙

- 요청 DTO는 validation 규칙을 명시할 수 있어야 한다.
- 필수값, 길이, 형식 제약은 가능한 한 요청 계층에서 먼저 검증한다.
- 비즈니스 규칙 검증은 facade/service에서 처리한다.

---

## 8. 응답(Response) 규칙

### 8.1 기본 원칙

- 응답은 Response DTO를 기본으로 사용한다.
- 엔티티를 그대로 외부 응답으로 노출하지 않는다.
- 응답 구조는 일관되어야 한다.

예:
- `PostDetailResponse`
- `PostListItemResponse`
- `CommentResponse`

---

### 8.2 성공 응답 구조

초기 단계에서는 아래 두 가지 방식 중 하나를 선택해 일관되게 유지한다.

#### 방식 A: 데이터 직접 반환

예시:

    {
      "postId": 1,
      "title": "title",
      "content": "content"
    }

#### 방식 B: 공통 envelope 사용

예시:

    {
      "success": true,
      "data": {
        "postId": 1,
        "title": "title",
        "content": "content"
      }
    }

현재 단계에서는 프로젝트 전체에서 하나만 선택해 일관되게 유지하는 것이 중요하다.  
공통 에러 구조와의 정합성을 고려하면 envelope 사용을 검토할 수 있다.

---

### 8.3 목록 응답 구조

목록 조회 응답은 항목 리스트와 페이징 정보를 함께 표현할 수 있다.

예:

    {
      "items": [
        {
          "postId": 1,
          "title": "Post 1"
        }
      ],
      "page": 1,
      "size": 20,
      "totalCount": 100
    }

또는 envelope 사용 시:

    {
      "success": true,
      "data": {
        "items": [
          {
            "postId": 1,
            "title": "Post 1"
          }
        ],
        "page": 1,
        "size": 20,
        "totalCount": 100
      }
    }

---

### 8.4 생성 응답 규칙

생성 후 응답은 아래 중 하나를 선택한다.

- 생성된 리소스 상세 반환
- 생성된 리소스 ID와 핵심 정보 반환
- 필요 시 `Location` 헤더 사용 검토

현재 단계에서는 단순성과 프론트 사용성을 고려해 생성된 리소스 핵심 정보 반환을 우선 검토한다.

---

## 9. 에러 응답 규칙

### 9.1 기본 원칙

- 에러 응답 구조는 성공 응답과 별개로 일관되게 유지한다.
- 사용자 메시지와 내부 상세 정보는 분리한다.
- 예외의 기술 세부를 외부에 그대로 노출하지 않는다.

---

### 9.2 기본 에러 응답 예시

예시:

    {
      "success": false,
      "error": {
        "code": "POST_NOT_FOUND",
        "message": "게시글을 찾을 수 없습니다."
      }
    }

필요 시 확장:

    {
      "success": false,
      "error": {
        "code": "VALIDATION_ERROR",
        "message": "입력값이 올바르지 않습니다.",
        "details": [
          {
            "field": "title",
            "reason": "must not be blank"
          }
        ]
      }
    }

---

### 9.3 HTTP Status 기준

기본적으로 아래 기준을 따른다.

- `200 OK`
  - 정상 조회/수정
- `201 Created`
  - 생성 성공
- `204 No Content`
  - 응답 본문 없는 삭제 성공
- `400 Bad Request`
  - 잘못된 요청/검증 실패
- `401 Unauthorized`
  - 인증 필요
- `403 Forbidden`
  - 권한 부족
- `404 Not Found`
  - 리소스 없음
- `409 Conflict`
  - 상태 충돌, 중복 등
- `500 Internal Server Error`
  - 서버 내부 오류

---

### 9.4 Validation 에러 규칙

입력값 검증 실패는 가능한 한 `400 Bad Request`로 응답한다.

예시 구조:
- 공통 메시지
- 필드별 오류 목록
- 코드 포함 가능

Validation 세부 기준은 후속 `exception-standard.md` 작성 시 함께 맞춘다.

---

## 10. 페이징 / 정렬 / 검색 규칙

### 10.1 페이징

기본 파라미터:
- `page`
- `size`

기본 원칙:
- `page`는 1부터 시작할지 0부터 시작할지 프로젝트 전체에서 통일한다.
- 현재 단계에서는 사용자 친화성을 고려해 1부터 시작하는 방식을 우선 검토한다.
- `size`의 최대값은 제한한다.

---

### 10.2 정렬

기본 파라미터:
- `sort`

예:
- `sort=createdAt,desc`
- `sort=title,asc`

여러 개 정렬이 실제 필요해질 때 확장한다.

---

### 10.3 검색

검색은 단순한 query parameter부터 시작한다.

예:
- `keyword`
- `status`
- `authorUserId`
- `boardId`

복잡한 검색 조건 객체는 실제 필요가 생길 때 도입한다.

---

## 11. 파일 / 첨부 API 기준

초기 단계에서는 파일 업로드 자체보다 첨부파일 메타데이터 API를 먼저 단순하게 다룬다.

예:
- `/posts/{postId}/attachments`
- `/attachments/{attachmentId}`

실제 바이너리 업로드/다운로드 규칙은 필요 시 별도 표준으로 분리할 수 있다.

---

## 12. 버전 관리 기준

현재 단계에서는 API 버전을 URL에 바로 넣는 것을 기본으로 하지 않는다.

예:
- 우선: `/posts`
- 필요 시 도입: `/api/v1/posts`

버전이 실제로 필요해질 때 아래 중 하나를 선택한다.

- URL 버전
- 헤더 버전
- 별도 서비스 버전 정책

지금은 버전 체계를 미리 과도하게 도입하지 않는다.

---

## 13. 문서화 기준

- API는 문서와 실제 URL이 일치해야 한다.
- controller 메서드 이름 변경 시 외부 API가 바뀌지 않도록 주의한다.
- API 문서에는 최소한 다음이 있어야 한다.
  - URL
  - HTTP method
  - 요청 DTO
  - 응답 DTO
  - 에러 응답
  - 인증/권한 필요 여부

---

## 14. 금지 또는 지양 규칙

다음을 지양한다.

- controller/action 이름을 그대로 외부 URL로 노출하는 것
- `savePost`, `deletePost` 같은 action형 URL 남용
- Request/Response 없이 map 기반으로 무분별하게 입출력 처리
- Entity를 API 응답으로 직접 노출하는 것
- 성공 응답 구조와 실패 응답 구조를 제각각 만드는 것
- 목록 응답에서 페이징 구조를 매번 다르게 만드는 것
- Grails식 메서드 관례만 믿고 명시적 URL 매핑 기준을 방치하는 것
- 지금 필요 없는 버전 전략을 과하게 먼저 도입하는 것

---

## 15. 현재 단계 적용 기준

현재 단계에서는 Spring Boot 기반의 레이어드 게시판을 빠르게 시작하되,  
나중에 공통 모듈 분리나 구조 전환이 가능하도록 최소한의 API 일관성을 유지하는 것을 목표로 한다.

따라서 현재는 다음을 우선한다.

- 리소스 중심 복수형 URL 사용
- controller 메서드 스타일과 외부 URL 분리
- 명시적 URL 매핑 기준의 관리
- Request/Response DTO 기반 입출력
- 일관된 성공/실패 응답 구조 유지
- 목록/상세/생성/수정/삭제 패턴 통일
- Validation과 비즈니스 예외 응답 구조 일관성 유지

즉, 현재 단계의 API 표준은  
미래의 모든 API 전략을 미리 완성하는 것이 아니라,  
초기 게시판 구현이 흔들리지 않도록 하는 최소한의 공통 API 기준을 먼저 고정하는 데 목적이 있다.
