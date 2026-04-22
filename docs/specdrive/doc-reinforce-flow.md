# docs/specdrive/doc-reinforce-flow.md

## 1. 문서 목적

이 문서는 specdrive의 `doc reinforce` 흐름을  
**현재 기준으로 가장 먼저 검증할 대표 시나리오**로 정리하는 문서다.

목적은 다음과 같다.

- `doc reinforce` 가 어떤 입력으로 시작되는지 정리한다.
- CLI, script, skill, Codex 실행이 어디서 연결되는지 정리한다.
- 사람이 어디서 검토하고 판단해야 하는지 고정한다.
- 실제 테스트 문서를 기준으로 최소 검증 흐름을 만든다.

현재 이 문서는  
`docs/projects/board/01-overview.md` 를 테스트 문서로 사용하는 기준으로 작성한다.

---

## 2. 현재 테스트 대상 문서

현재 `doc reinforce` 흐름의 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`

이 문서를 선택한 이유는 다음과 같다.

- board 프로젝트의 가장 앞쪽 개요 문서다.
- 내용이 아직 과도하게 복잡하지 않다.
- 요구사항 / 설계 / 구현 계획으로 확장되기 전 출발점 문서다.
- reinforce 결과를 사람이 빠르게 검토하기 좋다.

즉 첫 검증 문서로서  
**작고, 명확하고, 후속 문서의 기준점이 되는 문서**라는 장점이 있다.

---

## 3. `doc reinforce`가 하는 일

현재 기준에서 `doc reinforce` 는 다음 역할을 가진다.

- 기존 문서 초안을 읽는다.
- 문서의 목적, 범위, 빠진 항목, 모호한 표현을 점검한다.
- 현재 단계에서 필요한 최소 보강안을 만든다.
- 원문을 완전히 재작성하기보다, 현재 문서를 더 명확하게 만든다.

중요한 점은 다음과 같다.

- `doc reinforce` 는 confirm 가 아니다.
- `doc reinforce` 는 문서를 확정하지 않는다.
- `doc reinforce` 결과는 사람이 검토해야 한다.

즉 `doc reinforce` 는  
**문서 보강 초안을 만드는 단계**다.

---

## 4. 현재 기준 실행 흐름

현재 기준의 최소 실행 흐름은 아래와 같다.

1. 사용자가 `doc reinforce` 명령을 시작한다.
2. CLI가 대상 문서를 `docs/projects/board/01-overview.md` 로 인식한다.
3. 현재 스크립트는 legacy config 에서 `default_target` fallback 을 읽는다.
4. `specdrive/config/target-registry.json` 에서 대상 문서와 `context_set_key` 를 읽는다.
5. `specdrive/config/doc-action-registry.json` 에서 `skill_key`, `output_mode`, 사람 검토 요구 여부를 읽는다.
6. `specdrive/config/skill-registry.json`, `context-set-registry.json` 에서 실제 skill 경로와 context 문서 묶음을 해석한다.
7. `specdrive/config/output-policy.json` 에서 출력 정책을 읽는다.
8. `specdrive/scripts/doc/**` 가 reinforce 실행 흐름을 조합한다.
9. 필요하면 `specdrive/skills/doc/**` 에서 문서 보강 규칙 자산을 참조한다.
10. `specdrive/scripts/exec/**` 를 통해 Codex 실행 흐름으로 연결한다.
11. 현재 `codex-exec.ps1` 는 보강 실행 대신 prompt preview 를 생성한다.
12. 사용자가 결과를 검토하고, 필요하면 수정하거나 confirm 단계로 넘긴다.

---

## 5. 현재 기준 책임 분리

### 5.1 CLI
- 사용자의 진입점
- 어떤 작업을 실행할지 받는다
- 대상 문서를 명시적으로 선택하게 하거나 기본값을 해석한다

### 5.2 `specdrive/scripts/doc/**`
- reinforce 단계 흐름 조합
- 입력 문서 읽기
- skill / config / exec 연결
- 결과 반영 방식 제어
- 현재 첫 기준 스크립트: `specdrive/scripts/doc/reinforce.ps1`

### 5.3 `specdrive/skills/doc/**`
- 보강 규칙 자산 제공
- 문서 목적 점검
- 누락 항목 점검
- 과도한 확장 억제 기준 제공
- 현재 첫 기준 자산: `specdrive/skills/doc/reinforce.md`

### 5.4 `specdrive/scripts/exec/**`
- Codex 실행 연결
- 외부 실행 호출 책임만 가짐
- 현재 첫 기준 스크립트: `specdrive/scripts/exec/codex-exec.ps1`

### 5.5 `specdrive/scripts/common/**`
- 공통 함수 제공
- 경로 해석
- JSON 설정 읽기
- 출력 정책 해석
- 현재 첫 기준 스크립트: `specdrive/scripts/common/specdrive-common.ps1`

### 5.6 사람
- 최종 판단
- 보강안 수용 여부 결정
- 문서 방향 유지 여부 확인

---

## 6. 입력 기준

현재 `doc reinforce` 최소 테스트에서 필요한 입력은 다음과 같다.

- 대상 문서 경로
- 현재 문서 본문
- 대상 문서 / action / skill / context-set registry
  - `specdrive/config/target-registry.json`
  - `specdrive/config/doc-action-registry.json`
  - `specdrive/config/skill-registry.json`
  - `specdrive/config/context-set-registry.json`
- 출력 정책
  - `specdrive/config/output-policy.json`
- 관련 상위 문서
  - `README.md`
  - `AGENTS.md`
  - `docs/AI_CONTEXT.md`
  - `docs/projects/board/README.md`
  - `docs/projects/board/AGENTS.md`
- 필요 시 관련 standards 문서

현재 첫 테스트에서는  
입력을 과도하게 넓히기보다  
**대상 문서 + 핵심 진입 문서** 정도로 제한하는 편이 좋다.

---

## 7. 기대 출력

현재 기준에서 기대하는 출력은 다음과 같다.

- 문서 구조가 더 명확해진 보강안
- 빠진 핵심 항목에 대한 제안
- 중복되거나 모호한 표현에 대한 정리
- 현재 단계 범위를 벗어나는 과도한 확장 없이, 문서를 더 단단하게 만드는 수정안

즉 출력은 “새 문서 창작”보다  
**현재 문서를 더 읽기 좋고 더 작업 가능하게 만드는 보강안**이어야 한다.

---

## 8. 검토 체크포인트

`docs/projects/board/01-overview.md` 에 대해 reinforce 결과를 볼 때는 아래를 확인한다.

- 문서 목적이 더 선명해졌는가?
- board의 성격이 흔들리지 않았는가?
- specdrive 문서 내용이 board 문서로 섞여 들어오지 않았는가?
- 현재 범위와 비포함 범위가 더 분명해졌는가?
- 후속 요구사항 / 설계 / 구현 계획 문서로 자연스럽게 이어질 수 있는가?
- 과도한 기능 확장이나 상세 설계가 너무 빨리 들어오지 않았는가?

---

## 9. 현재 단계에서의 성공 기준

이번 첫 `doc reinforce` 테스트는 아래를 만족하면 성공으로 본다.

- 흐름상 어느 계층이 무슨 역할을 하는지 설명 가능하다.
- `01-overview.md` 를 기준으로 실제 보강 작업을 한 번 수행할 수 있다.
- 결과를 사람이 검토하고 다음 단계로 넘길 수 있다.
- 이후 `02-requirements.md` 같은 후속 문서에도 같은 흐름을 반복 적용할 수 있다.

즉 이번 목표는 완벽한 자동화가 아니라,  
**반복 가능한 최소 reinforce 흐름을 한 번 성립시키는 것**이다.

---

## 10. 다음 단계

이 문서 기준으로 다음에는 보통 아래로 이어진다.

1. `specdrive/config/**` 에 대상 문서 매핑 규칙 초안 추가
   - 현재 기준 registry: `specdrive/config/target-registry.json`
2. `specdrive/skills/doc/reinforce.md` 에 reinforce용 기본 skill 초안 추가
3. `specdrive/scripts/doc/reinforce.ps1` 에 reinforce 진입 스크립트 초안 추가
4. `specdrive/scripts/exec/codex-exec.ps1` 에 Codex 실행 래퍼 초안 추가
5. `docs/projects/board/01-overview.md` 에 대해 실제 reinforce 시뮬레이션 수행
6. 결과를 검토하고 `doc confirm` 흐름 문서로 확장

---

## 11. 최종 정리

현재 `doc reinforce` 흐름의 첫 테스트 문서는  
`docs/projects/board/01-overview.md` 다.

이 선택은 적절하다.  
왜냐하면 이 문서는 board의 출발점 문서이면서도,  
작고 명확하고 후속 문서 구조의 기준점이 되기 때문이다.

따라서 현재 specdrive의 `doc reinforce` 검증은  
이 문서를 대상으로 시작하는 것이 자연스럽다.
