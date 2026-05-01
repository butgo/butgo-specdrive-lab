# Work Policy

## 1. 문서 목적

이 문서는 board 프로젝트 dev 작업을 진행할 때 적용할 작업 운영 기준을 정리한다.

`work-policy.md`는 작업 후보 목록이나 현재 작업 포인터가 아니다.  
후보 검토, Roadmap 승격, dev 실행 범위를 제한하는 기준 문서다.

---

## 2. 기본 원칙

- 확정된 `01-overview.md`와 `specs/**` 문서를 기준으로 작업한다.
- Candidate, Work Package, Task, Current Pointer를 구분한다.
- Candidate는 바로 Task가 아니다.
- `Accepted` 상태가 된 Candidate만 `work-roadmap.md`로 승격할 수 있다.
- `work-index.md`에는 `work-roadmap.md`에 있는 Work Package만 현재 포인터로 지정한다.
- 현재 board 범위는 게시글 CRUD 최소 흐름을 우선한다.
- 검색, 댓글, 첨부파일, 인증/권한 연계, 독립 배포 구조는 현재 Phase에 선반영하지 않는다.

---

## 3. Candidate 처리 기준

Candidate 상태는 다음을 기본으로 사용한다.

| Status | 의미 | 처리 기준 |
|---|---|---|
| Proposed | 후보로 제안됨 | 아직 승격 여부가 결정되지 않음 |
| Accepted | roadmap 승격 대상 | `work-roadmap.md`로 승격 가능 |
| Deferred | 후속 검토 | 현재 Phase/Cycle에서는 제외 |
| Rejected | 제외 | 현재 범위 또는 specs와 맞지 않음 |
| Merged | 병합됨 | 다른 Candidate 또는 Roadmap 항목에 병합 |
| Needs Clarification | 추가 확인 필요 | 요구사항, 범위, 완료 기준이 불명확 |

---

## 4. Roadmap 승격 기준

Candidate는 다음 조건을 만족할 때만 `Accepted`로 조정하고 `work-roadmap.md` 승격 후보로 본다.

- board 현재 목표와 맞는다.
- 관련 기준 문서가 존재한다.
- Work Package 또는 Task로 구체화할 수 있다.
- 완료 기준과 검증 기준을 만들 수 있다.
- 현재 CRUD 최소 흐름 범위를 과도하게 흔들지 않는다.
- `specs/**` 문서와 충돌하지 않는다.

---

## 5. Dev 실행 기준

`dev` 단계는 승인된 `work-roadmap.md`와 현재 `work-index.md`를 기준으로 실행한다.

- `dev start`는 현재 Work Package를 선택하고 `work-index.md` 설정 초안을 만든다.
- `dev run`은 현재 Work Package 안에서만 코딩한다.
- `dev test`는 현재 Work Package 기준으로 검증한다.
- `dev sync`는 결과를 `work-log.md`, `status/`, `manual/` 반영 후보로 정리한다.
- 다음 Work Package 이동은 개발자 확인 후 진행한다.

---

## 6. 금지 사항

- Candidate를 바로 구현하지 않는다.
- `work-roadmap.md`에 없는 Work Package를 현재 포인터로 지정하지 않는다.
- `work-index.md` 없이 현재 작업을 추측하지 않는다.
- 현재 Cycle 범위를 넘어 미래 확장을 선반영하지 않는다.
- Git commit, push, PR 생성은 `dev` 단계에서 처리하지 않는다.
- `docs/history/**`는 명시 요청 없이 기본 조회하지 않는다.
