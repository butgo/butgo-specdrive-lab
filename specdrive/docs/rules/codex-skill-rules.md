# Codex Skill Rules

## 1. 문서 목적

이 문서는 `specdrive/codex-skills/**` 아래 배포/패키징 후보 Codex skill 원본의 운영 규칙을 정의한다.

현재 검증은 `.agents/skills/**` 사용본을 기준으로 하고, 안정화된 흐름만 `specdrive/codex-skills/**` 원본에 반영한다.

---

## 2. 기본 원칙

- `specdrive/codex-skills/**` 는 배포 가능한 원본 후보로 관리한다.
- 원본은 특정 로컬 세션 상태에 과하게 의존하지 않아야 한다.
- 원본에는 반복 가능한 action 구조와 경계 규칙을 남긴다.
- repo-local 사용본에서 검증되지 않은 흐름은 원본에 확정 규칙처럼 반영하지 않는다.
- 원본과 사용본이 다를 경우 그 차이가 실험인지 누락인지 확인한다.

---

## 3. 동기화 기준

다음 변경은 사용본과 원본 동기화를 함께 검토한다.

- action 목록 변경
- invocation rule 변경
- output 형식 변경
- stop point 변경
- 읽기/쓰기 경계 변경
- 개발자 승인 조건 변경

---

## 4. 금지 사항

- 검증 전 실험 흐름을 배포 후보 원본에 확정 규칙처럼 쓰지 않는다.
- 프로젝트별 판단을 Core skill 원본에 직접 고정하지 않는다.
- skill 원본이 repo-local 사용본의 현재 실험 상태를 숨기지 않는다.

