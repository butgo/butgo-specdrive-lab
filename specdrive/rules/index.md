# specdrive/rules/index.md

## 1. Purpose

이 문서는 `specdrive/rules/**` 정책 문서의 진입점이다.

`specdrive/rules/**`는 긴 기준 문서를 매번 읽지 않고, 현재 작업에 필요한 최소 정책만 선택해 읽기 위한 경량 rule layer다.

목적은 다음과 같다.

- 세션 토큰 사용량을 줄인다.
- 작업별 읽기 범위를 작게 유지한다.
- 공통 협업 원칙과 작업별 정책을 분리한다.
- 아직 확정되지 않은 후속 policy를 현재 기준처럼 오해하지 않게 한다.

---

## 2. Current Active Rules

현재 활성 policy는 다음과 같다.

- `core-collaboration-rules.md`
  - AI 협업의 최소 공통 원칙을 정의한다.
  - 적게 읽기, 작게 바꾸기, 짧게 보고하기, 단계 분리, 승인 경계를 다룬다.

- `read-scope-policy.md`
  - 작업 종류별 기본 읽기 범위를 정의한다.
  - compact 우선, full 문서 제한, bundle/history 예외 원칙을 다룬다.

- `session-policy.md`
  - session 계열 작업의 읽기 범위와 금지 범위를 정의한다.
  - session status/start/restore/save를 메타 운영 단계로 제한한다.

- `plan-policy.md`
  - plan 계열 작업의 읽기 범위와 금지 범위를 정의한다.
  - extract-candidates/phase-split/cycle-split/wp-split/task-split을 top-down 분해로 제한한다.

- `skill-wizard-rule.md`
  - skill action의 자동 연쇄 실행을 막는다.
  - copy-ready prompt는 다음 action이 명확할 때만 출력한다.

---

## 3. Read Order

기본 읽기 순서는 다음과 같다.

1. `core-collaboration-rules.md`
2. 현재 작업에 필요한 세부 policy
3. 대상 문서
4. 사용자가 명시한 참조 문서

세부 policy가 필요하지 않은 단순 작업에서는 `core-collaboration-rules.md`만 읽는다.

session 작업에서는 기본 policy로 다음만 읽는다.

1. `session-policy.md`

단순 `session status / start / restore / save`에서는 `session-policy.md`만 사용한다.
읽기 범위가 불명확하거나 다른 작업 단계로 전환되는 경우에만 `core-collaboration-rules.md` 또는 `read-scope-policy.md`를 추가로 읽는다.

---

## 4. Follow-up Policy Candidates

다음 policy는 아직 후속 후보로 둔다.

- doc-work
- dev
- bundle

후속 후보 문서는 실제 반복 흐름이 충분히 확인된 뒤 생성한다.

생성 전에는 기존 active rule과 각 skill action 문서를 기준으로 작업한다.

---

## 5. Boundaries

`specdrive/rules/**`는 specdrive 운영 정책을 다룬다.

다음은 이 영역에서 직접 다루지 않는다.

- 특정 프로젝트의 요구사항 본문
- 특정 프로젝트의 상세 설계
- 특정 프로젝트의 구현 계획 본문
- Git commit / push / PR 실행
- `docs/history/**`의 과거 이력 재정리

Git은 현재 repo-local skill 대상에서 제외한다.

필요한 경우 AI는 사용자가 제공한 Git 상태 요약을 바탕으로 commit message 또는 PR description 초안만 보조한다.

---

## 6. Final Rule

이 영역의 기준은 전체 문서를 더 많이 읽게 만드는 것이 아니다.

기준은 다음이다.

- compact 먼저
- policy는 필요한 것만
- 대상 문서는 하나씩
- bundle과 history는 명시 요청 시에만
- 출력은 짧게
