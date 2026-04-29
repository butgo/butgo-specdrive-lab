# docs/specdrive/README.ko.md

[English](README.md) | [한국어](README.ko.md)

## 1. 문서 목적

이 문서는 `docs/specdrive/**` 영역의 **대표 진입 문서**다.

목적은 다음과 같다.

- specdrive의 현재 정체성과 목표를 설명한다.
- specdrive 문서가 다루는 범위와 역할을 정리한다.
- specdrive와 projects의 경계를 구분한다.
- specdrive 문서를 어떤 순서로 읽어야 하는지 안내한다.
- 현재 단계에서 specdrive를 어떻게 이해해야 하는지 고정한다.

이 문서는 specdrive 영역 전체의 방향과 개요를 설명하는 문서이며,  
세부 작업 규칙은 `docs/specdrive/AGENTS.md`,  
현재 상태 복구는 `docs/AI_CONTEXT.md`,  
세부 목록은 `docs/specdrive/index.md` 와 개별 문서를 따른다.

---

## 2. specdrive를 무엇으로 보는가

specdrive는 **개발 스펙 문서를 기반으로 AI 협업을 실행하는 도구**다.

현재 specdrive는 다음과 같이 이해해야 한다.

- 문서 기반 AI 협업 엔진
- 반복 가능한 작업 흐름을 위한 운영체계
- **repo-local Codex skill-first** 작업 오케스트레이터
- 반복 검증된 흐름을 위한 향후 **wizard 방식의 안내형 작업 흐름** 계층
- 실제 프로젝트 문서를 읽고 협업 흐름을 실행하는 도구

즉 specdrive는 현재 **완성된 SaaS 제품**이라기보다,  
**AI 협업 개발의 core workflow를 검증하는 엔진/운영체계**에 가깝다.

현재 기준으로는 여기에 한 가지를 더 분명히 봐야 한다.

- `.speclab/**` 은 실행 중간 산출물이다.
- 실제 남겨야 할 것은 project 문서와 그 문서의 이력이다.
- 의미 있는 문서 작업은 `docs/history/projects/**` 아래에 문서대장처럼 남아야 한다.

즉 specdrive의 핵심은 preview 보관이 아니라  
**문서 기반 AI 협업 흐름을 실행하고, 그 결과를 실제 문서와 문서 이력으로 정착시키는 것**이다.

현재 단계에서 이 말은 순서가 분명하다는 뜻이다.

1. 먼저 repo-local skill로 흐름을 검증한다.
2. 반복 action의 형태와 사람 확인 지점을 안정화한다.
3. 그다음 안정화된 흐름을 wizard 방식의 안내형 경험으로 승격한다.

---

## 3. 왜 specdrive 문서가 필요한가

AI 협업은 빠르게 결과를 만들 수 있지만,  
문맥과 구조가 불분명하면 결과가 쉽게 흔들린다.

예를 들면 다음 문제가 생기기 쉽다.

- 현재 범위를 벗어난 확장
- 구조 경계 붕괴
- 세션 변경 시 맥락 유실
- 문서와 구현의 기준 불일치
- 같은 작업을 반복할 때 품질 편차 발생

specdrive 문서는 이런 문제를 줄이기 위해 존재한다.

즉 specdrive 문서는:

- AI가 무엇을 기준으로 일해야 하는지 정하고
- 어떤 절차로 문서를 보강하고
- 어떤 절차로 개발로 넘어가며
- 어떤 상태와 흔적을 남길지를

반복 가능한 형태로 정리하는 역할을 한다.

---

## 4. 현재 specdrive의 핵심 관점

현재 specdrive에서 가장 중요한 관점은 다음과 같다.

### 4.1 문서 우선
문서가 기준이다.  
구현은 문서를 따른다.

### 4.2 사람 확정 우선
AI가 보강한 문서는 초안 또는 보강안일 뿐이다.  
사람이 confirm 하기 전에는 기준 문서가 아니다.

### 4.3 단계 분리
문서를 다듬는 단계와  
문서를 기준으로 실제 개발을 진행하는 단계를 분리한다.

### 4.4 최소 흐름 우선
현재는 거대한 제품 구조보다  
실제로 반복 가능한 최소 작업 흐름을 먼저 고정한다.

### 4.5 Codex 중심 검증
현재는 Codex를 기준으로 협업 흐름을 정리하고 검증한다.

---

## 5. specdrive의 작업 단계

현재 specdrive는 핵심 작업 흐름을 `doc` 과 `dev` 로 나누고,  
`session` 을 운영 단계로, `git` 을 전달 단계로 둔다.

### 5.1 doc 단계
문서를 구현 가능한 상태로 만드는 단계다.

핵심 흐름:

- draft-save
- reinforce-prompt
- reinforce
- confirm-prompt
- apply-prompt
- apply-only-prompt

기본 의미:

- 현재 문서를 AI가 보강한다.
- 사람이 정규화된 검토 프롬프트로 보강 결과를 확인한다.
- 의미 있는 반영 결과와 history 초안을 함께 준비한다.

현재 기준으로 더 정확히 적으면 다음과 같다.

- `draft-save`: Codex 보강 전에 현재 개발자 초안을 history 로 저장한다.
- `reinforce-prompt`: Codex 대화를 specdrive 규칙 안에서 시작할 수 있도록 정규화된 copy prompt 를 만든다.
- `reinforce`: 보강안과 review 산출물을 만들고, 필요 시 실제 Codex 실행 테스트 경로를 유지한다.
- `confirm-prompt`: 실제 문서 반영 전에 검토/확인용 copy prompt 를 만든다.
- `apply-prompt`: 실제 문서 반영과 history 저장 초안을 함께 준비하는 copy prompt 를 만든다.
- `apply-only-prompt`: history 없이 문서 반영만 필요한 예외 경로용 copy prompt 를 만든다.

현재 기준에서는 한 가지를 더 분명히 본다.

문서 작업은 “자동화가 전부 적용하는 흐름”보다  
다음 같은 명시적 history 중심 루프로 이해하는 편이 더 맞다.

1. 개발자가 초안을 작성한다.
2. `draft-save` 로 초안을 history 로 남긴다.
3. `reinforce-prompt` 로 정규화된 Codex 대화를 시작한다.
4. 개발자와 Codex가 direct 또는 interactive 방식으로 문서를 함께 다듬는다.
5. `confirm-prompt` 로 반영 가능 여부를 검토한다.
6. `apply-prompt` 로 의미 있는 반영 결과와 history 초안을 준비한다.
7. 필요 시 반복한다.

즉 현재 specdrive는 repo-local skill을 통해  
프롬프트를 정규화하고 문서 이력 루프를 안정적으로 유지하는 흐름으로 보는 편이 맞다.

### 5.2 dev 단계
확정된 문서를 기준으로 실제 개발 작업을 진행하는 단계다.

핵심 흐름:

- task-split
- phase
- cycle
- status

기본 의미:

- confirm 된 문서를 기준으로 작업을 분해한다.
- 현재 개발 단계를 phase / cycle로 관리한다.
- 현재 작업 상태를 복구 가능하게 유지한다.

### 5.3 session 단계
세션을 시작하고 닫는 운영 단계다.

현재 skill 흐름 예:

- `$session start-lite`
- `$session start`
- `$session status`
- `$session save`

기본 의미:

- 세션 시작 시 현재 상태와 다음 진입점을 복구한다.
- 세션 종료 시 세션 메모와 다음 진입점을 정리한다.

현재 `$session start` 는 자동 작업 시작 명령으로 보기보다  
Codex가 관련 문서를 읽고 현재 상태를 복구한 뒤, 먼저 focus 와 다음 진입점을 정리하게 만드는 copy prompt 출력 action으로 이해하는 편이 맞다.  
즉 복구 요약을 먼저 보고, 개발자가 실제 작업을 요청한 뒤에만 문서 수정이나 후속 작업으로 들어간다.

현재 `$session save` 는 자동 저장 명령으로 보기보다  
`docs/AI_CONTEXT.md` 반영 초안을 Codex에게 요청하는 copy prompt 출력 action으로 이해하는 편이 맞다.  
즉 copy prompt 로 초안을 만든 뒤, 개발자가 검토하고 "저장해줘" 라고 명시적으로 요청한 경우에만 실제 반영을 진행한다.

현재 `$session status` 는 copy prompt를 만들지 않고  
간단한 현재 상태를 읽기 전용으로 확인하는 action으로 이해하는 편이 맞다.  
즉 복구 확인용 조회에 가깝고, 직접 수정이나 저장을 시작하는 명령은 아니다.

### 5.4 git 단계
브랜치명, Git commit message, PR 제목/설명 생성을 다루는 전달 단계다.

현재 skill 흐름 예:

- `git-commit`
- `github-pr`

기본 의미:

- 현재 브랜치와 변경 파일을 읽는다.
- 안전한 commit 제안을 준비한다.
- 명시 승인 후에만 commit/push를 수행한다.
- 명시 승인 후에만 GitHub PR을 생성한다.

---

## 6. specdrive가 다루는 것

현재 specdrive는 다음을 다룬다.

- 문서 기반 AI 협업 흐름
- 세션 시작과 문맥 복구
- 세션 저장과 다음 진입점 보존
- Git commit 및 GitHub PR workflow 지원
- 문서 보강 / 검토 / 반영 / 히스토리 저장 절차
- task 분해 절차
- phase / cycle / status 관리 방향
- repo-local Codex skill 구조
- prompt / skill / 상태 관리 자산의 역할 구분
- 실제 프로젝트에 적용 가능한 운영 방식 검증

---

## 7. specdrive가 직접 다루지 않는 것

현재 specdrive 문서가 직접 다루지 않는 것은 다음과 같다.

- 특정 애플리케이션의 상세 요구사항
- 특정 프로젝트의 API / DB / 패키지 설계
- 개별 프로젝트의 도메인 정책
- 완성된 SaaS UI 설계
- 조직 / 사용자 / 결제 기능
- 멀티 AI 엔진 일반화
- 운영 / 배포 자동화

이런 내용은 project 문서 또는 후속 단계에서 다룬다.

---

## 8. specdrive와 projects의 관계

specdrive와 projects는 현재 같은 저장소 안에 있지만, 역할은 다르다.

### specdrive
- 협업 방식을 다룬다
- 문맥, 절차, 명령, 상태 흐름을 다룬다
- 어떻게 일할 것인가를 다룬다

### projects
- 실제 애플리케이션 내용을 다룬다
- 요구사항, 설계, 구현 계획, 상태를 다룬다
- 무엇을 만들 것인가를 다룬다

현재는 둘을 함께 운영하면서 검증하지만,  
장기적으로는 분리 가능한 구조를 전제로 한다.

---

## 9. 현재 기술 방향

현재 specdrive의 기술 방향은 다음과 같다.

- AI 엔진: Codex 중심
- 실행 인터페이스: repo-local Codex skill
- 목표: 최소 작업 흐름 검증
- 현재 저장소 성격: 알파 통합 검증 저장소
- 추후 후보: Go 또는 Python 재구현 가능
- 현재는 멀티 AI 엔진 지원을 우선하지 않음

즉 지금은 범용 플랫폼보다  
**작동하는 최소 운영체계**를 먼저 만들고 검증하는 단계다.

---

## 10. specdrive 문서와 자산의 관계

현재 specdrive 관련 자산은 대략 다음 관계를 가진다.

### 10.1 `docs/specdrive/**`
- specdrive의 개념
- 규칙
- 구조
- 흐름 설명

### 10.2 `specdrive/scripts/**`
- specdrive 실행 스크립트
- workflow 처리 흐름
- 상태/경로/출력 보조

### 10.3 `specdrive/skills/**`
- 반복 작업 정규화를 위한 내부 작업 자산
- 예: 문서 보강, 히스토리 저장, 작업 분해

### 10.4 `specdrive/config/**`
- 문서 매핑
- 경로 규칙
- skill/상태와 연결되는 설정 자산

즉 문서는 설명과 기준을 제공하고,  
skill, script, config 는 필요한 경우 그 기준을 실행 가능한 형태로 연결한다.

---

## 11. 현재 우선순위

현재 specdrive의 우선순위는 다음과 같다.

### 우선순위 1
- README / AGENTS / AI_CONTEXT 정합성 확보
- specdrive 정체성과 작업 규칙 고정

### 우선순위 2
- `doc` / `dev` 단계 구분을 문서와 명령 차원에서 고정
- `session` 을 별도 운영 단계로 고정
- `git` 을 별도 전달 단계로 고정
- Codex가 프로젝트 성격을 안정적으로 이해하도록 만들기

### 우선순위 3
- 최소 repo-local skill 흐름 검증
- `doc reinforce / confirm-prompt / apply-prompt`
- `dev phase / cycle / status / task-split`
- `$session start-lite / $session start / $session status / $session save`
- `$git-commit / $github-pr`

### 우선순위 4
- 후속 기술 문서 정리
- skill / 후속 CLI / Codex 연동 상세 설계

---

## 12. 권장 읽기 순서

specdrive 작업을 시작할 때는 보통 아래 순서로 읽는다.

1. 루트 `README.md`
2. 루트 `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/README.md`
6. `docs/specdrive/index.md`
7. 대상 specdrive 문서

---

## 13. 최종 정리

`docs/specdrive/README.md` 는 specdrive 자체를 설명하는 진입 문서다.

specdrive를 다룰 때는 항상 먼저 아래를 확인한다.

- 지금 다루는 내용이 specdrive 자체 규칙인가?
- 현재 단계가 엔진/운영체계 검증 단계라는 점이 반영되어 있는가?
- `doc` 과 `dev` 의 책임이 섞이지 않았는가?
- project 문서의 내용을 specdrive 문서로 잘못 끌고 오지 않았는가?
- 지금 필요한 최소 흐름을 강화하는 방향인가?

현재 specdrive는 완성된 제품보다  
**문서 기반 AI 협업 흐름을 반복 가능하게 만드는 도구**로 이해해야 한다.

