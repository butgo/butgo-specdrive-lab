# specdrive/docs/stages/session-stage.md

## 1. 문서 목적

이 문서는 specdrive의 `session` 단계를  
**세션 복구와 세션 저장 같은 운영 보조 흐름을 다루는 별도 작업 단계**로 정리하는 문서다.

목적은 다음과 같다.

- `session` 이 왜 `doc` 과 `dev` 와 분리되어야 하는지 설명한다.
- `$session` 라우터와 session action 의 역할을 고정한다.
- 세션 시작/종료 프롬프트를 정규화해 반복 입력을 줄인다.
- 매번 긴 문서를 통째로 주입하지 않고 필요한 진입 문서와 확인 지점만 안내해 토큰 사용량을 줄이는 방향을 만든다.
- `session` 단계가 어디까지 다루고 어디까지 다루지 않는지 경계를 정한다.

이 문서는 구현 상세 문서가 아니다.  
현재 기준으로는 **운영 단계로서의 `session` 역할과 최소 명령 구조**를 설명한다.

---

## 2. 왜 `session` 단계가 필요한가

현재 specdrive는 핵심 작업 단계를 `doc` 과 `dev` 로 나눈다.

- `doc` 는 문서를 구현 가능한 상태로 만드는 단계다.
- `dev` 는 확정된 문서를 기준으로 실제 개발 작업을 진행하는 단계다.

하지만 다음 흐름은 이 둘에 깔끔하게 들어가지 않는다.

- 세션 시작 시 현재 상태 복구
- 세션 종료 시 다음 진입점 저장
- 매번 다른 방식으로 긴 세션 복구 프롬프트를 작성하는 문제
- 불필요한 문서를 한꺼번에 붙여넣어 토큰을 낭비하는 문제

이 흐름들은 문서 확정 자체도 아니고, 실제 개발 실행 자체도 아니다.  
대신 **세션 운영과 작업 전달을 돕는 메타 흐름**에 가깝다.

따라서 `session` 은 `doc` 과 `dev` 의 대체가 아니라,  
그 바깥에서 세션 진입/종료와 전달 메시지를 다루는 별도 운영 단계로 두는 편이 자연스럽다.

---

## 3. `session` 단계의 기본 성격

현재 기준 `session` 단계는 다음 성격으로 이해한다.

- 세션 시작 전후의 상태 복구 보조
- 현재 작업 상태 요약 보조
- 다음 세션 진입점 저장 보조
- 세션 시작/저장 명령의 입력 형식 정규화
- 필요한 문서만 읽게 유도하는 토큰 절약 보조
- 즉 `session` 은  
**작업 자체를 수행하는 단계라기보다, 작업을 시작하고 닫기 쉽게 만드는 운영 단계**다.

---

## 4. 현재 기준 핵심 명령

현재 기준으로 `session` 은 먼저 skill 중심으로 검증한다.

우선 검증 대상은 다음 `$session` action 이다.

```text
$session start-lite
$session restore
$session start
$session status
$session save
```

repo local skill 설치 위치는 다음과 같다.

```text
.agents/skills/session/SKILL.md
.agents/skills/session/actions/start-lite.md
.agents/skills/session/actions/restore.md
.agents/skills/session/actions/start.md
.agents/skills/session/actions/status.md
.agents/skills/session/actions/save.md
```

테스트 중에는 전역 skill 경로에 설치하지 않는다.
배포/패키징 후보 원본 위치는 다음과 같다.

```text
specdrive/codex-skills/session/SKILL.md
specdrive/codex-skills/session/actions/start-lite.md
specdrive/codex-skills/session/actions/restore.md
specdrive/codex-skills/session/actions/start.md
specdrive/codex-skills/session/actions/status.md
specdrive/codex-skills/session/actions/save.md
```

Codex 대화에서는 다음처럼 직접 호출해 사용해 보는 방향을 우선한다.

```text
$session start-lite
$session restore
$session start
$session status
$session save
```

현재 버전에서 `session` 단계는 CLI가 아니라 repo-local Codex skill 직접 사용을 기준으로 검증한다.

외부에 노출되는 skill 은 `$session` 하나로 두고, 세부 동작은 내부 action 문서로 분리한다.
이 action 들은 다음 역할을 가진다.

### 4.1 `$session start-lite`
- VSCode 또는 Codex 첫 시작 직후 사용하는 경량 복구 action
- `docs/AI_CONTEXT.md` 중심으로 현재 focus / 다음 진입점 / 변경 주의 범위만 짧게 복구
- `README.md`, 루트 `AGENTS.md`, `specdrive/docs/AGENTS.md`, `specdrive/docs/stages/session-stage.md` 같은 전체 복구 문서는 기본으로 읽지 않음
- 전체 문맥 복구가 필요하면 이후 `$session start` 로 넘어감

### 4.2 `$session restore`
- VSCode 재시작, Codex UI 재시작, 대화 문맥 손실 직후 사용하는 복구 action
- `docs/AI_CONTEXT.md` 를 기준으로 현재 맥락을 확인
- 현재 focus / 다음 진입점 / 변경 주의 범위를 짧게 복구
- 전체 복구용 copy prompt 는 만들지 않고, 필요할 때만 후속 `$session start` 를 제안
- 문서 수정이나 단계 전환으로 바로 이어지지 않게 유지

### 4.3 `$session start`
- 전체 문서를 즉시 읽는 대신 먼저 경량 복구를 수행
- 현재 focus / 다음 진입점 / 주의해야 할 변경 범위를 짧게 정리
- 전체 `$session start` 복구를 위한 copy prompt 를 출력
- 사용자가 해당 프롬프트를 복사해 다음 단계로 진행할 때만 `README.md`, 루트 `AGENTS.md`, `docs/AI_CONTEXT.md`, `specdrive/docs/AGENTS.md`, `specdrive/docs/stages/session-stage.md` 를 읽도록 안내
- 작업 대상 영역이 정해진 경우 해당 영역의 전용 `AGENTS.md`, README, index, 대상 문서를 추가로 확인하도록 안내
- 개발자 요청 전에는 파일을 직접 수정하지 않도록 경계 유지

### 4.4 `$session save`
- 현재 세션 변경 요약
- 다음 세션용 메모 초안 생성
- 필요 시 상태/히스토리 반영 후보 정리
- 다음 세션에서 다시 사용할 수 있는 진입점 요약 형식 정규화
- 긴 대화 전체를 넘기지 않고 변경 요약, 변경 영역, 변경 파일 샘플, 판단 후보 중심으로 저장할 수 있게 보조
- Codex에 붙여넣을 `docs/AI_CONTEXT.md` 반영 초안 요청 프롬프트 출력
- 초안 검토 전에는 `docs/AI_CONTEXT.md` 를 직접 수정하지 않도록 경계 유지

### 4.5 `$session status`
- `docs/AI_CONTEXT.md` 의 마지막 갱신 기준과 한 줄 상태를 확인
- 현재 focus 와 다음 진입점은 각각 한 줄 정도로만 표시
- 전체 AI_CONTEXT 내용을 길게 보여주지 않음
- Codex copy prompt를 만들지 않고 6줄 내외의 읽기 전용 스냅샷만 출력
- 문서 수정이나 저장 흐름으로 바로 이어지지 않게 유지

현재 기준으로 `session` 단계는 일회성 preview 파일을 남기지 않는다.  
즉 `$session start-lite`, `$session restore`, `$session start`, `$session status`, `$session save` 는 Codex가 직접 따르는 action 절차 자산으로 보고,
현재 버전에서는 CLI 흐름을 기준 경로로 사용하지 않는다.
영속적으로 남겨야 할 내용은 `docs/AI_CONTEXT.md` 같은 상태 문서나 `docs/history/projects/**` 같은 실제 이력 문서에 반영한다.

현재 `$session start` 의 의도는 다음 순서로 이해하는 편이 맞다.

1. 개발자가 Codex에서 `$session start-lite` 또는 `$session restore` 를 호출해 최소 복구를 먼저 수행한다.
2. 더 깊은 복구가 필요하면 `$session start` 를 호출한다.
3. Codex 는 전체 문서를 즉시 읽기보다 현재 focus, 다음 진입점, 주의해야 할 변경 범위를 짧게 정리하고 full recovery copy prompt 를 보여준다.
4. 개발자가 그 프롬프트를 복사해 다음 단계로 진행할 때만 전체 복구 문서를 읽는다.
5. 개발자가 실제 작업을 요청한 뒤에만 문서 수정이나 후속 작업으로 들어간다.
6. Git 상태나 변경 요약은 session 기본 흐름에서 요구하지 않는다. 필요한 경우 개발자가 직접 처리하거나 별도로 질문한다.

즉 현재 `$session start` 는 자동 작업 명령이 아니라  
**세션 복구와 진입점 확인을 단계적으로 시작하는 action 절차**로 보는 편이 맞다.

현재 `$session save` 의 의도는 다음 순서로 이해하는 편이 맞다.

1. 개발자가 Codex에서 `$session save` 를 호출한다.
2. Codex 는 `docs/AI_CONTEXT.md` 반영 초안을 먼저 제안한다.
3. 개발자가 초안을 검토한 뒤 "저장해줘" 같이 명시적으로 요청하면 그때 실제 `docs/AI_CONTEXT.md` 반영을 진행한다.
4. 로컬 변경 요약 생성은 필요한 경우 skill 내부의 읽기 전용 확인으로만 다룬다.

즉 현재 `$session save` 는 자동 저장 명령이 아니라  
**AI_CONTEXT 반영 초안을 안전하게 시작하는 action 절차**로 보는 편이 맞다.

현재 `$session status` 의 의도는 다음처럼 이해하는 편이 맞다.

1. `$session status` 가 `docs/AI_CONTEXT.md` 의 갱신 상태와 한 줄 상태를 확인한다.
2. focus 와 다음 진입점은 각각 한 줄 정도로만 본다.
3. Git 상태는 확인하지 않는다. Git은 개발자가 직접 처리한다.
4. 필요하면 그 다음에 `$session start`, `doc`, `$session save` 같은 후속 흐름으로 넘어간다.

즉 현재 `$session status` 는  
**AI_CONTEXT 상태와 다음 진입점을 6줄 내외로 확인하는 읽기 전용 스냅샷**으로 보는 편이 맞다.

현재 `$session restore` 의 의도는 다음처럼 이해하는 편이 맞다.

1. VSCode/Codex 재시작처럼 문맥이 끊긴 직후 호출한다.
2. `docs/AI_CONTEXT.md` 에서 focus 와 다음 진입점을 복구한다.
3. Git 상태는 확인하지 않는다. Git은 개발자가 직접 처리한다.
4. 파일 수정 없이 지금 이어갈 위치와 주의 범위만 짧게 정리한다.

즉 현재 `$session restore` 는
**재시작 직후 현재 맥락을 되살리는 읽기 전용 복구 action**으로 보는 편이 맞다.

---

## 5. `session` 단계가 직접 다루지 않는 것

현재 `session` 단계는 다음을 직접 다루지 않는다.

- 문서 보강/확정 자체
- task 분해나 phase/cycle 관리 자체
- Git branch/commit/PR 전달 단위 생성 자체
- 장기 session/profile/workspace 전역 관리 시스템

즉 `session` 은  
현재 기준으로 **요약/복구/메시지 초안 생성**에 집중한다.

여기서 중요한 점은  
일회성 세션 메모를 별도 preview 파일로 계속 누적하지 않는다는 것이다.

---

## 6. `doc` / `dev` / `session` 관계

세 단계의 관계는 다음처럼 이해하는 편이 좋다.

### `doc`
- 문서를 보강하고 확정하는 핵심 작업 단계

### `dev`
- 확정된 문서를 기준으로 실제 작업을 진행하는 핵심 작업 단계

### `session`
- 세션을 시작하고 닫고 전달하는 운영 단계

중요한 점은 다음과 같다.

- `session` 은 `doc` 과 `dev` 의 내부 로직을 대체하지 않는다.
- `$session start` 가 문서 확정을 대신하지 않는다.
- `$session save` 가 history-save 를 대체하지 않는다.
- Git 전달 단위 생성은 `git` 단계로 분리하되, 초기 버전 정리 중에는 개발자가 직접 처리한다.
- session은 Git 상태 확인, commit/push/PR 프롬프트를 기본으로 요구하지 않는다.

---

## 7. 현재 추천 호출 흐름

현재 단계에서는 다음 흐름이 자연스럽다.

1. `$session start-lite`
2. 재시작/문맥 손실 직후에는 `$session restore`
3. 필요 시 `$session start`
4. 필요 시 `$session status`
5. 필요한 경우 `doc ...`
6. 필요한 경우 `dev ...`
7. `$session save`

즉 `session` 은  
실제 작업의 앞뒤를 감싸는 운영 보조 계층으로 보는 편이 맞다.

---

## 8. 출력 형식 최소 원칙

현재 `session` skill 은 모든 기준 문서를 한 번에 읽게 만들지 않는다.
또한 파일 수정이나 history 저장을 자동으로 수행하지 않는다.

출력은 다음 원칙을 따른다.

- 세션 복구에 필요한 진입 문서만 먼저 요청한다.
- 작업 대상 영역이 확인되면 해당 영역의 전용 `AGENTS.md` 를 추가로 읽게 요청한다.
- 전체 문서 내용을 붙여넣지 않고, Codex가 필요한 파일을 직접 읽도록 지시한다.
- session skill/action 은 문서 수정, history 저장, Git 메시지 생성을 직접 수행하지 않는다.
- session skill/action 은 Git 상태 확인을 기본 요구하지 않는다. Git은 개발자가 직접 처리하고, 필요할 때만 별도로 Codex에게 질문한다.
- `$session start` copy prompt 는 먼저 현재 상태 요약을 보여주고, 개발자 요청 전에는 파일을 직접 수정하지 말라는 경계를 함께 준다.
- `$session save` copy prompt 는 먼저 반영 초안을 보여주고, 개발자 승인 전에는 `docs/AI_CONTEXT.md` 를 직접 수정하지 말라는 경계를 함께 준다.
- `$session status` 는 copy prompt를 만들지 않고, AI_CONTEXT 상태와 다음 진입점을 6줄 내외로 보여준다.

`$session start` 는 다음 정보를 출력한다.

- 현재 focus / 다음 진입점 / 변경 주의 범위
- full recovery 로 넘어가기 위한 copy prompt

`$session restore` 는 다음 정보를 출력한다.

- 현재 focus / 다음 진입점 / 변경 주의 범위
- 필요 시 다음에 호출할 session action

`$session status` 는 다음 정보를 출력한다.

- AI_CONTEXT 마지막 갱신 기준과 최신성 메모
- 현재 focus 한 줄
- 다음 진입점 한 줄
- Git은 개발자 직접 처리한다는 메모
- 주의 메모 한 줄

`$session save` 는 다음 정보를 출력한다.

- 세션 종료 요약
- `docs/AI_CONTEXT.md` 반영 초안
- 개발자 승인 전에는 파일을 수정하지 않는다는 경계

현재 기준에서 `session` skill 은 파일을 직접 생성하거나 수정하지 않는다.  
영속적으로 남겨야 할 내용은 사람이 검토한 뒤 `docs/AI_CONTEXT.md`, 관련 상태 문서, 또는 필요한 history 문서에 반영한다.

---

## 9. 최종 정리

현재 specdrive에서 `session` 은  
`doc` / `dev` 와 다른 성격의 메타 운영 단계다.

따라서 현재 기준 핵심 정리는 다음과 같다.

- `doc` 와 `dev` 는 핵심 작업 단계로 유지한다.
- `session` 은 세션 복구와 세션 저장 절차를 정규화하는 운영 단계로 둔다.
- 현재는 `$session` 라우터와 `start-lite/restore/start/status/save` action 직접 사용을 먼저 검증한다.
- CLI는 현재 버전의 session 기준 흐름에서 제외한다.
- Git 전달 단위 생성은 `git` 단계로 분리하되, 초기 버전 정리 중에는 개발자가 직접 처리한다.

