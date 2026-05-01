# Work Index

## 1. 문서 목적

이 문서는 board 프로젝트의 현재 작업 포인터를 관리한다.

`work-index.md`는 전체 작업 목록이나 문서 색인이 아니다.  
전체 작업 구조는 `work-roadmap.md`에서 관리하고, 이 문서는 현재 Codex와 개발자가 어디서부터 작업해야 하는지를 짧게 표시한다.

---

## 2. 현재 작업 요약

| 항목 | 내용 |
|---|---|
| Current Phase | Not Started |
| Current Cycle | Not Started |
| Current Work Package | Not Selected |
| Current Focus | `work-candidates.md` 후보 검토 후 roadmap 승격 필요 |
| Current Task | Not Selected |
| Current Status | Planning |
| Last Completed |  |
| Next Task | `$plan wp-split` 또는 `$plan phase-split` 초안 검토 |
| Blocker | `work-roadmap.md`에 승인된 Work Package가 아직 없음 |
| Updated At | 2026-05-01 |

---

## 3. 현재 판단

- board 프로젝트에는 `work-candidates.md` 후보가 준비되었지만, 아직 `work-roadmap.md`로 승격된 Work Package는 없다.
- `dev start`는 승인된 `work-roadmap.md`가 생긴 뒤 현재 Work Package를 선택할 때 사용한다.
- 현재 단계에서는 `work-index.md`에 Candidate를 직접 현재 작업으로 넣지 않는다.

---

## 4. 다음 진입점

1. `docs/projects/board/work/work-candidates.md` 후보 검토
2. 필요한 후보를 `Accepted` 또는 `Deferred`로 조정
3. `$plan wp-split`으로 Work Package 후보 분해
4. `$plan phase-split` / `$plan cycle-split`으로 roadmap 초안 작성
5. 개발자 승인 후 `work-roadmap.md` 반영
6. `$dev start`로 현재 Work Package 선택

---

## 5. 금지 사항

- Candidate를 바로 현재 Task로 지정하지 않는다.
- `work-roadmap.md`에 없는 Work Package를 현재 작업으로 지정하지 않는다.
- 현재 포인터 설정 없이 `dev run`으로 구현을 시작하지 않는다.
