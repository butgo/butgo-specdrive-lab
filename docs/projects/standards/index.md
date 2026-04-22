# docs/projects/standards/index.md

## 1. 문서 목적

이 문서는 `docs/projects/standards/**` 아래에서 관리하는 **프로젝트 공통 개발 표준 문서군의 인덱스 문서**다.

목적은 다음과 같다.

- 현재 관리 대상인 표준 문서 목록을 정리한다.
- 각 표준 문서의 역할과 범위를 구분한다.
- 어떤 표준 문서를 먼저 작성하거나 먼저 읽어야 하는지 안내한다.
- 개별 프로젝트 문서와 공통 표준 문서의 경계를 분명히 한다.
- 현재 단계에서 필요한 최소 공통 기준 세트를 고정한다.

이 문서는 각 표준 문서의 상세 본문을 모두 설명하지 않는다.  
상세 내용은 개별 표준 문서를 따른다.

---

## 2. standards를 무엇으로 보는가

`docs/projects/standards/**` 는  
projects 하위에서 여러 애플리케이션 프로젝트가 공통으로 참조할 수 있는  
**프로젝트 공통 개발 기준 문서군**이다.

이 문서군은 다음 역할을 가진다.

- 프로젝트마다 반복되는 공통 판단 기준을 정리한다.
- 구현 전에 공통 규칙을 먼저 고정해 팀/AI의 편차를 줄인다.
- 개별 프로젝트 문서가 공통 규칙을 중복 설명하지 않게 한다.
- specdrive 방식으로 실제 프로젝트를 운영할 때 필요한 공통 기준을 제공한다.

즉 standards는  
**무엇을 만들 것인가**를 직접 정의하지 않고,  
**어떤 공통 기준으로 만들 것인가**를 정의한다.

---

## 3. specdrive / projects / standards의 관계

현재 저장소에서는 specdrive, projects, standards가 함께 존재하지만 역할은 다르다.

### 3.1 specdrive
specdrive는 다음을 다룬다.

- 문서 기반 AI 협업 흐름
- 세션 시작과 문맥 복구
- 문서 보강 / 확정 / 히스토리 저장 절차
- task 분해와 상태 관리 흐름
- CLI 명령 구조
- 협업 운영 규칙

즉 specdrive는  
**어떻게 협업할 것인가**를 다룬다.

### 3.2 projects
projects는 다음을 다룬다.

- 요구사항
- 설계
- 구현 계획
- 상태
- 히스토리
- 프로젝트별 판단과 결정 사항

즉 projects는  
**무엇을 만들 것인가**를 다룬다.

### 3.3 standards
standards는 다음을 다룬다.

- naming
- coding style
- db
- api
- package structure
- git policy
- 후속 확장 표준 후보

즉 standards는  
**애플리케이션 개발 시 어떤 공통 기준을 따를 것인가**를 다룬다.

### 3.4 혼합 금지
- specdrive 문서 안에 standards 상세 본문을 넣지 않는다.
- standards 문서 안에 특정 프로젝트 상세 설계를 넣지 않는다.
- 개별 프로젝트 문서 안에 standards 본문을 길게 중복 복사하지 않는다.

---

## 4. 현재 기준 핵심 방향

현재 standards 문서군은 다음 방향을 기준으로 한다.

- 초기 구현은 **레이어드 아키텍처**를 기준으로 시작한다.
- 초기 레이어드 구조에서는 `controller → facade → service → repository` 중심 흐름을 사용한다.
- 이후 필요 시 헥사고날 전환을 검토할 수 있다.
- 지금 단계에서는 과도한 일반화보다 실제 구현에 바로 영향을 주는 표준을 먼저 고정한다.
- 공통 판단 기준이 없는 상태에서 구현이 제각각 흩어지는 것을 방지한다.
- 현재는 board 같은 실제 프로젝트가 흔들림 없이 시작될 수 있는 **실행 가능한 공통 기준**을 먼저 정리한다.

이 관점은 현재 정리된 표준 문서 방향과도 일치한다.

---

## 5. 현재 관리 대상 표준 문서 목록

현재 단계에서 관리 대상으로 두는 표준 문서는 다음과 같다.

1. `docs/projects/standards/naming-standard.md`
2. `docs/projects/standards/java-coding-standard.md`
3. `docs/projects/standards/db-standard.md`
4. `docs/projects/standards/api-standard.md`
5. `docs/projects/standards/package-structure-standard.md`
6. `docs/projects/standards/git-policy.md`
7. `docs/projects/standards/index.md`

---

## 6. 문서별 역할

### 6.1 `naming-standard.md`
역할:
- 프로젝트 전반에서 사용하는 이름 규칙을 통일한다.

주요 범위:
- 도메인 용어 기준
- 클래스명 규칙
- 메서드명 규칙
- DTO / Entity / VO / Enum 이름 규칙
- Facade / Service / Repository 이름 규칙
- 테이블 / 컬럼 이름 규칙
- API 경로 명명 기준
- 약어 사용 기준

비고:
- 이 문서는 다른 표준 문서의 공통 바탕이 된다.
- 이름이 흔들리면 자바, DB, API 표준이 서로 어긋나기 쉬우므로 가장 먼저 정리하는 것을 권장한다.

---

### 6.2 `java-coding-standard.md`
역할:
- 자바 코드 작성 방식과 클래스 책임 기준을 통일한다.

주요 범위:
- 클래스 / 메서드 / 필드 작성 원칙
- 생성자 / 정적 팩토리 사용 기준
- Lombok 사용 기준
- null 처리 기준
- Optional 사용 기준
- Stream 사용 기준
- DTO / Entity / VO 작성 기준
- Facade / Service / Repository 작성 기준
- 주석 작성 기준

비고:
- 이 문서는 코드 스타일만이 아니라 구조적 일관성을 유지하기 위한 기준으로 사용한다.
- 특히 Facade는 요청/화면 단위 흐름 조합, Service는 업무 규칙 단위 처리라는 책임 차이를 분명히 해야 한다.

---

### 6.3 `db-standard.md`
역할:
- 데이터베이스 구조와 테이블 설계 기준을 통일한다.

주요 범위:
- 테이블명 규칙
- 컬럼명 규칙
- PK / FK 기준
- 인덱스 기준
- 공통 컬럼 기준
- `created_at / updated_at / deleted` 처리 기준
- 상태값 / 코드값 처리 기준
- nullable 기준
- 타입 사용 기준

비고:
- 게시판 프로젝트뿐 아니라 이후 다른 프로젝트나 공통 모듈 분리 시에도 재사용될 수 있는 기준 문서다.

---

### 6.4 `api-standard.md`
역할:
- API 설계와 요청/응답 규칙을 통일한다.

주요 범위:
- URI 규칙
- HTTP Method 사용 기준
- 요청 DTO 규칙
- 응답 DTO 규칙
- 공통 응답 구조 여부
- 성공 응답 형식
- 에러 응답 형식
- 페이징 / 검색 / 정렬 규칙
- 버전 관리 기준

비고:
- 초기 프로젝트에서 반드시 필요한 문서다.
- 예외 처리 표준과 함께 읽히는 것을 전제로 한다.
- API Controller는 직접 비즈니스 세부를 처리하기보다 Facade를 통해 요청 단위 흐름을 위임하는 방향을 기본으로 본다.

---

### 6.5 `package-structure-standard.md`
역할:
- 레이어드 구조 기준의 패키지 배치 규칙을 통일한다.

주요 범위:
- 기본 패키지 구조
- controller / facade / service / repository / domain / entity / dto 위치
- config 패키지 위치
- common 패키지 사용 기준
- exception 패키지 위치
- util 패키지 남용 금지 기준
- 이후 헥사고날 전환 후보 영역 메모

비고:
- 현재는 레이어드 기준으로 작성한다.
- 처음부터 port / adapter 구조를 강제하지 않고, 나중에 전환 가능한 경계를 메모 수준으로만 남긴다.
- 초기 구조에서는 `controller → facade → service → repository` 흐름을 기본으로 두되, facade와 service의 책임이 섞이지 않도록 기준을 먼저 정한다.

---

### 6.6 `git-policy.md`
역할:
- Git 브랜치, 커밋, PR, merge 운영 규칙을 통일한다.

주요 범위:
- 브랜치 전략
- 커밋 메시지 규칙
- PR 제목 / 본문 규칙
- merge 기준
- 공개 브랜치 관리 기준

비고:
- 이 문서는 저장소 공통 운영 규칙과 가깝지만, 현재는 실제 개발 흐름과 함께 쓰이는 공통 기준 문서로서 standards 아래에서 관리한다.
- 프로젝트 전반에 강제되는 공통 규칙이므로 같은 계층에서 함께 보는 편이 자연스럽다.

---

### 6.7 후속 후보 문서
역할:
- 1차 표준 문서 세트 이후에 추가할 수 있는 2차 문서 후보를 정리한다.

후보:
- `docs/projects/standards/exception-standard.md`
- `docs/projects/standards/test-standard.md`

비고:
- 현재 저장소에는 아직 두 문서가 존재하지 않는다.
- `phase1-standards-checklist.md` 기준으로도 둘 다 2차 작성 대상으로 본다.

---

## 7. 우선순위 및 현재 단계 기준

### 7.1 1차 우선 작성 문서
아래 문서는 현재 단계의 **1차 문서 세트**로 본다.  
이 문서들이 정리되면 게시판 최소 구현 시작 가능 여부를 판단할 수 있다.

1. `docs/projects/standards/naming-standard.md`
2. `docs/projects/standards/java-coding-standard.md`
3. `docs/projects/standards/db-standard.md`
4. `docs/projects/standards/api-standard.md`
5. `docs/projects/standards/package-structure-standard.md`
6. `docs/projects/standards/git-policy.md`
7. `docs/projects/standards/index.md`

이 문서들은 실제 코드, DB, API 설계와 레이어드 구조 배치, 그리고 저장소 운영 기준에 즉시 영향을 준다.  
특히 facade를 사용할 경우 package 구조와 책임 분리 기준을 초기에 함께 고정하는 편이 좋다.

이 우선순위 판단은 현재 정리된 1차 문서 세트 기준과 동일한 맥락을 유지한다.

---

### 7.2 2차 작성 문서
아래 문서는 1차 문서 세트 정리 후 이어서 작성하는 **2차 문서**로 본다.

1. `docs/projects/standards/exception-standard.md`
2. `docs/projects/standards/test-standard.md`

이 문서들은 구현이 조금 보이기 시작할 때 더 구체적으로 정리하기 쉽다.  
현재 단계에서는 중요하지만, 1차 문서 세트 완료 판정의 필수 조건으로 두지는 않는다.

---

## 8. 현재 단계에서 보류하는 표준 문서

초기 단계에서는 아래 문서를 당장 만들지 않아도 된다.

- `docs/projects/standards/security-standard.md`
- `docs/projects/standards/logging-standard.md`
- `docs/projects/standards/auth-standard.md`
- `docs/projects/standards/module-standard.md`
- `docs/projects/standards/documentation-standard.md`

보류 이유:

- 현재는 게시판 최소 구현과 개발 흐름 검증이 우선이다.
- 인증, 보안, 로깅, 모듈 분리 표준은 필요 시점이 오면 추가하는 편이 더 현실적이다.
- 현재 단계에서 한꺼번에 문서가 너무 많아지는 것을 피한다.

---

## 9. standards와 개별 프로젝트의 관계

standards 문서는 공통 기준을 정의한다.  
개별 프로젝트 문서는 그 기준을 실제 프로젝트에 어떻게 적용하는지를 다룬다.

예를 들면:

- `standards/api-standard.md`  
  → 공통 API 설계 원칙
- `docs/projects/board/**`  
  → board 프로젝트에서 그 API 원칙을 실제로 어떻게 적용하는지

즉 standards 본문을 프로젝트 문서에 길게 복사하지 않고,  
프로젝트 문서에서는 필요한 예외나 추가 판단만 명시한다.

---

## 10. 현재 디렉토리 구조 기준

현재 기준으로 실제 존재하는 표준 문서는 아래 위치를 사용한다.

~~~text id="11449"
docs/
  projects/
    standards/
      naming-standard.md
      java-coding-standard.md
      db-standard.md
      api-standard.md
      package-structure-standard.md
      git-policy.md
      index.md
