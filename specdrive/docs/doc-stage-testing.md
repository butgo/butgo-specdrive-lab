# specdrive/docs/doc-stage-testing.md

## 1. 문서 목적

이 문서는 현재 `doc` 단계 최소 테스트의  
**대상, 실행 방법, 확인 포인트, 현재 상태**를 빠르게 복구하기 위한 상태 문서다.

흐름 설명은 `flows/doc-reinforce-flow.md`, `flows/doc-confirm-flow.md`, `flows/doc-history-save-flow.md` 를 따른다.

---

## 2. 현재 테스트 범위 한 줄 요약

- 현재 `doc` 단계는 `docs/projects/board/01-overview.md` 를 첫 테스트 문서로 삼아, `draft-save -> reinforce-prompt -> confirm-prompt -> apply-prompt` 수동 보강 루프를 정리하는 단계다.

현재 1차 완료 판정은 다음 범위까지로 한정한다.

- registry 기반 key routing 확인
- preview 기반 최소 검증 확인
- `doc reinforce` 의 좁은 실제 `codex exec` 연결 확인
- `confirm-prompt`, `apply-prompt` 출력 형식과 history 저장 초안 경로 확인

---

## 3. 현재 테스트 대상

- 대상 문서: `docs/projects/board/01-overview.md`
- 대상 키: `board-overview`

---

## 4. 현재 연결된 실행 자산

### 4.1 스크립트
- `specdrive/scripts/doc/reinforce.ps1`
- `specdrive/scripts/doc/reinforce-prompt.ps1`
- `specdrive/scripts/doc/draft-save.ps1`
- `specdrive/scripts/doc/confirm-prompt.ps1`
- `specdrive/scripts/doc/apply-prompt.ps1`
- `specdrive/scripts/doc/apply-only-prompt.ps1`
- `specdrive/scripts/exec/codex-exec.ps1`
- `specdrive/scripts/common/specdrive-common.ps1`

---

## 5. 현재 기준 실행 순서

보통 아래 순서로 테스트한다.

1. 개발자 초안 작성
2. `doc draft-save`
3. `doc reinforce-prompt`
4. 필요 시 `doc reinforce`
5. `doc confirm-prompt`
6. `doc apply-prompt`

---

## 6. 현재 확인된 상태

현재까지 확인된 것은 다음과 같다.

- `reinforce.ps1` 는 registry 와 output policy, skill, context 문서를 읽는다.
- `reinforce.ps1` 는 `codex-exec.ps1` 로 handoff 한다.
- `codex-exec.ps1` 는 `doc reinforce` 에 한해 `-Execute` 옵션으로 실제 `codex exec` 호출을 시도할 수 있다.
- `confirm-prompt.ps1` 는 confirm 검토용 copy prompt 를 생성한다.
- `apply-prompt.ps1` 는 실제 문서 반영 + history 저장 초안을 위한 copy prompt 를 생성한다.
- `apply-only-prompt.ps1` 는 history 없이 문서 반영만 필요한 예외 경로를 위한 copy prompt 를 생성한다.

즉 현재는  
**registry 기반 key routing, preview 기반 최소 검증, `doc reinforce` 의 좁은 실제 Codex 실행 연결, `confirm-prompt/apply-prompt` 의 프롬프트 출력 경로**까지 확인된 상태다.

---

## 7. 최종 정리

현재 `doc` 단계는  
`docs/projects/board/01-overview.md` 를 기준으로 prompt-first 최소 흐름까지 연결된 상태다.
