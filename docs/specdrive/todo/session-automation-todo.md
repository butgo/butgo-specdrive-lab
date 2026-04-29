# docs/specdrive/todo/session-automation-todo.md

## 1. 목적

이 문서는 session 관련 고도화 후보를 현재 버전과 분리해 보관하는 차기 버전용 메모다.

현재 버전에서는 session 고도화를 진행하지 않는다.
session 관련 추가 자동화, CLI, IDE 연동, SDK 연동은 `doc` / `dev` 관련 작업이 끝난 뒤 개발자가 다시 판단하고 요청할 때만 검토한다.

이 문서는 현재 기준 문서와 참조 관계를 유지하지 않는다.
세션 시작, 상태 확인, 저장의 현재 실행 기준도 이 문서에서 정하지 않는다.

---

## 2. 보류 결정

다음 항목은 현재 버전 범위에서 제외한다.

- session 자동 실행
- session CLI 고도화
- session 상태 출력 고도화
- session 저장 자동화
- Codex IDE Extension 직접 연동
- Codex SDK 기반 session runner
- `.speclab/session-output/**` 같은 session 출력 파일 누적
- session 흐름과 Git/PR 흐름의 추가 자동화 결합

---

## 3. 재검토 조건

아래 조건을 만족한 뒤에만 다시 검토한다.

1. `doc` 관련 현재 작업이 정리된다.
2. `dev` 관련 현재 작업이 정리된다.
3. 개발자가 session 고도화를 다시 요청한다.
4. 현재 skill 직접 사용 흐름에서 실제 반복 부담이 확인된다.

---

## 4. 후속 후보

나중에 다시 검토할 수 있는 후보는 다음과 같다.

- `$session start` 이후 full recovery 자동화
- `$session status` 출력 형식 추가 조정
- `$session save` 결과를 파일/클립보드/초안으로 분리
- `codex exec` 기반 읽기 전용 session runner
- IDE Extension 또는 SDK 기반 session runner
- session 결과를 상태 문서 반영 초안으로 구조화

---

## 5. 현재 메모

현재 기준에서는 session 고도화보다 `doc` / `dev` 흐름 정리가 먼저다.

이 문서는 후속 후보 보관용이며, 현재 세션 복구나 기준 문서 정비의 기본 참조 범위에 넣지 않는다.
