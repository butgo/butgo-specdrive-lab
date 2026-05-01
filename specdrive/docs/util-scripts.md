# specdrive/docs/util-scripts.md

## 1. 문서 목적

이 문서는 `specdrive/scripts/util/**` 아래의 보조 유틸리티 스크립트를 정리한다.

이 문서는 `doc`, `session`, `git` 단계의 기준 문서를 대체하지 않는다.
유틸 스크립트는 기준 문서나 상태 문서를 직접 확정하지 않고,
문서 묶음, 트리 출력, 구조 확인 같은 보조 산출물을 만드는 역할만 가진다.

---

## 2. 현재 기준

현재 util 스크립트는 상위 단일 진입점 CLI 라우팅에 연결하지 않는다.
필요할 때 PowerShell 파일을 직접 실행한다.

현재 util 출력은 `.speclab/**` 아래에 저장한다.
이 출력은 기준 문서가 아니라 필요할 때 다시 만들 수 있는 실행 산출물이다.

---

## 3. 현재 util 스크립트

### 3.1 `context-bundle.ps1`

역할:

- 선택한 문서를 하나의 Markdown bundle 로 묶는다.
- 기본 문서로 `README.md`, `AGENTS.md`, `docs/AI_CONTEXT.md` 를 사용할 수 있다.
- 특정 문서를 직접 지정해 작업용 context bundle 을 만들 수 있다.
- `specdrive/config/context-bundle-map.json` 의 `BundleKey` 로 정해진 문서 묶음을 생성할 수 있다.
- `-IncludeReadmeKo`, `-IncludeAgents` 로 저장소의 `README.ko.md`, `AGENTS.md` 전체를 묶을 수 있다.

실행 예:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1 -Documents docs/projects/board/01-overview.md,specdrive/docs/stages/session-stage.md -Name board-session-context
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1 -BundleKey readme-ko-all
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1 -BundleKey agents-all
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1 -BundleKey onboarding-all
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1 -BundleKey codex-base-review
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/context-bundle.ps1 -BundleKey standards-all
```

`BundleKey`, `Documents`, `IncludeDefault` 같은 선택 옵션 없이 실행하면 번호 선택 메뉴가 표시된다.

```text
1: default
2: readme-ko-all
3: readme-en-all
4: readme-all
5: agents-all
6: onboarding-all
7: codex-base-review
8: standards-all
```

출력 위치:

```text
.speclab/context-bundle-output/**
```

---

### 3.2 `project-tree.ps1`

역할:

- 저장소 전체의 디렉터리/파일 구조를 Markdown tree 로 저장한다.
- `.git`, `.speclab`, `node_modules`, `bin`, `obj` 는 기본 제외한다.
- 필요하면 `-MaxDepth`, `-DirectoriesOnly`, `-Exclude` 로 출력 범위를 줄인다.

실행 예:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/project-tree.ps1 -MaxDepth 4
```

출력 위치:

```text
.speclab/tree-output/**
```

---

### 3.3 `doc-tree.ps1`

역할:

- `docs/**` 문서 구조를 Markdown tree 로 저장한다.
- 문서 구조를 빠르게 검토하거나 문서 묶음 기준을 잡을 때 사용한다.
- 필요하면 `-MaxDepth`, `-DirectoriesOnly`, `-Exclude` 로 출력 범위를 줄인다.

실행 예:

```powershell
powershell -ExecutionPolicy Bypass -File specdrive/scripts/util/doc-tree.ps1 -MaxDepth 8
```

출력 위치:

```text
.speclab/tree-output/**
```

---

## 4. 번들 맵 설정

`context-bundle-map.json` 은 context bundle 에서 사용할 문서 묶음을 정의한다.

현재 위치는 다음과 같다.

```text
specdrive/config/context-bundle-map.json
```

현재 등록된 주요 bundle key 는 다음과 같다.

- `default`
  - `README.md`, `AGENTS.md`, `docs/AI_CONTEXT.md`
- `readme-ko-all`
  - 저장소 안의 모든 `README.ko.md`
- `readme-en-all`
  - 저장소 안의 모든 `README.md`
- `readme-all`
  - 저장소 안의 모든 `README.md` 와 `README.ko.md`
- `agents-all`
  - 저장소 안의 모든 `AGENTS.md`
- `onboarding-all`
  - ChatGPT 업로드용으로 모든 `README.md`, `README.ko.md`, `AGENTS.md`
- `codex-base-review`
  - Codex 기본 문맥 검토용 핵심 `README`, `AGENTS`, `AI_CONTEXT`
- `standards-all`
  - 프로젝트 공통 standards 문서 전체

이 설정은 `affected-docs-map.json` 과 분리한다.
`context-bundle-map.json` 은 문서 묶음 생성용이고,
`affected-docs-map.json` 은 변경 영향 관계 점검용이다.

---

## 5. 문서 맵 설정

`doc-map.json` 은 문서 자체의 목록과 역할을 정리하기 위한 설정이다.

현재 `temp/doc-map.json` 은 예시 파일이다.
현재 구조와 맞지 않는 오래된 경로가 포함되어 있으므로,
그 파일을 그대로 util 스크립트나 CLI 기본 동작에 연결하지 않는다.

현재 구조에 맞춘 초기 draft 설정은 다음 위치에 둔다.

```text
specdrive/config/doc-map.json
```

이 설정은 아직 어떤 util 스크립트도 기본으로 읽지 않는다.
현재는 문서 key, path, scope, kind, role, target 연결 후보를 정리하기 위한 draft 설정이다.

현재 세부 검토 메모는 `specdrive/docs/todo/doc-map-todo.md` 에 둔다.

---

## 6. 영향 문서 맵 설정

`affected-docs-map.json` 은 나중에 문서 간 영향 관계를 참조하기 위한 설정이다.

현재 `temp/affected-docs-map.json` 은 예시 파일이다.
현재 구조와 맞지 않는 오래된 경로가 포함되어 있으므로,
그 파일을 그대로 util 스크립트나 CLI 기본 동작에 연결하지 않는다.

현재 구조에 맞춘 초기 draft 설정은 다음 위치에 둔다.

```text
specdrive/config/affected-docs-map.json
```

이 설정은 아직 어떤 util 스크립트도 기본으로 읽지 않는다.
현재는 문서 계층과 영향 관계 후보를 정리하기 위한 draft 설정이다.

현재 설정은 다음 계층을 구분한다.

- 루트 공통 문서: `AGENTS.md`, `README.md`, `docs/AI_CONTEXT.md`
- specdrive 문서: `specdrive/docs/**`, `specdrive/docs/AGENTS.md`
- project 공통 문서: `docs/projects/**`
- project 전용 문서: `docs/projects/board/**`, `docs/projects/board/AGENTS.md`
- standards 문서: `docs/projects/standards/**`

현재 세부 검토 메모는 `specdrive/docs/todo/affected-docs-map-todo.md` 에 둔다.

---

## 7. 후속 연결 후보

문서 맵과 영향 문서 맵이 더 검증된 뒤에는 다음처럼 옵션 기반으로 연결할 수 있다.

- `context-bundle.ps1 -DocumentKey board-overview`
  - path 대신 `doc-map.json` 의 문서 key 로 bundle 대상을 선택한다.
- `context-bundle.ps1 -IncludeAffected`
  - 선택 문서와 함께 점검해야 할 문서를 bundle 에 추가한다.
- `doc-tree.ps1 -UseDocMap`
  - 파일 시스템 tree 대신 문서 인벤토리 기준으로 문서 목록을 출력한다.
- `doc-tree.ps1 -ShowAffected`
  - 문서 tree 에 영향 관계가 있는 문서를 표시한다.
- `session status`
  - 현재 작업 문서의 role 과 함께 확인할 문서 후보를 요약한다.

다만 현재는 모두 후속 후보이며 기본 동작으로 넣지 않는다.

---

## 8. 최종 정리

util 스크립트는 기준 문서 확정이나 단계 전환을 담당하지 않는다.
현재 기준은 다음이다.

- 실행은 직접 PowerShell 스크립트로 한다.
- 출력은 `.speclab/**` 아래에 둔다.
- 출력은 재생성 가능한 보조 산출물로 본다.
- `doc-map.json`, `affected-docs-map.json` 은 draft 설정이며 기본 동작에 연결하지 않는다.
