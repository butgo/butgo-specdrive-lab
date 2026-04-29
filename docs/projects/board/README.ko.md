# docs/projects/board/README.ko.md

[English](README.md) | 한국어

## 1. 문서 목적

이 문서는 `docs/projects/board/**` 영역의 **대표 진입 문서**다.

목적은 다음과 같다.

- board 프로젝트의 현재 정체성과 목표를 설명한다.
- board 문서군이 다루는 범위와 역할을 정리한다.
- specdrive 문서와 board 문서의 경계를 구분한다.
- board 문서를 어떤 순서로 읽어야 하는지 안내한다.
- 현재 단계에서 board를 어떻게 이해해야 하는지 고정한다.

이 문서는 board 영역 전체의 방향과 개요를 설명하는 문서이며,  
세부 작업 규칙은 `docs/projects/board/AGENTS.md`,  
현재 상태 복구는 `docs/AI_CONTEXT.md`,  
상세 문서 목록은 `docs/projects/board/index.md` 와 개별 문서를 따른다.

---

## 2. board를 무엇으로 보는가

board는 specdrive의 하위 기능이 아니다.  
board는 **specdrive가 다루는 첫 번째 실제 애플리케이션 프로젝트**다.

현재 board는 다음과 같이 이해해야 한다.

- 실제 애플리케이션 개발 스펙 문서군
- 문서 기반 AI 협업 흐름을 검증하는 대상 프로젝트
- 요구사항 / 설계 / 구현 계획 / 상태 / 히스토리 구조를 실제로 운영해 보는 프로젝트
- specdrive의 문서 기반 개발 방식이 실제 프로젝트에도 유효한지 검증하는 프로젝트

즉 board는 단순 예시 문서가 아니라,  
**실제 개발 프로젝트 문서를 다루는 작업공간**이다.

---

## 3. 왜 board 프로젝트를 두는가

specdrive는 협업 방식을 다루는 도구이지만,  
그 방식이 실제 프로젝트에도 유효한지는 별도 검증이 필요하다.

board 프로젝트를 두는 이유는 다음과 같다.

- 문서 우선 개발 흐름이 실제 프로젝트에서 작동하는지 확인한다.
- 요구사항 → 설계 → 구현 계획 → 상태 → 히스토리 흐름을 실제로 운영해 본다.
- AI가 실제 프로젝트 문서를 기준으로 협업할 때 어떤 문제가 생기는지 확인한다.
- specdrive의 `doc` / `dev` 흐름이 실제 프로젝트에 적용 가능한지 검증한다.
- 향후 다른 프로젝트에도 재사용 가능한 문서 구조와 작업 흐름을 점검한다.

즉 board는  
**specdrive를 설명하기 위한 예시**가 아니라,  
**specdrive 방식으로 실제 개발을 검증하는 프로젝트**다.

---

## 4. board의 현재 방향

현재 board는 다음 방향을 기준으로 한다.

- Spring Boot 기반 레이어드 구조를 우선 검증 대상으로 본다.
- 처음부터 과한 추상화나 복잡한 구조를 도입하지 않는다.
- 현재 검증 단계에 필요한 최소 범위부터 문서화하고 구현한다.
- 요구사항, 설계, 구현 계획, 상태, 히스토리를 가능한 한 분리한다.
- 공통 standards 문서를 참조하되, board에 실제로 어떻게 적용할지는 board 문서에서 명확히 적는다.

현재 단계에서는  
board를 “완성된 제품”보다  
**문서 기반 개발 흐름 검증 대상 프로젝트**로 보는 것이 더 중요하다.

---

## 5. board와 specdrive의 관계

board와 specdrive는 현재 같은 저장소 안에 있지만, 역할은 다르다.

### 5.1 specdrive
specdrive는 다음을 다룬다.

- 문서 기반 AI 협업 흐름
- 세션 시작과 문맥 복구
- 문서 보강 / 확정 / 히스토리 저장 절차
- task 분해와 상태 관리 흐름
- repo-local skill-first 흐름과 향후 wizard 방식 안내 후보
- 협업 운영 규칙

즉 specdrive는  
**어떻게 협업할 것인가**를 다룬다.

### 5.2 board
board는 다음을 다룬다.

- board 요구사항
- board 설계
- board 구현 계획
- board 현재 상태
- board 히스토리
- board 전용 판단과 결정 사항

즉 board는  
**무엇을 만들 것인가**를 다룬다.

### 5.3 혼합 금지
board 문서 안에 specdrive 자체 운영 규칙을 중심 내용으로 넣지 않는다.  
반대로 specdrive 문서 안에 board 상세 설계를 넣지 않는다.

---

## 6. board 문서군이 다루는 것

board 문서군은 다음을 다룬다.

- board 프로젝트의 요구사항
- board 구조와 설계
- board 구현 계획
- board 진행 상태
- board 히스토리와 중요한 판단
- board 전용 예외 규칙이나 추가 결정

즉 board 문서군은  
**실제 애플리케이션 프로젝트 문서군**이어야 한다.

---

## 7. board 문서군이 직접 다루지 않는 것

board 문서군은 다음을 직접 다루지 않는다.

- specdrive 자체 skill / 자동화 / 후속 CLI 설계
- specdrive의 skill 구조
- Codex exec 상세 설계
- 저장소 전체 공통 운영 규칙
- 다른 프로젝트에도 공통 적용되는 협업 절차 자체
- specdrive 전용 문서 구조 설명

이런 내용은 루트 문서나 `docs/specdrive/**` 에서 다룬다.

---

## 8. board 문서 구조의 기본 관점

현재 board 문서 구조는 다음 역할을 분리하는 쪽을 우선한다.

- 요구사항
- 설계
- 구현 계획
- 상태
- 히스토리

원칙은 다음과 같다.

### 8.1 문서가 기준이다
문서가 기준이고, 구현은 문서를 따른다.

### 8.2 현재 결정 우선
가능성 나열보다 현재 채택한 설계와 범위를 먼저 기록한다.

### 8.3 문서 역할 분리
요구사항, 설계, 구현 계획, 상태, 히스토리를 가능한 한 분리한다.

### 8.4 최소 범위 우선
현재 검증 단계에 필요한 최소 범위부터 문서화하고 구현한다.

### 8.5 AI가 읽기 쉬운 구조 유지
제목 체계, 용어, 범위 구분, 참조 문서를 일관되게 유지한다.

---

## 9. board의 작업 흐름

board도 전체 흐름에서는 `doc` 단계와 `dev` 단계를 따른다.

### 9.1 doc 단계
board 문서를 구현 가능한 상태로 만드는 단계다.

핵심 흐름:

- reinforce
- confirm
- history-save

기본 의미:

- 현재 board 문서를 AI가 보강한다.
- 사람이 검토하고 확정한다.
- 중요한 판단과 결과를 history로 남긴다.

### 9.2 dev 단계
confirm 된 board 문서를 기준으로 실제 개발 작업을 진행하는 단계다.

핵심 흐름:

- task-split
- phase
- cycle
- status

기본 의미:

- 확정된 board 문서를 기준으로 작업을 분해한다.
- 현재 구현 단계를 phase / cycle로 관리한다.
- 현재 작업 상태를 복구 가능하게 유지한다.

---

## 10. standards와의 관계

`docs/projects/standards/**` 는  
board를 포함한 projects 하위 프로젝트에서 공통으로 참조하는 개발 기준 문서군이다.

예:

- naming
- java coding
- db
- api
- package structure
- git policy

원칙은 다음과 같다.

- standards는 공통 기준이다.
- board 문서는 그 기준을 board에 어떻게 적용하는지를 다룬다.
- standards 본문을 board 문서에 중복 복사하지 않는다.
- board에 필요한 예외나 추가 판단이 있으면 board 문서에 명시한다.

즉 standards는  
**공통 기준**, board는 **실제 적용 판단**을 맡는다.

---

## 11. 현재 우선순위

현재 board 영역의 우선순위는 다음과 같다.

### 우선순위 1
- board의 정체성을 specdrive 하위 기능이 아니라 실제 애플리케이션 프로젝트로 고정
- board 문서와 specdrive 문서의 경계 고정

### 우선순위 2
- board 하위 요구사항 / 설계 / 구현 계획 문서의 최소 세트 정리
- README / AGENTS / index / 개별 문서의 역할 정리

### 우선순위 3
- specdrive의 `doc` / `dev` 흐름을 board 프로젝트 문서에 실제로 적용해 보기
- repo-local skill 및 문서 흐름 검증에 사용할 실제 문서 기반 준비

---

## 12. 권장 읽기 순서

board 작업을 시작할 때는 보통 아래 순서로 읽는다.

1. 루트 `README.md`
2. 루트 `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. `docs/projects/board/AGENTS.md`
6. `docs/projects/board/README.md`
7. `docs/projects/board/index.md`
8. 필요 시 관련 `docs/projects/standards/**` 문서
9. 실제 대상 요구사항 / 설계 / 구현 계획 문서

---

## 13. 최종 정리

`docs/projects/board/README.md` 는 board 프로젝트 문서군을 이해하기 위한 진입 문서다.

board를 다룰 때는 항상 먼저 아래를 확인한다.

- 이 내용은 board 자체 판단인가?
- 이 내용은 specdrive 도구 규칙이 아니라 board 문서에 있어야 하는가?
- 이 내용은 공통 standards로 빼야 하는가?
- 현재 범위와 후속 후보를 구분하고 있는가?
- 현재 검증 단계에 필요한 최소 문서 구조를 강화하고 있는가?

현재 board는 specdrive와 같은 저장소 안에서 함께 운영되지만,  
처음부터 **독립 가능한 실제 애플리케이션 프로젝트 문서군**으로 정리한다.
