# docs/specdrive/doc-history-save-flow.md

## 1. 문서 목적

이 문서는 specdrive의 `doc history-save` 흐름을  
**현재 기준 최소 history 저장 시나리오**로 정리하는 문서다.

목적은 다음과 같다.

- `doc history-save` 가 어떤 입력으로 시작되는지 정리한다.
- reinforce / confirm 이후 어떤 흔적을 남겨야 하는지 고정한다.
- 사람이 어떤 판단을 history 로 남길지 분명히 한다.
- 첫 테스트 문서를 기준으로 최소 history-save 흐름을 만든다.

현재 이 문서는  
`docs/projects/board/01-overview.md` 를 첫 테스트 대상 문서로 사용한다.

---

## 2. 현재 테스트 대상 문서

현재 `doc history-save` 흐름의 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`

이 문서를 선택한 이유는 다음과 같다.

- reinforce 와 confirm 흐름을 같은 문서로 이어갈 수 있다.
- 문서 규모가 작아 저장할 판단 내용을 빠르게 정리할 수 있다.
- board 문서 구조의 출발점이라 history 의미가 선명하다.

---

## 3. `doc history-save`가 하는 일

현재 기준에서 `doc history-save` 는 다음 역할을 가진다.

- reinforce 와 confirm 이후의 판단 흔적을 저장한다.
- 현재 문서가 왜 이런 상태가 되었는지 남긴다.
- 다음 세션이나 후속 작업에서 맥락을 빠르게 복구할 수 있게 한다.
- 문서 작업 이력이 단순 덮어쓰기가 되지 않도록 한다.

중요한 점은 다음과 같다.

- history-save 는 문서를 다시 보강하지 않는다.
- history-save 는 confirm 를 대신하지 않는다.
- history-save 는 현재 문서 상태와 판단 이유를 남기는 단계다.

즉 `doc history-save` 는  
**문서 작업의 판단 흔적을 기록하는 단계**다.

원래 의도한 목적은 `.speclab/history-output` 아래 preview 를 남기는 것보다,  
의미 있는 문서 변경이 발생했을 때 실제 적용 문서와 요약 메모를 프로젝트 history 로 보존하는 것이다.

---

## 4. 현재 기준 실행 흐름

현재 기준의 최소 실행 흐름은 아래와 같다.

1. 사용자가 `doc history-save` 명령을 시작한다.
2. CLI가 대상 문서를 `docs/projects/board/01-overview.md` 로 인식한다.
3. 현재 스크립트는 legacy config 에서 `default_target` fallback 을 읽는다.
4. `specdrive/config/target-registry.json` 에서 대상 문서와 `context_set_key` 를 읽는다.
5. `specdrive/config/doc-action-registry.json` 에서 `skill_key`, `output_mode`, review output directory 를 읽는다.
6. `specdrive/config/skill-registry.json`, `context-set-registry.json` 에서 실제 skill 경로와 context 문서 묶음을 해석한다.
7. `specdrive/config/output-policy.json` 에서 출력 정책을 읽는다.
8. `specdrive/scripts/doc/**` 가 history-save 실행 흐름을 조합한다.
9. 필요한 경우 최근 reinforce / confirm preview 를 함께 읽는다.
10. 결과는 history 초안 또는 저장 preview 로 사용자에게 돌아온다.
11. 사용자가 내용을 검토하고 history 기록으로 남긴다.

---

## 5. 현재 기준 책임 분리

### 5.1 CLI
- 사용자의 진입점
- 어떤 문서의 history 를 남길지 받는다

### 5.2 `specdrive/scripts/doc/**`
- history-save 단계 흐름 조합
- 대상 문서 / 관련 preview / 설정 읽기
- 저장 preview 생성

### 5.3 `specdrive/skills/doc/**`
- history 기록 기준 제공
- 어떤 판단을 남겨야 하는지 정리
- 현재 첫 기준 자산: `specdrive/skills/doc/history-save.md`

### 5.4 사람
- 어떤 내용을 기록할지 최종 판단
- 저장할 가치가 있는 변경인지 결정
- 남길 요약과 이유를 확인

---

## 6. 입력 기준

현재 `doc history-save` 최소 테스트에서 필요한 입력은 다음과 같다.

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
- 필요 시 최근 confirm preview
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

- history 초안
- 변경 이유 요약
- 현재 문서의 의미 변화 요약
- 다음 진입점에 도움이 되는 짧은 메모

즉 기본 출력은 자동 요약이 아니라  
**사람이 history 로 남길 수 있는 기록 초안**이어야 한다.

현재 단계에서 `doc history-save` 는 두 경로를 가진다.

- 기본 경로:
  - history preview 생성
- `-Execute` 경로:
  - 현재 적용된 대상 문서를 `docs/history/projects/**` 아래 snapshot 으로 저장
  - history note 저장
  - 최신 reinforce / confirm preview 를 함께 history 폴더에 복사

즉 현재 `history-save` 의 `-Execute` 는  
**현재 적용 문서 상태를 실제 이력으로 남기는 실행 경로**로 이해한다.

즉 preview 는 history 초안 검토용이고,  
원래 의도했던 핵심은 `history-save -Execute` 에서 현재 적용 문서와 note 가 실제 문서대장 이력으로 남는 것이다.

### 7.1 `history-save -Execute` 저장 흐름

현재 `history-save -Execute` 가 실제로 저장하는 흐름은 아래처럼 이해한다.

1. 현재 적용된 대상 문서 상태를 읽는다.
2. 그 시점의 문서 snapshot 을 `docs/history/projects/**` 아래에 저장한다.
3. 왜 이 snapshot 을 남겼는지 짧은 note 를 함께 저장한다.
4. 같은 시점에 참고한 최신 reinforce preview, confirm preview 를 history 폴더에 같이 복사한다.

즉 `history-save -Execute` 는  
새로운 문서를 적용하는 단계라기보다,  
**현재 적용 상태와 그 직전의 검토 맥락을 문서대장처럼 묶어 저장하는 단계**다.

### 7.2 `history-save -Execute` 생성 파일

현재 `history-save -Execute` 가 남기는 대표 파일은 다음과 같다.

- `history-applied`
  - `history-save` 시점의 현재 대상 문서 snapshot 이다.
  - 이 값은 `confirm-applied` 와 같을 수도 있지만, confirm 후 사람이 추가 수정한 상태일 수도 있다.
- `history-applied.note`
  - 왜 현재 문서 상태를 저장했는지, 어떤 preview 를 참고했는지 남기는 짧은 메모다.
- `history-source-reinforce-preview`
  - history 저장 시점에 함께 보관한 최신 reinforce preview 사본이다.
  - 문서가 어떤 보강 제안을 거쳤는지 추적하기 위한 참조본이다.
- `history-source-confirm-preview`
  - history 저장 시점에 함께 보관한 최신 confirm preview 사본이다.
  - 문서를 어떤 검토 맥락에서 저장했는지 추적하기 위한 참조본이다.

즉 현재 기준에서 `history-*` 묶음은  
**현재 적용 상태와 그 상태에 이르기 전의 검토 preview 맥락을 함께 남기는 history 묶음**으로 본다.

---

## 8. 현재 단계에서의 성공 기준

이번 첫 `doc history-save` 테스트는 아래를 만족하면 성공으로 본다.

- `01-overview.md` 를 기준으로 history 기록 초안을 만들 수 있다.
- reinforce / confirm / history-save 의 역할 분리가 선명하다.
- 다음 세션에서 왜 이 문서가 이렇게 되었는지 빠르게 이해할 수 있다.
- 이후 다른 요구사항/설계 문서에도 같은 history 흐름을 반복 적용할 수 있다.

---

## 9. 다음 단계

이 문서 기준으로 다음에는 보통 아래로 이어진다.

1. `specdrive/config/target-registry.json`, `doc-action-registry.json` 기준 정리
2. `specdrive/skills/doc/history-save.md` 초안 추가
3. `specdrive/scripts/doc/history-save.ps1` 초안 추가
4. `docs/projects/board/01-overview.md` 에 대해 history-save 시뮬레이션 수행

---

## 10. 최종 정리

현재 `doc history-save` 흐름의 첫 테스트 문서는  
`docs/projects/board/01-overview.md` 다.

이 흐름은 `doc` 단계의 마지막에서  
문서 작업 판단의 흔적을 남기는 역할을 하며,  
다음 세션 복구와 후속 문서 작업의 연결점을 만든다.

