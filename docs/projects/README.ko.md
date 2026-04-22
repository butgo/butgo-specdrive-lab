# docs/projects/README.ko.md

[English](README.md) | [한국어](README.ko.md)

## 1. 문서 목적

이 문서는 `docs/projects/**` 영역의 **대표 진입 문서**다.

목적은 다음과 같다.

- projects 영역의 정체성과 역할을 설명한다.
- specdrive와 projects의 관계를 구분한다.
- projects 하위 문서가 무엇을 다루는지 정리한다.
- 개별 애플리케이션 프로젝트 문서를 어떤 순서로 읽어야 하는지 안내한다.
- 공통 standards 문서와 프로젝트 문서의 관계를 설명한다.

이 문서는 projects 영역 전체의 방향과 개요를 설명하는 문서이며,  
세부 작업 규칙은 각 프로젝트의 `AGENTS.md`,  
현재 상태 복구는 `docs/AI_CONTEXT.md`,  
프로젝트별 상세 구조는 각 하위 `README.md`, `index.md`, 개별 문서를 따른다.

---

## 2. projects를 무엇으로 보는가

`projects`는 **실제 애플리케이션의 개발 스펙 문서 작업공간**이다.

여기서 다루는 것은 다음과 같다.

- 요구사항
- 설계
- 구현 계획
- 상태
- 히스토리
- 애플리케이션별 결정 사항

즉 `projects`는  
**무엇을 만들 것인가**를 다루는 영역이다.

현재는 specdrive의 운영 방식을 실제 프로젝트에 적용해 보기 위해  
같은 저장소 안에서 함께 운영하고 있다.

다만 장기적으로는 specdrive와 projects가  
분리 가능한 구조를 전제로 한다.

---

## 3. projects와 specdrive의 관계

현재 저장소에서 specdrive와 projects는 함께 존재하지만,  
둘의 역할은 분명히 다르다.

### 3.1 specdrive
specdrive는 다음을 다룬다.

- 문서 기반 AI 협업 흐름
- 세션 시작과 문맥 복구
- 문서 보강 / 확정 / 히스토리 저장 절차
- task 분해와 상태 관리 흐름
- CLI 명령 구조
- 협업 운영 규칙

즉, specdrive는  
**어떻게 협업할 것인가**를 다룬다.

### 3.2 projects
projects는 다음을 다룬다.

- 요구사항
- 설계
- 구현 계획
- 현재 상태
- 프로젝트별 판단 이력

즉, projects는  
**무엇을 만들 것인가**를 다룬다.

### 3.3 혼합 금지
projects 문서 안에 specdrive 자체 운영 규칙을 중심 내용으로 넣지 않는다.  
반대로 specdrive 문서 안에 특정 프로젝트 상세 설계를 넣지 않는다.

---

## 4. projects의 현재 역할

현재 projects는 단순 예시 문서 모음이 아니다.

현재 projects는 다음 역할을 가진다.

- specdrive 방식이 실제 프로젝트에도 유효한지 검증한다.
- 문서 기반 AI 협업 흐름을 실제 애플리케이션에 적용한다.
- 요구사항 / 설계 / 구현 계획 / 상태 / 히스토리 구조를 실제로 운영해 본다.
- 향후 여러 프로젝트에 반복 적용 가능한 작업 구조를 검증한다.

즉 projects는  
**specdrive의 검증 대상이자 실제 적용 공간**이다.

---

## 5. projects 하위 구조

현재 `docs/projects/**` 는 크게 다음 층으로 나뉜다.

### 5.1 프로젝트 공통 진입 문서
예:
- `docs/projects/README.md`

역할:
- projects 전체 정체성 설명
- 하위 프로젝트 문서 읽기 전 공통 안내

### 5.2 개별 애플리케이션 프로젝트 문서
예:
- `docs/projects/board/**`

역할:
- 특정 애플리케이션의 요구사항, 설계, 구현 계획, 상태, 히스토리 관리

### 5.3 프로젝트 공통 기준 문서
위치:
- `docs/projects/standards/**`

역할:
- 여러 프로젝트에서 공통으로 참조하는 개발 기준 문서 관리

---

## 6. board를 어떻게 보는가

현재 첫 번째 실제 프로젝트 예시는 `board`다.

board는 specdrive의 하위 기능이 아니다.  
board는 **specdrive가 다루는 첫 번째 실제 애플리케이션 프로젝트**다.

현재 board는 다음 목적을 가진다.

- specdrive 문서 흐름을 실제 프로젝트에 적용해 본다.
- 요구사항 → 설계 → 구현 계획 → 상태 → 히스토리 흐름을 검증한다.
- 문서 기반 AI 협업이 실제 개발 프로젝트에서 유효한지 확인한다.
- 현재는 Spring Boot 기반 레이어드 구조 예시를 우선 검증한다.

즉 board는  
**실제 애플리케이션 프로젝트 문서군**으로 다뤄야 한다.

---

## 7. standards와의 관계

`docs/projects/standards/**` 는  
projects 하위에서 공통으로 사용하는 개발 기준 문서군이다.

예:

- naming
- java coding
- db
- api
- package structure
- git policy

원칙은 다음과 같다.

- standards는 공통 기준이다.
- 개별 프로젝트 문서는 standards를 참조해서 적용한다.
- standards 본문을 프로젝트 문서에 중복 복사하지 않는다.
- 프로젝트별 예외나 추가 판단이 있으면 해당 프로젝트 문서에 명시한다.

즉 standards는  
**공통 기준**, projects는 **실제 적용 판단**을 맡는다.

---

## 8. projects 문서가 다루는 것

projects 문서는 다음을 다룬다.

- 현재 프로젝트의 요구사항
- 현재 프로젝트의 설계와 구조
- 현재 프로젝트의 구현 계획
- 현재 프로젝트의 상태
- 현재 프로젝트의 히스토리
- 현재 프로젝트의 결정 사항
- 필요 시 프로젝트별 예외 규칙

---

## 9. projects 문서가 직접 다루지 않는 것

projects 문서는 다음을 직접 다루지 않는다.

- specdrive 자체 CLI 설계
- specdrive의 skill 구조
- Codex exec 상세 설계
- 저장소 전체 공통 운영 규칙
- 다른 프로젝트에도 공통 적용되는 협업 절차 자체

이런 내용은 루트 문서 또는 `docs/specdrive/**` 에서 다룬다.

---

## 10. 현재 문서 작업 원칙

projects 영역에서는 다음 원칙을 유지한다.

### 10.1 문서 우선
문서가 기준이고, 구현은 문서를 따른다.

### 10.2 현재 결정 우선
가능성 나열보다 현재 채택한 설계와 범위를 먼저 기록한다.

### 10.3 문서 역할 분리
요구사항, 설계, 구현 계획, 상태, 히스토리를 가능한 한 분리한다.

### 10.4 최소 범위 우선
현재 검증 단계에 필요한 최소 범위부터 문서화하고 구현한다.

### 10.5 AI가 읽기 쉬운 구조 유지
제목 체계, 용어, 범위 구분, 참조 문서를 일관되게 유지한다.

---

## 11. 읽기 순서

projects 작업을 시작할 때는 보통 아래 순서로 읽는다.

1. 루트 `README.md`
2. 루트 `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. 대상 프로젝트의 `AGENTS.md`
6. 대상 프로젝트의 `README.md`
7. 대상 프로젝트의 `index.md`
8. 필요 시 관련 `docs/projects/standards/**` 문서
9. 실제 대상 요구사항 / 설계 / 구현 계획 문서

---

## 12. 현재 우선순위

현재 projects 영역의 우선순위는 다음과 같다.

### 우선순위 1
- projects / board / standards의 역할 경계 고정
- README / AGENTS / AI_CONTEXT와 표현 정합성 확보

### 우선순위 2
- board를 첫 번째 실제 애플리케이션 프로젝트로 명확히 고정
- specdrive 문서와 board 문서의 혼합 방지

### 우선순위 3
- board 하위 요구사항 / 설계 / 구현 계획 문서 최소 세트 정리
- CLI 테스트에 사용할 실제 문서 기반 준비

---

## 13. 최종 정리

`docs/projects/README.md` 는 projects 영역 전체를 이해하기 위한 진입 문서다.

projects를 다룰 때는 항상 먼저 아래를 확인한다.

- 이 내용은 실제 애플리케이션 판단인가?
- 이 내용은 specdrive 도구 규칙이 아니라 project 문서에 있어야 하는가?
- 이 내용은 공통 standards로 빼야 하는가?
- 현재 범위와 후속 후보를 구분하고 있는가?
- 현재 검증 단계에 필요한 최소 문서 구조를 강화하고 있는가?

현재는 한 저장소 안에서 specdrive와 projects를 함께 운영하지만,  
projects는 처음부터 **독립 가능한 실제 애플리케이션 문서 작업공간**으로 정리한다.
