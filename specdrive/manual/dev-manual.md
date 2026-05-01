# Dev Manual

## 1. 문서 목적

이 문서는 SpecDrive의 `$dev` 사용 절차를 정리하는 실행 매뉴얼이다.

`dev` 단계는 승인된 plan 결과를 기준으로 현재 Work Package를 선택하고, 그 범위 안에서 코딩, 테스트, 동기화를 수행하는 단계다.

나중에 `specdrive/manual/**` 문서를 통합해 SpecDrive 전체 매뉴얼을 만들 때 이 문서를 `dev` 단계 매뉴얼의 기준으로 사용한다.

---

## 2. dev 단계 위치

```text
doc
  ↓
plan
  ↓
dev
```

`dev` 단계는 `plan` 단계가 만든 `work-roadmap.md` 를 기준으로 시작한다.

dev 단계의 기본 실행 단위는 Task가 아니라 Work Package다.  
Task는 Work Package 안에서 실행을 돕는 세부 항목이며, Task 분해는 `$plan task-split` 책임이다.

---

## 3. dev action 목록

현재 `$dev` 는 다음 action을 가진다.

```text
$dev start
$dev run
$dev test
$dev sync
```

기본 순서는 다음과 같다.

```text
승인된 work-roadmap.md
  ↓
start
  ↓
run
  ↓
test
  ↓
sync
```

---

## 4. action별 사용 기준

### 4.1 `$dev start`

승인된 plan 결과에서 현재 실행할 Work Package를 선택하고 `work-index.md` 설정 초안을 준비한다.

생성/갱신 대상:

```text
docs/projects/{project}/work/work-index.md
```

주의:

- 코딩하지 않는다.
- 테스트하지 않는다.
- `work-roadmap.md` 에 없는 작업을 현재 포인터로 잡지 않는다.

### 4.2 `$dev run`

현재 `work-index.md` 의 Work Package 안에서 코딩을 진행한다.

`dev run`은 현재 Work Package를 기본 실행 단위로 삼는다.  
Focus Task는 참고하되, 같은 Work Package 안에서 자연스럽게 이어지는 인접 Task까지 함께 처리할 수 있다.

생성/갱신 대상:

```text
실제 코드 파일
필요한 테스트 파일 초안
```

주의:

- 현재 Work Package와 Cycle 범위를 넘지 않는다.
- 다음 Work Package로 임의 이동하지 않는다.
- Git commit은 하지 않는다.

### 4.3 `$dev test`

현재 Work Package 기준으로 테스트 또는 검증을 실행한다.

생성/갱신 대상:

```text
테스트 실행 결과 요약
실패 원인과 수정 후보
필요 시 테스트 파일
```

주의:

- 테스트 중 새 범위를 확장하지 않는다.
- 실패한 테스트를 완료 상태로 기록하지 않는다.
- 실패 시 `$dev run` 으로 돌아갈지 `$dev sync` 에 실패 상태를 남길지 판단한다.

### 4.4 `$dev sync`

실행/테스트 결과를 프로젝트 work/status/manual 후보로 정리한다.

생성/갱신 대상 후보:

```text
docs/projects/{project}/work/work-log.md
docs/projects/{project}/work/work-index.md
docs/projects/{project}/status/current-status.md
docs/projects/{project}/manual/**
docs/projects/{project}/rules/affected-docs-rules.md 점검 결과
```

주의:

- 다음 Work Package 이동은 개발자 확인 후 진행한다.
- 실패한 테스트가 있으면 완료 처리하지 않는다.
- 파일 반영은 초안 확인 후 진행한다.

## 5. 문서 반영 기준

`$dev` 결과는 코드/테스트 변경과 문서 반영 후보를 구분해서 다룬다.

코딩과 테스트는 실제 파일을 변경할 수 있지만, work/status/manual 문서 반영은 먼저 초안으로 정리하고 개발자 확인 후 적용한다.

기본 반영 후보 문서는 다음과 같다.

```text
docs/projects/{project}/work/work-index.md
docs/projects/{project}/work/work-log.md
docs/projects/{project}/status/current-status.md
docs/projects/{project}/manual/**
docs/projects/{project}/rules/affected-docs-rules.md
```

`docs/history/**` 는 dev 단계의 기본 반영 대상이 아니다.  
history 확인이나 저장은 개발자가 명시적으로 요청한 경우에만 다룬다.

---

## 6. action별 생성/갱신 대상 파일

아래 기준은 `$dev` action 결과를 승인했을 때 생성하거나 갱신할 수 있는 파일을 action별로 분리한 것이다.

### 6.1 `$dev start`

생성/갱신 대상:

```text
docs/projects/{project}/work/work-index.md
```

반영 내용:

- Current Phase
- Current Cycle
- Current Work Package
- Current Focus Task
- Next Task
- Entry Notes

기준:

- 코딩 전 현재 실행 포인터를 설정한다.
- `work-roadmap.md` 에 없는 작업을 현재 포인터로 잡지 않는다.
- 파일 반영은 초안 확인 후 진행한다.

### 6.2 `$dev run`

생성/갱신 대상:

```text
실제 코드 파일
필요한 테스트 파일 초안
```

반영 내용:

- 현재 Work Package 범위의 구현 변경
- 현재 Focus Task 또는 같은 Work Package 안의 인접 Task 구현
- 필요한 경우 테스트를 작성하기 위한 최소 준비

기준:

- `work-index.md` 의 현재 실행 포인터를 임의로 전환하지 않는다.
- 현재 Work Package와 Cycle 범위를 넘지 않는다.
- Git commit은 하지 않는다.

### 6.3 `$dev test`

생성/갱신 대상:

```text
테스트 실행 결과 요약
필요한 테스트 파일
실패 원인과 수정 후보
```

반영 내용:

- 현재 Work Package 검증 결과
- 실행한 테스트 명령 또는 수동 검증 방법
- 실패한 테스트와 원인
- `$dev run` 으로 되돌아갈 수정 후보
- `$dev sync` 에 남길 실패 또는 보류 상태 후보

기준:

- 실패한 테스트가 있으면 완료 처리하지 않는다.
- 테스트 중 새 기능 범위를 확장하지 않는다.
- 다음 Work Package로 이동하지 않는다.

### 6.4 `$dev sync`

생성/갱신 대상 후보:

```text
docs/projects/{project}/work/work-log.md
docs/projects/{project}/work/work-index.md
docs/projects/{project}/status/current-status.md
docs/projects/{project}/manual/**
docs/projects/{project}/rules/affected-docs-rules.md 점검 결과
```

반영 내용:

- 실행/테스트 결과
- 완료된 작업과 남은 작업
- 현재 Work Package 완료 여부
- 다음 Task 또는 다음 Work Package 전환 후보
- status/manual 갱신 필요 여부
- affected docs 점검 결과

기준:

- 다음 Work Package 이동은 개발자 확인 후 진행한다.
- 실패한 테스트가 있으면 완료 처리하지 않는다.
- 파일 반영은 초안 확인 후 진행한다.

### 6.5 함께 확인할 수 있는 파일

필요한 경우 함께 확인할 수 있는 파일은 다음과 같다.

| 파일 | 확인 목적 |
|---|---|
| `docs/projects/{project}/work/work-roadmap.md` | 현재 Work Package가 승인된 plan 범위인지 확인 |
| `docs/projects/{project}/work/work-policy.md` | dev 실행과 전환 기준 확인 |
| `docs/projects/{project}/specs/**` | 구현이 기준 문서와 충돌하지 않는지 확인 |
| `docs/projects/{project}/manual/**` | 실행/검증/복구 절차 갱신 필요 여부 확인 |

`$dev` 단계에서 직접 수행하지 않는 반영은 다음과 같다.

| 대상 | 이유 |
|---|---|
| Git commit / push / PR | `$git` 단계 책임 |
| 작업 후보 추출 / Phase / Cycle / Task 분해 | `$plan` 단계 책임 |
| 기준 문서 보강 / confirm / apply | `doc` 단계 책임 |
| session save | `$session` 단계 책임 |

---

## 7. 파일 생성 기준

프로젝트에 `work/` 문서가 아직 없으면 `$dev` 를 바로 시작하지 않는다.

먼저 `$plan` 단계에서 최소한 다음 문서를 준비해야 한다.

```text
docs/projects/{project}/work/work-roadmap.md
```

`$dev start` 는 다음 문서가 없으면 생성 후보를 제안할 수 있다.

```text
docs/projects/{project}/work/work-index.md
```

`$dev sync` 는 다음 문서가 없으면 생성 후보를 제안할 수 있다.

```text
docs/projects/{project}/work/work-log.md
docs/projects/{project}/status/current-status.md
```

manual 문서는 Cycle 3 또는 실행/검증/복구 절차가 실제로 필요해졌을 때 생성 후보로 제안한다.

---

## 8. 금지 사항

`dev` 단계에서는 다음을 하지 않는다.

- 개발 문서 보강
- 작업 후보 추출
- Phase/Cycle/Task 분해
- plan 없이 현재 작업 추측
- 현재 Work Package 밖 작업 실행
- Git commit/push/PR 생성
- session save 대체

---

## 9. 관련 문서

- `specdrive/docs/stages/dev-stage.md`
- `specdrive/docs/stages/plan-stage.md`
- `specdrive/docs/work-system.md`
- `.agents/skills/dev/SKILL.md`
