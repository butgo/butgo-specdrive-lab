# docs/README.ko.md

[English](README.md) | [한국어](README.ko.md)

## 1. 문서 목적

이 문서는 `docs/**` 전체 문서 구조의 **최상위 진입점**이다.

목적은 다음과 같다.

- 문서 트리의 큰 구조를 빠르게 이해한다.
- specdrive 문서와 project 문서의 경계를 구분한다.
- 공통 운영 문서, 도구 문서, 애플리케이션 문서, 공통 표준 문서의 역할을 구분한다.
- 새 세션이나 새 작업에서 어떤 문서를 먼저 읽어야 하는지 안내한다.
- 현재 저장소가 왜 통합 검증 구조를 갖고 있는지 설명한다.

이 문서는 개별 문서의 상세 정책을 직접 정의하지 않는다.  
상세 기준은 각 영역의 `AGENTS.md`, `README.md`, `index.md`, 개별 문서를 따른다.

---

## 2. docs 영역을 어떻게 보는가

`docs/**` 는 현재 저장소 안에서  
**specdrive와 projects를 함께 검증하기 위한 통합 문서 영역**이다.

현재는 제품 검증과 실제 적용 검증을 위해  
specdrive 문서와 projects 문서를 한 저장소 안에서 함께 운영한다.

다만 이것은 현재 단계의 운영 방식이며,  
장기적으로는 다음과 같은 방향을 지향한다.

- `specdrive` 문서 = 독립된 도구 / 엔진 / 운영체계 문서
- `projects` 문서 = specdrive가 다루는 개별 애플리케이션 문서

즉, 현재 `docs/**` 는 통합 검증용 문서 공간이지만,  
장기적으로는 도구와 애플리케이션 문서가 분리 가능한 구조를 전제로 정리한다.

---

## 3. 현재 기준 핵심 관점

현재 `docs/**` 를 볼 때는 다음 관점을 먼저 고정한다.

### 3.1 specdrive
specdrive는 현재 **완성된 SaaS 제품**이 아니라,  
개발 스펙 문서를 기반으로 AI 협업을 실행하는  
**엔진 / 운영체계 / CLI 도구**로 본다.

### 3.2 projects
projects는 실제 애플리케이션의  
**개발 스펙 문서 작업공간**으로 본다.

### 3.3 board
board는 specdrive의 하위 기능이 아니라,  
specdrive 방식이 실제 프로젝트에도 유효한지 검증하는  
**첫 번째 실제 애플리케이션 프로젝트**로 본다.

### 3.4 standards
`docs/projects/standards/**` 는  
projects 하위에서 공통으로 참조하는  
**프로젝트 공통 개발 기준 문서군**으로 본다.

---

## 4. 전체 문서 구조

현재 `docs/**` 는 크게 다음 층으로 나뉜다.

### 4.1 공통 운영 문서
저장소 전체의 진입점, 상태 복구, 계층 안내를 담당하는 문서

예:
- `docs/README.md`
- `docs/AI_CONTEXT.md`

### 4.2 specdrive 문서
specdrive 자체의 운영 구조, AI 협업 방식, 도구 관점을 다루는 문서군

위치:
- `docs/specdrive/**`

진입 문서 예:
- `docs/specdrive/README.md`
- `docs/specdrive/AGENTS.md`
- `docs/specdrive/index.md`

### 4.3 projects 문서
실제 애플리케이션의 개발 스펙 문서를 다루는 문서군

위치:
- `docs/projects/**`

진입 문서 예:
- `docs/projects/README.md`
- `docs/projects/board/README.md`
- `docs/projects/board/AGENTS.md`
- `docs/projects/board/index.md`

### 4.4 프로젝트 공통 기준 문서
실제 애플리케이션 개발 시 참조하는 공통 기준 문서군

위치:
- `docs/projects/standards/**`

진입 문서 예:
- `docs/projects/standards/index.md`

현재 단계에서는 `docs/projects/standards/**` 를  
`projects`를 보조하는 하위 공통 문서 성격으로 본다.

---

## 5. 각 영역이 다루는 것

### 5.1 공통 운영 문서
다음과 같은 공통 성격을 다룬다.

- 현재 상태 복구
- 문서 진입 순서
- 문서 계층 안내
- 전체 작업 흐름에서의 공통 진입 기준

### 5.2 `docs/specdrive/**`
다음과 같은 specdrive 자체의 도구 관점을 다룬다.

- specdrive의 정체성과 목표
- 문서 기반 AI 협업 흐름
- `doc` / `dev` 단계 구분
- 세션 시작 방식
- 문맥 복구 방식
- 문서 검토와 동기화 흐름
- CLI 중심 실행 구조의 방향
- 도구로서의 운영 구조

즉, `docs/specdrive/**` 는  
**어떻게 AI 협업을 실행할 것인가**를 다룬다.

### 5.3 `docs/projects/**`
다음과 같은 실제 애플리케이션 문서를 다룬다.

- 요구사항
- 설계
- 구현 계획
- 상태
- 히스토리
- 애플리케이션별 결정 사항

즉, `docs/projects/**` 는  
**무엇을 만들 것인가**를 다룬다.

### 5.4 `docs/projects/standards/**`
다음과 같은 프로젝트 공통 개발 기준을 다룬다.

- naming
- coding style
- db
- api
- package structure
- git policy

즉, `docs/projects/standards/**` 는  
**애플리케이션 개발 시 어떤 공통 기준을 따를 것인가**를 다룬다.

---

## 6. 먼저 이해해야 하는 문서 계층

문서를 읽을 때는 아래 계층을 먼저 이해하는 것이 좋다.

### 6.1 루트 규칙
- `AGENTS.md`
- 저장소 전체 공통 작업 규칙과 협업 원칙

### 6.2 상태 복구
- `docs/AI_CONTEXT.md`
- 현재 focus, 다음 진입점, 최근 결정 사항

### 6.3 docs 전체 진입 문서
- `docs/README.md`

### 6.4 영역별 진입 문서
- `docs/specdrive/README.md`
- `docs/projects/README.md`
- `docs/projects/board/README.md`

### 6.5 영역별 전용 규칙
- `docs/specdrive/AGENTS.md`
- `docs/projects/board/AGENTS.md`

### 6.6 개별 작업 문서
- 요구사항 문서
- 설계 문서
- 구현 계획 문서
- 상태 문서
- 검토 문서
- 히스토리 문서

---

## 7. 권장 읽기 순서

### 7.1 저장소를 처음 이해할 때
1. 루트 `README.md`
2. 루트 `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/README.md`
5. `docs/projects/board/README.md`

### 7.2 docs 구조를 따라 들어갈 때
1. 루트 `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. `docs/README.md`

### 7.3 specdrive 작업을 시작할 때
1. 루트 `README.md`
2. 루트 `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/README.md`
6. `docs/specdrive/index.md`
7. 대상 specdrive 문서

### 7.4 project 작업을 시작할 때
1. 루트 `README.md`
2. 루트 `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. 대상 프로젝트의 `AGENTS.md`
6. 대상 프로젝트의 `README.md`
7. 대상 프로젝트의 `index.md`
8. 필요 시 관련 `docs/projects/standards/**` 문서

---

## 8. 문서 경계 판단 기준

어떤 내용을 어디에 둘지 헷갈리면 아래 질문으로 판단한다.

### 질문 1
이 내용이 저장소 전체 공통 규칙이나 공통 진입 기준인가?

- 그렇다 → 루트 문서 또는 공통 운영 문서

### 질문 2
이 내용이 specdrive 자체의 도구 동작, 협업 흐름, 운영 구조에 관한 것인가?

- 그렇다 → `docs/specdrive/**`

### 질문 3
이 내용이 특정 애플리케이션의 요구사항, 설계, 구현 판단인가?

- 그렇다 → `docs/projects/**`

### 질문 4
이 내용이 실제 애플리케이션 개발 시 참조하는 공통 기준인가?

- 그렇다 → `docs/projects/standards/**`

### 질문 5
이 내용이 현재 상태, 현재 focus, 다음 진입점 복구를 위한 것인가?

- 그렇다 → `docs/AI_CONTEXT.md`

---

## 9. 현재 구조의 의미

현재 문서 구조는 다음을 분리하기 위한 목적을 가진다.

- 공통 운영 기준
- specdrive 도구 문서
- 애플리케이션 개발 스펙 문서
- 프로젝트 공통 개발 기준
- 현재 상태 복구 문서

즉, 현재는 한 저장소 안에서 함께 검증하고 있지만  
역할은 처음부터 분리해 두는 것이 목적이다.

이 구분이 선명할수록 다음이 쉬워진다.

- 문서 중복 감소
- 책임 경계 유지
- AI 협업 품질 향상
- 새 세션 진입 속도 향상
- 장기적 분리 구조로의 전환 용이성

---

## 10. 현재 운영 방향

현재는 specdrive 자체를 완성된 제품으로 분리하기보다,  
실제 애플리케이션 프로젝트와 함께 운영하면서  
도구로서의 유효성을 검증하는 단계다.

즉, 현재 `docs/**` 는 다음을 함께 수행한다.

- specdrive 도구 문서 정리
- 실제 project 문서 작성
- AI 협업 방식 검증
- 문서 진입 구조와 상태 복구 방식 검증
- README / AGENTS / AI_CONTEXT 기반의 CLI 테스트 준비

다만 장기적으로는  
specdrive 문서와 project 문서가 분리 가능한 구조를 유지하는 것이 전제다.

---

## 11. 현재 docs 관점의 우선순위

현재 docs 영역에서 우선순위는 다음과 같다.

### 우선순위 1
- README / AGENTS / AI_CONTEXT 정합성 확보
- specdrive / projects / board / standards 정의 고정

### 우선순위 2
- `doc` / `dev` 작업 단계 구분을 문서 차원에서 명확히 유지
- specdrive와 board의 경계가 문서에서 흔들리지 않도록 정리

### 우선순위 3
- 이 문서들을 기준으로 Codex가 프로젝트 성격을 안정적으로 이해하도록 만드는 것
- 이후 최소 CLI 테스트 진입 문서로 활용하는 것

---

## 12. 최종 정리

`docs/README.md` 는 `docs/**` 전체 구조를 빠르게 이해하기 위한 진입 문서다.

새 작업을 시작하거나 새 문서를 추가할 때는  
항상 먼저 아래를 확인한다.

- 이 내용은 공통 운영 문서에 있어야 하는가?
- 이 내용은 specdrive 도구 문서에 있어야 하는가?
- 이 내용은 project 개발 스펙 문서에 있어야 하는가?
- 이 내용은 project 공통 개발 기준 문서에 있어야 하는가?
- 이 내용은 현재 상태 복구 문서에 있어야 하는가?

현재는 한 저장소에서 함께 검증하고 있지만,  
문서 구조는 처음부터 `specdrive`와 `projects`가  
장기적으로 분리 가능한 방향을 전제로 정리한다.
