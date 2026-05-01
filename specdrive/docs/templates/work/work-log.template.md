# Work Log

## 1. 문서 목적

이 문서는 이 프로젝트의 최근 작업 실행 결과와 sync 판단을 기록한다.

`work-log.md`는 상세 history 저장소가 아니다.  
상세 변경 이력은 기존 history 관리 방식을 따르고, 이 문서는 Work System 관점에서 다음을 요약한다.

- 어떤 Work Package 또는 Task를 수행했는가
- 어떤 결과가 나왔는가
- 현재 작업이 완료되었는가
- 다음 작업으로 넘어갈 수 있는가
- `work-index.md` 갱신이 필요한가
- `status/current-status.md` 갱신이 필요한가
- `manual/` 갱신이 필요한가
- `rules/affected-docs-rules.md` 점검이 필요한가

~~~text
work-index.md
  ↓ run

Codex / Developer execution
  ↓ sync

work-log.md
  ↓ 필요 시

work-index.md
status/current-status.md
manual/
rules/affected-docs-rules.md
history
~~~

---

## 2. 기본 원칙

이 문서는 다음 원칙을 따른다.

- 최근 작업 결과와 sync 판단을 중심으로 기록한다.
- 전체 작업 목록을 반복하지 않는다.
- 상세 변경 이력을 길게 누적하지 않는다.
- 상세 history는 기존 history 관리 방식을 따른다.
- 현재 작업 포인터는 `work-index.md`에서 관리한다.
- 전체 작업 구조는 `work-roadmap.md`에서 관리한다.
- 후보 작업은 `work-candidates.md`에서 관리한다.
- 의미 있는 작업 단위가 끝났을 때 기록한다.
- 작업 후 다음 액션이 불명확하면 `Needs Human Decision`으로 남긴다.

---

## 3. 최근 작업 요약

| 항목 | 내용 |
|---|---|
| Last Work Date | YYYY-MM-DD |
| Last Actor | Developer / Codex / ChatGPT |
| Last Phase |  |
| Last Cycle |  |
| Last Work Package |  |
| Last Task |  |
| Result |  |
| Sync Result |  |
| Next Action |  |
| Updated At | YYYY-MM-DD |

작성 기준:

- `Last Actor`에는 작업 주체를 적는다.
- `Result`에는 작업 결과를 짧게 적는다.
- `Sync Result`에는 7장의 sync 결과 중 하나를 적는다.
- `Next Action`에는 다음 실행 진입점을 적는다.

---

## 4. Work Log 목록

| Date | Actor | Phase | Cycle | Work Package | Task | Result | Sync Result | Next Action |
|---|---|---|---|---|---|---|---|---|
| YYYY-MM-DD |  |  |  |  |  |  |  |  |

작성 기준:

- 최근 기록이 위로 오도록 작성한다.
- 너무 오래된 상세 기록은 history로 넘기고 이 문서에는 요약만 유지한다.
- Work Package 또는 Task 단위의 의미 있는 결과만 기록한다.
- 단순 오탈자 수정이나 미세 변경은 반드시 기록하지 않아도 된다.

---

## 5. Log 상세

필요한 경우 주요 작업 결과만 상세로 남긴다.

### LOG-YYYYMMDD-001. {{work-summary}}

| 항목 | 내용 |
|---|---|
| Date | YYYY-MM-DD |
| Actor | Developer / Codex / ChatGPT |
| Phase |  |
| Cycle |  |
| Work Package |  |
| Task |  |
| Related Docs |  |
| Related Files |  |
| Result |  |
| Sync Result |  |
| History Ref |  |

#### 작업 내용

<!-- 수행한 작업을 짧게 요약한다. -->

#### 변경 결과

<!-- 변경된 문서, 코드, 설정, 테스트 결과를 요약한다. -->

#### 확인한 기준

<!-- work-policy, work-roadmap, specs 등 확인한 기준을 적는다. -->

#### 남은 이슈

<!-- 남은 이슈, 보류 항목, 사람 판단이 필요한 항목을 적는다. -->

#### 다음 액션

<!-- 다음 작업 진입점을 적는다. -->

---

## 6. Sync 점검

작업 후 다음 항목을 확인한다.

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 현재 Task가 완료되었는가? |  |  |
| 현재 Work Package가 완료되었는가? |  |  |
| Roadmap 완료 기준을 만족했는가? |  |  |
| Roadmap 검증 기준을 만족했는가? |  |  |
| 현재 Scope 안에서만 작업했는가? |  |  |
| 관련 specs와 충돌하지 않는가? |  |  |
| 새 Candidate가 발견되었는가? |  |  |
| Blocker가 생겼는가? |  |  |
| 사람 판단이 필요한가? |  |  |
| 다음 Task로 이동 가능한가? |  |  |
| 다음 Work Package로 이동 가능한가? |  |  |
| Cycle 전환이 필요한가? |  |  |
| Phase 전환이 필요한가? |  |  |

---

## 7. Sync Result 기준

작업 후 sync 결과는 다음 중 하나로 정리한다.

| Sync Result | 의미 | 다음 처리 |
|---|---|---|
| Continue Current Task | 현재 Task 계속 진행 | `work-index.md` 유지 또는 보완 |
| Move To Next Task | 다음 Task로 이동 가능 | `work-index.md`의 Current Task / Next Task 갱신 |
| Complete Work Package | 현재 Work Package 완료 | `work-index.md`의 Last Completed 갱신 |
| Move To Next Work Package | 다음 Work Package로 이동 | `work-index.md`의 Current Scope 갱신 |
| Cycle Transition Needed | Cycle 전환 필요 | 전환 체크 후 roadmap/index 갱신 |
| Phase Transition Needed | Phase 전환 필요 | Phase 전환 체크 후 roadmap/index 갱신 |
| Blocked | 진행 불가 | `work-index.md`의 Blocker / Decision Needed 갱신 |
| Needs Human Decision | 사람 판단 필요 | 결정 항목 기록 후 작업 보류 |
| Candidate Update Needed | 새 후보 반영 필요 | `work-candidates.md` 갱신 제안 |
| Manual Update Needed | 실행/검증/복구 절차 반영 필요 | `manual/` 갱신 제안 |
| Status Update Needed | 현재 상태 요약 반영 필요 | `status/current-status.md` 갱신 제안 |
| Rules Check Needed | 변경 전파 점검 필요 | `rules/affected-docs-rules.md` 기준 점검 |

---

## 8. 문서 갱신 판단

작업 후 다음 문서 갱신 여부를 판단한다.

| 문서 | 갱신 필요 여부 | 판단 기준 | 비고 |
|---|---|---|---|
| `work-candidates.md` |  | 새 후보, 후보 상태 변경, 후보 승격/보류/제외 |  |
| `work-roadmap.md` |  | 확정 작업 구조, 상태, 완료/검증 기준 변경 |  |
| `work-index.md` |  | 현재 포인터, 다음 Task, Blocker, Sync 상태 변경 |  |
| `status/current-status.md` |  | 사람이 보는 현재 상태 요약 변경 |  |
| `manual/` |  | 실행, 설정, 테스트, 복구, 운영 재현 절차 영향 |  |
| `rules/affected-docs-rules.md` |  | 문서 변경 전파 점검 필요 |  |
| `history` |  | 기존 history 저장 기준에 해당 |  |

---

## 9. Candidate 발견 기록

작업 중 새 후보가 발견되면 바로 구현하지 않고 아래에 기록한다.  
이후 `work-candidates.md`에 반영할지 판단한다.

| ID | Candidate | 발견 위치 | Reason | Suggested Status | Note |
|---|---|---|---|---|---|
| NEW-CAND-001 |  |  |  | Proposed |  |

원칙:

- 새 후보는 현재 작업에 즉시 끼워 넣지 않는다.
- 현재 Scope 밖 후보는 `work-candidates.md`로 이동한다.
- 현재 specs와 충돌하는 후보는 Accepted로 처리하지 않는다.
- 새 후보가 현재 작업 완료를 막는 경우 `Needs Human Decision`으로 남긴다.

---

## 10. Blocker / Decision Log

작업 중 발생한 blocker 또는 사람 판단 필요 항목을 기록한다.

| ID | Type | 내용 | 영향 | 필요한 결정 | Status | Follow-up |
|---|---|---|---|---|---|---|
| DEC-001 | Decision |  |  |  | Open |  |

Type 예시:

| Type | 의미 |
|---|---|
| Decision | 사람의 결정 필요 |
| Blocker | 진행 불가 이슈 |
| Clarification | 요구사항 확인 필요 |
| Dependency | 선행 작업 필요 |
| Risk | 위험 요소 |

Status 예시:

| Status | 의미 |
|---|---|
| Open | 미해결 |
| Resolved | 해결 |
| Deferred | 후속 보류 |
| Cancelled | 취소 |

---

## 11. History 연계

`work-log.md`는 상세 history를 대체하지 않는다.

history 저장이 필요한 경우 다음 정보를 남긴다.

| 항목 | 내용 |
|---|---|
| History Needed | Yes / No |
| History Target |  |
| History Reason |  |
| Suggested History Name |  |

예시:

~~~text
History Needed: Yes
History Target: work-system
History Reason: Work System template set finalized
Suggested History Name: 2026-MM-DD_WORK_SYSTEM_template-set-finalized.md
~~~

---

## 12. Log 정리 기준

`work-log.md`가 너무 길어지면 다음 기준으로 정리한다.

- 최근 작업 요약은 유지한다.
- 오래된 상세 내용은 history에 저장한다.
- 완료된 오래된 Log 상세는 요약만 남긴다.
- Blocker / Decision 항목은 해결 여부를 남긴 뒤 정리한다.
- Candidate 발견 기록은 `work-candidates.md` 반영 후 정리한다.
- `work-log.md`는 현재 작업 흐름을 방해할 정도로 길게 유지하지 않는다.

---

## 13. Codex 사용 기준

Codex는 작업 후 sync 단계에서 이 문서의 갱신안을 제안할 수 있다.

Codex는 다음을 수행할 수 있다.

- 작업 결과 요약 작성
- Sync Result 제안
- 다음 Task 제안
- Work Package 완료 여부 제안
- `work-index.md` 갱신 필요 여부 제안
- `status/current-status.md` 갱신 필요 여부 제안
- `manual/` 갱신 필요 여부 제안
- 새 Candidate 발견 기록 제안
- Blocker / Decision 항목 제안
- history 저장 필요 여부 제안

Codex는 다음을 수행하지 않는다.

- 상세 history를 이 문서에 길게 누적하지 않는다.
- 전체 Roadmap을 이 문서에 반복하지 않는다.
- Candidate를 바로 현재 Task로 확정하지 않는다.
- 사람 결정이 필요한 항목을 임의로 완료 처리하지 않는다.
- Blocker가 있는 작업을 완료 처리하지 않는다.
- 검증 기준을 확인하지 않고 Work Package 완료를 선언하지 않는다.
- Cycle 3 산출물을 manual 갱신 없이 완료 처리하지 않는다.

---

## 14. 금지 사항

다음을 금지한다.

- `work-log.md`를 상세 history 저장소처럼 사용하는 것
- 전체 Roadmap을 이 문서에 복사하는 것
- `work-index.md`의 현재 포인터를 이 문서에서 중복 관리하는 것
- Candidate를 바로 현재 작업으로 확정하는 것
- 새 후보를 현재 Scope에 임의로 끼워 넣는 것
- 검증 기준 없이 Work Package를 완료 처리하는 것
- Blocker 또는 Decision Needed 상태를 무시하고 다음 작업으로 넘어가는 것
- Cycle 3 산출물을 manual 갱신 없이 완료 처리하는 것
- history 저장이 필요한 변경을 work-log에만 남기고 끝내는 것
