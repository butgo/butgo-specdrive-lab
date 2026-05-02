# docs/AI_CONTEXT.compact.md

## 1. Purpose

이 문서는 `docs/AI_CONTEXT.md`의 대체본이 아니다.

이 문서는 Codex 기본 주입용 현재 상태 요약이다.  
긴 상태 문서를 매번 읽지 않고 현재 focus와 다음 진입점만 빠르게 복구하기 위해 사용한다.

---

## 2. Current Focus

- SpecDrive의 토큰 사용량을 줄이기 위해 compact 문서 계층과 read scope 정책을 정리한다.
- 현재 rule layer 기준 경로는 `specdrive/rules/**`다.
- session 흐름은 compact 문서와 `specdrive/rules/session-policy.md`를 우선 읽도록 정리했다.
- plan 흐름은 `specdrive/rules/plan-policy.md`와 `specdrive/rules/skill-wizard-rule.md` 기준으로 정리했다.
- Git skill은 현재 repo-local skill 대상에서 제외한다.

---

## 3. Current Mode

- 문서 계층 경량화
- session read scope 축소
- plan action read scope 축소
- `$plan` top-down 실행 순서 정리
- `docs/AI_CONTEXT.md` full 읽기 최소화
- repo-local Codex skill-first 흐름 유지

---

## 4. Current Project

- specdrive 운영 정책 정리
- board는 실제 애플리케이션 프로젝트로 유지

---

## 5. Current Entry Point

`specdrive/rules/**` 정책과 repo-local skill 문서를 기준으로 session/plan skill의 읽기 범위와 출력 흐름을 줄인다.

---

## 6. Next Entry Point

1. `dev-policy.md` 생성 전까지 `core-collaboration-rules.md`의 `Spec-to-Anchor`는 유지한다.
2. 이후 `dev-policy.md`를 만들 때 plan/dev Anchor 책임을 분리한다.
3. 필요한 경우 `$dev` skill도 session/plan과 같은 방식으로 policy 연결과 read scope 축소를 진행한다.

---

## 7. Open Questions

- `dev-policy.md` 생성 시점 결정 필요
- `doc-work-policy.md`, `bundle-policy.md` 생성 여부는 반복 검증 뒤 결정
- `Spec-to-Anchor` 상세 규칙은 dev policy 생성 후 core에서는 Traceability 원칙으로 축소할지 검토

---

## 8. Read Scope Hint

기본은 다음만 읽는다.

1. `docs/AI_CONTEXT.compact.md`
2. 현재 작업에 필요한 `specdrive/rules/**` policy
3. 현재 호출된 repo-local skill action 문서
4. 사용자가 명시한 대상 문서

`docs/history/**`, bundle 문서, full README/AGENTS/AI_CONTEXT, source code, version-control 정보는 명시 요청 또는 불명확한 승인 경계가 있을 때만 읽는다.
