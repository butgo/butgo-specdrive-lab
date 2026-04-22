# docs/specdrive/doc-stage-testing.md

## 1. 문서 목적

이 문서는 현재 `doc` 단계 최소 테스트의  
**대상, 실행 방법, 확인 포인트, 현재 상태**를 빠르게 복구하기 위한 상태 문서다.

목적은 다음과 같다.

- 지금 `doc` 단계가 어디까지 검증됐는지 빠르게 파악한다.
- 어떤 문서를 테스트 대상으로 쓰고 있는지 고정한다.
- 어떤 명령을 어떤 순서로 실행하는지 정리한다.
- 새 세션이나 다른 장소에서 동일한 테스트를 다시 시작하기 쉽게 만든다.

이 문서는 상세 설계 문서가 아니다.  
흐름 설명은 `doc-reinforce-flow.md`, `doc-confirm-flow.md`, `doc-history-save-flow.md` 를 따른다.

---

## 2. 현재 테스트 범위 한 줄 요약

- 현재 `doc` 단계는 `docs/projects/board/01-overview.md` 를 첫 테스트 문서로 삼아, `reinforce -> confirm -> history-save` 가 기대한 역할대로 분리되는지 1차 검증을 완료한 상태다.

현재 1차 완료 판정은 다음 범위까지로 한정한다.

- registry 기반 key routing 확인
- preview 기반 최소 검증 확인
- `doc reinforce` 의 좁은 실제 `codex exec` 연결 확인
- `confirm -Execute`, `history-save -Execute` 의 실제 history 저장 경로 확인

다만 이는 `doc` 단계 전체 안정화 완료가 아니라,
`01-overview.md` 기준 첫 검증 문서에 대한 1차 완료 판정이다.

---

## 3. 현재 테스트 대상

- 대상 문서: `docs/projects/board/01-overview.md`
- 대상 키: `board-overview`

이 문서를 현재 첫 테스트 대상으로 쓰는 이유는 다음과 같다.

- board 문서군의 출발점 문서다.
- 크기가 작아 흐름 검증이 빠르다.
- 요구사항 / 설계 / 구현 계획 문서로 확장되기 전 기준점 역할을 한다.

---

## 4. 현재 연결된 실행 자산

### 4.1 흐름 문서
- `docs/specdrive/doc-reinforce-flow.md`
- `docs/specdrive/doc-confirm-flow.md`
- `docs/specdrive/doc-history-save-flow.md`

### 4.2 스크립트
- `specdrive/scripts/doc/reinforce.ps1`
- `specdrive/scripts/doc/confirm.ps1`
- `specdrive/scripts/doc/history-save.ps1`
- `specdrive/scripts/exec/codex-exec.ps1`
- `specdrive/scripts/common/specdrive-common.ps1`

### 4.3 skill
- `specdrive/skills/doc/reinforce.md`
- `specdrive/skills/doc/confirm.md`
- `specdrive/skills/doc/history-save.md`

### 4.4 config
- `specdrive/config/target-registry.json`
- `specdrive/config/skill-registry.json`
- `specdrive/config/context-set-registry.json`
- `specdrive/config/doc-action-registry.json`
- `specdrive/config/output-policy.json`

현재 legacy 호환용으로 다음 config 도 남아 있다.

- `specdrive/config/doc-reinforce-targets.json`
- `specdrive/config/doc-confirm-targets.json`
- `specdrive/config/doc-history-targets.json`

---

## 5. 현재 기준 실행 순서

보통 아래 순서로 테스트한다.

1. `doc reinforce`
2. `doc confirm`
3. `doc history-save`

PowerShell 예시는 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/history-save.ps1
```

---

## 6. 현재 확인된 상태

현재까지 확인된 것은 다음과 같다.

- `reinforce.ps1` 는 `target-registry.json` 의 공통 default target 과 legacy fallback config, output policy, skill, context 문서를 읽는다.
- `reinforce.ps1` 는 `codex-exec.ps1` 로 handoff 한다.
- `codex-exec.ps1` 는 현재 key 기반 입력 해석 또는 해석 결과를 받아 preview prompt 를 생성한다.
- `codex-exec.ps1` 는 `doc reinforce` 에 한해 `-Execute` 옵션으로 실제 `codex exec` 호출을 시도할 수 있다.
- 실제 실행 시 non-zero exit code 가 나와도 `output-last-message` 파일에 본문이 남으면 결과 검토는 가능하도록 처리한다.
- reinforce preview 는 `.speclab/review-output/**` 아래에 저장된다.
- `confirm.ps1` 는 최근 reinforce preview 를 찾아 confirm preview 를 생성한다.
- confirm preview 는 `.speclab/review-output/**` 아래에 저장된다.
- `confirm -Execute` 는 action registry 의 execute 허용 여부와 선행조건을 먼저 확인한다.
- `confirm`, `history-save` 는 현재 preview prefix 와 history suffix 일부를 action registry 에서 읽는다.
- `history-save.ps1` 는 최근 reinforce / confirm preview 를 읽어 history preview 를 생성한다.
- history preview 는 `.speclab/history-output/**` 아래에 저장된다.
- `confirm -Execute` 는 최신 reinforce codex output 을 대상 문서에 적용하고 관련 증적을 `docs/history/projects/**` 아래에 저장한다.
- `history-save -Execute` 는 현재 적용된 대상 문서를 snapshot 과 note 형태로 `docs/history/projects/**` 아래에 저장한다.
- `reinforce` 는 기존 문서를 전면 재작성하기보다 보강 초안을 만드는 단계로 동작하는 것을 확인했다.
- `confirm` 은 preview 경로에서는 사람 검토용 체크리스트를 만들고, `-Execute` 경로에서는 실제 project 문서 적용과 history 저장까지 이어지는 단계로 동작하는 것을 확인했다.
- `history-save` 는 preview 경로에서는 판단과 변경 요지를 정리하고, `-Execute` 경로에서는 현재 적용 문서와 note 를 실제 history 로 남기는 단계로 동작하는 것을 확인했다.
- `confirm` 과 `history-save` 는 병렬보다 순차 실행이 맞고, 최신 confirm preview 를 기준으로 history preview 를 생성해야 한다는 점을 확인했다.

즉 현재는  
**registry 기반 key routing, preview 기반 최소 검증, `doc reinforce` 의 좁은 실제 Codex 실행 연결, `confirm/history-save` 의 실제 history 저장 경로**까지 확인된 상태다.  
다만 실행 환경 경고 정리, history 운영 규칙 고정, 다른 문서로의 반복 적용 안정화는 후속 범위다.

---

## 7. 이번 1차 테스트의 의미

이번 `01-overview.md` 기준 테스트에서 먼저 확인하려던 것은  
명령이 단순히 실행되는지보다, `reinforce / confirm / history-save` 가  
각각 기대한 역할대로 분리되는지였다.

현재 기준으로 정리하면 다음과 같다.

- `reinforce` 는 문서 보강 초안을 만든다.
- `confirm` 은 사람 검토를 위한 확인 단계를 만들고, 필요 시 실제 project 문서 적용과 근거 저장까지 수행한다.
- `history-save` 는 앞선 판단과 변경 요지를 기록 후보로 만들고, 필요 시 현재 적용 문서와 note 를 실제 history 로 고정한다.

즉 현재 1차 테스트는  
**세 단계의 역할 분리가 기대한 방향과 크게 어긋나지 않는지, 그리고 의미 있는 문서 변경이 실제 문서와 문서대장 이력으로 연결되는지 확인하는 테스트**로 이해한다.

---

## 8. 아직 남아 있는 후속 판단

현재 후속 판단 대상은 다음과 같다.

- `doc reinforce` 외 단계까지 실제 `codex exec` 연결을 넓힐지
- preview 출력 포맷이 사람 검토에 충분한지
- `01-overview.md` 이후 어떤 문서에 같은 `doc` 흐름을 반복 적용할지
- `dev` 단계로 넘어가기 전에 `doc` 단계 테스트를 얼마나 더 반복할지
- Codex 실행 환경 경고를 어디까지 허용 가능한 것으로 볼지

---

## 9. 현재 단계에서의 테스트 관점

현재는 구조를 더 크게 늘리는 것보다  
다음을 확인하는 쪽이 더 중요하다.

- 흐름이 실제로 자연스러운가?
- 사람이 preview 결과를 보고 다음 판단을 내리기 쉬운가?
- config / skill / script / flow 문서 경계가 이해 가능한가?
- 다음 문서에도 같은 패턴을 반복 적용할 수 있는가?

즉 지금은 기능 확장보다  
**반복 테스트와 어색한 지점 찾기**가 우선이다.

---

## 10. 다음 자연스러운 진입점

현재 기준으로 다음 진입점 후보는 다음과 같다.

1. `01-overview.md` 기준 preview / output 형식이 사람이 쓰기 편한지 최종 점검
2. `session` 단계 출력과 운영 흐름 정리
3. `doc reinforce -Execute` 실제 사용감 점검
4. `confirm`, `history-save` 까지 실연결을 넓힐지 판단
5. 다음 board 문서에 `doc` 3단계 흐름을 반복 적용할지 판단

현재 우선순위는  
1번과 2번이 먼저다.
3번 이후는 현재 흐름 정리가 끝난 뒤 판단한다.

---

## 11. 1차 완료 판정

`docs/projects/board/01-overview.md` 기준 `doc` 단계 1차 테스트는
현재 완료 판정한다.

완료 판정 근거는 다음과 같다.

- `reinforce` 는 기존 문서를 전면 재작성하지 않고 보강 초안을 만드는 단계로 설명 가능하다.
- `confirm` 은 사람 검토용 체크리스트와 실제 적용 경로를 분리해 설명 가능하다.
- `history-save` 는 현재 문서 상태와 판단 흔적을 문서대장 이력으로 남기는 단계로 설명 가능하다.
- `docs/history/projects/board/01-overview/**` 아래에 confirm/history 산출물 묶음이 남아 있다.
- `confirm` 과 `history-save` 는 병렬이 아니라 최신 confirm preview 를 기준으로 순차 실행하는 흐름이 맞다는 점을 확인했다.

이 완료 판정은 다음을 의미하지 않는다.

- 모든 project 문서에 `doc` 단계가 충분히 검증됐다는 뜻은 아니다.
- `dev` 단계로 즉시 넘어간다는 뜻은 아니다.
- `confirm`, `history-save` 의 실제 Codex 연결 범위를 확정했다는 뜻은 아니다.

따라서 다음 단계는 기능 확장이 아니라,
`session` 운영 흐름 정리와 다음 board 문서에 같은 패턴을 반복 적용할지 판단하는 것이다.

---

## 12. 최종 정리

현재 `doc` 단계는  
`docs/projects/board/01-overview.md` 를 기준으로 최소 골격과 1차 역할 분리 테스트 완료 판정까지 연결된 상태다.

따라서 새 세션에서는 먼저 이 문서로 테스트 상태를 복구한 뒤,  
`session` 단계 정리 또는 다음 board 문서에 같은 흐름을 반복 적용하는 작업으로 넘어가는 것이 자연스럽다.

