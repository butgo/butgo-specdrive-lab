# docs/specdrive/index.md

## 1. 문서 목적

이 문서는 `docs/specdrive/**` 아래 문서들의 **목록과 역할을 안내하는 인덱스 문서**다.

목적은 다음과 같다.

- specdrive 영역 문서가 무엇이 있는지 빠르게 파악한다.
- 각 문서의 역할과 읽는 순서를 안내한다.
- 현재 작업 목적에 따라 어떤 문서를 먼저 봐야 하는지 구분한다.
- specdrive 문서 구조를 탐색 가능한 형태로 유지한다.

이 문서는 specdrive의 정체성 자체를 자세히 설명하는 문서가 아니다.  
specdrive의 개요와 방향은 `docs/specdrive/README.md` 를 따른다.  
작업 규칙은 `docs/specdrive/AGENTS.md` 를 따른다.

---

## 2. specdrive 문서군의 역할

`docs/specdrive/**` 는 specdrive 자체의 도구 관점을 다룬다.

즉 이 영역은 다음을 설명한다.

- specdrive의 정체성과 목표
- 문서 기반 AI 협업 흐름
- 세션 시작 방식
- 문맥 복구 방식
- 문서 보강과 동기화 흐름
- `doc` / `dev` / `session` / `git` 단계 구분
- CLI 중심 실행 구조의 방향
- specdrive 문서 구조와 역할

이 영역은 **특정 애플리케이션의 요구사항/설계 문서**를 다루지 않는다.  
그 내용은 `docs/projects/**` 에서 다룬다.

---

## 3. 먼저 읽어야 하는 문서

specdrive 작업을 시작할 때는 보통 아래 순서로 읽는다.

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/README.md`
6. `docs/specdrive/index.md`

그 이후에는 작업 목적에 따라 관련 문서를 따라간다.

---

## 4. 현재 주요 문서 목록

### 4.1 `docs/specdrive/README.md`
specdrive 자체의 대표 진입 문서다.

다음 내용을 다룬다.

- specdrive의 현재 정체성
- specdrive의 목표
- specdrive와 projects의 관계
- `doc` / `dev` / `session` / `git` 작업 단계 개요
- 현재 기술 방향
- 현재 우선순위

이 문서는  
**specdrive가 무엇인가**를 먼저 이해할 때 읽는다.

---

### 4.2 `docs/specdrive/AGENTS.md`
specdrive 전용 작업 규칙 문서다.

다음 내용을 다룬다.

- specdrive 문서와 자산의 역할/경계
- specdrive와 projects의 분리 기준
- `doc` / `dev` 단계 구분 원칙
- CLI / skill / Codex 연동의 방향 원칙
- specdrive를 설계·운영할 때의 금지/주의 사항

이 문서는  
**specdrive 문서를 어떻게 다뤄야 하는가**를 확인할 때 읽는다.

---

### 4.3 `docs/specdrive/index.md`
현재 문서 자체다.

다음 내용을 다룬다.

- specdrive 문서 목록
- 각 문서의 역할
- 권장 읽기 순서
- 작업 목적별 참조 문서 안내

이 문서는  
**specdrive 문서 구조를 빠르게 탐색할 때** 읽는다.

---

### 4.4 `specdrive/{scripts,skills,config}`
specdrive 실행 자산의 현재 기준 폴더 구조다.

다음 내용을 포함한다.

- `specdrive/scripts/**`: CLI 실행 흐름과 단계별 스크립트 자산
- `specdrive/skills/**`: 반복 작업 정규화를 위한 내부 작업 자산
- `specdrive/config/**`: 명령, 문서 매핑, 경로 규칙, 상태 연결 설정 자산

이 구조는  
**specdrive 문서와 실행 자산의 경계를 함께 따라갈 때** 확인한다.

---

### 4.5 `docs/specdrive/runtime-structure.md`
specdrive 실행 자산 구조의 책임을 설명하는 문서다.

다음 내용을 다룬다.

- `specdrive/scripts/**`, `specdrive/skills/**`, `specdrive/config/**` 의 역할
- `doc` / `dev` / `session` / `git` / `exec` / `common` 하위 구조 구분
- CLI / Codex / skill 연결 기준

이 문서는  
**실행 자산 폴더를 실제로 설계하거나 정리할 때** 읽는다.

---

### 4.6 `docs/specdrive/doc-stage-testing.md`
현재 `doc` 단계 테스트 상태를 빠르게 복구하는 문서다.

다음 내용을 다룬다.

- 현재 테스트 대상 문서
- `reinforce / confirm / history-save` 실행 순서
- preview 출력 위치
- 현재 어디까지 검증됐는지
- 다음 테스트 진입점

이 문서는  
**다른 장소나 다음 세션에서 현재 테스트 상태를 바로 복구할 때** 읽는다.

---

### 4.7 `docs/specdrive/cli-manual.md`
현재 specdrive CLI 테스트 방법을 설명하는 운영 매뉴얼이다.

다음 내용을 다룬다.

- 현재 실행 방식과 장기 방향의 구분
- `doc` 단계 명령별 역할
- PowerShell 실행 예시
- preview 출력 위치
- 현재 테스트 시 확인 포인트

이 문서는  
**실제로 명령을 실행해보려는 사람이 바로 따라갈 때** 읽는다.

---

### 4.8 `docs/specdrive/cli-key-routing.md`
specdrive CLI를 키 기반 연결 구조로 확장하기 위한 설계 초안이다.

다음 내용을 다룬다.

- `target key`, `skill key`, `context-set key` 분리 방향
- registry 기반 config 구조
- 비대화식 입력과 선택형 입력의 역할 분리
- `codex-exec.ps1` 를 execution wrapper 로 유지하는 기준

이 문서는  
**CLI를 다음 단계로 구조화하려고 할 때** 읽는다.

현재 이 문서는 순수 아이디어 메모가 아니라,  
이미 반영된 key 기반 registry 구조와 아직 남아 있는 legacy fallback 을 함께 설명하는 문서로 보는 편이 맞다.

---

### 4.9 `docs/specdrive/cli-single-entry.md`
`specdrive/specdrive.ps1` 단일 진입점을 어떤 책임으로 도입할지 정리하는 최소 설계 문서다.

다음 내용을 다룬다.

- `specdrive/specdrive.ps1` 의 역할과 비역할
- `doc` / `dev` / `session` / `git` 단계 상위 분기 기준
- 기존 하위 스크립트와의 책임 분리
- 현재 단계에서 넣지 않을 범위

이 문서는  
**단일 진입 CLI를 실제로 만들기 전에 상위 라우터의 경계를 먼저 고정할 때** 읽는다.

---

### 4.10 `docs/specdrive/session-stage.md`
`session` 단계를 세션 복구/상태 확인/세션 저장 중심 운영 단계로 정리하는 문서다.

다음 내용을 다룬다.

- 왜 `session` 이 `doc`, `dev` 와 분리되어야 하는지
- `session start`, `session status`, `session save` 의 역할
- `session` 단계의 출력 계약과 책임 경계

이 문서는  
**세 번째 상위 단계로 `session` 을 도입할 때 역할과 범위를 먼저 고정하려고 할 때** 읽는다.

---

### 4.11 `docs/specdrive/git-stage.md`
`git` 단계를 브랜치명, commit message, PR 메시지 생성 중심 전달 단계로 정리하는 문서다.

다음 내용을 다룬다.

- 왜 `git` 이 `session` 과 분리되어야 하는지
- `git branch-name`, `git git-message`, `git pr-message` 의 역할
- 브랜치명 생성이 phase/cycle 및 문서 흐름과 연결될 수 있는 위치

이 문서는  
**Git 전달 단위를 별도 상위 단계로 고정하려고 할 때** 읽는다.

---

## 5. 현재 또는 후속으로 유지할 수 있는 문서

아래 문서들은 현재 있거나, 후속으로 유지/정리할 수 있는 문서들이다.  
이 문서들이 실제로 존재하지 않는 경우, 현재는 후보 또는 후속 정리 대상으로 본다.

### 5.1 세션/문맥 관련 문서
예:
- `docs/specdrive/context-recovery.md`

역할:
- 세션 변경 시 어떤 문서로 복귀할지
- 어떤 문맥을 먼저 복구할지
- AI 협업에서 상태 복구를 어떻게 다룰지

---

### 5.2 프롬프트/명령 관련 문서
예:
- `docs/specdrive/prompt-commands.md`
- `docs/specdrive/prompt-routing.md`

역할:
- 프롬프트를 어떤 작업 단위로 나눌지
- 어떤 명령/상황에 어떤 프롬프트를 연결할지
- 문서 작업과 개발 작업 흐름을 어떻게 정규화할지

---

### 5.3 템플릿/자산 설명 문서
예:
- `docs/specdrive/prompt-templates/**`

역할:
- 반복 가능한 프롬프트 템플릿 자산의 구조 설명
- 어떤 템플릿이 어떤 목적을 가지는지 설명
- 실행 자산과 설명 문서의 관계 정리

---

### 5.4 CLI / skill / Codex 연동 관련 문서
예:
- CLI 관련 설명 문서
- skill 관련 설명 문서
- Codex 연동 관련 설명 문서
- `docs/specdrive/doc-reinforce-flow.md`
- `docs/specdrive/doc-confirm-flow.md`

역할:
- 현재는 방향 설명 수준으로만 다루고
- 상세 기술 설계는 후속으로 분리해 정리
- `doc reinforce` 같은 최소 흐름은 실제 테스트 문서를 기준으로 먼저 고정
- `doc confirm` 같은 사람 판단 단계도 같은 방식으로 고정

현재 단계에서는 이들보다  
**README / AGENTS / AI_CONTEXT를 먼저 안정화하는 것**이 우선이다.

---

## 6. 작업 목적별 참조 문서

### 6.1 specdrive 정체성을 이해하고 싶을 때
우선 읽을 문서:

1. `docs/specdrive/README.md`
2. `docs/specdrive/AGENTS.md`

---

### 6.2 specdrive 문서를 수정하려고 할 때
우선 읽을 문서:

1. `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. `docs/specdrive/AGENTS.md`
4. `docs/specdrive/README.md`
5. 현재 수정 대상 문서

---

### 6.3 specdrive와 project 문서 경계가 헷갈릴 때
우선 읽을 문서:

1. `docs/README.md`
2. `docs/specdrive/README.md`
3. `docs/projects/README.md`
4. `docs/specdrive/AGENTS.md`

---

### 6.4 CLI 테스트나 명령 흐름을 준비할 때
우선 읽을 문서:

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/README.md`
5. `docs/specdrive/AGENTS.md`
6. `docs/specdrive/runtime-structure.md`
7. `docs/specdrive/doc-stage-testing.md`
8. `docs/specdrive/cli-manual.md`
9. `docs/specdrive/cli-key-routing.md`
10. `docs/specdrive/cli-single-entry.md`
11. `docs/specdrive/session-stage.md`
12. `docs/specdrive/git-stage.md`
13. `specdrive/scripts/**`, `specdrive/skills/**`, `specdrive/config/**`
14. 관련 명령/프롬프트 문서

---

## 7. 현재 문서 구조에서 중요한 원칙

specdrive 문서를 다룰 때는 다음을 계속 확인한다.

- 이 문서가 specdrive 자체를 설명하는 문서인가?
- 이 문서가 작업 규칙 문서인가?
- 이 문서가 현재 상태 복구 문서인가?
- 이 문서가 실제 프로젝트 문서와 역할이 섞이지 않았는가?
- 이 문서가 현재 단계의 최소 흐름을 강화하는가?

현재 단계에서는 문서를 많이 늘리는 것보다  
**역할이 선명한 진입 문서를 먼저 고정하는 것**이 더 중요하다.

---

## 8. 최종 정리

`docs/specdrive/index.md` 는  
`docs/specdrive/**` 문서군을 빠르게 탐색하기 위한 인덱스 문서다.

specdrive 문서를 다룰 때는 항상 먼저 아래를 구분한다.

- 지금 필요한 것이 개요 문서인가?
- 작업 규칙 문서인가?
- 상태 복구 문서인가?
- 후속 기술 문서인가?

현재 specdrive는 완성된 제품보다  
**문서 기반 AI 협업 흐름을 반복 가능하게 만드는 엔진/운영체계**로 이해해야 하며,  
이 인덱스 문서는 그 구조를 따라가기 위한 안내판 역할을 한다.
