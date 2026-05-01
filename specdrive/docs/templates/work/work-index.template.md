# Work Index

## 1. 문서 목적

이 문서는 이 프로젝트의 현재 작업 포인터를 관리한다.

`work-index.md`는 전체 작업 목록 문서가 아니다.  
전체 작업 구조는 `work-roadmap.md`에서 관리하고, 이 문서는 현재 Codex와 개발자가 어디서부터 작업해야 하는지를 짧게 표시한다.

~~~text
work-roadmap.md
  ↓ select current scope

work-index.md
  ↓ run

Codex / Developer execution
  ↓ sync

work-index.md / work-log.md
~~~

---

## 2. 기본 원칙

이 문서는 다음 원칙을 따른다.

- 현재 작업 위치만 관리한다.
- 전체 Roadmap을 반복하지 않는다.
- 현재 Phase / Cycle / Work Package / Focus를 명확히 표시한다.
- Codex는 이 문서를 기준으로 현재 작업을 판단한다.
- 현재 Work Package 범위를 임의로 넘지 않는다.
- 현재 Cycle 범위를 임의로 넘지 않는다.
- 작업 후 sync 결과에 따라 이 문서를 갱신한다.
- 상세 작업 이력은 `work-log.md` 또는 기존 history 관리 방식을 따른다.

---

## 3. 현재 작업 요약

| 항목 | 내용 |
|---|---|
| Current Phase |  |
| Current Cycle |  |
| Current Work Package |  |
| Current Focus |  |
| Current Task |  |
| Current Status |  |
| Last Completed |  |
| Next Task |  |
| Blocker |  |
| Updated At | YYYY-MM-DD |

작성 기준:

- `Current Phase`는 `work-roadmap.md`의 Phase와 일치해야 한다.
- `Current Cycle`은 `work-roadmap.md`의 Cycle과 일치해야 한다.
- `Current Work Package`는 `work-roadmap.md`의 Work Package ID와 이름을 적는다.
- `Current Focus`는 Codex가 지금 집중해야 할 작업 범위를 짧게 적는다.
- `Current Task`는 현재 실행 중인 Task ID를 적는다.
- `Current Status`는 `Not Started`, `In Progress`, `Blocked`, `Sync Needed`, `Done` 중 하나를 사용한다.
- `Last Completed`는 최근 완료된 Work Package 또는 Task를 적는다.
- `Next Task`는 다음에 실행할 Task를 적는다.
- `Blocker`는 현재 진행을 막는 이슈가 있을 때만 적는다.

---

## 4. 현재 작업 상세

### 4.1 Current Scope

| 항목 | 내용 |
|---|---|
| Phase |  |
| Cycle |  |
| Work Package |  |
| Task |  |
| Related Specs |  |
| Related Docs |  |

---

### 4.2 Current Focus

<!-- Codex 또는 개발자가 현재 집중해야 할 작업을 짧게 작성한다. -->

예시:

~~~text
현재 작업은 Phase 1 / Cycle 1의 게시글 생성 최소 구현이다.
Controller, Service, Repository, Entity 흐름이 최소 동작하도록 구현한다.
테스트와 운영 문서는 후속 Cycle에서 다룬다.
~~~

---

### 4.3 Scope Boundary

이번 작업에서 포함하는 것과 포함하지 않는 것을 명확히 적는다.

#### Include

- 

#### Exclude

- 

원칙:

- Include는 현재 Work Package 안에서 수행할 작업만 적는다.
- Exclude는 다음 Cycle 또는 후속 Phase로 넘길 항목을 적는다.
- Exclude 항목을 임의로 구현하지 않는다.

---

## 5. 실행 기준

Codex 또는 개발자는 작업 전 다음 문서를 확인한다.

~~~text
1. AGENTS.compact.md
2. work/README.md
3. work/work-policy.md
4. work/work-index.md
5. work/work-roadmap.md
6. 현재 작업에 필요한 specs 문서
~~~

현재 작업 중에는 다음 원칙을 따른다.

- `work-index.md`의 Current Scope를 기준으로 작업한다.
- `work-roadmap.md`의 해당 Work Package 완료 기준을 확인한다.
- 현재 Work Package 밖의 작업은 수행하지 않는다.
- 현재 Cycle 밖의 작업은 수행하지 않는다.
- specs와 충돌하는 구조 변경은 하지 않는다.
- 작업 중 새 후보가 발견되면 바로 구현하지 않고 `work-candidates.md`에 추가 대상으로 남긴다.
- 작업 완료 후 sync 판단을 남긴다.

---

## 6. 현재 Work Package 완료 기준

| 확인 항목 | 기준 | 결과 | 비고 |
|---|---|---|---|
| Roadmap 완료 기준을 만족했는가? | `work-roadmap.md` 기준 |  |  |
| Roadmap 검증 기준을 만족했는가? | `work-roadmap.md` 기준 |  |  |
| 현재 Scope 안에서만 작업했는가? | Include / Exclude 기준 |  |  |
| 관련 specs와 충돌하지 않는가? | specs 기준 |  |  |
| 새 후보가 생겼는가? | 있으면 `work-candidates.md` 반영 필요 |  |  |
| `work-log.md` 기록이 필요한가? | 의미 있는 작업 결과 여부 |  |  |
| `status/current-status.md` 갱신이 필요한가? | 상태 요약 변경 여부 |  |  |
| `manual/` 갱신이 필요한가? | 실행/검증/복구 절차 영향 여부 |  |  |
| `rules/affected-docs-rules.md` 점검이 필요한가? | 문서 변경 전파 여부 |  |  |

---

## 7. Sync 판단

작업 후 다음 중 하나로 판단한다.

| Sync Result | 의미 | 다음 처리 |
|---|---|---|
| Continue Current Task | 현재 Task 계속 진행 | `Current Status` 유지 |
| Move To Next Task | 다음 Task로 이동 가능 | `Current Task`, `Next Task` 갱신 |
| Complete Work Package | 현재 Work Package 완료 | `Last Completed` 갱신, 다음 WP 검토 |
| Move To Next Work Package | 다음 Work Package로 이동 | Current Scope 갱신 |
| Cycle Transition Needed | Cycle 전환 필요 | 전환 체크 후 roadmap/index 갱신 |
| Phase Transition Needed | Phase 전환 필요 | Phase 전환 체크 후 roadmap/index 갱신 |
| Blocked | 진행 불가 | Blocker 기록 |
| Needs Human Decision | 사람 판단 필요 | 확인 사항 기록 |

---

## 8. 다음 작업 후보

`work-index.md`에는 전체 작업 목록을 반복하지 않는다.  
다만 현재 작업 직후의 다음 진입점은 짧게 표시할 수 있다.

| 순서 | Next Candidate | Source | Condition | Note |
|---|---|---|---|---|
| 1 |  | `work-roadmap.md` |  |  |
| 2 |  | `work-roadmap.md` |  |  |

작성 기준:

- 다음 후보는 1~3개 정도만 유지한다.
- 전체 Roadmap을 복사하지 않는다.
- 후보가 불확실하면 `Needs Human Decision`으로 남긴다.

---

## 9. Blocker / Decision Needed

현재 작업 진행을 막는 이슈나 사람 판단이 필요한 항목을 정리한다.

| ID | Type | 내용 | 영향 | 필요한 결정 | Status |
|---|---|---|---|---|---|
| DEC-001 | Decision |  |  |  | Open |

Type 예시:

| Type | 의미 |
|---|---|
| Decision | 사람의 결정 필요 |
| Blocker | 진행 불가 이슈 |
| Clarification | 요구사항 확인 필요 |
| Dependency | 선행 작업 필요 |
| Risk | 위험 요소 |

---

## 10. 최근 완료 항목

최근 완료된 Work Package 또는 Task만 간단히 기록한다.

| Date | Completed Item | Result | Follow-up |
|---|---|---|---|
| YYYY-MM-DD |  |  |  |

상세 이력은 `work-log.md` 또는 기존 history 관리 방식을 따른다.

---

## 11. Index 갱신 기준

`work-index.md`는 다음 경우에 갱신한다.

- 현재 Phase가 바뀌었을 때
- 현재 Cycle이 바뀌었을 때
- 현재 Work Package가 바뀌었을 때
- Current Focus가 바뀌었을 때
- Current Task가 바뀌었을 때
- 다음 Task가 확정되었을 때
- Work Package가 완료되었을 때
- Blocker가 생겼거나 해소되었을 때
- 사람 판단이 필요한 항목이 생겼을 때
- Cycle 또는 Phase 전환 판단이 필요할 때

---

## 12. Codex 사용 기준

Codex는 `work-index.md`를 현재 작업 포인터로 사용한다.

Codex는 다음을 수행할 수 있다.

- Current Scope 기준 작업 수행
- 현재 Task 완료 여부 판단
- 다음 Task 제안
- Work Package 완료 여부 제안
- `work-log.md` 갱신 필요 여부 제안
- `status/current-status.md` 갱신 필요 여부 제안
- `manual/` 갱신 필요 여부 제안
- 새 Candidate 발견 시 `work-candidates.md` 반영 제안

Codex는 다음을 수행하지 않는다.

- `work-index.md` 없이 현재 작업을 추측하지 않는다.
- 전체 Roadmap을 `work-index.md`에 복사하지 않는다.
- Candidate를 바로 현재 Task로 넣지 않는다.
- 현재 Work Package 밖 작업을 임의로 수행하지 않는다.
- 현재 Cycle 밖 작업을 임의로 수행하지 않는다.
- Phase 전환을 임의로 완료 처리하지 않는다.
- specs와 충돌하는 구조 변경을 하지 않는다.

---

## 13. 금지 사항

다음을 금지한다.

- 전체 Roadmap을 이 문서에 반복하는 것
- `work-candidates.md`의 Candidate를 직접 Current Task로 지정하는 것
- `Accepted`되지 않은 Candidate를 현재 작업으로 지정하는 것
- 현재 Work Package 범위를 넘는 작업을 Current Focus에 넣는 것
- 현재 Cycle 범위를 넘는 작업을 Current Focus에 넣는 것
- Blocker가 있는데 완료 처리하는 것
- 검증 기준을 확인하지 않고 Work Package를 완료 처리하는 것
- Cycle 3 산출물을 manual 갱신 없이 완료 처리하는 것
- 상세 history를 이 문서에 길게 누적하는 것