# git-policy.md

## 1. 문서 목적

이 문서는 **이 저장소에서 사용할 Git 운영 규칙**을 정의한다.

주요 목적은 다음과 같다.

- 브랜치 운영 기준을 고정한다.
- 커밋 메시지 규칙을 통일한다.
- PR(Pull Request) 작성 기준을 정리한다.
- merge 기준을 명확히 한다.
- 문서 기반 개발 흐름과 Git 이력을 연결한다.

이 문서는 Git 사용법 자체를 설명하는 문서가 아니라,  
**이 저장소에서 어떤 방식으로 Git을 운영할지 정하는 운영 규칙 문서**이다.

---

## 2. 기본 원칙

이 저장소의 Git 운영은 다음 원칙을 따른다.

- Git 이력은 단순 저장 이력이 아니라 **작업 의도와 변경 이유를 남기는 기록**이어야 한다.
- 브랜치는 구현 단위보다 **작업 주제와 목적**이 드러나야 한다.
- 커밋은 가능한 한 작은 변경 단위로 나눈다.
- PR은 “무엇을 바꿨는가”보다 “왜 바꿨는가”가 드러나야 한다.
- 문서 변경과 상태 변경은 가능한 한 함께 추적 가능해야 한다.
- 큰 변경은 한 번에 밀어 넣지 않는다.
- 사람이 최종 승인하는 흐름을 유지한다.
- 현재 단계에서는 복잡한 Git Flow보다 **읽기 쉬운 이력과 추적 가능한 변경 이유**를 우선한다.

---

## 3. 브랜치 운영 규칙

### 3.1 기본 브랜치

#### `main`
- 공개 기준 브랜치
- 외부에 보여도 되는 안정 상태를 유지한다.
- README, 핵심 문서, 검증된 결과를 반영한다.

#### `develop`
- 선택적으로 사용할 수 있는 통합 작업 기준 브랜치
- 여러 작업 브랜치가 합쳐지는 중간 통합 지점으로 사용할 수 있다.
- 다음 반영 대상이 모이는 기준 브랜치로 사용할 수 있다.

현재 단계는 알파 검증 단계이므로, 저장소 상황에 따라 아래 두 방식 중 하나를 선택할 수 있다.

- `main` + 작업 브랜치 중심 단순 운영
- `main` / `develop` / 작업 브랜치 운영

즉, `develop`은 현재 단계에서 **사용 가능하지만 무조건 강제되는 전제는 아니다.**

---

### 3.2 작업 브랜치 종류

작업 브랜치는 아래 접두사를 사용한다.

- `docs/`
- `spec/`
- `impl/`
- `test/`
- `refactor/`
- `fix/`
- `chore/`

예시:

- `docs/readme-alpha-status`
- `spec/git-policy`
- `impl/board-phase1-cycle1`
- `test/board-post-service`
- `refactor/state-sync-rules`
- `fix/config-validation-message`
- `chore/repo-initial-setup`

#### 접두사 해석
- `docs/`  
  README, 안내 문서, 설명 문서 중심 변경
- `spec/`  
  스펙 문서, 운영 규칙 문서, 정책 문서 중심 변경
- `impl/`  
  실제 구현 작업 브랜치  
  이 저장소에서는 일반적인 `feat/` 대신 `impl/` 을 기능 구현 브랜치 접두사로 사용한다.
- `test/`  
  테스트 추가/보강 중심 변경
- `refactor/`  
  구조 정리 중심 변경
- `fix/`  
  잘못된 동작 또는 오류 수정
- `chore/`  
  저장소 설정, 환경 정리, 보조 작업

---

### 3.3 브랜치명 규칙

브랜치명은 아래 기준을 따른다.

- 무엇을 다루는지 한눈에 알 수 있어야 한다.
- 너무 긴 문장은 피한다.
- 작업의 주제가 하나로 드러나야 한다.
- 번호 체계가 없다면 억지 번호보다 짧은 의미 이름을 우선한다.

좋은 예:

- `docs/readme-intro`
- `spec/phase-transition-rules`
- `impl/board-post-crud`
- `refactor/ai-context-ssot`

지양 예:

- `work/test`
- `mybranch`
- `update`
- `temp/final-really-final`

---

### 3.4 브랜치 생성 기준

아래 경우에는 새 브랜치를 만드는 것을 권장한다.

- 문서 구조 또는 운영 규칙을 바꿀 때
- 하나의 구현 주제를 독립적으로 진행할 때
- 상태 문서 반영과 구조 문서 정리를 분리하고 싶을 때
- 실험적 변경을 안전하게 격리하고 싶을 때

작은 수정 하나만 하는 경우라도,  
직접 `main`에 넣기보다 작업 브랜치를 거치는 것을 기본으로 한다.

---

## 4. 커밋 메시지 규칙

### 4.1 기본 형식

커밋 메시지는 아래 형식을 기본으로 한다.

`type(scope): summary`

예시:

- `docs(readme): add alpha status block`
- `spec(git-policy): define branch and commit rules`
- `impl(board): add basic post entity and repository`
- `test(board): add post service test cases`
- `refactor(state): separate policy and status roles`
- `fix(config): reject unsupported provider inputs`
- `chore(repo): add editorconfig and gitignore`

---

### 4.2 type 종류

기본적으로 아래 type을 사용한다.

- `docs`
- `spec`
- `impl`
- `test`
- `refactor`
- `fix`
- `chore`

#### type 의미

- `docs`
  - README, 가이드, 설명 문서 변경
- `spec`
  - 스펙 문서, 운영 규칙 문서, 정책 문서 변경
- `impl`
  - 실제 구현 추가 또는 수정
- `test`
  - 테스트 코드 추가 또는 보강
- `refactor`
  - 동작 의미를 크게 바꾸지 않는 구조 정리
- `fix`
  - 버그 수정, 잘못된 동작 수정
- `chore`
  - 저장소 설정, 도구 설정, 빌드/환경 정리 등

---

### 4.3 scope 규칙

scope는 너무 세세하게 나누기보다  
변경 대상을 짧게 드러내는 수준으로 쓴다.

예시:

- `readme`
- `git-policy`
- `board`
- `state`
- `config`
- `phase`
- `repo`

scope는 필수는 아니지만, 가능한 경우 넣는 것을 권장한다.

---

### 4.4 summary 규칙

summary는 아래 기준을 따른다.

- 한 줄로 무엇을 했는지 보여야 한다.
- 가능하면 동사로 시작한다.
- 너무 추상적인 표현은 피한다.
- `update`, `change`, `misc` 같은 모호한 표현만 쓰지 않는다.

좋은 예:

- `docs(readme): clarify current alpha status`
- `spec(state): define SSOT roles for state documents`
- `impl(board): add basic post create flow`

지양 예:

- `docs: update files`
- `impl: change code`
- `fix: bug fix`

---

### 4.5 커밋 본문(body) 사용 기준

아래 경우에는 본문을 추가하는 것을 권장한다.

- 문서 역할이 바뀐 경우
- 상태 문서까지 함께 수정한 경우
- phase / cycle 전환이 있는 경우
- 영향 문서를 검토한 경우
- 한 줄 요약만으로 의도가 충분히 드러나지 않는 경우

예시:

    spec(state-sync): define SSOT roles for AI_CONTEXT and implementation-index

    - treat AI_CONTEXT as human-readable current status summary
    - treat implementation-index as machine-readable work pointer
    - keep spec-catalog and phase-index as supporting indexes

---

### 4.6 한 커밋의 범위

한 커밋은 가능한 한 하나의 주제를 가진다.

예:

- README 수정만 한 커밋
- git-policy 초안 추가만 한 커밋
- 게시판 post entity 추가만 한 커밋
- 테스트 보강만 한 커밋

다음을 지양한다.

- README 수정 + 구현 코드 추가 + 테스트 수정 + 설정 파일 변경을 한 커밋에 모두 넣는 것

단, 하나의 작은 작업 결과로 자연스럽게 묶이는 경우는 허용할 수 있다.

---

## 5. PR(Pull Request) 규칙

### 5.1 PR 기본 원칙

PR은 단순 변경 결과를 올리는 절차가 아니라,  
**변경 의도와 검증 결과를 설명하는 리뷰 단위**로 사용한다.

PR에는 최소한 아래가 드러나야 한다.

- 왜 바꿨는가
- 무엇을 바꿨는가
- 어디까지 영향을 주는가
- 어떻게 검증했는가
- 무엇이 아직 남아 있는가

---

### 5.2 PR 제목 규칙

PR 제목은 아래 형식을 권장한다.

`[type] short summary`

예시:

- `[docs] refine README for public repository`
- `[spec] add git policy rules`
- `[impl] start board phase 1 cycle 1`
- `[test] strengthen board service test cases`

---

### 5.3 PR 본문 템플릿

PR 본문에는 아래 항목을 넣는 것을 권장한다.

예시 템플릿:

    ## 목적
    이 PR의 목적을 간단히 적는다.

    ## 변경 내용
    - 주요 변경 1
    - 주요 변경 2
    - 주요 변경 3

    ## 영향 문서 / 파일
    - 관련 문서
    - 관련 구현 파일
    - 관련 상태 문서

    ## 검증
    - 어떤 방식으로 확인했는지
    - 테스트 / 문서 검토 / 수동 실행 등

    ## 보류 / 후속 작업
    - 아직 남은 작업
    - 다음 PR에서 다룰 내용

예시:

    ## 목적
    README와 공개 저장소 소개 문구를 현재 운영 방향에 맞게 정리한다.

    ## 변경 내용
    - README 소개문 추가
    - alpha 상태 블록 추가
    - 현재 적용 방향 / 향후 확장 방향 정리

    ## 영향 문서 / 파일
    - README.md
    - AGENTS.md 검토
    - docs/AI_CONTEXT.md 참조

    ## 검증
    - README와 현재 운영 방향의 일치 여부 확인
    - 상태 문서와 README 표현 충돌 여부 확인

    ## 보류 / 후속 작업
    - 영문 README 변환
    - git-policy 문서 추가

---

### 5.4 PR 분리 기준

아래 경우에는 PR을 나누는 것을 권장한다.

- 문서 정리와 구현 추가가 동시에 큰 경우
- 구조 변경과 기능 추가가 동시에 있는 경우
- phase 전환과 실제 구현 변경이 함께 있는 경우
- 리뷰 포인트가 너무 많아지는 경우

원칙적으로 PR 하나는 **하나의 리뷰 주제**를 가져야 한다.

---

### 5.5 초기 단계 운영 유연성

현재 저장소는 알파 검증 단계이므로,  
혼자 진행하는 작은 실험 작업에서는 정식 PR 절차를 생략할 수 있다.

다만 공개 반영 전에는 최소한 아래 내용은 남기는 것을 권장한다.

- 목적
- 변경 내용
- 검증 방법
- 후속 작업

즉 PR을 생략하더라도 **리뷰 가능한 변경 설명**은 유지하는 것이 좋다.

---

## 6. Merge 규칙

### 6.1 통합 브랜치로의 merge

통합 브랜치(`develop` 또는 현재 선택한 통합 기준 브랜치)로 merge 할 때는 아래를 만족하는 것이 좋다.

- 작업 목적이 분명하다.
- 커밋 메시지가 의미를 가진다.
- 변경 범위가 과도하게 섞이지 않았다.
- 변경 이유와 검증 방법을 추적할 수 있다.

---

### 6.2 `main`으로의 merge

`main`은 공개 기준 브랜치다.

따라서 `main`으로 올릴 때는 아래를 더 엄격히 본다.

- 공개 상태로 보여도 되는가
- README와 현재 저장소 설명이 맞는가
- 상태 문서와 공개 설명이 심하게 충돌하지 않는가
- 변경 이유가 추적 가능한가
- 너무 큰 실험 변경이 그대로 섞이지 않았는가

---

### 6.3 merge 방식

기본적으로 아래 방식을 권장한다.

- 통합 브랜치
  - 일반 merge 또는 squash merge 허용
- `main`
  - squash merge 우선

이유는 다음과 같다.

- 작업 브랜치에서는 여러 실험 커밋이 가능하다.
- 공개 브랜치에는 정리된 변경 기록만 남기는 편이 좋다.
- 공개 저장소 이력이 더 읽기 쉬워진다.

---

## 7. 문서 기반 개발과 Git의 연결

이 저장소에서 Git은 단순 소스 관리 도구가 아니다.  
Git 이력은 다음과 연결된다.

- 문서 변경 이력
- 상태 변경 이력
- phase / cycle / task 진행 기록
- 구조 변경 이유
- 검증 결과 축적

따라서 아래 원칙을 따른다.

- 문서 구조 변경은 가능한 한 이유를 함께 남긴다.
- 상태 문서 변경은 현재 전환 의미가 드러나게 남긴다.
- phase 변경은 관련 상태 문서와 함께 추적 가능해야 한다.
- 큰 변경 전에 현재 상태를 보존하는 것이 좋다.

---

## 8. 권장 운영 예시

### 문서 작업 예시

1. `spec/git-policy` 브랜치 생성
2. `spec(git-policy): add initial git policy draft` 커밋
3. 필요 시 PR 작성 또는 작업 설명 기록
4. 검토 후 통합 브랜치 merge
5. 정리 후 `main` 반영

### 구현 작업 예시

1. `impl/board-post-crud` 브랜치 생성
2. `impl(board): add post entity and repository`
3. `test(board): add post repository tests`
4. `spec(board): reflect current scope in implementation docs`
5. 필요 시 PR 작성
6. 검증 후 merge

---

## 9. 금지 또는 지양 규칙

다음을 지양한다.

- 의미 없는 브랜치명
- 너무 큰 변경을 한 PR에 몰아넣는 것
- `update`, `misc`, `final` 같은 모호한 커밋 메시지
- 상태 문서 변경 이유 없이 단순 덮어쓰기
- 문서 구조 변경과 구현 변경을 설명 없이 섞는 것
- `main`에 직접 큰 변경을 푸시하는 것
- 현재 단계에 비해 과하게 복잡한 브랜치 전략을 먼저 강제하는 것

---

## 10. 현재 단계 결론

현재 단계에서 Git 운영의 핵심은 복잡한 Git Flow 도입이 아니다.

우선 아래 4가지를 안정적으로 지키는 것이 중요하다.

- 브랜치명에 작업 의도를 드러낸다.
- 커밋 메시지에 변경 이유와 범위를 남긴다.
- PR 또는 동등한 기록에서 목적, 변경 내용, 검증 내용을 설명한다.
- `main`은 공개 기준 브랜치로 더 엄격하게 관리한다.

즉, 이 문서의 목적은 Git을 복잡하게 만드는 것이 아니라,  
현재 저장소의 문서 우선 / 상태 분리 / 구조 우선 원칙에 맞는  
**신뢰 가능한 Git 운영 규칙**을 만드는 데 있다.
