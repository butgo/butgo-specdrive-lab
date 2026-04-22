# docs/specdrive/cli-manual.md

## 1. 문서 목적

이 문서는 현재 specdrive의 CLI 테스트 흐름을  
**사람이 실제로 실행하고 검증할 수 있도록 설명하는 운영 매뉴얼**이다.

목적은 다음과 같다.

- 현재 단계에서 어떤 명령을 어떻게 실행하는지 정리한다.
- `doc` 단계 명령의 역할과 순서를 분명히 한다.
- 실제 스크립트 기준의 실행 예시를 제공한다.
- 장기 방향과 현재 실행 방식을 혼동하지 않도록 구분한다.

이 문서는 CLI 상세 설계 문서가 아니다.  
현재 있는 스크립트를 기준으로 **지금 어떻게 테스트할 것인가**를 설명한다.

---

## 2. 현재 CLI 이해 방식

현재 specdrive는 CLI 중심으로 흐름을 검증하는 단계다.

현재는 `specdrive/specdrive.ps1` 단일 진입점을 통해 `doc`, `session`, `git` 최소 흐름을 실행할 수 있다.  
다만 내부적으로는 여전히 PowerShell 하위 스크립트를 호출하는 얇은 라우터 구조다.

즉 현재 기준은 다음과 같다.

- 현재 단일 진입점: `specdrive/specdrive.ps1 doc ...`, `specdrive/specdrive.ps1 session ...`, `specdrive/specdrive.ps1 git ...`
- 현재 내부 실행 방식: `specdrive/scripts/**` 아래 PowerShell 스크립트 호출
- 후속 정리 방향: `target / skill / context-set` 키 기반 연결 구조

따라서 이 문서에서 중요한 것은  
**미래 문법을 상상하는 것보다 현재 테스트 가능한 명령을 정확히 쓰는 것**이다.

---

## 3. 현재 개발 환경 전제

현재 CLI 테스트는 다음 환경을 전제로 한다.

- OS / 셸: Windows + PowerShell
- 에디터: VS Code
- AI 협업 환경: Codex 확장
- AI 실행 CLI: `codex-cli`
- 현재 확인 버전: `codex-cli 0.121.0`

먼저 아래 명령으로 `codex-cli` 가 준비되어 있는지 확인하는 편이 좋다.

```powershell
codex --version
```

현재 `codex-exec.ps1` 는 preview 중심 래퍼를 유지하지만,  
`doc reinforce` 에 한해 `-Execute` 옵션으로 실제 `codex exec` 호출을 좁게 연결한 상태다.

현재 확인된 `codex-cli 0.121.0` 기준으로는  
PowerShell 제약 또는 plugin/analytics 관련 경고가 함께 출력될 수 있다.  
따라서 이후 CLI 버전이 올라가면 같은 흐름을 다시 비교 검증하는 편이 좋다.

---

## 4. 현재 테스트 대상

현재 `doc` 단계 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`
- 대상 키: `board-overview`

현재 테스트 전략은 다음과 같다.

- `doc reinforce`
- `doc confirm`
- `doc history-save`
- `session start`
- `session status`
- `session save`
- `git branch-name`
- `git git-message`
- `git pr-message`

위 3개 흐름을 먼저 `01-overview.md` 기준으로 반복 테스트한다.

`dev` 단계는 아직 테스트하지 않는다.  
`dev` 단계 검증은 실제 코딩 작업이 시작될 때 진행한다.

---

## 5. 현재 명령 구조

현재 테스트에 직접 사용하는 스크립트는 다음과 같다.

### 5.1 `doc reinforce`
- 스크립트: `specdrive/scripts/doc/reinforce.ps1`
- 역할:
  - 대상 문서 설정 읽기
  - context 문서 확인
  - skill 연결
  - exec wrapper 로 handoff
  - preview 생성

### 5.2 `doc confirm`
- 스크립트: `specdrive/scripts/doc/confirm.ps1`
- 역할:
  - 대상 문서 설정 읽기
  - 최근 reinforce preview 탐색
  - confirm 체크리스트 preview 생성

### 5.3 `doc history-save`
- 스크립트: `specdrive/scripts/doc/history-save.ps1`
- 역할:
  - 대상 문서 설정 읽기
  - 최근 reinforce / confirm preview 탐색
  - history preview 생성

### 5.4 exec wrapper
- 스크립트: `specdrive/scripts/exec/codex-exec.ps1`
- 역할:
  - 기본은 preview prompt 생성
  - `doc reinforce` 에 한해 `-Execute` 로 실제 `codex exec` 호출 가능
  - `doc reinforce` 단계에서 exec 계층 테스트 지점 역할

### 5.5 common 유틸
- 스크립트: `specdrive/scripts/common/specdrive-common.ps1`
- 역할:
  - repo root 해석
  - JSON 설정 읽기
  - 출력 정책 해석
  - preview 파일 저장 같은 공통 처리 제공

현재 주 경로는 이미 `target key / skill key / context-set key` 기반 registry 구조다.  
관련 설계는 `docs/specdrive/cli-key-routing.md` 를 따르며,  
현재 registry 는 `specdrive/config/target-registry.json`, `skill-registry.json`, `context-set-registry.json`, `doc-action-registry.json` 에 둔다.  
다만 각 `doc-*-targets.json` 파일은 현재 스크립트에서 `default_target` fallback 용 legacy config 로 일부 남아 있다.

### 5.6 session 명령
- 스크립트:
  - `specdrive/scripts/session/start.ps1`
  - `specdrive/scripts/session/status.ps1`
  - `specdrive/scripts/session/save.ps1`
- 역할:
  - 세션 시작 시 읽을 문서와 현재 Git 상태 요약 안내
  - `docs/AI_CONTEXT.md` 기준 현재 상태를 서술형으로 조회하는 `session status` 제공
  - 세션 종료 시 변경 요약, 변경 영역, 변경 파일 샘플, 다음 진입점, 확인 포인트 안내
  - 매번 새로 작성하던 세션 시작/저장 프롬프트를 정규화
  - Codex 프롬프트에 붙여넣을 수 있는 최소 copy prompt 블록 출력
  - 전체 문서 내용을 붙여넣지 않고 필요한 파일을 읽게 유도해 토큰 사용량 절감
  - 일회성 preview 파일을 남기지 않고 콘솔 출력만 제공

### 5.7 git 명령
- 스크립트:
  - `specdrive/scripts/git/branch-name.ps1`
  - `specdrive/scripts/git/git-message.ps1`
  - `specdrive/scripts/git/pr-message.ps1`
- 역할:
  - `docs/projects/standards/git-policy.md` 기준의 브랜치명 / commit message / PR 제목 초안 생성
  - 현재 브랜치/변경 요약 기준 브랜치명 초안 생성
  - `type(scope): summary` 형식의 Git commit message 초안 생성
  - `[type] short summary` 형식의 PR 제목과 설명 초안 생성
  - 기본 출력은 변경 수, 변경 영역, 변경 파일 샘플로 제한
  - `-Detailed` 사용 시 상세 변경 파일 목록 출력
  - 일회성 초안 파일을 저장하지 않고 콘솔 출력만 제공

### 5.8 util 명령
util 스크립트는 현재 상위 `specdrive/specdrive.ps1 util ...` 라우팅에 연결하지 않고 직접 실행한다.

상세 목록과 사용법은 `docs/specdrive/util-scripts.md` 를 따른다.

---

## 6. 기본 실행 순서

현재 `doc` 단계는 보통 아래 순서로 실행한다.

1. `reinforce`
2. `confirm`
3. `history-save`

PowerShell 예시는 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/history-save.ps1
```

현재 기본 타깃은 `board-overview` 다.  
실행 시 `-Target` 을 생략하면 각 doc 스크립트는 legacy config 의 `default_target` 값을 fallback 으로 사용한다.

`session` 단계는 보통 아래처럼 쓴다.

1. `session start`
2. 필요 시 `session status`
3. 필요한 `doc` 작업 수행
4. `session save`
5. 필요 시 `git branch-name`
6. 필요 시 `git git-message`
7. 필요 시 `git pr-message`

현재 의미 있는 문서 반영 흐름으로 보려면 보통 아래처럼 이해한다.

1. `reinforce -Execute`
2. `confirm -Execute`
3. 필요 시 사람이 직접 수정
4. `history-save -Execute`

---

## 7. 명령별 사용 예시

### 7.1 reinforce

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1
```

특정 target 을 명시하려면:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1 -Target board-overview
```

dry-run 만 보려면:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/reinforce.ps1 -DryRun
```

현재 `-Execute` 옵션은 `doc reinforce` 에서만 실제 `codex exec` 호출을 시도한다.  
기본 실행은 여전히 preview 생성이며, 환경 경고나 플러그인 경고가 있어도 `output-last-message` 파일이 남으면 결과 검토는 가능하게 처리한다.

### 7.2 confirm

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm.ps1
```

특정 target 을 명시하려면:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm.ps1 -Target board-overview
```

dry-run 만 보려면:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/confirm.ps1 -DryRun
```

현재 `confirm` 은 기본 경로에서 preview 생성만 수행한다.  
즉 기본 동작은 사람 검토용 체크리스트를 만드는 역할이다.

현재 `-Execute` 는 다음 의미를 가진다.

- 최신 reinforce codex output 에서 문서 초안을 추출한다.
- 대상 문서(`docs/projects/**`)를 그 초안으로 갱신한다.
- reinforce codex output / note / 적용된 문서 snapshot 을 `docs/history/projects/**` 아래에 저장한다.

### 7.3 history-save

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/history-save.ps1
```

특정 target 을 명시하려면:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/history-save.ps1 -Target board-overview
```

dry-run 만 보려면:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/doc/history-save.ps1 -DryRun
```

현재 `history-save` 는 기본 경로에서 preview 생성만 수행한다.  
즉 기본 동작은 history 기록 후보를 정리하는 역할이다.

현재 `-Execute` 는 다음 의미를 가진다.

- 현재 적용된 대상 문서 내용을 `docs/history/projects/**` 아래 snapshot 으로 저장한다.
- history note 를 함께 저장한다.
- 최신 reinforce / confirm preview 도 함께 history 폴더에 복사한다.

### 7.4 codex-exec

현재 `codex-exec.ps1` 는 보통 단독 진입점보다  
`reinforce.ps1` 에서 내부적으로 호출되는 래퍼로 사용한다.

기본 역할은 다음과 같다.

- target document 확인
- skill document 확인
- context 문서 목록 확인
- Codex 실행용 prompt preview 생성
- preview 파일 저장

권장 테스트 예시는 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/exec/codex-exec.ps1 -TargetKey board-overview
```

이 방식은 registry 에서 다음을 함께 해석한다.

- target document
- skill document
- required context documents
- optional context documents

저수준 직접 테스트가 필요하면 아래처럼 path 직접 입력도 가능하다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/exec/codex-exec.ps1 `
  -TargetDocument docs/projects/board/01-overview.md `
  -SkillDocument specdrive/skills/doc/reinforce.md `
  -ContextDocuments README.md,AGENTS.md,docs/AI_CONTEXT.md,docs/projects/board/README.md,docs/projects/board/AGENTS.md
```

주의할 점은 다음과 같다.

- 현재 기본 동작은 preview 생성이다.
- `doc reinforce` 에 한해 `-Execute` 로 실제 `codex exec` 호출이 가능하다.
- 현재는 `-TargetKey board-overview` 같은 key 기반 테스트를 표준 경로로 본다.
- 직접 `TargetDocument / SkillDocument / ContextDocuments` 를 넣는 방식은 주로 디버깅/저수준 테스트용이다.
- 표준 사용 흐름은 상위 `doc` 스크립트가 config 를 읽어 넘기는 방식으로 유지하는 편이 좋다.
- 현재 `confirm`, `history-save`, `session`, `git` 단계는 여전히 preview 중심이다.
- 따라서 현재 `codex-exec.ps1` 테스트 목적은 **실행 프롬프트 조합 확인 + `doc reinforce` 좁은 실연결 검증**에 가깝다.

### 7.5 specdrive/specdrive.ps1

현재 권장 진입 방식은 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc reinforce -Target board-overview
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc confirm -Target board-overview
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc history-save -Target board-overview
```

실제 Codex 실행까지 보려면 다음처럼 `-Execute` 를 붙인다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 doc reinforce -Target board-overview -Execute
```

`session` 예시는 다음과 같다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 session start
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 session status
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 session save
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 git branch-name
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 git git-message
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 git pr-message
```

변경 파일 전체 목록을 함께 확인해야 할 때는 `-Detailed` 를 붙인다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 git branch-name -Detailed
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 git git-message -Detailed
powershell -ExecutionPolicy Bypass -File specdrive/specdrive.ps1 git pr-message -Detailed
```

현재 `specdrive/specdrive.ps1` 는 상위 라우터 역할만 가진다.  
실제 업무 로직은 계속 `specdrive/scripts/**` 하위 스크립트가 수행한다.

util 스크립트는 현재 직접 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/project-tree.ps1 -MaxDepth 4
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/doc-tree.ps1 -MaxDepth 8
```

상세 옵션은 `docs/specdrive/util-scripts.md` 를 따른다.

---

## 8. 출력 위치

현재 preview 출력은 다음 위치를 사용한다.

### 8.1 review 출력
- 위치: `.speclab/review-output/**`
- 생성 대상:
  - reinforce preview
  - confirm preview

### 8.2 history 출력
- 위치: `.speclab/history-output/**`
- 생성 대상:
  - history-save preview

### 8.3 session / git 출력
- 현재 `session start`, `session save`, `git branch-name`, `git git-message`, `git pr-message` 는 콘솔 출력만 제공한다.
- `session status` 는 copy prompt를 만들지 않고 `docs/AI_CONTEXT.md` 기준의 서술형 현재 상태 요약만 콘솔에 출력한다.
- `session status` 의 Git 변경 정보는 보조 정보이며, 상세 파일 목록은 `-Detailed` 에서만 출력한다.
- `session start`, `session save` 는 Codex에 자동으로 문맥을 주입하지 않고, 사람이 복사해서 사용할 수 있는 최소 copy prompt 블록을 함께 출력한다.
- 이 copy prompt 는 긴 문서 본문을 직접 포함하지 않고, Codex가 읽을 파일과 확인할 상태만 지정하는 방식으로 토큰 사용량을 줄이는 것을 목표로 한다.
- `session start` 는 상세 변경 파일 목록 대신 변경 수와 변경 영역 요약만 출력한다.
- `session save` 는 기본적으로 변경 수, 변경 영역, 변경 파일 샘플만 출력한다.
- `session save -Detailed` 를 사용할 때만 상세 변경 파일 목록을 콘솔에 출력한다.
- `git branch-name`, `git git-message`, `git pr-message` 도 기본적으로 변경 수, 변경 영역, 변경 파일 샘플만 출력한다.
- Git 관련 명령도 `-Detailed` 를 사용할 때만 상세 변경 파일 목록을 콘솔에 출력한다.
- 일회성 성격의 session/git 초안은 별도 preview 파일로 저장하지 않는다.

### 8.4 util 출력
- `context-bundle.ps1` 의 출력 위치는 `.speclab/context-bundle-output/**` 이다.
- `project-tree.ps1`, `doc-tree.ps1` 의 출력 위치는 `.speclab/tree-output/**` 이다.
- util 출력은 기준 문서가 아니라 필요할 때 다시 만들 수 있는 실행 산출물이다.

실제 문서 이력은 별도로 아래 위치에 저장한다.

- 위치: `docs/history/projects/**`
- 예:
  - confirm 적용 시 codex output / note / 적용 문서 snapshot 저장
  - history-save 실행 시 현재 적용 문서 snapshot / note / 관련 preview 저장

현재 파일 묶음은 아래처럼 이해하면 가장 빠르다.

- `confirm-*`
  - confirm 적용 근거와 confirm 적용 결과를 저장하는 묶음
  - 예: `confirm-source-codex-output`, `confirm-source-codex-output.note`, `confirm-applied`
- `history-*`
  - history-save 시점의 현재 문서 상태와 관련 preview 맥락을 저장하는 묶음
  - 예: `history-applied`, `history-applied.note`, `history-source-reinforce-preview`, `history-source-confirm-preview`

### 8.5 정리 원칙
- `.speclab/**` 아래 파일은 현재 기준 문서가 아니라 재생성 가능한 실행 산출물이다.
- 다만 `session` / `git` 처럼 일회성 성격이 강한 출력은 `.speclab/**` 아래에도 남기지 않는 쪽을 현재 기준으로 본다.
- 따라서 필요 메모를 따로 옮겨두었다면 `.speclab/**` 내용은 비워도 된다.
- 다만 아직 검토 중인 reinforce output, note, history preview 가 있으면 먼저 확인한 뒤 지우는 편이 안전하다.
- 기준 문서는 계속 `docs/**` 아래에서 관리하고, `.speclab/**` 은 실행 흔적과 검토 보조 산출물로만 본다.

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
- 실행 환경에 따라 Codex 플러그인/인증 경고가 함께 나올 수 있으므로, 실제 사용 시에는 preview 파일과 codex output 파일을 함께 확인하는 편이 안전하다.
- `dev` 단계 명령은 아직 본격 테스트 대상이 아니다.

따라서 이 문서는 완성 제품 매뉴얼이 아니라,  
**현재 알파 검증 단계용 실행 매뉴얼**로 이해해야 한다.

---

## 11. 다음 확장 후보

현재 매뉴얼 이후의 후속 후보는 다음과 같다.

1. `specdrive/specdrive.ps1` 에 `dev` 단계 상위 라우팅 추가
2. `doc reinforce` 외 단계까지 `codex-exec.ps1` 실제 실행 연동 범위 확대 여부 판단
3. `docs/projects/board/02-requirements.md` 에 동일 흐름 반복 적용
4. 실제 코딩 시작 시점의 `dev` CLI 매뉴얼 추가

현재 우선순위는  
1번보다도 먼저, 현재 `doc` 흐름이 실제로 자연스러운지 반복 테스트하는 것이다.

---

## 12. 최종 정리

현재 specdrive CLI는  
완성된 제품 CLI가 아니라 PowerShell 스크립트 기반의 최소 검증 구조다.

따라서 지금 이 매뉴얼의 핵심은 다음 두 가지다.

- 현재 실제로 실행 가능한 명령을 정확히 안내하는 것
- `01-overview.md` 를 기준으로 `doc` 단계 흐름을 반복 테스트하는 것

