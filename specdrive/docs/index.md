# specdrive/docs/index.md

## 1. 문서 목적

이 문서는 `specdrive/docs/**` 아래 문서들의 **목록과 역할을 안내하는 인덱스 문서**다.

목적은 다음과 같다.

- specdrive 영역 문서가 무엇이 있는지 빠르게 파악한다.
- 각 문서의 역할과 읽는 순서를 안내한다.
- 현재 작업 목적에 따라 어떤 문서를 먼저 봐야 하는지 구분한다.
- specdrive 문서 구조를 탐색 가능한 형태로 유지한다.

이 문서는 specdrive의 정체성 자체를 자세히 설명하는 문서가 아니다.  
specdrive의 개요와 방향은 `specdrive/docs/README.md` 를 따른다.  
작업 규칙은 `specdrive/docs/AGENTS.md` 를 따른다.

---

## 2. specdrive 문서군의 역할

`specdrive/docs/**` 는 specdrive 자체의 도구 관점을 다룬다.

즉 이 영역은 다음을 설명한다.

- specdrive의 정체성과 목표
- 문서 기반 AI 협업 흐름
- 세션 시작 방식
- 문맥 복구 방식
- 문서 보강과 동기화 흐름
- `doc` / `dev` / `session` / `git` 단계 구분
- skill 중심 실행 구조의 방향
- specdrive 문서 구조와 역할

이 영역은 **특정 애플리케이션의 요구사항/설계 문서**를 다루지 않는다.  
그 내용은 `docs/projects/**` 에서 다룬다.

---

## 3. 먼저 읽어야 하는 문서

specdrive 작업을 시작할 때는 보통 아래 순서로 읽는다.

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `specdrive/docs/AGENTS.md`
5. `specdrive/docs/README.md`
6. `specdrive/docs/index.md`

그 이후에는 작업 목적에 따라 관련 문서를 따라간다.

---

## 4. 현재 주요 문서 목록

### 4.1 `specdrive/docs/README.md`
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

### 4.2 `specdrive/docs/AGENTS.md`
specdrive 전용 작업 규칙 문서다.

다음 내용을 다룬다.

- specdrive 문서와 자산의 역할/경계
- specdrive와 projects의 분리 기준
- `doc` / `dev` 단계 구분 원칙
- skill / Codex 연동의 방향 원칙
- specdrive를 설계·운영할 때의 금지/주의 사항

이 문서는  
**specdrive 문서를 어떻게 다뤄야 하는가**를 확인할 때 읽는다.

---

### 4.3 `specdrive/docs/index.md`
현재 문서 자체다.

다음 내용을 다룬다.

- specdrive 문서 목록
- 각 문서의 역할
- 권장 읽기 순서
- 작업 목적별 참조 문서 안내

이 문서는  
**specdrive 문서 구조를 빠르게 탐색할 때** 읽는다.

---

### 4.4 Core Concept

- `work-system.md`  
  SpecDrive의 Phase / Cycle / Work Package / Task 기반 작업 운영 체계를 설명한다.

---

### 4.5 `.agents/skills/**` 와 `specdrive/codex-skills/**`
specdrive 실행 자산의 현재 기준 폴더 구조다.

다음 내용을 포함한다.

- `.agents/skills/**`: 현재 repo-local Codex skill 사용본
- `specdrive/codex-skills/**`: 배포/패키징 후보 skill 원본
- `specdrive/config/**`: 명령, 문서 매핑, 경로 규칙, 상태 연결 설정 자산

이 구조는  
**specdrive 문서와 실행 자산의 경계를 함께 따라갈 때** 확인한다.

---

### 4.6 `specdrive/docs/runtime-structure.md`
specdrive 실행 자산 구조의 책임을 설명하는 문서다.

다음 내용을 다룬다.

- `specdrive/scripts/**`, `specdrive/skills/**`, `specdrive/config/**` 의 역할
- `doc` / `dev` / `session` / `git` / `exec` / `common` 하위 구조 구분
- skill / Codex 연결 기준

이 문서는  
**실행 자산 폴더를 실제로 설계하거나 정리할 때** 읽는다.

---

### 4.7 `specdrive/docs/rules/**`
SpecDrive Core 전체 운영 규칙을 두는 문서 영역이다.

다음 내용을 포함할 수 있다.

- `README.md`: Core rules 문서군 안내
- 문서 변경 전파 규칙
- skill 사용본과 배포 후보 원본의 동기화 기준
- script / config / runtime 구조 변경 시 영향 점검 기준
- Codex가 Core 자산을 수정할 때 확인해야 할 공통 운영 규칙

이 영역은 프로젝트에 복사해서 쓰는 템플릿이 아니다.  
프로젝트별 규칙 문서 템플릿은 `specdrive/docs/templates/rules/**` 를 따른다.

---

### 4.8 `specdrive/docs/templates/**`
프로젝트에 복사해서 사용할 문서 템플릿을 두는 문서 영역이다.

다음 내용을 포함한다.

- `work/` 문서 템플릿
- `manual/` 문서 템플릿
- `rules/` 문서 템플릿

`specdrive/docs/templates/rules/**` 는 프로젝트별 `rules/` 문서를 만들기 위한 시작점이다.  
SpecDrive Core 자체의 운영 규칙은 `specdrive/docs/rules/**` 에 둔다.

---

### 4.9 `specdrive/docs/skill-wizard-manual.md`
repo-local skill-first 흐름과 향후 wizard 방식 안내 흐름을 설명하는 운영 매뉴얼이다.

다음 내용을 다룬다.

- 현재 사용하는 repo-local Codex skill 기준
- skill-first 작업 원칙
- wizard 방식으로 승격할 반복 흐름의 조건
- `$session`, `$doc-work`, `$doc-work-ref`, `$doc-work-bundle`, `$git` 흐름의 역할

이 문서는  
**현재 skill-first / wizard 지향 실행 기준 매뉴얼**로 읽는다.

---

### 4.10 `specdrive/docs/flows/**`
SpecDrive의 특정 실행 흐름을 설명하는 문서 영역이다.

다음 내용을 포함한다.

- `doc-reinforce-flow.md`: `doc reinforce-prompt` 와 `doc reinforce` 흐름
- `doc-confirm-flow.md`: `doc confirm-prompt` 검토 흐름
- `doc-history-save-flow.md`: `doc apply-prompt` 기반 반영과 history 저장 흐름

이 영역은 Core 운영 규칙을 두는 곳이 아니다.  
Core 운영 규칙은 `specdrive/docs/rules/**` 를 따른다.

---

### 4.11 `specdrive/docs/stages/**`
SpecDrive의 상위 작업 단계 책임을 설명하는 문서 영역이다.

다음 내용을 포함한다.

- `doc-stage.md`: 기준 문서를 보강, 검토, 반영, history 저장하는 책임
- `plan-stage.md`: 기준 문서를 dev 실행 가능한 작업 구조로 분해하는 책임
- `dev-stage.md`: 현재 Work Package를 기준으로 코딩, 테스트, 동기화하는 책임
- `session-stage.md`: session 단계의 복구, 상태 확인, 저장 보조 책임
- `git-stage.md`: git 단계의 commit, push, PR 전달 단위 준비 책임

---

### 4.12 `specdrive/manual/**`
SpecDrive 사용 절차를 실행자 관점으로 정리하는 매뉴얼 후보 영역이다.

현재 문서:

- `plan-manual.md`: `$plan extract-candidates -> wp-split -> phase-split -> cycle-split -> task-split` 사용 절차
- `dev-manual.md`: `$dev start -> run -> test -> sync` 사용 절차

이 영역은 나중에 SpecDrive 전체 매뉴얼로 통합할 수 있는 실행 매뉴얼 초안을 둔다.

---

### 4.13 `specdrive/docs/doc-stage-testing.md`
현재 `doc` 단계 테스트 상태를 빠르게 복구하는 문서다.

다음 내용을 다룬다.

- 현재 테스트 대상 문서
- `reinforce / confirm-prompt / apply-prompt` 실행 순서
- preview 출력 위치
- 현재 어디까지 검증됐는지
- 다음 테스트 진입점

이 문서는  
**다른 장소나 다음 세션에서 현재 테스트 상태를 바로 복구할 때** 읽는다.

---

### 4.14 `specdrive/docs/stages/session-stage.md`
`session` 단계를 세션 복구/상태 확인/세션 저장 중심 운영 단계로 정리하는 문서다.

다음 내용을 다룬다.

- 왜 `session` 이 `doc`, `dev` 와 분리되어야 하는지
- `$session start-lite`, `$session restore`, `$session start`, `$session status`, `$session save` action 의 역할
- `session` 단계의 출력 형식과 책임 경계

이 문서는  
**세 번째 상위 단계로 `session` 을 도입할 때 역할과 범위를 먼저 고정하려고 할 때** 읽는다.

---

### 4.15 `specdrive/docs/stages/git-stage.md`
`git` 단계를 commit message, push, PR 생성 중심 전달 단계로 정리하는 문서다.

다음 내용을 다룬다.

- 왜 `git` 이 `session` 과 분리되어야 하는지
- `$git-commit`, `$github-pr` skill 의 역할
- Git 전달 단위가 문서 흐름과 연결될 수 있는 위치

이 문서는  
**Git 전달 단위를 별도 상위 단계로 고정하려고 할 때** 읽는다.

---

## 5. 현재 또는 후속으로 유지할 수 있는 문서

아래 문서들은 현재 있거나, 후속으로 유지/정리할 수 있는 문서들이다.  
이 문서들이 실제로 존재하지 않는 경우, 현재는 후보 또는 후속 정리 대상으로 본다.

### 5.1 세션/문맥 관련 문서
예:
- `specdrive/docs/context-recovery.md`

역할:
- 세션 변경 시 어떤 문서로 복귀할지
- 어떤 문맥을 먼저 복구할지
- AI 협업에서 상태 복구를 어떻게 다룰지

---

### 5.2 프롬프트/명령 관련 문서
예:
- `specdrive/docs/prompt-commands.md`
- `specdrive/docs/prompt-routing.md`

역할:
- 프롬프트를 어떤 작업 단위로 나눌지
- 어떤 명령/상황에 어떤 프롬프트를 연결할지
- 문서 작업과 개발 작업 흐름을 어떻게 정규화할지

---

### 5.3 템플릿/자산 설명 문서
예:
- `specdrive/docs/prompt-templates/**`

역할:
- 반복 가능한 프롬프트 템플릿 자산의 구조 설명
- 어떤 템플릿이 어떤 목적을 가지는지 설명
- 실행 자산과 설명 문서의 관계 정리

---

### 5.4 skill / Codex 연동 관련 문서
예:
- skill 관련 설명 문서
- Codex 연동 관련 설명 문서
- `specdrive/docs/flows/doc-reinforce-flow.md`
- `specdrive/docs/flows/doc-confirm-flow.md`
- `specdrive/docs/flows/doc-history-save-flow.md`

역할:
- 현재는 방향 설명 수준으로만 다루고
- 상세 기술 설계는 후속으로 분리해 정리
- `doc reinforce` 같은 최소 흐름은 실제 테스트 문서를 기준으로 먼저 고정
- `doc confirm-prompt`, `doc apply-prompt` 같은 사람 판단/반영 단계도 같은 방식으로 고정

현재 단계에서는 이들보다  
**README / AGENTS / AI_CONTEXT를 먼저 안정화하는 것**이 우선이다.

---

## 6. 작업 목적별 참조 문서

### 6.1 specdrive 정체성을 이해하고 싶을 때
우선 읽을 문서:

1. `specdrive/docs/README.md`
2. `specdrive/docs/AGENTS.md`

---

### 6.2 specdrive 문서를 수정하려고 할 때
우선 읽을 문서:

1. `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. `specdrive/docs/AGENTS.md`
4. `specdrive/docs/README.md`
5. 현재 수정 대상 문서

---

### 6.3 specdrive와 project 문서 경계가 헷갈릴 때
우선 읽을 문서:

1. `docs/README.md`
2. `specdrive/docs/README.md`
3. `docs/projects/README.md`
4. `specdrive/docs/AGENTS.md`

---

### 6.4 skill 기반 작업 흐름을 준비할 때
우선 읽을 문서:

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `specdrive/docs/README.md`
5. `specdrive/docs/AGENTS.md`
6. `specdrive/docs/runtime-structure.md`
7. `specdrive/docs/skill-wizard-manual.md`
8. `specdrive/docs/doc-stage-testing.md`
9. `specdrive/docs/stages/session-stage.md`
10. `specdrive/docs/stages/git-stage.md`
11. `.agents/skills/**`
12. `specdrive/codex-skills/**`
13. 관련 skill 문서

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

`specdrive/docs/index.md` 는  
`specdrive/docs/**` 문서군을 빠르게 탐색하기 위한 인덱스 문서다.

specdrive 문서를 다룰 때는 항상 먼저 아래를 구분한다.

- 지금 필요한 것이 개요 문서인가?
- 작업 규칙 문서인가?
- 상태 복구 문서인가?
- 후속 기술 문서인가?

현재 specdrive는 완성된 제품보다  
**문서 기반 AI 협업 흐름을 반복 가능하게 만드는 엔진/운영체계**로 이해해야 하며,  
이 인덱스 문서는 그 구조를 따라가기 위한 안내판 역할을 한다.
