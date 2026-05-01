# Doc Stage

## 1. 문서 목적

이 문서는 SpecDrive의 `doc` 단계 책임과 경계를 정의한다.

`doc` 단계는 개발 문서를 구현 가능한 기준 문서로 만들기 위한 단계다.
AI가 문서를 보강할 수 있지만, 개발자 확인 전에는 기준 문서로 확정하지 않는다.

---

## 2. 단계 책임

`doc` 단계는 다음을 다룬다.

- 개발자 초안 저장
- 문서 보강 프롬프트 생성
- Codex 보강 대화 또는 보강안 생성
- 반영 전 confirm 검토
- 실제 문서 반영 초안 준비
- 의미 있는 문서 변경의 history snapshot/note 준비

---

## 3. 현재 action 후보

현재 `doc` 단계의 대표 흐름은 다음과 같다.

- `draft-save`
- `reinforce-prompt`
- `reinforce`
- `confirm-prompt`
- `apply-prompt`
- `apply-only-prompt`

repo-local skill 기준으로는 `$doc-work`, `$doc-work-ref`, `$doc-work-bundle` 흐름이 이 역할을 나누어 담당한다.

---

## 4. 경계

- `doc` 단계는 작업을 Phase/Cycle/Work Package/Task로 확정 분해하지 않는다.
- `doc` 단계는 코딩과 테스트를 실행하지 않는다.
- `doc` 단계 결과는 `plan` 단계의 입력이 될 수 있다.
- 신규 문서 생성, 문서 역할 변경, 요구사항에서 설계 또는 설계에서 구현 계획으로 넘어가는 전환은 개발자 확인 후 진행한다.

---

## 5. 다음 단계

문서가 기준으로 사용할 수 있는 상태가 되면 `plan` 단계에서 실행 가능한 작업 구조로 분해한다.

