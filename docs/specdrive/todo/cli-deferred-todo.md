# docs/specdrive/todo/cli-deferred-todo.md

## 1. 목적

이 문서는 현재 버전에서 제외한 specdrive CLI 관련 후속 검토 항목을 보관한다.

현재 버전의 우선 흐름은 repo-local Codex skill 직접 사용이다.
CLI는 현재 기준 문서의 기본 진입점이나 권장 흐름으로 두지 않는다.

---

## 2. 현재 제외한 범위

현재 버전에서는 다음을 기본 작업 흐름에서 제외한다.

- `specdrive/specdrive.ps1` 단일 진입점 확장
- `session start / status / save` CLI 흐름
- `git branch-name / git-message / pr-message` CLI 흐름
- CLI 기반 copy prompt 생성 자동화
- CLI 기반 로컬 상태 수집 자동화
- `session status` CLI 출력 재정비

---

## 3. 후속 검토 조건

CLI는 다음 조건이 충분히 반복 확인된 뒤 다시 검토한다.

- skill 직접 사용만으로는 반복 입력 부담이 크다.
- 매번 같은 로컬 상태 수집이 필요하다.
- 매번 같은 prompt 껍데기를 작성해야 한다.
- skill 출력 형식이 안정되어 CLI가 단순 보조 도구로만 남을 수 있다.

---

## 4. 현재 기준

현재 기준에서는 다음 흐름을 우선한다.

- `$session-start-lite`
- `$session-start`
- `$session-status`
- `$session-save`
- `$git-commit`
- `$github-pr`

CLI 문서는 과거 검증 이력과 후속 후보로 보관하되, 현재 세션 복구나 기준 문서 정비의 기본 참조 범위에 넣지 않는다.
