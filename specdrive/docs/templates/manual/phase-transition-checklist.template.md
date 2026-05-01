# Phase Transition Checklist

## 1. 문서 목적

이 문서는 현재 프로젝트에서 Phase 또는 Cycle을 전환하기 전에 확인해야 할 항목을 정리한다.

Phase 전환은 단순히 다음 작업으로 넘어가는 것이 아니다.  
현재 Phase의 목표, 구현, 문서, 테스트, 운영 재현 가능성이 충분히 정리되었는지 확인한 뒤 수행한다.

이 문서는 다음 상황에서 사용한다.

- Cycle 전환 전
- Phase 전환 전
- 현재 Work Package 완료 후 다음 범위로 이동하기 전
- Cycle 3 완료 후 운영 재현 가능성 확인 전
- `work-index.md`에서 `Cycle Transition Needed` 또는 `Phase Transition Needed`가 나온 경우

---

## 2. 기본 원칙

Phase / Cycle 전환은 다음 원칙을 따른다.

- 현재 Phase / Cycle의 목표가 충족되어야 한다.
- `work-roadmap.md`의 완료 기준과 검증 기준을 확인해야 한다.
- `work-index.md`의 현재 포인터가 정리되어야 한다.
- `work-log.md`에 sync 결과가 남아 있어야 한다.
- 관련 specs와 구현 또는 문서가 충돌하지 않아야 한다.
- 필요한 경우 `status/current-status.md`가 갱신되어야 한다.
- Cycle 3 산출물은 `manual/` 문서에 우선 정리되어야 한다.
- unresolved blocker가 있으면 전환하지 않는다.
- 사람 판단이 필요한 항목이 있으면 전환하지 않는다.

---

## 3. 전환 대상

| 항목 | 내용 |
|---|---|
| Transition Type | Cycle / Phase |
| From Phase |  |
| From Cycle |  |
| To Phase |  |
| To Cycle |  |
| Current Work Package |  |
| Transition Requested By | Developer / Codex / ChatGPT |
| Transition Date | YYYY-MM-DD |
| Related Work Index | `work/work-index.md` |
| Related Work Log | `work/work-log.md` |
| Related Roadmap | `work/work-roadmap.md` |

---

## 4. 현재 범위 완료 확인

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 현재 Phase 목표가 명확한가? |  |  |
| 현재 Cycle 목표가 명확한가? |  |  |
| 현재 Work Package가 완료되었는가? |  |  |
| 현재 Task가 완료되었는가? |  |  |
| `work-roadmap.md`의 완료 기준을 만족했는가? |  |  |
| `work-roadmap.md`의 검증 기준을 만족했는가? |  |  |
| `work-index.md`의 Current Status가 정리되었는가? |  |  |
| `work-log.md`에 sync 결과가 기록되었는가? |  |  |
| 남은 작업이 다음 Cycle 또는 Phase로 명확히 분리되었는가? |  |  |

결과 기준:

- `Yes`: 충족
- `No`: 미충족
- `N/A`: 해당 없음
- `Needs Decision`: 사람 판단 필요

---

## 5. 문서 정합성 확인

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| `01-overview.md`와 충돌하지 않는가? |  |  |
| `specs/*.md`와 충돌하지 않는가? |  |  |
| `work-policy.md`와 충돌하지 않는가? |  |  |
| `work-roadmap.md`와 현재 상태가 일치하는가? |  |  |
| `work-index.md`의 현재 포인터가 최신인가? |  |  |
| `work-log.md`의 최근 결과가 최신인가? |  |  |
| `work-candidates.md`에 새 후보가 반영되었는가? |  |  |
| `rules/affected-docs-rules.md` 기준 영향 문서 점검이 필요한가? |  |  |
| 필요한 영향 문서가 갱신되었는가? |  |  |

---

## 6. 구현 / 산출물 확인

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 현재 범위의 구현 또는 문서 산출물이 존재하는가? |  |  |
| 현재 범위 밖 작업이 섞이지 않았는가? |  |  |
| 임시 구현 또는 임시 문서가 남아 있지 않은가? |  |  |
| TODO / FIXME / 보류 항목이 정리되었는가? |  |  |
| 후속 후보는 `work-candidates.md` 또는 Deferred 항목으로 분리되었는가? |  |  |
| 삭제 또는 제외된 항목의 이유가 기록되었는가? |  |  |

---

## 7. 테스트 / 검증 확인

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 현재 범위의 최소 검증이 완료되었는가? |  |  |
| 관련 테스트가 통과했는가? |  |  |
| 실패한 테스트가 있다면 사유가 기록되었는가? |  |  |
| 수동 검증이 필요한 경우 절차가 기록되었는가? |  |  |
| 검증하지 못한 항목이 있다면 이유가 기록되었는가? |  |  |
| 검증 결과가 `work-log.md` 또는 관련 문서에 남아 있는가? |  |  |

---

## 8. Cycle 3 / Manual 확인

Cycle 3 또는 Phase 완료 전에는 실행자 관점의 manual 문서를 우선 확인한다.

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 실행 방법이 `manual/` 문서에 정리되었는가? |  |  |
| 설정 절차가 `manual/` 문서에 정리되었는가? |  |  |
| 테스트 / 검증 절차가 `manual/` 문서에 정리되었는가? |  |  |
| 로그 확인 방법이 정리되었는가? |  |  |
| 복구 절차가 정리되었는가? |  |  |
| 롤백 절차가 필요한 경우 정리되었는가? |  |  |
| 운영 재현 절차가 정리되었는가? |  |  |
| 알려진 제한 사항이 정리되었는가? |  |  |
| `manual/phases/phase-XX-manual.md`가 갱신되었는가? |  |  |

원칙:

~~~text
Cycle 3 산출물은 status 문서보다 manual 문서에 우선 정리한다.
~~~

---

## 9. Status / History 확인

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| `status/current-status.md` 갱신이 필요한가? |  |  |
| 필요한 경우 `status/current-status.md`가 갱신되었는가? |  |  |
| history 저장이 필요한 변경인가? |  |  |
| 필요한 경우 history가 저장되었는가? |  |  |
| history 저장 사유가 명확한가? |  |  |
| 다음 세션 진입점이 정리되었는가? |  |  |

---

## 10. Blocker / Decision 확인

전환 전에 blocker와 사람 판단 필요 항목을 확인한다.

| ID | Type | 내용 | 영향 | Required Decision | Status | 전환 가능 여부 |
|---|---|---|---|---|---|---|
| DEC-001 | Decision |  |  |  | Open | No |

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

전환 기준:

- `Open` 상태의 Blocker가 있으면 전환하지 않는다.
- `Open` 상태의 Decision이 있으면 전환하지 않는다.
- Deferred 항목은 후속 처리 위치가 명확해야 한다.

---

## 11. 전환 판단

| 판단 항목 | 결과 |
|---|---|
| 현재 Cycle 전환 가능 여부 | Yes / No / Needs Decision |
| 현재 Phase 전환 가능 여부 | Yes / No / Needs Decision |
| 다음 Cycle |  |
| 다음 Phase |  |
| 전환 조건 |  |
| 전환 보류 사유 |  |
| 다음 작업 진입점 |  |

---

## 12. 전환 후 갱신 대상

전환이 승인되면 다음 문서 갱신 여부를 확인한다.

| 문서 | 갱신 필요 여부 | 갱신 내용 |
|---|---|---|
| `work-roadmap.md` |  | Phase / Cycle / Work Package 상태 변경 |
| `work-index.md` |  | Current Phase / Cycle / Work Package / Focus 변경 |
| `work-log.md` |  | 전환 결과 기록 |
| `status/current-status.md` |  | 현재 상태 요약 변경 |
| `manual/` |  | 실행/운영 문서 보강 |
| `work-candidates.md` |  | 후속 후보 정리 |
| `rules/affected-docs-rules.md` |  | 영향 문서 점검 |
| `history` |  | 전환 이력 저장 |

---

## 13. 전환 기록

| 항목 | 내용 |
|---|---|
| Transition Date | YYYY-MM-DD |
| Transition Type | Cycle / Phase |
| From |  |
| To |  |
| Decision | Approved / Rejected / Deferred / Needs Decision |
| Reason |  |
| Approved By | Developer |
| History Ref |  |

---

## 14. Codex 사용 기준

Codex는 이 체크리스트를 기준으로 전환 가능 여부를 제안할 수 있다.

Codex는 다음을 수행할 수 있다.

- 현재 Cycle 전환 가능 여부 제안
- 현재 Phase 전환 가능 여부 제안
- 미충족 항목 목록화
- `work-index.md` 갱신 제안
- `work-log.md` 갱신 제안
- `status/current-status.md` 갱신 제안
- `manual/` 갱신 필요 여부 제안
- history 저장 필요 여부 제안
- 다음 작업 진입점 제안

Codex는 다음을 수행하지 않는다.

- 사람 승인 없이 Phase 전환을 확정하지 않는다.
- Open Blocker가 있는데 전환 완료 처리하지 않는다.
- Open Decision이 있는데 전환 완료 처리하지 않는다.
- 검증 기준을 확인하지 않고 완료 처리하지 않는다.
- Cycle 3 산출물을 manual 문서 없이 완료 처리하지 않는다.
- specs와 충돌하는 상태를 무시하고 전환하지 않는다.

---

## 15. 금지 사항

다음을 금지한다.

- 완료 기준 없이 Cycle 또는 Phase를 전환하는 것
- 검증 기준 없이 Cycle 또는 Phase를 전환하는 것
- `work-log.md` sync 결과 없이 전환하는 것
- `work-index.md` 현재 포인터 정리 없이 전환하는 것
- Open Blocker를 무시하고 전환하는 것
- Open Decision을 무시하고 전환하는 것
- Cycle 3 산출물을 manual에 남기지 않고 Phase를 완료하는 것
- status 문서만 갱신하고 manual 문서를 생략하는 것
- specs와 충돌하는 상태를 남긴 채 전환하는 것
- 후속 후보를 정리하지 않고 전환하는 것