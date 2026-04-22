# phase1-standards-checklist.md

## 1. 문서 목적

이 문서는 초기 게시판 프로젝트의 1차 표준 문서 세트가 실제로 작성 완료되었는지,  
그리고 현재 상태에서 구현을 시작해도 되는 수준인지 점검하기 위한 체크리스트 문서다.

주요 목적은 다음과 같다.

- 1차 표준 문서의 작성 완료 여부를 확인한다.
- 문서가 단순히 존재하는지뿐 아니라, 실제로 사용할 수 있는 수준인지 점검한다.
- 문서 간 충돌이나 누락 여부를 확인한다.
- 게시판 최소 구현 시작 가능 여부를 판단한다.
- 2차 표준 문서로 넘어가기 전 현재 기준이 충분히 정리되었는지 확인한다.

이 문서는 개별 표준 문서의 상세 내용을 다시 설명하는 문서가 아니라,  
**현재 단계에서 1차 표준 문서 세트의 준비 상태를 점검하는 기준 문서**이다.

---

## 2. 적용 범위

이 체크리스트는 아래 1차 표준 문서를 대상으로 한다.

1. `docs/projects/standards/naming-standard.md`
2. `docs/projects/standards/java-coding-standard.md`
3. `docs/projects/standards/db-standard.md`
4. `docs/projects/standards/api-standard.md`
5. `docs/projects/standards/package-structure-standard.md`
6. `docs/projects/standards/git-policy.md`
7. `docs/projects/standards/index.md`

현재 단계에서 `exception-standard.md`, `test-standard.md`는 2차 문서로 본다.  
따라서 이 체크리스트는 1차 문서 세트 기준의 준비 상태만 점검한다.

---

## 3. 판정 기준

각 항목은 아래 기준으로 점검한다.

- `[ ]` 미완료
- `[x]` 완료
- `보류` 현재 단계에서 의도적으로 뒤로 미룬 상태

필요 시 각 항목 옆에 메모를 남길 수 있다.

---

## 4. 문서 존재 여부 체크

### 4.1 필수 문서 존재 여부

- [x] `docs/projects/standards/naming-standard.md` 파일이 존재한다.
- [x] `docs/projects/standards/java-coding-standard.md` 파일이 존재한다.
- [x] `docs/projects/standards/db-standard.md` 파일이 존재한다.
- [x] `docs/projects/standards/api-standard.md` 파일이 존재한다.
- [x] `docs/projects/standards/package-structure-standard.md` 파일이 존재한다.
- [x] `docs/projects/standards/git-policy.md` 파일이 존재한다.
- [x] `docs/projects/standards/index.md` 파일이 존재한다.

### 4.2 문서 경로 일치 여부

- [x] `standards-index.md` 안의 문서 목록 경로가 현재 실제 파일 경로와 일치한다.

---

## 5. 문서별 최소 품질 체크

### 5.1 naming-standard.md

- [x] 문서 목적이 작성되어 있다.
- [x] 기본 원칙이 작성되어 있다.
- [x] 도메인 용어 기준이 작성되어 있다.
- [x] 자바 이름 규칙이 작성되어 있다.
- [x] controller/action 스타일 이름 규칙이 작성되어 있다.
- [x] DB 이름 규칙이 작성되어 있다.
- [x] API / URL 이름 규칙이 작성되어 있다.
- [x] 현재 단계 적용 기준 또는 현재 단계 요약이 포함되어 있다.

### 5.2 java-coding-standard.md

- [x] 문서 목적이 작성되어 있다.
- [x] 기본 원칙이 작성되어 있다.
- [x] controller / facade / service / repository 책임 기준이 포함되어 있다.
- [x] DTO / Entity / Enum 작성 기준이 포함되어 있다.
- [x] 생성자 / Lombok / Optional / Stream 기준이 포함되어 있다.
- [x] 예외 처리와 테스트 친화성에 대한 최소 원칙이 포함되어 있다.
- [x] 현재 단계 적용 기준이 포함되어 있다.

### 5.3 db-standard.md

- [x] 문서 목적이 작성되어 있다.
- [x] 기본 원칙이 작성되어 있다.
- [x] 테이블명 규칙이 포함되어 있다.
- [x] 컬럼명 규칙이 포함되어 있다.
- [x] PK / FK 규칙이 포함되어 있다.
- [x] 공통 컬럼 기준이 포함되어 있다.
- [x] 상태값 / 삭제 정책 기준이 포함되어 있다.
- [x] 인덱스 규칙이 포함되어 있다.
- [x] 현재 단계 적용 기준이 포함되어 있다.

### 5.4 api-standard.md

- [x] 문서 목적이 작성되어 있다.
- [x] 기본 원칙이 작성되어 있다.
- [x] URL 규칙이 포함되어 있다.
- [x] HTTP Method 규칙이 포함되어 있다.
- [x] controller 메서드 스타일 / URL 매핑 기준이 포함되어 있다.
- [x] Request / Response 규칙이 포함되어 있다.
- [x] 성공 응답 / 에러 응답 규칙이 포함되어 있다.
- [x] 페이징 / 정렬 / 검색 규칙이 포함되어 있다.
- [x] 현재 단계 적용 기준이 포함되어 있다.

### 5.5 package-structure-standard.md

- [x] 문서 목적이 작성되어 있다.
- [x] 기본 원칙이 작성되어 있다.
- [x] 현재 단계가 레이어드 구조 기준임이 명시되어 있다.
- [x] controller / facade / service / repository 패키지 기준이 포함되어 있다.
- [x] dto / entity / domain / exception / config / support 기준이 포함되어 있다.
- [x] 의존 방향 기준이 포함되어 있다.
- [x] common / util 남용 방지 기준이 포함되어 있다.
- [x] 헥사고날 전환 후보 메모가 포함되어 있다.
- [x] 현재 단계 적용 기준이 포함되어 있다.

### 5.6 git-policy.md

- [x] 문서 목적이 작성되어 있다.
- [x] 브랜치 규칙이 포함되어 있다.
- [x] 커밋 메시지 규칙이 포함되어 있다.
- [x] PR 규칙이 포함되어 있다.
- [x] merge 기준이 포함되어 있다.
- [x] 현재 프로젝트 단계에 맞는 운영 원칙이 반영되어 있다.

### 5.7 index.md

- [x] 문서 목적이 작성되어 있다.
- [x] 초기 표준 문서 목록이 현재 기준과 일치한다.
- [x] facade 기준이 반영되어 있다.
- [x] git-policy 경로가 standards 폴더 기준으로 반영되어 있다.
- [x] 1차/2차 문서 우선순위가 현재 기준과 일치한다.
- [x] 현재 단계 결론 또는 현재 단계 적용 기준이 포함되어 있다.

---

## 6. 문서 간 정합성 체크

### 6.1 naming ↔ java

- [x] naming-standard의 클래스/메서드/역할 이름 규칙이 java-coding-standard와 충돌하지 않는다.
- [x] Facade / Service / Repository 이름 기준이 두 문서에서 일관된다.
- [x] controller 메서드 스타일 naming과 자바 메서드 naming이 문맥상 충돌하지 않는다.

### 6.2 naming ↔ db

- [x] 도메인 용어가 자바와 DB에서 같은 의미로 유지된다.
- [x] 테이블 / 컬럼 이름 규칙이 naming-standard와 충돌하지 않는다.

### 6.3 naming ↔ api

- [x] URL 리소스 이름이 도메인 용어와 일치한다.
- [x] path variable 이름과 자바/문서 이름이 일관된다.
- [x] controller/action 이름과 외부 URL 의미가 충돌하지 않는다.

### 6.4 java ↔ package structure

- [x] java-coding-standard의 계층 책임 기준이 package-structure-standard와 일치한다.
- [x] controller → facade → service → repository 흐름이 두 문서에서 일관된다.
- [x] facade 책임과 service 책임 구분이 두 문서에서 일관된다.

### 6.5 api ↔ package structure

- [x] controller는 facade 호출 기준으로 서술되어 있다.
- [x] API 표준의 controller 메서드 스타일 규칙이 package-structure-standard의 controller 책임과 일치한다.
- [x] URL 매핑 기준과 controller/action 역할 설명이 충돌하지 않는다.

### 6.6 standards-index ↔ 개별 문서

- [x] standards-index의 문서 목록이 실제 작성 문서와 일치한다.
- [x] standards-index의 설명과 개별 문서의 실제 역할이 크게 어긋나지 않는다.
- [x] 1차/2차 구분이 현재 작업 순서와 일치한다.

---

## 7. 현재 단계 적합성 체크

### 7.1 레이어드 시작 기준

- [x] 현재 문서들이 “초기 레이어드 게시판 시작” 기준으로 작성되어 있다.
- [x] 헥사고날 완성형 구조를 미리 강제하지 않는다.
- [x] 과도한 공통화/추상화를 먼저 도입하지 않는다.
- [x] facade 중심 흐름이 현재 기준으로 명확히 반영되어 있다.

### 7.2 Controller 스타일 기준 반영 여부

- [x] controller/action 스타일 관점이 naming-standard에 반영되어 있다.
- [x] 명시적 URL 매핑 관점이 api-standard에 반영되어 있다.
- [x] Spring Boot 기반 구조와 controller/action 스타일 참고 기준이 package-structure-standard와 충돌하지 않는다.

### 7.3 현재 단계 요약 구간 점검

- [x] 각 문서의 마지막 “현재 단계 적용 기준” 또는 이에 준하는 요약 구간이 존재한다.
- [x] 현재 단계 요약이 “레이어드 게시판 시작” 방향과 맞는다.
- [x] 미래 확장을 설명하더라도 현재 기준을 흐리지 않는다.

---

## 8. 구현 시작 가능 여부 체크

### 8.1 최소 구현 시작 조건

아래 항목이 모두 만족되면 게시판 최소 구현을 시작할 수 있다.

- [x] naming-standard.md 완료
- [x] java-coding-standard.md 완료
- [x] db-standard.md 완료
- [x] api-standard.md 완료
- [x] package-structure-standard.md 완료
- [x] git-policy.md 완료
- [x] standards-index.md 완료
- [x] 문서 간 치명적인 충돌이 없다

### 8.2 구현 보류 조건

아래 중 하나라도 해당하면 구현 시작 전 보강을 검토한다.

- [ ] facade와 service 책임이 문서마다 다르게 서술된다
- [ ] API URL 규칙과 naming 규칙이 충돌한다
- [ ] DB 용어와 자바/API 용어가 다르게 쓰인다
- [ ] git-policy 경로나 표준 문서 목록 경로가 실제 구조와 다르다
- [ ] 현재 단계 기준이 레이어드인지 헥사고날인지 문서마다 다르다

---

## 9. 2차 문서 진입 준비 체크

아래 항목이 만족되면 2차 문서로 넘어갈 수 있다.

- [x] 1차 문서 세트가 모두 존재한다
- [x] 1차 문서의 최소 품질 항목이 충족된다
- [x] 문서 간 정합성에 치명적 문제 없음
- [x] 게시판 최소 구현 시작 가능 판정
- [x] 2차 문서 필요성이 현재 구조상 분명하다

현재 기준의 2차 문서:
- `docs/projects/standards/exception-standard.md`
- `docs/projects/standards/test-standard.md`

---

## 10. 최종 판정

### 10.1 판정 결과

- [x] 1차 문서 세트 작성 완료
- [x] 1차 문서 세트 정합성 확인 완료
- [x] 게시판 최소 구현 시작 가능
- [x] 2차 문서 작성 단계로 이동 가능

### 10.2 메모

현재 상태 메모:

- 1차 표준 문서 7종이 모두 존재한다.
- 1차 문서 세트는 레이어드 + facade 기준으로 정합성이 맞는다.
- 현재 기준으로 게시판 최소 구현 시작 가능 판정이다.

보강 필요 메모:

- `exception-standard.md`는 아직 미작성 상태다.
- `test-standard.md`는 아직 미작성 상태다.
- 2차 문서 작성 시 API 예외 응답 규칙과 테스트 계층 기준을 우선 연결해야 한다.

다음 작업 메모:

- `exception-standard.md` 초안 작성
- `test-standard.md` 초안 작성
- 2차 문서 작성 후 API / java / package 구조 문서와 재정합성 점검

---

## 11. 현재 단계 적용 기준

현재 단계에서 이 체크리스트의 목적은  
문서가 단순히 “있는지”를 확인하는 것이 아니라,  
초기 레이어드 게시판 구현을 시작해도 되는 수준으로 정리되었는지 판단하는 데 있다.

따라서 현재는 다음을 우선한다.

- 1차 문서 존재 여부 확인
- 1차 문서 최소 품질 확인
- 문서 간 정합성 확인
- 레이어드 + facade 기준의 현재 방향 유지
- 2차 문서를 너무 일찍 당겨오지 않기
- 구현 시작 가능 여부를 문서 기준으로 먼저 판단하기

즉, 이 체크리스트는  
문서 작업을 늘리기 위한 문서가 아니라,  
**현재 표준 문서 세트가 실제 구현 시작 기준으로 충분한지 점검하는 기준 문서**이다.
