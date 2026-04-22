# naming-standard.md

## 1. 문서 목적

이 문서는 초기 게시판 프로젝트에서 사용하는 공통 이름 규칙을 정의한다.

주요 목적은 다음과 같다.

- 프로젝트 전반에서 사용하는 용어를 통일한다.
- 자바 코드, DB, API, 문서 사이의 이름 불일치를 줄인다.
- 도메인 용어와 기술 용어가 섞여 혼동되는 것을 방지한다.
- Spring Boot 기반 프로젝트에서 controller/action 스타일, URL, DTO, DB 이름 규칙을 일관되게 유지한다.
- 이후 공통 모듈 분리 또는 헥사고날 전환 시 기준이 되는 이름 체계를 먼저 고정한다.

이 문서는 개별 클래스 구현 방법을 설명하는 문서가 아니라,  
**프로젝트 전반에서 어떤 이름을 어떤 기준으로 사용할지 정의하는 공통 표준 문서**이다.

---

## 2. 기본 원칙

이 프로젝트의 이름 규칙은 다음 원칙을 따른다.

- 이름은 짧더라도 의미가 분명해야 한다.
- 같은 개념에는 같은 이름을 사용한다.
- 자바, DB, API, 문서에서 가능한 한 같은 용어를 유지한다.
- 기술 구현 관점보다 업무/도메인 관점 이름을 우선한다.
- 약어는 정말 널리 통용되는 경우에만 사용한다.
- 임시성, 모호성, 축약 위주의 이름을 피한다.
- suffix는 역할 구분이 필요한 경우에만 사용한다.
- 처음부터 미래 확장을 과하게 반영한 이름은 피한다.
- Spring Boot를 사용하되 controller/action 스타일에서 Grails식 관례를 참고하더라도 도메인 용어를 흔들지 않는다.

---

## 3. 도메인 용어 기준

초기 게시판 프로젝트에서는 아래 도메인 용어를 기본으로 사용한다.

- `Board`
  - 게시판 자체
- `Post`
  - 게시글
- `Comment`
  - 댓글
- `User`
  - 사용자
- `Attachment`
  - 첨부파일
- `Category`
  - 게시글 분류 또는 게시판 분류
- `Permission`
  - 권한
- `Role`
  - 역할

### 3.1 용어 선택 원칙

- 게시글은 `Article`보다 `Post`를 우선한다.
- 댓글은 `Reply`보다 `Comment`를 우선한다.
- 사용자 권한은 `Auth`보다 `Permission`, `Role`을 우선 사용한다.
- 첨부파일은 `File`보다 의미가 분명한 경우 `Attachment`를 우선 사용한다.
- 화면이나 기술 구현에 따라 용어를 바꾸지 않는다.

예:

- 자바 클래스에서 `Post`
- DB 테이블에서 `post`
- API 경로에서 `/posts`
- 문서에서도 `Post`

같은 개념은 가능한 한 같은 이름을 유지한다.

---

## 4. 자바 이름 규칙

### 4.1 패키지명

- 모두 소문자를 사용한다.
- 단어는 점(`.`)으로 계층을 구분한다.
- 불필요한 축약은 피한다.

예:

- `kr.co.butgo.board`
- `kr.co.butgo.board.post`
- `kr.co.butgo.board.comment`

지양 예:

- `kr.co.butgo.brd`
- `kr.co.butgo.common.util2`

---

### 4.2 클래스명

- PascalCase를 사용한다.
- 클래스명은 명사 또는 명사구를 사용한다.
- 역할이 명확한 suffix만 사용한다.

예:

- `Post`
- `PostController`
- `PostFacade`
- `PostService`
- `PostRepository`
- `PostEntity`
- `PostCreateRequest`
- `PostDetailResponse`

지양 예:

- `PostMgr`
- `PostProc`
- `PostHandle`
- `CommonPostThing`

---

### 4.3 메서드명

- camelCase를 사용한다.
- 동사로 시작한다.
- 가능한 한 한눈에 의도가 드러나야 한다.

예:

- `createPost`
- `updatePost`
- `deletePost`
- `getPost`
- `getPostList`
- `validatePermission`

지양 예:

- `doPost`
- `handle`
- `process`
- `work`
- `executeSomething`

---

### 4.4 변수명 / 필드명

- camelCase를 사용한다.
- 자료형보다 의미를 우선한다.
- 단수/복수를 구분한다.

예:

- `post`
- `postList`
- `commentCount`
- `createdAt`

지양 예:

- `obj`
- `data`
- `item`
- `list1`

---

## 5. 역할별 suffix 규칙

suffix는 역할 구분이 필요할 때만 사용한다.

### 5.1 허용하는 대표 suffix

- `Controller`
- `Facade`
- `Service`
- `Repository`
- `Entity`
- `Request`
- `Response`
- `Dto`
- `Command`
- `Result`
- `Mapper`
- `Config`

### 5.2 사용 기준

- Entry 계층은 `Controller`
- 요청 단위 흐름 조합은 `Facade`
- 업무 규칙 단위 처리는 `Service`
- DB 접근은 `Repository`
- JPA 영속 모델은 `Entity`
- API 입력은 `Request`
- API 출력은 `Response`

### 5.3 지양 suffix

- `Manager`
- `Helper`
- `Util`
- `Processor`
- `Handler`

단, 프레임워크나 기술적으로 의미가 고정된 경우는 예외로 둘 수 있다.

---

## 6. Facade / Service / Repository 이름 규칙

현재 레이어드 구조에서는 아래 기준을 따른다.

### 6.1 Facade

- 요청 또는 화면 단위 흐름 조합 책임
- 이름은 보통 도메인명 + `Facade`
- 필요 시 기능 단위 이름 사용 가능

예:

- `PostFacade`
- `CommentFacade`
- `BoardAdminFacade`

### 6.2 Service

- 업무 규칙 처리 책임
- 이름은 도메인명 + `Service`
- 너무 많은 책임이 모이면 기능 단위로 나눈다

예:

- `PostService`
- `CommentService`
- `PermissionService`

### 6.3 Repository

- 영속성 접근 책임
- 이름은 도메인명 + `Repository`

예:

- `PostRepository`
- `CommentRepository`
- `UserRepository`

### 6.4 이름 선택 원칙

- `Facade`와 `Service`를 이름만 다르게 두고 같은 책임으로 쓰지 않는다.
- `PostFacade`, `PostService`가 둘 다 전체 게시글 흐름을 모두 처리하면 안 된다.
- 이름이 다르면 책임도 달라야 한다.

---

## 7. DTO 이름 규칙

DTO는 역할이 이름에 드러나야 한다.

### 7.1 Request / Response 우선

API 관점에서는 아래를 우선 사용한다.

- `PostCreateRequest`
- `PostUpdateRequest`
- `PostListResponse`
- `PostDetailResponse`

### 7.2 Dto suffix 사용 기준

`Dto`는 내부 계층 전달 모델에서만 제한적으로 사용한다.

예:

- `PostSummaryDto`
- `CommentAuthorDto`

지양:

- 모든 DTO를 무조건 `PostDto`, `CommentDto`처럼 뭉뚱그리는 방식

### 7.3 Command / Result 사용 기준

내부 흐름에서 요청/결과 모델을 분리하고 싶을 때 사용할 수 있다.

예:

- `CreatePostCommand`
- `UpdatePostCommand`
- `PostCreateResult`

초기 단계에서는 Request / Response만으로 충분하면 억지로 늘리지 않는다.

---

## 8. Controller / Action 스타일 이름 규칙

현재 프로젝트는 온전한 Spring Boot 기반 레이어드 구조를 사용한다.  
다만 API와 컨트롤러 메서드 스타일을 정할 때는 Grails식 controller/action 관례를 참고하므로, 아래 이름 규칙을 따른다.

### 8.1 Controller 이름 규칙

- 도메인명 + `Controller` 형식을 기본으로 한다.
- Controller 이름은 요청 진입점 역할을 드러내야 한다.
- 화면/관리 기능이 명확히 다르면 기능명을 추가할 수 있다.

예:

- `PostController`
- `CommentController`
- `BoardAdminController`

지양 예:

- `PostMgrController`
- `CommonController`
- `MainProcessController`

---

### 8.2 Action 이름 규칙

- controller 메서드 이름은 소문자 camelCase를 사용한다.
- 가능하면 Grails식 action 관례와 REST 의미가 함께 맞는 이름을 사용한다.
- 메서드 이름은 controller 내부 요청 단위 흐름을 드러내야 한다.

기본 예:

- `index`
- `show`
- `save`
- `update`
- `delete`

필요 시 예:

- `createForm`
- `editForm`
- `publish`
- `downloadAttachment`

### 8.3 Action 이름 사용 원칙

- 단순 목록 조회는 `index`
- 단건 조회는 `show`
- 생성은 `save`
- 수정은 `update`
- 삭제는 `delete`

추가 동작은 정말 필요할 때만 별도 action 이름을 둔다.

지양 예:

- `doSave`
- `postSaveAction`
- `procUpdate`
- `deleteProc`

---

### 8.4 Grails 관례와 도메인 용어 충돌 시 원칙

- controller 메서드 이름은 Grails식 관례를 참고하되, 도메인 이름은 업무 용어를 유지한다.
- 예를 들어 메서드 이름은 `save`를 써도, 도메인 객체 이름은 `Post`를 유지한다.
- 기술적 편의를 위해 도메인 용어를 `Data`, `Item`, `Info`처럼 흐리게 바꾸지 않는다.

---

## 9. Enum 이름 규칙

- Enum 클래스는 PascalCase
- Enum 값은 UPPER_SNAKE_CASE

예:

- `PostStatus`
- `UserRole`

Enum 값 예:

- `DRAFT`
- `PUBLISHED`
- `DELETED`

지양 예:

- `draft`
- `PublishDone`
- `DEL_YN`

---

## 10. DB 이름 규칙

### 10.1 테이블명

- 소문자 snake_case
- 단수형을 기본으로 한다
- 의미가 분명한 명사 사용

예:

- `post`
- `comment`
- `user_account`
- `board_category`

초기 단계에서는 단수형을 기본으로 고정한다.

---

### 10.2 컬럼명

- 소문자 snake_case
- 자바 필드명과 의미를 맞춘다

예:

- `post_id`
- `board_id`
- `created_at`
- `updated_at`
- `deleted_at`
- `comment_count`

지양 예:

- `postid`
- `crt_dt`
- `updDtm`

---

### 10.3 PK / FK 이름

PK 컬럼은 `<table>_id` 형식을 기본으로 한다.

예:

- `post_id`
- `comment_id`
- `user_id`

FK도 참조 대상 의미가 드러나게 한다.

예:

- `post_id`
- `author_user_id`

---

## 11. API / URL 이름 규칙

### 11.1 URI

- 복수형 명사를 기본으로 한다
- 리소스 중심으로 설계한다
- 소문자 kebab-case 또는 소문자 단어 사용
- 일관성을 위해 초기에는 소문자 복수형만 사용한다

예:

- `/posts`
- `/posts/{postId}`
- `/posts/{postId}/comments`

### 11.2 URL segment 이름 규칙

- URL path segment는 도메인 용어와 맞춘다.
- Controller/action 이름과 직접 1:1로 맞추기보다 리소스 이름을 우선한다.
- URL은 가능한 한 도메인 관점에서 읽혀야 한다.

예:

- `PostController.show` → `/posts/{postId}`
- `CommentController.save` → `/posts/{postId}/comments`

지양 예:

- `/postController/show`
- `/boardProc/savePost`

### 11.3 JSON 필드명

- camelCase를 사용한다
- 자바 DTO 필드명과 의미를 맞춘다

예:

- `postId`
- `createdAt`
- `commentCount`

---

## 12. 문서 이름 규칙

- 문서 파일명은 소문자 kebab-case를 기본으로 한다
- 역할이 드러나는 이름을 사용한다
- index 문서는 `*-index.md` 형식을 사용할 수 있다
- 표준 문서는 `*-standard.md` 형식을 사용한다

예:

- `naming-standard.md`
- `java-coding-standard.md`
- `package-structure-standard.md`
- `standards-index.md`

---

## 13. 약어 사용 기준

약어는 아래 기준으로 제한한다.

### 13.1 허용 가능한 약어 예

- `API`
- `DTO`
- `URL`
- `ID`
- `DB`

### 13.2 지양하는 약어 예

- `Mgr`
- `Svc`
- `Proc`
- `ReqDto`
- `RespDto`

이름 길이를 줄이기 위한 임의 축약은 피한다.

---

## 14. 금지 또는 지양 규칙

다음을 지양한다.

- 같은 개념에 문서마다 다른 이름 사용
- 기술 구현에 따라 도메인 이름이 바뀌는 것
- 책임이 다른 계층에 비슷한 이름을 대충 붙이는 것
- `Common`, `Base`, `General`, `Util` 같은 모호한 이름 남용
- 의미 없는 약어 남용
- 임시 이름을 장기간 유지하는 것
- Controller/action 이름을 그대로 URL로 노출하는 것
- Grails식 메서드 관례를 이유로 도메인 용어를 흐리는 것

---

## 15. 현재 단계 적용 기준

초기 게시판 프로젝트에서는 이름부터 먼저 통일해야 한다.

이름이 흔들리면 다음이 모두 흔들린다.

- 자바 코드 구조
- DB 설계
- API 설계
- controller/action 스타일 구조
- 예외 코드
- 테스트 이름
- 문서 용어

따라서 현재 단계에서는  
기능 구현보다 먼저 **도메인 용어, 클래스 역할 이름, controller/action 스타일 이름, DB/API 이름 규칙**을 공통 기준으로 고정하는 것을 우선한다.
