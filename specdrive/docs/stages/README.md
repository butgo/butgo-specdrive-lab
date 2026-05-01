# Stage Documents

## 1. 문서 목적

이 문서는 `specdrive/docs/stages/**` 아래 stage 문서들의 역할을 안내한다.

stage 문서는 SpecDrive의 상위 작업 단계가 어떤 책임과 경계를 가지는지 설명한다.

---

## 2. flows와의 차이

`specdrive/docs/stages/**`
= `doc`, `plan`, `dev`, `session`, `git` 같은 상위 작업 단계의 책임을 설명한다.

`specdrive/docs/flows/**`
= 특정 action이나 작업 흐름의 실행 순서를 설명한다.

---

## 3. 문서 목록

- `doc-stage.md`: 기준 문서를 보강, 검토, 반영, history 저장하는 책임
- `plan-stage.md`: 기준 문서를 dev 실행 가능한 작업 구조로 분해하는 책임
- `dev-stage.md`: 현재 Work Package를 기준으로 코딩, 테스트, 동기화하는 책임
- `session-stage.md`: session 단계의 복구, 상태 확인, 저장 보조 책임
- `git-stage.md`: git 단계의 commit, push, PR 전달 단위 준비 책임

---

## 4. 권장 읽기 순서

핵심 작업 흐름을 이해할 때는 다음 순서로 읽는다.

1. `doc-stage.md`
2. `plan-stage.md`
3. `dev-stage.md`
4. `session-stage.md`
5. `git-stage.md`

---

## 5. 핵심 단계 구분

SpecDrive의 핵심 작업 단계는 `doc -> plan -> dev` 로 본다.

```text
doc
= 기준 문서를 만든다.
= 문서 보강, 검토, 반영, history 저장을 다룬다.

plan
= 기준 문서를 실행 가능한 작업 구조로 분해한다.
= Work Package 후보 추출, Phase/Cycle 배치, Task 분해를 다룬다.
= 아직 코딩하지 않는다.

dev
= plan에서 정리된 현재 Work Package를 기준으로 코딩하고 테스트한다.
= work-index, work-log, status/manual 동기화를 다룬다.
```

`session` 과 `git` 은 핵심 작업 단계가 아니라 각각 세션 운영과 전달 단위를 담당하는 보조 단계다.
