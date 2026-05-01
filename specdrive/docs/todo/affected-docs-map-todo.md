# specdrive/docs/todo/affected-docs-map-todo.md

## 1. 문서 목적

이 문서는 문서 간 영향 관계를 정의할 `affected-docs-map.json` 의 후속 정리 메모다.

이 문서는 현재 확정 규칙이 아니다.
현재 `temp/affected-docs-map.json` 은 예시 파일이며,
그 내용을 그대로 실행 설정으로 사용하지 않는다.

현재 구조에 맞춘 초기 draft 설정은 `specdrive/config/affected-docs-map.json` 에 있다.
다만 `$doc-work-bundle` 의 board 문서 상호 정합성 묶음은
`specdrive/config/doc-work-bundle-map.json` 으로 분리했다.
`affected-docs-map.json` 은 `$doc-work-ref` 와 넓은 영향 관계 검토 후보로 유지한다.

---

## 2. 정리 배경

문서 구조가 현재 다음처럼 분리되어 있다.

- 루트 공통 문서
- `specdrive/docs/**`
- `docs/projects/**`
- `docs/projects/board/**`
- `docs/projects/standards/**`
- 각 계층의 `AGENTS.md`

따라서 영향 문서 맵도 단순한 문서 목록이 아니라,
문서 계층과 책임 경계를 반영해야 한다.

---

## 3. 현재 예시 파일의 문제

`temp/affected-docs-map.json` 은 예시로만 참고한다.

현재 그대로 사용하기 어려운 이유는 다음과 같다.

- 오래된 경로인 `docs/specs/**`, `docs/impl/**` 가 포함되어 있다.
- 현재 제품명과 문서 구조인 `specdrive/docs/**`, `docs/projects/**` 기준이 반영되어 있지 않다.
- 루트 `AGENTS.md`, `specdrive/docs/AGENTS.md`, `docs/projects/board/AGENTS.md` 의 계층 차이가 분리되어 있지 않다.
- context bundle 후보와 실제 변경 영향 점검 후보가 섞여 있다.
- `action` 값이 실행 의미인지 검토 의미인지 아직 명확하지 않다.

---

## 4. 현재 draft 설정 위치

현재 구조에 맞춘 draft 설정 위치는 다음과 같다.

```text
specdrive/config/affected-docs-map.json
```

`temp/**` 아래 파일은 임시 예시와 실험용으로만 둔다.
`specdrive/config/affected-docs-map.json` 도 아직 확정 규칙이 아니라 draft 설정으로 본다.

---

## 5. 권장 분리 구조

정식 맵은 최소한 다음 영역을 분리하는 편이 좋다.

### 5.1 root

대상 예:

- `AGENTS.md`
- `README.md`
- `docs/AI_CONTEXT.md`

역할:

- 전체 작업 규칙
- 제품/저장소 개요
- 현재 상태 복구

### 5.2 specdrive

대상 예:

- `specdrive/docs/AGENTS.md`
- `specdrive/docs/README.md`
- `specdrive/docs/stages/session-stage.md`
- `specdrive/docs/stages/git-stage.md`
- `specdrive/docs/skill-wizard-manual.md`
- `specdrive/docs/util-scripts.md`

역할:

- specdrive 자체 운영 구조
- CLI, session, git, util 보조 도구
- 문서 기반 AI 협업 흐름

### 5.3 projects-common

대상 예:

- `docs/projects/README.md`
- `docs/projects/standards/**`

역할:

- 실제 프로젝트 문서군의 공통 기준
- 표준 문서

### 5.4 project-board

대상 예:

- `docs/projects/board/AGENTS.md`
- `docs/projects/board/01-overview.md`
- `docs/projects/board/02-requirements.md`

역할:

- board 프로젝트 전용 규칙
- board 요구사항/설계/상태 문서

---

## 6. 엔트리 형태

현재 `affected-docs-map.json` draft 설정의 각 항목은 아래 정도의 의미를 가진다.

```json
{
  "key": "board-overview",
  "path": "docs/projects/board/01-overview.md",
  "scope": "project-board",
  "history_recommended": true,
  "include_for_bundle": [
    "AGENTS.md",
    "docs/AI_CONTEXT.md",
    "docs/projects/board/AGENTS.md"
  ],
  "check_targets": [
    {
      "path": "docs/projects/board/02-requirements.md",
      "action": "review",
      "reason": "개요 변경이 요구사항 범위에 영향을 주는지 확인"
    }
  ]
}
```

현재 이 형태는 draft 이며, 스크립트 입력 계약으로 확정된 것은 아니다.

`$doc-work-bundle` 전용 board 묶음은 아래처럼 별도 map을 사용한다.

```json
{
  "key": "requirements",
  "path": "specs/02-requirements.md",
  "bundle_refs": [
    "01-overview.md",
    "specs/03-design.md",
    "specs/04-application-structure.md"
  ],
  "reason": "요구사항은 후속 설계와 구현 계획의 입력이므로 주요 문서와 정합성을 점검한다."
}
```

---

## 7. util 연결 후보

영향 문서 맵이 정리된 뒤에만 다음 연결을 검토한다.

- `context-bundle.ps1 -IncludeAffected`
  - 선택 문서 기준으로 영향 문서를 bundle 에 추가한다.
- `doc-tree.ps1 -ShowAffected`
  - 문서 tree 에 영향 관계가 있는 항목을 표시한다.
- `session status`
  - 현재 작업 문서 기준으로 함께 점검할 문서 후보를 요약한다.

현재는 어떤 util 스크립트도 `temp/affected-docs-map.json` 또는
`specdrive/config/affected-docs-map.json` 을 기본 동작으로 읽지 않는다.

---

## 8. 보류 결정

현재 확정하지 않는 항목은 다음과 같다.

- `context-bundle.ps1` 기본 동작에 영향 문서 자동 포함
- `doc-tree.ps1` 기본 출력에 영향 관계 표시
- `session` 명령의 기본 출력에 영향 문서 후보 포함

먼저 draft 설정을 실제 문서 작업에서 몇 차례 검토한 뒤,
옵션 기반으로 연결하는 편이 안전하다.
