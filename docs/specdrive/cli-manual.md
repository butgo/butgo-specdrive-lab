# docs/specdrive/cli-manual.md

## 1. 문서 목적

이 문서는 과거 specdrive의 CLI 테스트 흐름을 기록한  
**후속 검토용 보류 문서**이다.

목적은 다음과 같다.

- 과거 CLI 검증 흐름을 보존한다.
- 후속 CLI 재검토 시 확인할 기준을 남긴다.
- 현재 skill-first 실행 방식과 혼동하지 않도록 구분한다.

이 문서는 현재 버전의 실행 매뉴얼이 아니다.  
현재 버전은 repo-local Codex skill 직접 사용을 기준으로 한다.

---

## 2. 현재 CLI 이해 방식

현재 specdrive는 skill-first 흐름을 검증하는 단계다.

과거에는 `specdrive/specdrive.ps1` 단일 진입점을 통해 `doc`, `session`, `git` 최소 흐름을 검증했다.  
이 흐름은 현재 버전의 기준 경로에서 제외하고 후속 후보로 보류한다.

과거 `doc` 단계는 prompt-first 흐름을 기준으로 아래 명령을 사용했다.

- `doc draft-save`
- `doc reinforce-prompt`
- `doc reinforce`
- `doc confirm-prompt`
- `doc apply-prompt`
- `doc apply-only-prompt`

즉 과거 CLI의 역할은 문서를 직접 자동 완성하는 실행기보다,  
**Codex 협업에 필요한 정규화 프롬프트와 절차를 출력하는 도구**에 더 가깝다.

---

## 3. 현재 개발 환경 전제

현재 버전은 별도 CLI 설치 안내를 전제로 하지 않는다.

현재 기준은 다음과 같다.

- OS / 셸: Windows + PowerShell
- 에디터: VS Code
- AI 협업 환경: Codex 확장
- 실행 인터페이스: repo-local Codex skill

CLI 자동화와 직접 `codex exec` 연동은 후속 검토 범위다.

---

## 4. 현재 테스트 대상

현재 `doc` 단계 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`
- 대상 키: `board-overview`

현재 권장 반복 흐름은 아래와 같다.

1. 개발자가 문서 초안을 직접 작성
2. `doc draft-save`
3. `doc reinforce-prompt`
4. 사람이 복사한 prompt 로 Codex 대화 진행
5. 필요 시 `doc reinforce -Execute` 로 좁은 실연결만 테스트
6. `doc confirm-prompt`
7. `doc apply-prompt` 또는 필요 시 `doc apply-only-prompt`
8. 사람이 승인한 뒤 문서 반영 및 history 저장
9. 3~8 반복

`dev` 단계는 아직 테스트하지 않는다.  
`dev` 단계 검증은 실제 코딩 작업이 시작될 때 진행한다.

---

## 5. 현재 명령 구조

### 5.1 `doc draft-save`
- 스크립트: `specdrive/scripts/doc/draft-save.ps1`
- 역할:
  - 현재 대상 문서를 개발자 초안 기준으로 history 저장
  - 초안 단계와 보강 단계 history 를 구분
  - Codex 보강 전 기준 snapshot 확보

### 5.2 `doc reinforce-prompt`
- 스크립트: `specdrive/scripts/doc/reinforce-prompt.ps1`
- 역할:
  - 대상 문서, context 문서, reinforce 규칙을 읽어 copy prompt 출력
  - `direct`, `interactive` 모드별 대화 시작 프롬프트 제공
  - 개발자가 직접 프롬프트를 매번 다시 쓰지 않도록 정규화된 시작점 제공

### 5.3 `doc reinforce`
- 스크립트: `specdrive/scripts/doc/reinforce.ps1`
- 역할:
  - 대상 문서 설정 읽기
  - context 문서 확인
  - skill 연결
  - exec wrapper 로 handoff
  - preview 생성
  - 필요 시 `-Execute` 로 실제 Codex 연결 테스트

### 5.4 `doc confirm-prompt`
- 스크립트: `specdrive/scripts/doc/confirm-prompt.ps1`
- 역할:
  - 대상 문서와 관련 문서 읽기 규칙 정리
  - 반영 가능 여부 검토용 copy prompt 출력
  - confirm 체크리스트와 보류 포인트 정리 유도

### 5.5 `doc apply-prompt`
- 스크립트: `specdrive/scripts/doc/apply-prompt.ps1`
- 역할:
  - 실제 문서 반영 + history 저장 초안용 copy prompt 출력
  - snapshot 파일명, note 파일명, change summary, note body 제안 유도

### 5.6 `doc apply-only-prompt`
- 스크립트: `specdrive/scripts/doc/apply-only-prompt.ps1`
- 역할:
  - history 저장 없이 실제 문서 반영안만 제안하는 copy prompt 출력

### 5.7 `session` 명령
- `session start`
  - 세션 복구용 copy prompt 출력
- `session status`
  - `docs/AI_CONTEXT.md` 기준 현재 상태를 읽기 전용으로 조회
- `session save`
  - `docs/AI_CONTEXT.md` 반영 초안 요청용 copy prompt 출력

### 5.8 `git` 명령
- `git branch-name`
- `git git-message`
- `git pr-message`

현재 `git` 단계는 전달 단위 초안 생성에 집중한다.

---

## 6. 기본 실행 순서

현재 `doc` 단계의 권장 수동 보강 흐름은 보통 아래 순서로 실행한다.

1. 개발자 초안 작성
2. `draft-save`
3. `reinforce-prompt`
4. Codex 대화로 보강안 확인
5. `confirm-prompt`
6. `apply-prompt` 또는 필요 시 `apply-only-prompt`

PowerShell 예시는 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/draft-save.ps1 -Target board-overview
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce-prompt.ps1 -Target board-overview -Mode interactive
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm-prompt.ps1 -Target board-overview
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/apply-prompt.ps1 -Target board-overview -Source codex-reinforce
```

현재 문서 해석의 중심은 아래 흐름에 둔다.

1. `reinforce-prompt`
2. `confirm-prompt`
3. `apply-prompt`
4. 필요 시 예외 경로로 `apply-only-prompt`

---

## 7. 명령별 사용 예시

### 7.1 draft-save

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/draft-save.ps1 -Target board-overview
```

### 7.2 reinforce-prompt

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce-prompt.ps1 -Target board-overview -Mode interactive
```

### 7.3 reinforce

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1 -Target board-overview -DryRun
```

현재 `-Execute` 옵션은 `doc reinforce` 에서만 실제 `codex exec` 호출을 시도한다.  
기본 실행은 여전히 preview 생성이다.

### 7.4 confirm-prompt

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm-prompt.ps1 -Target board-overview
```

현재 `confirm-prompt` 는 사람 검토용 체크리스트와 반영 가능 조건을 정리하는 copy prompt 를 출력한다.

### 7.5 apply-prompt

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/apply-prompt.ps1 -Target board-overview -Source codex-reinforce
```

현재 `apply-prompt` 는 실제 문서 반영 + history 저장 초안을 함께 준비하는 copy prompt 를 출력한다.

출력은 보통 다음 항목을 함께 포함한다.

- Applied Document
- History Snapshot File
- History Note File
- Change Summary
- Note Body
- Next Entry

### 7.6 apply-only-prompt

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/apply-only-prompt.ps1 -Target board-overview -Source codex-reinforce
```

현재 `apply-only-prompt` 는 예외적으로 history 저장 없이 실제 문서 반영안만 준비하는 copy prompt 를 출력한다.

### 7.7 specdrive/specdrive.ps1

현재 권장 진입 방식은 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc draft-save -Target board-overview
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc reinforce-prompt -Target board-overview -Mode interactive
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc confirm-prompt -Target board-overview
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc apply-prompt -Target board-overview -Source codex-reinforce
```

---

## 8. 출력 위치

현재 preview 출력은 다음 위치를 사용한다.

### 8.1 review 출력
- 위치: `.speclab/review-output/**`
- 생성 대상:
  - reinforce prompt preview
  - reinforce preview
  - confirm prompt preview
  - apply-only prompt preview

### 8.2 history 출력
- 위치: `.speclab/history-output/**`
- 생성 대상:
  - apply prompt preview

실제 문서 이력은 별도로 아래 위치에 저장한다.

- 위치: `docs/history/projects/**`
- 예:
  - apply 실행 시 적용 문서 snapshot / note 저장

---

## 9. 테스트할 때 확인할 것

현재 CLI 테스트에서는 다음을 본다.

- 명령 실행 순서가 자연스러운가?
- 대상 문서와 context 문서 연결이 이해 가능한가?
- preview 출력이 사람 검토에 충분한가?
- `scripts / skills / config / exec` 경계가 헷갈리지 않는가?
- 같은 흐름을 다음 문서에도 반복 적용할 수 있을 것 같은가?

즉 현재는 기능 완성도보다  
**반복 가능한 최소 운영 흐름인지**를 보는 단계다.

---

## 10. 현재 한계

현재 CLI는 아직 다음 상태다.

- `specdrive/specdrive.ps1` 는 현재 `doc`, `session`, `git` 최소 라우팅만 가진다.
- `dev` 단계는 아직 `specdrive/specdrive.ps1` 라우팅에 올리지 않았다.
- 실제 `codex exec` 호출은 현재 `doc reinforce` 에만 좁게 연결했다.
- 실제 반영과 history 저장은 아직 copy prompt 기반 초안 생성 중심이며, 자동 저장 경로는 후속 검토 대상이다.

따라서 이 문서는 완성 제품 매뉴얼이 아니라,  
**현재 알파 검증 단계용 실행 매뉴얼**로 이해해야 한다.

---

## 11. 최종 정리

현재 specdrive CLI는  
완성된 제품 CLI가 아니라 PowerShell 스크립트 기반의 최소 검증 구조다.

따라서 지금 이 매뉴얼의 핵심은 다음 두 가지다.

- 현재 실제로 실행 가능한 명령을 정확히 안내하는 것
- `01-overview.md` 를 기준으로 `doc` 단계의 prompt-first 흐름을 반복 테스트하는 것
