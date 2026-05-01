# specdrive/docs/flows/doc-confirm-flow.md

## 1. 문서 목적

이 문서는 specdrive의 `doc confirm-prompt` 흐름을  
**현재 기준 최소 confirm 시나리오**로 정리하는 문서다.

목적은 다음과 같다.

- `doc confirm-prompt` 가 어떤 입력으로 시작되는지 정리한다.
- reinforce 결과와 confirm 단계의 관계를 고정한다.
- 사람이 어디서 최종 판단하는지 분명히 한다.
- 첫 테스트 문서를 기준으로 최소 confirm 흐름을 만든다.

현재 이 문서는  
`docs/projects/board/01-overview.md` 를 첫 테스트 대상 문서로 사용한다.

---

## 2. 현재 테스트 대상 문서

현재 `doc confirm-prompt` 흐름의 첫 테스트 대상 문서는 다음과 같다.

- 대상 문서: `docs/projects/board/01-overview.md`

---

## 3. `doc confirm-prompt`가 하는 일

현재 기준에서 `doc confirm-prompt` 는 다음 역할을 가진다.

- reinforce 결과 또는 현재 문서 초안을 검토 대상으로 올린다.
- 사람이 현재 문서를 기준 문서로 받아들일 수 있는지 확인하게 한다.
- 현재 범위, 문서 역할, 후속 후보 혼합 여부를 점검하게 한다.
- 실제 반영 가능한 상태인지 판단하도록 돕는다.

즉 `doc confirm-prompt` 는  
**보강안을 실제 문서에 반영하기 전에 범위, 역할, 정합성, 반영 가능 여부를 검토하는 단계**다.

---

## 4. 현재 기준 실행 흐름

현재 기준의 최소 실행 흐름은 아래와 같다.

1. 사용자가 `doc confirm-prompt` 를 시작한다.
2. CLI가 대상 문서를 `docs/projects/board/01-overview.md` 로 인식한다.
3. 현재 스크립트는 fallback target 규칙을 읽는다.
4. `specdrive/config/target-registry.json` 에서 대상 문서와 `context_set_key` 를 읽는다.
5. `specdrive/config/doc-action-registry.json` 에서 `skill_key`, `output_mode`, review output directory 를 읽는다.
6. `specdrive/config/skill-registry.json`, `context-set-registry.json` 에서 실제 skill 경로와 context 문서 묶음을 해석한다.
7. `specdrive/config/output-policy.json` 에서 출력 정책을 읽는다.
8. `specdrive/scripts/doc/**` 가 confirm prompt 생성 흐름을 조합한다.
9. 필요한 경우 최근 reinforce preview 를 함께 검토 대상으로 가져온다.
10. 결과는 confirm 체크리스트 또는 review 요약 형태로 사용자에게 돌아온다.
11. 사용자가 최종 판단하고, 필요 시 후속 반영 프롬프트로 넘긴다.

---

## 5. 기대 출력

현재 기준에서 기대하는 출력은 다음과 같다.

- confirm 검토 체크리스트
- 현재 문서를 기준 문서로 받아들일 수 있는지에 대한 판단 보조
- 남은 수정 포인트 요약
- confirm 가능 / 보류 필요 여부에 대한 review 결과
- 필요 시 적용 전 정리해야 할 변경 요약

즉 기본 출력은 자동 확정이 아니라  
**사람이 확정 판단을 내릴 수 있게 돕는 검토 출력**이어야 한다.

---

## 6. 최종 정리

현재 `doc confirm-prompt` 흐름의 첫 테스트 문서는  
`docs/projects/board/01-overview.md` 다.

이 흐름은 reinforce 결과를 사람이 기준 문서로 끌어올릴 수 있는지 검토하는 단계이며,  
`doc` 단계에서 사람이 책임을 갖는 지점을 분명히 만드는 역할을 한다.
