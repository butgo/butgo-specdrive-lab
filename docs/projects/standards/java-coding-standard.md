# java-coding-standard.md

## 1. 문서 목적

이 문서는 초기 게시판 프로젝트에서 사용할 자바 코딩 표준을 정의한다.

주요 목적은 다음과 같다.

- 코드 작성 방식의 일관성을 유지한다.
- 레이어드 구조에서 controller, facade, service, repository의 책임 혼선을 줄인다.
- DTO, Entity, Enum, 공통 클래스 작성 기준을 통일한다.
- 이후 공통 모듈 분리나 헥사고날 전환 시에도 유지 가능한 최소 코딩 규칙을 먼저 고정한다.
- AI 협업 시 코드 스타일과 구조 판단 기준을 통일한다.

이 문서는 특정 프레임워크 기능 사용법을 설명하는 문서가 아니라,  
**프로젝트 전반에서 어떤 방식으로 자바 코드를 작성할지 정의하는 공통 표준 문서**이다.

---

## 2. 기본 원칙

이 프로젝트의 자바 코드는 다음 원칙을 따른다.

- 코드는 짧은 것보다 읽기 쉬운 것이 우선이다.
- 한 클래스와 한 메서드는 가능한 한 하나의 주된 책임을 가진다.
- 이름으로 역할이 드러나야 한다.
- 구조를 숨기는 편의 코드보다 명시적인 코드가 낫다.
- 공통 규칙은 반복 구현보다 표준으로 먼저 해결한다.
- 프레임워크 편의보다 도메인 의미와 책임 경계를 우선한다.
- 현재 단계에 필요한 수준만 구현하고, 미래 확장을 위한 과도한 일반화는 피한다.
- AI가 생성한 코드라도 사람이 바로 읽고 수정할 수 있어야 한다.

---

## 3. 공통 작성 규칙

### 3.1 클래스 크기

- 클래스는 너무 많은 책임을 가지지 않도록 유지한다.
- 하나의 클래스가 controller, facade, service, repository 역할을 동시에 가져서는 안 된다.
- 한 클래스 안에 unrelated 기능이 함께 들어가기 시작하면 분리를 우선 검토한다.

### 3.2 메서드 크기

- 메서드는 가능한 한 한눈에 흐름을 이해할 수 있는 수준으로 유지한다.
- 분기와 반복이 많아지는 경우, 의미 있는 private 메서드로 분리한다.
- 단순 분리보다 “이름으로 의도가 드러나는 분리”를 우선한다.

### 3.3 파라미터 수

- 파라미터가 많아지면 Request, Command, Criteria 같은 모델 도입을 검토한다.
- boolean 플래그를 여러 개 받는 메서드는 지양한다.
- null 허용 여부가 불분명한 파라미터는 지양한다.

### 3.4 반환값

- 반환값은 의미가 분명해야 한다.
- 성공/실패/결과 의미가 모호하면 전용 Result 객체 사용을 검토한다.
- `Map`, `Object`, `Serializable` 같은 모호한 반환 타입은 지양한다.

---

## 4. 패키지 및 계층 기준

현재 단계에서는 레이어드 구조를 기준으로 다음 책임을 따른다.

- `controller`
  - HTTP 요청 수신, 입력 전달, 응답 반환
- `facade`
  - 요청 단위 흐름 조합
- `service`
  - 업무 규칙 처리
- `repository`
  - DB 접근
- `domain`
  - 도메인 개념 및 규칙
- `entity`
  - JPA 영속 모델
- `dto`
  - 요청/응답 및 내부 전달 모델
- `config`
  - 설정 및 스프링 빈 구성
- `exception`
  - 예외 및 에러 코드 정의

### 4.1 controller 규칙

- controller는 직접 핵심 비즈니스 로직을 처리하지 않는다.
- controller는 facade 호출을 기본으로 한다.
- 요청 파라미터 검증, 인증 정보 수집, 응답 반환 역할에 집중한다.
- repository를 controller에서 직접 호출하지 않는다.

### 4.2 facade 규칙

- facade는 요청 단위 흐름 조합을 담당한다.
- 하나의 요청에서 여러 service 호출을 조합할 수 있다.
- facade는 화면/요청 단위 orchestration을 담당한다.
- facade가 domain 규칙의 원천이 되어서는 안 된다.

### 4.3 service 규칙

- service는 업무 규칙과 처리 단위를 담당한다.
- service는 가능한 한 업무 의미 중심으로 나눈다.
- service끼리의 무분별한 순환 호출은 지양한다.
- service가 controller 관심사나 응답 포맷 관심사를 가져서는 안 된다.

### 4.4 repository 규칙

- repository는 영속성 접근 책임만 가진다.
- repository는 비즈니스 흐름 조합을 하지 않는다.
- 쿼리 의도는 메서드 이름으로 최대한 드러나야 한다.
- controller나 facade에서 repository 직접 호출은 지양한다.

---

## 5. 클래스 유형별 작성 기준

### 5.1 Controller

- 클래스명은 `*Controller`
- action 성격의 메서드는 요청 의미를 드러내야 한다.
- HTTP 세부는 controller에 두고, 업무 판단은 facade/service에 둔다.
- 응답은 Response DTO 또는 공통 응답 모델로 변환한다.

예:
- `PostController`
- `CommentController`

### 5.2 Facade

- 클래스명은 `*Facade`
- 요청 단위 처리 흐름을 조합한다.
- 트랜잭션 경계가 facade에 필요한지 여부는 명시적으로 판단한다.
- 여러 service 호출을 묶되, facade가 비대해지면 기능 단위 분리를 검토한다.

예:
- `PostFacade`
- `BoardAdminFacade`

### 5.3 Service

- 클래스명은 `*Service`
- 도메인 규칙과 업무 처리 단위를 담당한다.
- 하나의 service가 너무 많은 use case를 품지 않도록 주의한다.
- 가능한 한 기술 세부보다 업무 의미가 드러나는 메서드명을 쓴다.

예:
- `PostService`
- `CommentService`

### 5.4 Repository

- 클래스명은 `*Repository`
- JPA Repository 또는 그에 준하는 저장소 역할을 맡는다.
- 커스텀 쿼리가 많아지면 별도 구현체 분리를 검토한다.
- repository는 service/facade의 하위 영속성 계층임을 유지한다.

### 5.5 Entity

- 클래스명은 `*Entity`를 기본으로 사용한다.
- Domain 모델과 JPA Entity를 구분할 필요가 커지면 그때 분리한다.
- 현재 단계에서는 JPA Entity 중심으로 시작할 수 있다.
- Entity는 persistence 편의를 위해 과도한 비즈니스 로직을 품지 않는다.

예:
- `PostEntity`
- `CommentEntity`

### 5.6 DTO

- API 입력은 `*Request`
- API 출력은 `*Response`
- 내부 전달은 필요 시 `*Dto`, `*Command`, `*Result`를 사용한다.
- 모든 전달 모델을 `Dto` 하나로 뭉뚱그리지 않는다.

예:
- `PostCreateRequest`
- `PostUpdateRequest`
- `PostDetailResponse`
- `CreatePostCommand`

### 5.7 Enum

- Enum 클래스명은 의미가 드러나는 명사를 사용한다.
- 상태값, 역할값, 타입값은 Enum으로 우선 검토한다.
- DB 코드값과 Enum 이름은 문서 기준에 맞게 일관되게 유지한다.

예:
- `PostStatus`
- `UserRole`

---

## 6. 생성자와 객체 생성 기준

### 6.1 생성자 사용 원칙

- 의존성 주입 대상 클래스는 생성자 주입을 기본으로 한다.
- 필드 주입은 사용하지 않는다.
- 테스트 가능성과 불변성을 위해 final 필드를 우선한다.

### 6.2 정적 팩토리 사용 기준

- 생성 의도가 이름으로 드러나야 할 때 정적 팩토리를 사용할 수 있다.
- 단순 생성만 하는 경우 무조건 정적 팩토리로 감싸지 않는다.
- Entity 생성과 DTO 생성 규칙은 과도하게 복잡하게 만들지 않는다.

예:
- `PostEntity.of(...)`
- `PostDetailResponse.from(...)`

### 6.3 Builder 사용 기준

- 필드가 많고 의미가 분명할 때만 Builder를 사용한다.
- 필드 수가 적고 의미가 단순하면 생성자를 우선한다.
- Builder가 오히려 객체 생성 규칙을 숨기지 않도록 주의한다.

---

## 7. Lombok 사용 기준

Lombok은 허용하되, 무분별하게 사용하지 않는다.

### 7.1 허용 기준

- `@Getter`
- `@Setter`는 꼭 필요한 경우에만 사용
- `@RequiredArgsConstructor`
- `@NoArgsConstructor`, `@AllArgsConstructor`는 용도를 분명히 할 때만 사용
- `@Builder`는 대상이 명확할 때만 사용

### 7.2 지양 기준

- Entity에 `@Data` 사용
- 무조건적인 `@Setter` 남용
- equals/hashCode/toString이 민감한 객체에 `@Data` 사용
- 생성 규칙이 중요한 객체를 Lombok 편의성만으로 단순화하는 것

### 7.3 Entity에서의 원칙

- JPA Entity는 최소한의 Lombok만 사용한다.
- Entity 상태 변경 메서드는 의미 있는 메서드로 드러나는 편을 우선한다.
- 필드 변경을 무차별 `setXxx()`로 열어두는 방식은 지양한다.

---

## 8. null / Optional 기준

### 8.1 null 처리 원칙

- null 허용 여부는 명확해야 한다.
- null을 방치한 채 하위 계층으로 넘기지 않는다.
- “없음”을 의미하는 값을 null 하나에만 의존하지 않는다.

### 8.2 Optional 사용 기준

- 메서드 반환에서 “없을 수 있음”을 표현할 때 Optional을 사용할 수 있다.
- 필드 타입으로 Optional은 사용하지 않는다.
- 파라미터 타입으로 Optional은 사용하지 않는다.

예:
- `Optional<PostEntity> findById(Long postId)`

지양:
- `private Optional<String> title;`
- `void update(Optional<String> title)`

---

## 9. Collection / Stream 기준

### 9.1 Collection

- 컬렉션 타입은 가능한 한 인터페이스 타입으로 선언한다.
- null 컬렉션보다 빈 컬렉션을 우선한다.
- 컬렉션 반환은 호출자가 의미를 쉽게 이해할 수 있어야 한다.

### 9.2 Stream

- Stream은 가독성을 해치지 않는 범위에서만 사용한다.
- 복잡한 중첩 Stream은 지양한다.
- 조건 분기, 예외 처리, 부수효과가 많은 경우 일반 반복문이 더 낫다.

좋은 예:
- 단순 filter/map/collect

지양 예:
- 긴 체인 + 복잡한 람다 + 예외 처리 혼합

---

## 10. 예외 처리 기준

- 예외는 삼키지 않는다.
- `catch (Exception e)`로 모든 예외를 뭉뚱그리지 않는다.
- 비즈니스 예외와 시스템 예외를 구분한다.
- 예외 메시지는 사용자 노출용과 내부 로그용을 구분한다.
- 예외 처리의 상세 규칙은 후속 `exception-standard.md` 작성 시 연결한다.

### 10.1 금지 예시

- 단순 로그 출력 후 무시
- null 반환으로 예외 상황 숨기기
- 의미 없는 RuntimeException 재포장

---

## 11. 주석 기준

### 11.1 기본 원칙

- 자명한 코드를 설명하는 주석은 쓰지 않는다.
- 왜 이렇게 작성했는지 이해에 도움이 되는 주석을 우선한다.
- 구조 의도, 경계 조건, 예외적 판단 이유를 설명할 때 주석을 쓴다.

### 11.2 허용되는 주석 예

- facade와 service 책임 분리 이유
- 특정 검증 순서의 이유
- DB 제약 또는 외부 시스템 제약 설명
- 현재 단계에서 일부러 일반화하지 않은 이유

### 11.3 지양되는 주석 예

- `i++ // i 증가`
- `save 호출 // 저장`
- 코드만 읽어도 바로 아는 반복 설명

---

## 12. 상수 / 공통 값 기준

- 의미 있는 상수는 이름을 부여한다.
- 문자열 리터럴을 여러 곳에서 반복하지 않는다.
- 다만 한 번만 쓰는 값을 무조건 상수로 빼지 않는다.
- 상수는 사용 범위가 좁으면 가까운 위치에 둔다.
- 전역 상수 클래스 남용은 지양한다.

---

## 13. 테스트 친화성 기준

- 테스트하기 어려운 구조는 다시 검토한다.
- 숨은 static 의존성, 전역 상태, 과도한 프레임워크 결합을 지양한다.
- controller, facade, service는 각 계층 책임에 맞게 분리해 테스트 가능해야 한다.
- 테스트 상세 기준은 후속 `test-standard.md` 작성 시 연결한다.

---

## 14. 금지 또는 지양 규칙

다음을 지양한다.

- controller에서 직접 repository 호출
- facade 없이 controller에서 여러 service를 과도하게 조합
- service에서 HTTP 요청/응답 관심사 처리
- repository에서 비즈니스 규칙 판단
- Entity에 과도한 setter 남용
- 모든 전달 모델을 `Dto` 하나로 뭉뚱그리는 것
- 의미 없는 접두사/접미사 남용
- util 클래스에 업무 로직을 몰아넣는 것
- 미래 확장을 이유로 현재 필요 없는 추상화를 먼저 도입하는 것

---

## 15. 현재 단계 적용 기준

현재 단계에서는 레이어드 게시판을 빠르게 시작하되,  
나중에 헥사고날 전환이 가능하도록 최소한의 책임 경계를 유지하는 것을 목표로 한다.

따라서 현재는 다음을 우선한다.

- controller → facade → service → repository 흐름 유지
- facade와 service 책임 분리
- 요청/응답 DTO와 Entity 역할 구분
- Grails 및 스프링 기반 코드 작성 시에도 도메인 용어 일관성 유지
- 과도한 공통화와 추상화보다 명확한 구조 우선

즉, 현재 단계의 자바 코딩 표준은  
미래 구조를 완성해 두는 것이 아니라,  
**초기 게시판 구현이 흔들리지 않도록 하는 최소한의 공통 기준**을 먼저 고정하는 데 목적이 있다.
