# specdrive/docs/todo/doc-map-todo.md

## 1. 문서 목적

이 문서는 문서 인벤토리 설정인 `doc-map.json` 의 후속 정리 메모다.

현재 `temp/doc-map.json` 은 예시 파일이며,
그 내용을 그대로 실행 설정으로 사용하지 않는다.

현재 구조에 맞춘 초기 draft 설정은 `specdrive/config/doc-map.json` 에 있다.
다만 아직 어떤 스크립트도 이 설정을 기본 동작으로 읽지 않는다.

---

## 2. `doc-map` 의 역할

`doc-map` 은 문서 자체의 목록과 역할을 정의한다.

주요 관심사는 다음이다.

- 문서 key
- 문서 path
- 문서 scope
- 문서 kind
- 문서 title
- 문서 role
- 필요한 경우 `target_key` 같은 기존 registry 연결

`doc-map` 은 문서 간 영향 관계를 직접 판단하지 않는다.
영향 관계는 `affected-docs-map.json` 이 담당한다.

---

## 3. `affected-docs-map` 과의 차이

두 설정의 역할은 다음처럼 분리한다.

- `doc-map.json`
  - 이 문서가 무엇인지 설명한다.
  - 문서 인벤토리 역할을 한다.
  - `doc-tree`, 문서 목록 출력, context 선택 UI 후보의 기반이 될 수 있다.

- `affected-docs-map.json`
  - 이 문서가 바뀌면 무엇을 함께 봐야 하는지 설명한다.
  - 영향 관계와 검토 후보를 관리한다.
  - `context-bundle -IncludeAffected`, `doc-tree -ShowAffected` 같은 후속 옵션의 기반이 될 수 있다.

---

## 4. 현재 예시 파일의 문제

`temp/doc-map.json` 은 예시로만 참고한다.

현재 그대로 사용하기 어려운 이유는 다음과 같다.

- 오래된 경로인 `docs/specs/**`, `docs/impl/**` 가 포함되어 있다.
- 현재 구조인 `specdrive/docs/**`, `docs/projects/**` 기준이 반영되어 있지 않다.
- `historyDir`, `promptDir` 이 현재 실행 자산 구조와 맞지 않는다.
- 문서 인벤토리와 프롬프트 자산 경로가 섞여 있다.
- 현재 target registry 와의 연결이 명확하지 않다.

---

## 5. 현재 draft 설정 위치

현재 구조에 맞춘 draft 설정 위치는 다음과 같다.

```text
specdrive/config/doc-map.json
```

`temp/**` 아래 파일은 임시 예시와 실험용으로만 둔다.
`specdrive/config/doc-map.json` 도 아직 확정 규칙이 아니라 draft 설정으로 본다.

---

## 6. 후속 연결 후보

`doc-map` 이 더 검증된 뒤에는 다음처럼 옵션 기반으로 연결할 수 있다.

- `doc-tree.ps1 -UseDocMap`
  - 파일 시스템 tree 대신 문서 인벤토리 기준으로 문서 목록을 출력한다.
- `context-bundle.ps1 -DocumentKey board-overview`
  - path 대신 doc-map key 로 bundle 대상을 선택한다.
- `session status`
  - 현재 작업 문서 key, role, target 연결 상태를 요약한다.

현재는 모두 후속 후보이며 기본 동작으로 넣지 않는다.

---

## 7. 보류 결정

현재 확정하지 않는 항목은 다음과 같다.

- `doc-tree.ps1` 기본 동작에서 `doc-map.json` 자동 사용
- `context-bundle.ps1` 기본 동작에서 document key 사용
- `session` 명령의 기본 출력에 doc-map 기반 문서 인벤토리 표시

먼저 draft 설정이 실제 문서 구조를 잘 표현하는지 검토한 뒤,
옵션 기반으로 연결하는 편이 안전하다.
