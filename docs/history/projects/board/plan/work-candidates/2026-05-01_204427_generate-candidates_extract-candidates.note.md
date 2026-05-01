# Plan Extract Candidates Note

## 1. 변경 요약

`$plan extract-candidates apply` 승인에 따라 `docs/projects/board/work/work-candidates.md` 에 `CAND-013`부터 `CAND-018`까지의 작업 후보를 추가했다.

## 2. 판단 근거

- `specs/04-application-structure.md`, `specs/06-api-spec.md`, `specs/07-db-design.md` 에서 API DTO, Controller/Facade, Entity/Repository, DB/Flyway 관련 후보가 구체화되어 있었다.
- `specs/03-design.md`, `specs/04-application-structure.md`, `specs/06-api-spec.md` 에서 공통 예외와 오류 응답 구조가 후보 수준으로 남아 있었다.
- `specs/02-requirements.md`, `specs/05-domain-model.md`, `specs/07-db-design.md` 에서 삭제 방식이 아직 확정되지 않은 결정 후보로 남아 있었다.
- 테스트 데이터와 검증 시나리오는 구현 계획으로 넘겨야 할 후보로 확인되었다.

## 3. 유지한 경계

- 기존 `CAND-001`부터 `CAND-012`는 변경하지 않았다.
- `work-index.md`는 수정하지 않았다.
- Phase, Cycle, Work Package, Task는 확정하지 않았다.
- `CAND-014`, `CAND-016`, `CAND-018`은 기존 후보와 연결 또는 중복 가능성이 있음을 Notes에 남겼다.

## 4. 다음 판단 후보

- 추가된 후보를 기존 후보와 병합할지, 별도 후보로 유지할지 검토한다.
- 이후 필요하면 `$plan wp-split` 또는 `$plan phase-split` 으로 넘어간다.
