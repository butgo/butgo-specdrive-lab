# Runtime Rules

## 1. 문서 목적

이 문서는 SpecDrive Core runtime 구조와 실행 산출물의 운영 규칙을 정의한다.

runtime 구조는 문서 기준, config 기준, script 실행, skill 실행 결과가 만나는 영역이다.

---

## 2. 기본 원칙

- 현재 기준 문서는 `specdrive/docs/**` 와 `docs/projects/**` 에 둔다.
- 재생성 가능한 실행 산출물은 `.speclab/**` 아래에 둔다.
- 의미 있는 문서 변경 이력은 `docs/history/**` 정책을 따른다.
- runtime 산출물은 현재 기준 문서를 대체하지 않는다.
- runtime 구조 변경 시 `runtime-structure.md` 와 관련 stage 문서 반영 필요 여부를 확인한다.

---

## 3. 주요 경계

`.speclab/**`
= preview, review output, history output 같은 재생성 가능한 실행 산출물 영역

`docs/history/**`
= 의미 있는 판단과 문서 변경 이력을 보존하는 영역

`specdrive/config/**`
= target, skill, context-set, action, doc map 같은 해석 기준을 두는 영역

`specdrive/scripts/**`
= config와 문서를 읽어 preview 또는 실행 보조 산출물을 만드는 영역

---

## 4. 금지 사항

- `.speclab/**` 산출물을 현재 기준 문서처럼 다루지 않는다.
- runtime 편의를 이유로 문서 역할과 책임 경계를 바꾸지 않는다.
- 현재 단계에서 CLI/TUI/MCP runtime 구조를 확정된 기준처럼 선반영하지 않는다.
- history 확인 요청 없이 `docs/history/**` 를 기본 복구 문맥으로 읽지 않는다.

