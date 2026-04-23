# docs/specdrive/cli-single-entry.md

## 1. 문서 목적

이 문서는 specdrive CLI를  
**여러 개의 하위 PowerShell 스크립트 직접 실행 방식에서 `specdrive/specdrive.ps1` 단일 진입점 방식으로 정리하기 위한 최소 설계 문서**다.

목적은 다음과 같다.

- 현재 흩어져 있는 `doc` 단계 스크립트의 상위 진입 구조를 정의한다.
- `specdrive/specdrive.ps1` 가 무엇을 해야 하고, 무엇을 하지 말아야 하는지 경계를 정한다.
- `doc` / `dev` / `session` / `git` 단계 구분을 단일 진입점에서도 유지하는 기준을 정한다.
- 현재 preview 기반 구조를 무너뜨리지 않고 상위 CLI만 정리하는 최소 방향을 만든다.

이 문서는 실제 구현 완료 문서가 아니다.  
현재 기준으로는 **단일 진입 CLI를 만들기 전에 먼저 고정해야 하는 책임 구조와 최소 명령 형태**를 다룬다.

---

## 2. 왜 지금 이 문서가 필요한가

현재 specdrive CLI는 작동한다.  
하지만 사용자는 아직 다음처럼 개별 스크립트를 직접 실행해야 한다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/history-save.ps1
```

이 방식은 최소 검증에는 충분하지만, 다음 한계가 있다.

- 사용자가 내부 스크립트 위치를 직접 알아야 한다.
- `doc`, `dev`, `session`, `git` 단계의 상위 명령 구조가 표면에 드러나지 않는다.
- 이후 명령이 늘어날수록 진입 방식이 흩어진다.
- 문서에서 설명하는 장기 방향과 실제 실행 방식 사이에 차이가 남는다.

따라서 다음 단계에서는  
하위 스크립트를 바로 없애기보다,  
**그 위에 얇은 단일 진입 계층을 올리는 방향**이 자연스럽다.

---

## 3. 현재 기준에서 `specdrive/specdrive.ps1` 의 역할

현재 기준 `specdrive/specdrive.ps1` 는 다음 역할만 가져야 한다.

- 사용자의 상위 명령 입력을 받는다.
- `doc`, `dev`, `session`, `git` 단계를 1차로 분기한다.
- action 과 target 같은 상위 인자를 해석한다.
- 실제 실행은 기존 `specdrive/scripts/**` 하위 스크립트에 위임한다.
- 사용자가 내부 파일 경로를 직접 알 필요 없게 만든다.

즉 `specdrive/specdrive.ps1` 는  
**오케스트레이션 진입점**이어야 한다.

현재 단계에서 `specdrive/specdrive.ps1` 가 직접 가지지 않아야 할 책임은 다음과 같다.

- 문서/skill/context registry 상세 해석 로직
- preview 파일 생성 로직
- Codex 실행 래퍼 로직
- `doc` 단계와 `dev` 단계의 업무별 내부 처리 로직
- 장기 멀티엔진 추상화

이 책임들은 여전히 하위 스크립트와 config layer 에 둔다.

---

## 4. 최소 명령 구조

현재 단계에서 추천하는 최소 명령 구조는 다음과 같다.

```powershell
specdrive/specdrive.ps1 doc draft-save -Target board-overview
specdrive/specdrive.ps1 doc reinforce-prompt -Target board-overview -Mode interactive
specdrive/specdrive.ps1 doc reinforce -Target board-overview
specdrive/specdrive.ps1 doc confirm -Target board-overview
specdrive/specdrive.ps1 doc history-save -Target board-overview -Source codex-reinforce
specdrive/specdrive.ps1 session start
specdrive/specdrive.ps1 session save
specdrive/specdrive.ps1 git branch-name
specdrive/specdrive.ps1 git git-message
specdrive/specdrive.ps1 git pr-message
```

후속 확장 후보는 다음과 같이 본다.

```powershell
specdrive/specdrive.ps1 dev phase set ...
specdrive/specdrive.ps1 dev cycle set ...
specdrive/specdrive.ps1 dev status
specdrive/specdrive.ps1 dev task-split ...
```

중요한 점은 다음과 같다.

- 지금 먼저 필요한 것은 `doc` 단계 진입 정리다.
- `dev`, `session`, `git` 단계 문법은 현재 문서에서 방향만 두고, 실제 구현은 후속으로 미룬다.
- 명령은 문서 종류보다 작업 action 중심으로 유지한다.

---

## 5. 추천 책임 분리

### 5.1 `specdrive/specdrive.ps1`
- 최상위 진입점
- stage / action / target 같은 상위 입력 해석
- 적절한 하위 스크립트 호출
- 잘못된 명령에 대한 짧은 도움말 출력

### 5.2 `specdrive/scripts/doc/*.ps1`
- `doc` 단계 action 별 흐름 실행
- registry, output policy, preview 흐름 해석
- 현재는 legacy `default_target` fallback 도 포함

### 5.3 `specdrive/scripts/dev/*.ps1`
- `dev` 단계 action 별 흐름 실행
- 현재는 자리만 있고 본격 구현은 후속

### 5.4 `specdrive/scripts/session/*.ps1`
- `session` 단계 action 별 흐름 실행
- 세션 복구, 세션 저장
- 현재는 문서 기준과 상위 명령 구조를 먼저 고정하는 단계

### 5.5 `specdrive/scripts/git/*.ps1`
- `git` 단계 action 별 흐름 실행
- 브랜치명, Git message, PR message 초안 생성
- phase / cycle / 관련 문서와의 연결은 후속 확장 범위

### 5.6 `specdrive/scripts/exec/*.ps1`
- 외부 실행기 연결
- 현재는 `codex-exec.ps1` preview wrapper 중심
### 5.7 `specdrive/config/*.json`
- target / skill / context-set / action registry
- output policy
- 현재 일부 legacy target config fallback

즉 단일 진입점이 생겨도  
실제 작업 계층 구조는 그대로 유지하는 편이 좋다.

---

## 6. 현재 단계의 추천 호출 흐름

현재 기준 추천 흐름은 다음과 같다.

1. 사용자가 `specdrive/specdrive.ps1 doc reinforce-prompt -Target board-overview -Mode interactive` 를 실행한다.
2. `specdrive/specdrive.ps1` 가 stage=`doc`, action=`reinforce-prompt`, target=`board-overview` 를 해석한다.
3. `specdrive/specdrive.ps1` 가 `specdrive/scripts/doc/reinforce-prompt.ps1` 를 호출한다.
4. `reinforce-prompt.ps1` 가 registry 와 context 문서를 읽고 copy prompt 를 생성한다.
5. 필요 시 사용자는 이어서 `specdrive/specdrive.ps1 doc reinforce -Target board-overview -Execute` 로 실제 Codex 실행 연결을 테스트한다.
6. 보강 결과를 사람이 반영한 뒤 `specdrive/specdrive.ps1 doc history-save -Target board-overview -Source codex-reinforce` 를 실행한다.

이 구조에서 중요한 것은 다음이다.

- 단일 진입점은 상위 분기만 맡는다.
- 실제 처리 책임은 기존 action 스크립트에 둔다.
- registry 중심 구조를 유지한 채 진입 방식만 정리한다.

---

## 7. 인자 설계 최소 원칙

현재 단계에서 인자는 다음 정도만 먼저 정리하는 편이 좋다.

### 공통 인자 후보
- `-Target`
- `-DryRun`
- `-Execute`
- `-Mode`
- `-Source`
- `-Note`
- `-Focus`

### `doc` 단계 공통 예시

```powershell
specdrive/specdrive.ps1 doc draft-save -Target board-overview
specdrive/specdrive.ps1 doc reinforce-prompt -Target board-overview -Mode interactive
specdrive/specdrive.ps1 doc reinforce -Target board-overview -DryRun
specdrive/specdrive.ps1 doc reinforce -Target board-overview -Execute
specdrive/specdrive.ps1 doc confirm -Target board-overview
specdrive/specdrive.ps1 doc history-save -Target board-overview -Source codex-reinforce
specdrive/specdrive.ps1 session start
specdrive/specdrive.ps1 git branch-name
specdrive/specdrive.ps1 git git-message
specdrive/specdrive.ps1 git pr-message
```

원칙은 다음과 같다.

- 가능한 한 현재 하위 스크립트 인자와 크게 어긋나지 않게 유지한다.
- 새로운 상위 CLI가 하위 스크립트 인터페이스를 불필요하게 비틀지 않게 한다.
- 지금은 선택형 입력보다 비대화식 입력을 기본 경로로 본다.

---

## 8. 현재 단계에서 아직 넣지 않을 것

현재 `specdrive/specdrive.ps1` 설계에 다음을 먼저 넣지 않는 편이 좋다.

- 대규모 도움말 시스템
- 멀티엔진 실행 분기
- profile / workspace / session 같은 추가 전역 옵션
- interactive selector UI
- dev/session/git 단계의 상세 서브커맨드 트리
- registry 직접 수정 명령

이유는 간단하다.  
지금 목표는 완성형 CLI가 아니라  
**현재 작동하는 `doc` 단계 흐름의 진입 구조를 정리하는 것**이기 때문이다.

---

## 9. 최소 구현 순서 제안

현재 기준으로는 다음 순서가 자연스럽다.

1. 이 문서로 `specdrive/specdrive.ps1` 책임과 최소 문법을 고정한다.
2. `specdrive/specdrive.ps1` 에서 `doc draft-save|reinforce-prompt|reinforce|confirm|history-save` 라우팅을 정리한다.
3. 이후 `session start|save`, `git branch-name|git-message|pr-message` 상위 라우팅을 검토한다.
4. 기존 하위 스크립트 호출이 끊기지 않는지 확인한다.
5. 현재 preview 결과가 기존 직접 실행 방식과 동일한지 비교한다.
6. 이후 필요하면 `dev` 단계 상위 라우팅을 추가한다.

즉 지금 바로 필요한 것은  
**단일 진입점의 최소 라우팅**이지,  
전체 CLI 재작성은 아니다.

---

## 10. 문서와 현재 상태의 연결

이 문서는 다음 문서와 함께 봐야 한다.

- `docs/specdrive/cli-manual.md`
  - 현재 직접 실행 방식과 테스트 예시
- `docs/specdrive/cli-key-routing.md`
  - target / skill / context-set / action registry 구조
- `docs/specdrive/doc-stage-testing.md`
  - 현재 `doc` 단계 테스트 상태
- `docs/AI_CONTEXT.md`
  - 현재 세션 복구와 다음 진입점

즉 이 문서는  
현재 실행 매뉴얼을 대체하는 문서가 아니라,  
**현재 실행 방식 위에 어떤 상위 진입점을 얹을지 정리하는 문서**다.

---

## 11. 최종 정리

현재 specdrive CLI에서 다음 자연스러운 한 걸음은  
전체 구조를 다시 만드는 것이 아니라,  
`specdrive/specdrive.ps1` 라는 얇은 단일 진입점을 추가하는 것이다.

그 핵심 원칙은 다음 한 줄로 요약된다.

- `specdrive/specdrive.ps1` 는 상위 라우터이고, 실제 업무 로직은 계속 하위 스크립트에 둔다.
