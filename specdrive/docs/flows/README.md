# Flow Documents

## 1. 문서 목적

이 문서는 `specdrive/docs/flows/**` 아래 flow 문서들의 역할을 안내한다.

flow 문서는 SpecDrive의 특정 실행 흐름이 어떤 입력, 처리 단계, 출력, 사람 확인 지점을 가지는지 설명한다.

---

## 2. rules와의 차이

`specdrive/docs/rules/**`
= Core 운영 규칙을 둔다.

`specdrive/docs/flows/**`
= 특정 실행 흐름의 순서와 책임 경계를 설명한다.

즉 flow 문서는 "무엇을 지켜야 하는가"보다 "어떤 순서로 움직이는가"를 다룬다.

---

## 3. 문서 목록

- `doc-reinforce-flow.md`: `doc reinforce-prompt` 와 `doc reinforce` 흐름
- `doc-confirm-flow.md`: `doc confirm-prompt` 검토 흐름
- `doc-history-save-flow.md`: `doc apply-prompt` 기반 반영과 history 저장 흐름

