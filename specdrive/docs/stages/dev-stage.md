# Dev Stage

## 1. 문서 목적

이 문서는 SpecDrive의 `dev` 단계 책임과 경계를 정의한다.

`dev` 단계는 `plan` 단계에서 정리된 Work Package를 기준으로 실제 코딩, 테스트, 동기화를 수행하는 단계다.

---

## 2. 단계 책임

`dev` 단계는 다음을 다룬다.

- 승인된 `work-roadmap.md` 에서 현재 시작 위치 선택
- `work-index.md` 에 현재 Phase / Cycle / Work Package / Focus Task 설정
- 현재 Work Package 기준 코딩
- 현재 Work Package 기준 테스트 또는 검증
- 실행 결과를 `work-log.md` 에 요약
- 필요 시 `status/`, `manual/`, `rules/` 반영 후보 정리

---

## 3. 현재 action 후보

현재 `dev` 단계는 다음 action 후보를 기준으로 본다.

- `$dev start`
- `$dev impl-run`
- `$dev run`
- `$dev test`
- `$dev sync`

### 3.1 `$dev start`

승인된 plan 결과에서 현재 시작할 Work Package를 선택하고 `work-index.md` 를 설정한다.

### 3.2 `$dev impl-run`

현재 `work-index.md` 의 Work Package 안에서 코딩을 진행한다.

`$dev run`은 `$dev impl-run`과 같은 구현 실행 action으로 본다.

### 3.3 `$dev test`

현재 `work-index.md` 의 Work Package를 기준으로 테스트 또는 검증을 실행한다.

### 3.4 `$dev sync`

실행/테스트 결과를 `work-log.md` 에 요약하고, 다음 Work Package 이동 여부와 status/manual 갱신 필요 여부를 정리한다.

---

## 4. 실행 단위

`dev` 단계의 기본 실행 단위는 Work Package다.

Task는 WP 구성을 위한 후보이며, Work Package는 그 후보들을 묶은 dev 실행 단위다.  
Codex는 선택된 Work Package 범위 안에서 구현을 진행한다.

단, 현재 Cycle 범위나 다음 Work Package로 임의 이동하지 않는다.

---

## 5. 경계

- `dev` 단계는 기준 문서를 새로 확정하지 않는다.
- `dev` 단계는 plan 없이 현재 작업을 추측하지 않는다.
- `dev` 단계는 Candidate를 바로 구현하지 않는다.
- `dev` 단계는 현재 Work Package 범위를 넘어 미래 확장을 선반영하지 않는다.
