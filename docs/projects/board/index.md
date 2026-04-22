# docs/projects/board/index.md

## 1. 문서 목적

이 문서는 `docs/projects/board/**` 아래 문서들의 **목록과 역할을 안내하는 인덱스 문서**다.

목적은 다음과 같다.

- board 영역 문서가 무엇이 있는지 빠르게 파악한다.
- 각 문서의 역할과 읽는 순서를 안내한다.
- 현재 작업 목적에 따라 어떤 문서를 먼저 봐야 하는지 구분한다.
- board 문서 구조를 탐색 가능한 형태로 유지한다.

이 문서는 board의 정체성 자체를 자세히 설명하는 문서가 아니다.  
board의 개요와 방향은 `docs/projects/board/README.md` 를 따른다.  
작업 규칙은 `docs/projects/board/AGENTS.md` 를 따른다.

---

## 2. board 문서군의 역할

`docs/projects/board/**` 는 board 프로젝트 자체의 개발 스펙 문서를 다룬다.

즉 이 영역은 다음을 설명한다.

- board 요구사항
- board 설계
- board 구현 계획
- board 현재 상태
- board 히스토리
- board 전용 판단과 결정 사항

이 영역은 **specdrive 자체의 도구 규칙**을 다루지 않는다.  
그 내용은 `docs/specdrive/**` 에서 다룬다.

---

## 3. 먼저 읽어야 하는 문서

board 작업을 시작할 때는 보통 아래 순서로 읽는다.

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. `docs/projects/board/AGENTS.md`
6. `docs/projects/board/README.md`
7. `docs/projects/board/index.md`

그 이후에는 작업 목적에 따라 관련 문서를 따라간다.

---

## 4. 현재 주요 문서 목록

### 4.1 `docs/projects/board/README.md`
board 자체의 대표 진입 문서다.

다음 내용을 다룬다.

- board의 현재 정체성
- board의 목표
- board와 specdrive의 관계
- board의 현재 방향
- standards와의 관계
- 현재 우선순위

이 문서는  
**board가 무엇인가**를 먼저 이해할 때 읽는다.

---

### 4.2 `docs/projects/board/AGENTS.md`
board 전용 작업 규칙 문서다.

다음 내용을 다룬다.

- board 문서와 specdrive 문서의 경계
- board 문서 작성과 검토 원칙
- board의 작업 흐름 원칙
- standards 적용 방식
- board 전용 금지/주의 사항

이 문서는  
**board 문서를 어떻게 다뤄야 하는가**를 확인할 때 읽는다.

---

### 4.3 `docs/projects/board/index.md`
현재 문서 자체다.

다음 내용을 다룬다.

- board 문서 목록
- 각 문서의 역할
- 권장 읽기 순서
- 작업 목적별 참조 문서 안내

이 문서는  
**board 문서 구조를 빠르게 탐색할 때** 읽는다.

---

### 4.4 `docs/projects/board/01-overview.md`
board 프로젝트의 가장 기초적인 개요 문서다.

다음 내용을 다룬다.

- board를 왜 시작하는가
- board의 현재 성격
- 현재 범위와 제외 범위
- 이후 문서로 이어지는 출발점

이 문서는  
**board 프로젝트를 가장 짧게 이해하고 시작할 때** 읽는다.

---

### 4.5 `docs/projects/board/02-requirements.md`
board 프로젝트의 현재 단계 최소 요구사항 문서다.

다음 내용을 다룬다.

- 현재 포함 범위와 제외 범위
- 최소 게시판 기능 요구사항
- 후속 설계 문서가 받아야 할 입력

이 문서는  
**board가 현재 무엇을 해야 하는지 구체적으로 정리할 때** 읽는다.

---

## 5. 현재 또는 후속으로 유지할 수 있는 문서

아래 문서들은 현재 있거나, 후속으로 유지/정리할 수 있는 문서들이다.  
이 문서들이 실제로 존재하지 않는 경우, 현재는 후보 또는 후속 정리 대상으로 본다.

### 5.1 요구사항 문서
예:
- 기능 요구사항 문서
- 범위 정의 문서
- 사용자 흐름 문서

역할:
- board가 무엇을 해야 하는지
- 현재 포함 범위와 제외 범위가 무엇인지
- 어떤 기능 흐름을 우선하는지

---

### 5.2 설계 문서
예:
- 구조 문서
- 패키지/레이어 설계 문서
- 도메인/화면/API 관계 문서

역할:
- board를 어떤 구조로 만들지
- 현재 채택한 설계 판단이 무엇인지
- 구조 경계를 어디에 둘지

---

### 5.3 구현 계획 문서
예:
- 구현 단계 문서
- task 분해 문서
- phase / cycle 기준 문서

역할:
- 문서를 기준으로 어떻게 구현을 진행할지
- 어떤 단위로 작업을 쪼갤지
- 지금 어느 수준까지를 목표로 할지

---

### 5.4 상태 문서
예:
- 현재 진행 상태 문서
- 현재 focus 문서
- 현재 active task 문서

역할:
- 지금 무엇을 하고 있는지
- 현재 어떤 단계인지
- 다음 진입점이 무엇인지

---

### 5.5 히스토리 문서
예:
- 변경 이력 문서
- 구조 결정 이력 문서
- 중요한 판단 메모 문서

역할:
- 어떤 판단이 있었는지
- 왜 그렇게 바뀌었는지
- 현재 문서와 과거 문서의 관계가 무엇인지

---

## 6. 작업 목적별 참조 문서

### 6.1 board 정체성을 이해하고 싶을 때
우선 읽을 문서:

1. `docs/projects/board/README.md`
2. `docs/projects/board/AGENTS.md`

---

### 6.2 board 문서를 수정하려고 할 때
우선 읽을 문서:

1. `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. `docs/projects/board/AGENTS.md`
4. `docs/projects/board/README.md`
5. 현재 수정 대상 문서

---

### 6.3 specdrive와 board 문서 경계가 헷갈릴 때
우선 읽을 문서:

1. `docs/README.md`
2. `docs/specdrive/README.md`
3. `docs/projects/README.md`
4. `docs/projects/board/README.md`
5. `docs/projects/board/AGENTS.md`

---

### 6.4 standards를 어떻게 적용해야 할지 헷갈릴 때
우선 읽을 문서:

1. `docs/projects/README.md`
2. `docs/projects/board/README.md`
3. `docs/projects/board/AGENTS.md`
4. 관련 `docs/projects/standards/**` 문서

---

### 6.5 실제 구현 준비를 하려 할 때
우선 읽을 문서:

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/board/README.md`
5. `docs/projects/board/AGENTS.md`
6. 관련 요구사항 / 설계 / 구현 계획 문서
7. 필요 시 관련 `docs/projects/standards/**` 문서

---

## 7. 현재 문서 구조에서 중요한 원칙

board 문서를 다룰 때는 다음을 계속 확인한다.

- 이 문서가 board 자체를 설명하는 문서인가?
- 이 문서가 작업 규칙 문서인가?
- 이 문서가 현재 상태 문서인가?
- 이 문서가 specdrive 문서와 역할이 섞이지 않았는가?
- 이 문서가 현재 단계의 최소 구현 흐름을 강화하는가?

현재 단계에서는 문서를 많이 늘리는 것보다  
**역할이 선명한 진입 문서와 최소 작업 문서 구조를 먼저 고정하는 것**이 더 중요하다.

---

## 8. 최종 정리

`docs/projects/board/index.md` 는  
`docs/projects/board/**` 문서군을 빠르게 탐색하기 위한 인덱스 문서다.

board 문서를 다룰 때는 항상 먼저 아래를 구분한다.

- 지금 필요한 것이 개요 문서인가?
- 작업 규칙 문서인가?
- 요구사항 문서인가?
- 설계 문서인가?
- 구현 계획 문서인가?
- 상태 문서인가?
- 히스토리 문서인가?

현재 board는 specdrive와 같은 저장소 안에서 함께 운영되지만,  
처음부터 **독립 가능한 실제 애플리케이션 프로젝트 문서군**으로 정리한다.
