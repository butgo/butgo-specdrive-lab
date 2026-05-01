# specdrive/docs/flows/doc-history-save-flow.md

## 1. 문서 목적

이 문서는 specdrive의 `doc apply-prompt` 해석을 기준으로  
**현재 기준 최소 history 저장 시나리오**를 정리하는 문서다.

목적은 다음과 같다.

- `doc apply-prompt` 가 어떤 입력으로 시작되는지 정리한다.
- reinforce / confirm 이후 어떤 흔적을 남겨야 하는지 고정한다.
- 정식 문서 반영과 history 저장을 어떻게 함께 볼지 정리한다.
- 첫 테스트 문서를 기준으로 최소 history 저장 흐름을 만든다.

현재 이 문서는  
`docs/projects/board/01-overview.md` 를 첫 테스트 대상 문서로 사용한다.

---

## 2. 현재 테스트 대상 문서

현재 `doc apply-prompt` 흐름의 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`

---

## 3. history 저장이 하는 일

현재 기준에서 history 저장은 다음 역할을 가진다.

- reinforce 와 confirm 이후의 판단 흔적을 저장한다.
- 현재 문서가 왜 이런 상태가 되었는지 남긴다.
- 다음 세션이나 후속 작업에서 맥락을 빠르게 복구할 수 있게 한다.
- 문서 작업 이력이 단순 덮어쓰기가 되지 않도록 한다.

중요한 점은 다음과 같다.

- history 저장은 문서를 다시 보강하지 않는다.
- history 저장은 confirm 를 대신하지 않는다.
- history note 는 가능하면 diff 자체보다 Codex가 실제로 어떤 보강과 정리를 했는지 요약하는 기록을 우선한다.

현재는 `apply-prompt` 가 문서 반영 본문과 history snapshot/note 초안을 함께 제안하는 경로를 우선 해석한다.

---

## 4. 현재 기준 실행 흐름

현재 기준의 최소 실행 흐름은 아래와 같다.

1. 사용자가 `doc apply-prompt` 를 시작한다.
2. CLI가 대상 문서를 `docs/projects/board/01-overview.md` 로 인식한다.
3. 현재 스크립트는 fallback target 규칙을 읽는다.
4. `specdrive/config/target-registry.json` 에서 대상 문서와 `context_set_key` 를 읽는다.
5. `specdrive/config/doc-action-registry.json` 에서 `skill_key`, `output_mode`, review output directory 를 읽는다.
6. `specdrive/config/skill-registry.json`, `context-set-registry.json` 에서 실제 skill 경로와 context 문서 묶음을 해석한다.
7. `specdrive/config/output-policy.json` 에서 출력 정책을 읽는다.
8. `specdrive/scripts/doc/**` 가 apply prompt 생성 흐름을 조합한다.
9. 필요한 경우 최근 reinforce / confirm preview 를 함께 읽는다.
10. 결과는 문서 반영 + history 저장 초안으로 사용자에게 돌아온다.
11. 사용자가 내용을 검토하고 승인 후 실제 반영으로 넘긴다.

---

## 5. 기대 출력

현재 기준에서 기대하는 출력은 다음과 같다.

- Applied Document
- History Snapshot File
- History Note File
- Change Summary
- Note Body
- Next Entry

즉 기본 출력은 기계적 저장 결과가 아니라  
**사람이 반영과 history 저장을 함께 승인할 수 있는 기록 초안**이어야 한다.

---

## 6. history 파일 패턴

현재 `doc` 단계에서 문서 작업 이력을 남길 때는 모든 history 파일명 앞에
timestamp prefix 를 붙이고, 그 뒤에 아래 suffix 패턴을 사용한다.

timestamp prefix 형식은 다음과 같다.

```text
yyyy-MM-dd_HHmmss_
```

예:

```text
2026-03-17_131703_
```

따라서 실제 파일명은 아래와 같은 형태가 된다.

```text
2026-03-17_131703_<document-base>_dev-draft.md
```

| 파일 패턴 | 의미 |
| --- | --- |
| `_dev-draft.md` | 개발자 초안 |
| `_dev-draft.note.md` | 개발자 초안 노트 |
| `_codex-reinforced.md` | Codex 초기 보강 |
| `_codex-reinforced.note.md` | Codex 초기 보강 노트 |
| `_dev-revised.md` | Codex 초기 보강 후 개발자 수정 |
| `_dev-revised.note.md` | Codex 초기 보강 후 개발자 수정 노트 |

`_dev-revised` 계열 파일은 한 문서에 여러 개 존재할 수 있다.
따라서 timestamp prefix 를 반드시 사용해 여러 수정 이력이 서로 덮어쓰이지 않게 한다.

개발자 초안 note 파일은 아래 형식을 우선 사용한다.

```markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: dev-draft
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Summary

개발자 초안 작성
```

Codex 초기 보강 note 파일은 아래 형식을 우선 사용한다.

```markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: codex-reinforced
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Summary

- <summary line 1>
- <summary line 2>
```

`_codex-reinforced.note.md` 의 Summary 는 10줄 이내로 작성한다.
이 note 는 diff 전체가 아니라 Codex 초기 보강에서 실제로 정리한 핵심 내용을 요약한다.

Codex 초기 보강으로 원본 문서를 업데이트하기 전에는 해당 대상 문서의
`_dev-draft.md` history snapshot 이 이미 있는지 먼저 확인한다.

대상 문서의 `_dev-draft.md` snapshot 이 없다면, 원본 업데이트 전에 현재 원본 문서를
변경 없이 `_dev-draft.md` 로 먼저 저장하고 `_dev-draft.note.md` 도 함께 생성한다.
그 다음 Codex 보강 결과를 원본 문서와 `_codex-reinforced.md` history snapshot 에 반영한다.

단, 같은 대상 문서에 대해 이미 해당 stage 의 history snapshot 이 존재하면 같은 stage 를 다시 진행하지 않는다.

- `draft` 작업은 `_dev-draft.md` 가 이미 있으면 존재 사실을 알리고 중단한다.
- `reinforce` 작업은 `_codex-reinforced.md` 가 이미 있으면 존재 사실을 알리고 중단한다.
- `revise` 작업은 `_dev-revised.md` 가 이미 있어도 중단하지 않는다. 개발자 수정은 여러 번 존재할 수 있다.

이 확인은 파일명 기준으로 수행하며, 사용자가 명시적으로 요청하지 않는 한 기존 `docs/history/**` 파일 본문은 열람하지 않는다.

이 패턴은 다음 구분을 선명하게 남기기 위한 기준이다.

- 개발자가 처음 작성한 초안
- Codex가 처음 보강한 결과
- Codex 보강 이후 개발자가 다시 조정한 결과

---

## 7. 최종 정리

현재 `doc apply-prompt` 흐름의 첫 테스트 문서는  
`docs/projects/board/01-overview.md` 다.

이 흐름은 `doc` 단계의 마지막에서  
문서 작업 판단의 흔적을 남기는 역할을 하며,  
현재는 `apply-prompt` 와 함께 정식 반영과 history 저장을 묶는 방향으로 정리한다.
