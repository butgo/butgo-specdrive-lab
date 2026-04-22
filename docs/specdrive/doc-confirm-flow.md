# docs/specdrive/doc-confirm-flow.md

## 1. 문서 목적

이 문서는 specdrive의 `doc confirm` 흐름을  
**현재 기준 최소 confirm 시나리오**로 정리하는 문서다.

목적은 다음과 같다.

- `doc confirm` 이 어떤 입력으로 시작되는지 정리한다.
- reinforce 결과와 confirm 단계의 관계를 고정한다.
- 사람이 어디서 최종 판단하는지 분명히 한다.
- 첫 테스트 문서를 기준으로 최소 confirm 흐름을 만든다.

현재 이 문서는  
`docs/projects/board/01-overview.md` 를 첫 테스트 대상 문서로 사용한다.

---

## 2. 현재 테스트 대상 문서

현재 `doc confirm` 흐름의 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`

이 문서를 선택한 이유는 다음과 같다.

- reinforce 테스트와 같은 문서를 이어서 사용할 수 있다.
- 문서 규모가 작아 사람이 confirm 판단을 빠르게 내리기 좋다.
- board 문서 구조의 출발점이라 confirm 의미가 분명하다.

---

## 3. `doc confirm`이 하는 일

현재 기준에서 `doc confirm` 은 다음 역할을 가진다.

- reinforce 결과 또는 현재 문서 초안을 검토 대상으로 올린다.
- 사람이 현재 문서를 기준 문서로 받아들일 수 있는지 확인한다.
- 필요한 최소 수정 후 현재 문서를 confirm 상태로 본다.
- 이후 구현 또는 후속 문서 작성의 기준점이 되게 한다.

중요한 점은 다음과 같다.

- confirm 은 보강 자체가 아니다.
- confirm 은 사람 판단이 반드시 들어간다.
- confirm 전 문서는 아직 기준 문서가 아니다.

즉 `doc confirm` 은  
**문서를 작업 기준으로 확정하는 단계**다.

원래 의도한 목적은 단순 checklist preview 생성이 아니라,  
Codex가 보강한 문서를 실제 프로젝트 문서에 적용하고 그 근거를 문서 이력으로 남기는 것이다.

---

## 4. 현재 기준 실행 흐름

현재 기준의 최소 실행 흐름은 아래와 같다.

1. 사용자가 `doc confirm` 명령을 시작한다.
2. CLI가 대상 문서를 `docs/projects/board/01-overview.md` 로 인식한다.
3. 현재 스크립트는 legacy config 에서 `default_target` fallback 을 읽는다.
4. `specdrive/config/target-registry.json` 에서 대상 문서와 `context_set_key` 를 읽는다.
5. `specdrive/config/doc-action-registry.json` 에서 `skill_key`, `output_mode`, review output directory 를 읽는다.
6. `specdrive/config/skill-registry.json`, `context-set-registry.json` 에서 실제 skill 경로와 context 문서 묶음을 해석한다.
7. `specdrive/config/output-policy.json` 에서 출력 정책을 읽는다.
8. `specdrive/scripts/doc/**` 가 confirm 실행 흐름을 조합한다.
9. 필요한 경우 최근 reinforce preview 를 함께 검토 대상으로 가져온다.
10. 결과는 confirm 체크리스트 또는 review 요약 형태로 사용자에게 돌아온다.
11. 사용자가 최종 판단하고 문서를 기준 문서로 확정한다.

---

## 5. 현재 기준 책임 분리

### 5.1 CLI
- 사용자의 진입점
- 어떤 문서를 confirm 할지 받는다

### 5.2 `specdrive/scripts/doc/**`
- confirm 단계 흐름 조합
- 대상 문서 / 관련 preview / 설정 읽기
- 결과 출력 방식 제어

### 5.3 `specdrive/skills/doc/**`
- confirm 판단 기준 제공
- 최소 확인 체크리스트 제공
- 현재 첫 기준 자산: `specdrive/skills/doc/confirm.md`

### 5.4 사람
- 최종 승인 여부 판단
- 문서 기준 확정
- 후속 작업으로 넘어갈지 결정

---

## 6. 입력 기준

현재 `doc confirm` 최소 테스트에서 필요한 입력은 다음과 같다.

- 대상 문서 경로
- 대상 문서 현재 본문
- 대상 문서 / action / skill / context-set registry
  - `specdrive/config/target-registry.json`
  - `specdrive/config/doc-action-registry.json`
  - `specdrive/config/skill-registry.json`
  - `specdrive/config/context-set-registry.json`
- 출력 정책
  - `specdrive/config/output-policy.json`
- 필요 시 최근 reinforce preview
  - `.speclab/review-output/**`
- 관련 상위 문서
  - `README.md`
  - `AGENTS.md`
  - `docs/AI_CONTEXT.md`
  - `docs/projects/board/README.md`
  - `docs/projects/board/AGENTS.md`

---

## 7. 기대 출력

현재 기준에서 기대하는 출력은 다음과 같다.

- confirm 검토 체크리스트
- 현재 문서를 기준 문서로 받아들일 수 있는지에 대한 판단 보조
- 남은 수정 포인트 요약
- confirm 가능 / 보류 필요 여부에 대한 review 결과

즉 기본 출력은 자동 확정이 아니라  
**사람이 확정 판단을 내릴 수 있게 돕는 검토 출력**이어야 한다.

현재 단계에서 `doc confirm` 은 두 경로를 가진다.

- 기본 경로:
  - confirm checklist preview 생성
- `-Execute` 경로:
  - 최신 reinforce codex output 에서 문서 초안을 추출
  - 대상 문서를 그 초안으로 갱신
  - codex output / note / 적용 문서 snapshot 을 `docs/history/projects/**` 아래 저장

즉 현재 `confirm` 의 `-Execute` 는  
**문서를 실제로 적용하고 이력을 남기는 실행 경로**로 이해한다.

즉 preview 는 검토 보조용이고,  
원래 의도했던 핵심은 `confirm -Execute` 에서 실제 프로젝트 문서와 문서대장 이력이 함께 갱신되는 것이다.

### 7.1 `confirm -Execute` 저장 흐름

현재 `confirm -Execute` 가 실제로 저장하는 흐름은 아래처럼 이해한다.

1. 최신 reinforce codex output 을 찾는다.
2. codex output 에서 실제 문서에 반영할 markdown 초안을 추출한다.
3. 대상 문서(`docs/projects/**`)를 그 초안으로 갱신한다.
4. 적용 근거와 적용 결과를 `docs/history/projects/**` 아래에 함께 남긴다.

즉 `confirm -Execute` 는  
단순히 문서를 덮어쓰는 것이 아니라,  
**무엇을 근거로 적용했는지와 무엇이 실제로 적용되었는지를 같이 남기는 단계**다.

### 7.2 `confirm -Execute` 생성 파일

현재 `confirm -Execute` 가 남기는 대표 파일은 다음과 같다.

- `confirm-source-codex-output`
  - confirm 적용의 직접 근거가 된 Codex 출력 원본이다.
  - 실제 적용은 이 파일 전체를 그대로 쓰는 것이 아니라, 이 안에서 markdown 초안을 추출해 반영한다.
- `confirm-source-codex-output.note`
  - 위 Codex 출력과 함께 남긴 보조 메모다.
  - 실행 맥락이나 확인 포인트를 짧게 보존하는 용도다.
- `confirm-applied`
  - Codex 초안을 실제 대상 문서에 반영한 뒤 저장한 snapshot 이다.
  - 의미는 "confirm 단계에서 실제로 적용된 결과"다.

즉 현재 기준에서 `confirm-*` 묶음은  
**confirm 적용 근거와 confirm 적용 결과를 함께 보존하는 history 묶음**으로 본다.

---

## 8. 현재 단계에서의 성공 기준

이번 첫 `doc confirm` 테스트는 아래를 만족하면 성공으로 본다.

- `01-overview.md` 를 confirm 대상으로 삼는 흐름이 설명 가능하다.
- reinforce 이후 confirm 으로 이어지는 단계 분리가 선명하다.
- 사람이 현재 문서를 기준 문서로 볼 수 있는지 판단할 수 있다.
- 이후 다른 요구사항/설계 문서에도 같은 confirm 흐름을 반복 적용할 수 있다.

---

## 9. 다음 단계

이 문서 기준으로 다음에는 보통 아래로 이어진다.

1. `specdrive/config/target-registry.json`, `doc-action-registry.json` 기준 정리
2. `specdrive/skills/doc/confirm.md` 초안 추가
3. `specdrive/scripts/doc/confirm.ps1` 초안 추가
4. `docs/projects/board/01-overview.md` 에 대해 confirm 시뮬레이션 수행

---

## 10. 최종 정리

현재 `doc confirm` 흐름의 첫 테스트 문서는  
`docs/projects/board/01-overview.md` 다.

이 흐름은 reinforce 결과를 사람이 기준 문서로 끌어올리는 단계이며,  
`doc` 단계에서 사람이 책임을 갖는 지점을 분명히 만드는 역할을 한다.

