# Work Roadmap

## 1. 문서 목적

이 문서는 board 프로젝트의 승인된 Phase / Cycle / Work Package / Task 구조를 관리한다.

`work-roadmap.md`는 후보 목록이 아니다.  
`work-candidates.md`에서 검토되어 `Accepted` 상태가 된 Candidate만 이 문서로 승격할 수 있다.

---

## 2. 현재 상태

- 현재 `work-candidates.md`에 작업 후보가 정리되어 있다.
- 아직 개발자 승인으로 `Accepted` 처리되어 Roadmap에 승격된 Work Package는 없다.
- 따라서 현재 `work-index.md`의 Current Work Package도 `Not Selected` 상태로 둔다.

---

## 3. Roadmap

현재 승인된 Roadmap 항목은 없다.

다음 단계에서 `$plan wp-split`, `$plan phase-split`, `$plan cycle-split` 결과를 검토한 뒤 승인된 항목만 이 문서에 반영한다.

Work Package를 승격할 때는 필요한 경우 다음 항목을 함께 확인한다.

- 선행 Work Package 또는 기준 문서
- 현재 Phase/Cycle 안에서의 우선순위
- 완료 기준
- 테스트 또는 수동 검증 기준

---

## 4. 승격 대기 후보

승격 대기 후보는 `work-candidates.md`를 기준으로 확인한다.

현재 우선 검토 대상:

- 게시판 CRUD 최소 흐름
- 최소 입력 검증과 오류 흐름
- 게시글 기본 데이터와 JPA persistence 연결
- 최소 API 검증 또는 테스트 흐름
- board 실행/검증 매뉴얼 초안

후속 검토 대상:

- 검색/정렬/페이징
- 사용자 인증/권한 연계
- 댓글/첨부파일/좋아요
