# docs/specdrive/cli-single-entry.md

## 1. 문서 목적

이 문서는 specdrive CLI를  
**여러 개의 하위 PowerShell 스크립트 직접 실행 방식에서 `specdrive/specdrive.ps1` 단일 진입점 방식으로 정리하기 위한 최소 설계 문서**다.

---

## 2. 최소 명령 구조

현재 단계에서 추천하는 최소 명령 구조는 다음과 같다.

```powershell
specdrive/specdrive.ps1 doc draft-save -Target board-overview
specdrive/specdrive.ps1 doc reinforce-prompt -Target board-overview -Mode interactive
specdrive/specdrive.ps1 doc reinforce -Target board-overview
specdrive/specdrive.ps1 doc confirm-prompt -Target board-overview
specdrive/specdrive.ps1 doc apply-prompt -Target board-overview -Source codex-reinforce
specdrive/specdrive.ps1 doc apply-only-prompt -Target board-overview -Source codex-reinforce
specdrive/specdrive.ps1 session start
specdrive/specdrive.ps1 session save
specdrive/specdrive.ps1 git branch-name
specdrive/specdrive.ps1 git git-message
specdrive/specdrive.ps1 git pr-message
```

---

## 3. 현재 단계의 추천 호출 흐름

현재 기준 추천 흐름은 다음과 같다.

1. 사용자가 `specdrive/specdrive.ps1 doc reinforce-prompt -Target board-overview -Mode interactive` 를 실행한다.
2. `specdrive/specdrive.ps1` 가 `reinforce-prompt` 를 하위 스크립트에 위임한다.
3. 사용자는 이어서 `specdrive/specdrive.ps1 doc confirm-prompt -Target board-overview` 를 실행한다.
4. 보강 결과를 검토한 뒤 `specdrive/specdrive.ps1 doc apply-prompt -Target board-overview -Source codex-reinforce` 를 실행한다.

---

## 4. 최종 정리

현재 specdrive CLI에서 다음 자연스러운 한 걸음은  
`specdrive/specdrive.ps1` 라는 얇은 단일 진입점을 유지한 채 prompt-first 명령 구조를 정리하는 것이다.
