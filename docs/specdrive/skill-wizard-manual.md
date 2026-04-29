# docs/specdrive/skill-wizard-manual.md

## 1. 문서 목적

이 문서는 현재 specdrive의 실행 기준을  
**repo-local Codex skill-first 흐름과 향후 wizard 방식 안내 흐름**으로 정리하는 운영 매뉴얼이다.

이 문서는 과거 CLI 실행 매뉴얼을 대체한다.  
현재 기준에서 단일 진입점 CLI 라우터는 제거되었고, 작업 진입은 repo-local Codex skill을 우선한다.

목적은 다음과 같다.

- 현재 사용하는 skill-first 작업 방식을 정리한다.
- 반복 검증된 흐름을 wizard 방식으로 승격할 때의 기준을 남긴다.
- `doc`, `session`, `git` 흐름이 서로의 역할을 침범하지 않도록 한다.
- 사용자가 원시 명령을 외우지 않아도 다음 action과 확인 지점을 따라갈 수 있는 방향을 고정한다.

---

## 2. 현재 실행 기준

현재 기준은 다음과 같다.

- 기본 실행 인터페이스: repo-local Codex skill
- 사용 위치: `.agents/skills/**`
- 배포/패키징 후보 원본: `specdrive/codex-skills/**`
- 현재 검증 방향: skill-first
- 향후 UX 방향: wizard-style guided workflow

현재 버전은 별도 CLI 설치나 단일 CLI 진입점을 전제로 하지 않는다.  
PowerShell 스크립트는 필요한 경우 내부 보조 자산 또는 후속 자동화 후보로만 본다.

---

## 3. Skill-First 원칙

Skill-first는 다음 뜻이다.

1. 사용자는 먼저 repo-local Codex skill을 직접 호출한다.
2. skill은 현재 action에서 필요한 문서와 경계만 안내한다.
3. skill은 자동 반영보다 copy prompt, preview, 검토 지점을 우선한다.
4. 실제 문서 수정, 신규 문서 생성, 단계 전환은 개발자 확인 후 진행한다.
5. 반복 사용 중 안정된 흐름만 wizard 후보로 올린다.

즉 skill은 현재 실행 단위이고, wizard는 안정화된 반복 흐름을 더 사용하기 쉽게 만드는 후속 UX 방향이다.

---

## 4. Wizard 지향 원칙

Wizard 방식은 새로운 단계나 과한 자동화를 뜻하지 않는다.  
현재 확인된 skill 흐름을 사용자가 순서대로 따라갈 수 있게 만드는 안내형 구조다.

wizard 후보가 되려면 다음이 분명해야 한다.

- 현재 action의 목적
- 필요한 입력
- 읽어야 할 문서 범위
- 생성되는 출력
- 사람 확인 지점
- 실제 반영 여부
- 다음 action 후보

wizard는 다음을 피해야 한다.

- 개발자 확인 없이 문서 역할을 바꾸는 것
- 요구사항에서 설계, 설계에서 구현 계획으로 자동 전환하는 것
- 현재 범위를 넘는 future feature를 확정처럼 만드는 것
- `doc`, `dev`, `session`, `git` 단계를 한 흐름에 섞는 것

---

## 5. 현재 주요 Skill 흐름

### 5.1 `$session`

세션 복구와 저장 보조를 담당한다.

현재 action:

- `$session start-lite`
- `$session start`
- `$session status`
- `$session save`

기준:

- `session`은 메타 운영 단계다.
- 문서 보강, 개발 실행, Git 전달 단위를 대신하지 않는다.
- `$session save`는 곧바로 파일을 저장하지 않고 `docs/AI_CONTEXT.md` 반영 초안을 먼저 준비한다.

### 5.2 `$doc-work`

단일 target 문서 작업 진입점이다.

현재 action:

- `$doc-work <target> draft`
- `$doc-work <target> reinforce`
- `$doc-work <target> revise`

기준:

- 단일 문서 자체의 draft, reinforce, revise 흐름을 다룬다.
- 신규 문서 생성이나 문서 역할 변경은 개발자 확인 후 진행한다.
- history snapshot과 note는 의미 있는 문서 변경을 추적하기 위한 결과물이다.

### 5.3 `$doc-work-ref`

대상 문서와 상위/reference 문서만 함께 보는 흐름이다.

현재 action:

- `$doc-work-ref <target> reference`
- `$doc-work-ref <target> revise`

기준:

- 대상 문서가 상위 기준 문서와 충돌하지 않는지 확인한다.
- 넓은 묶음 검토가 아니라 reference 중심 검토에 집중한다.

### 5.4 `$doc-work-bundle`

대상 문서와 영향 문서 묶음을 함께 보는 흐름이다.

현재 action:

- `$doc-work-bundle <target> reference`
- `$doc-work-bundle <target> revise`

기준:

- `specdrive/config/doc-work-bundle-map.json` 의 `bundle_refs` 를 기준으로 읽는다.
- 문서 간 역할, 용어, 경계 정합성을 본다.
- 여러 문서가 함께 수정될 수 있으므로 같은 timestamp를 공유하되 문서별 snapshot/note를 남긴다.

### 5.5 `$git`

Git 전달 단위를 담당한다.

현재 action:

- `$git commit`
- `$git pr`

기준:

- `git`은 세션 저장이나 문서 보강을 대신하지 않는다.
- commit/push/PR 생성은 승인 기반으로 진행한다.
- PR 생성 자동화는 GitHub CLI `gh` 설치와 인증 상태가 준비된 뒤 검증한다.

---

## 6. Wizard 후보 우선순위

현재 wizard 후보는 다음 순서로 보는 것이 자연스럽다.

1. `$session start-lite -> status -> save`
2. `$doc-work <target> draft -> reinforce -> revise`
3. `$doc-work-ref` / `$doc-work-bundle`의 reference와 revise
4. `$git commit -> $git pr`

단, wizard 승격은 구현보다 먼저 사용 흐름이 충분히 반복 검증되어야 한다.

---

## 7. 현재 테스트할 때 확인할 것

skill-first / wizard 후보 흐름을 테스트할 때는 다음을 본다.

- action 이름이 실제 사용자의 의도와 맞는가?
- 출력이 다음 행동을 충분히 안내하는가?
- 읽는 문서 범위가 과하지 않은가?
- 개발자 확인이 필요한 지점이 분명한가?
- history 저장 기준이 과하지도, 부족하지도 않은가?
- 같은 흐름을 다른 target 문서에도 반복 적용할 수 있는가?

---

## 8. Skill 출력 UX 규칙

새 skill을 만들거나 기존 skill을 정리할 때는 출력이 다음 행동과 맞아야 한다.

- 이어지는 작업이 있으면 다음 action을 복사 가능한 prompt block으로 제공한다.
- 개발자 승인 후 실행해야 하는 작업은 일반 질문만 남기지 않고, 승인용 copy-ready prompt를 함께 제공한다.
- preview, approval, completion처럼 대화가 이어지는 흐름은 각 단계의 후속 prompt를 명확히 분리한다.
- follow-up prompt와 completion prompt는 서로 다른 copy block으로 나눈다.
- 작업이 완전히 끝났거나 유용한 후속 action이 없으면 copy-ready prompt를 만들지 않고 짧은 결과 요약으로 끝낸다.
- copy-ready prompt 바깥에는 대상, action, 경로 설명을 반복해서 붙이지 않는다.
- prompt 내부에 note template이 필요하면 fenced code block 중첩을 피하고 `~~~markdown` 형식을 사용한다.

이 규칙의 목적은 사용자가 다음에 무엇을 복사해 실행해야 하는지 헷갈리지 않게 하는 것이다.  
skill은 자동화를 먼저 늘리기보다, 사람이 승인하고 이어갈 수 있는 작은 prompt 단위를 안정화한다.

---

## 9. 최종 정리

현재 specdrive의 실행 기준은 CLI가 아니라  
**repo-local Codex skill-first 흐름**이다.

향후 제품 방향은 이 skill 흐름을 바로 자동화로 밀어붙이는 것이 아니라,  
반복 검증된 흐름을 **wizard 방식의 안내형 작업 흐름**으로 정리하는 것이다.

즉 현재 핵심은 다음 두 가지다.

- skill로 먼저 실제 협업 흐름을 안정화한다.
- 안정화된 흐름만 wizard로 승격한다.
