# specdrive/rules/skill-wizard-rule.md

## 1. Purpose

이 문서는 SpecDrive skill의 공통 wizard 실행 규칙을 정의한다.

이 규칙은 session, doc, plan, dev 계열 skill에 공통 적용한다.

목적은 다음과 같다.

- 하나의 skill action이 현재 요청된 작업만 수행하도록 제한한다.
- AI가 후속 작업을 자동으로 연쇄 실행하지 않도록 한다.
- 필요한 경우에만 copy-ready prompt를 출력한다.
- 후속 작업이 없거나 사람 검토가 먼저 필요한 경우 불필요한 prompt 출력을 막는다.
- session, doc, plan, dev, version-control 역할이 한 응답 안에서 섞이지 않도록 한다.

---

## 2. Core Rule

SpecDrive skill은 wizard-style interaction을 기본으로 한다.

기본 흐름은 다음과 같다.

1. 사용자가 skill action을 실행한다.
2. AI는 현재 action의 결과만 출력한다.
3. 후속 AI action이 명확하게 필요한 경우에만 copy-ready prompt를 출력한다.
4. 사용자는 출력된 prompt를 복사하여 다음 action을 별도로 실행한다.
5. 후속 action이 없으면 copy-ready prompt를 출력하지 않는다.

---

## 3. Action Boundary

하나의 skill action은 현재 요청된 action만 수행한다.

규칙:

- 현재 action과 다음 action을 한 응답에서 함께 실행하지 않는다.
- 후속 action은 실행하지 않고, 필요 시 copy-ready prompt만 제공한다.
- copy-ready prompt는 하나의 다음 action만 포함한다.
- 여러 action을 하나의 prompt에 묶지 않는다.
- 사용자가 명시하지 않은 save, apply, dev, session, version-control 성격의 작업을 수행하지 않는다.
- doc, plan, dev, session 역할을 하나의 action 안에서 섞지 않는다.

---

## 4. Copy-ready Prompt Allowed

copy-ready prompt는 다음 경우에만 출력한다.

- 사용자가 명시적으로 요청한 경우
- 다음 AI action이 명확한 경우
- 다음 action이 현재 action의 자연스러운 후속 단계인 경우
- 다음 action이 별도 승인 또는 별도 실행 단위여야 하는 경우
- prompt를 수정 없이 복사해서 사용할 수 있는 경우
- 다음 action이 현재 skill의 책임 범위 안에 있거나, 사용자가 명시적으로 단계 전환을 요청한 경우

---

## 5. Copy-ready Prompt Forbidden

copy-ready prompt는 다음 경우 출력하지 않는다.

- 현재 action으로 작업이 완료된 경우
- 다음 단계가 불명확한 경우
- 사람 검토가 먼저 필요한 경우
- 사용자의 확정 또는 승인이 먼저 필요한 경우
- 다음 작업이 개발자 수동 작업인 경우
- 다음 작업이 version-control 작업인 경우
- 다음 작업이 현재 skill의 책임 범위를 벗어나는 경우
- 다음 prompt가 session, doc, plan, dev, version-control 작업을 혼합하는 경우
- 다음 prompt가 여러 action을 한 번에 수행하도록 요구하는 경우

---

## 6. Output Shape

기본 출력은 짧게 유지한다.

권장 형식:

1. Summary
2. Result
3. Issues Found
4. Next Step
5. Copy-ready Prompt

`Copy-ready Prompt` 섹션은 허용 조건을 만족할 때만 출력한다.

후속 작업이 없으면 `Copy-ready Prompt` 섹션 자체를 출력하지 않는다.

---

## 7. Next Step Rule

`Next Step`은 짧게 작성한다.

규칙:

- 다음 단계가 명확하면 한 줄로 제안한다.
- 사람 검토가 필요하면 사람 검토가 먼저라고 표시한다.
- 후속 AI action이 필요하지 않으면 `Next Step`은 생략할 수 있다.
- `Next Step`이 있다고 해서 반드시 copy-ready prompt를 출력하지 않는다.
- copy-ready prompt는 별도 실행이 필요한 명확한 AI action이 있을 때만 출력한다.

---

## 8. Skill-specific Rule

각 skill은 이 공통 규칙을 따른다.

단, 각 skill의 action 파일은 다음 항목을 더 구체적으로 정의할 수 있다.

- 해당 action의 Read Scope
- 해당 action의 Output 형식
- 해당 action의 Stop Points
- 해당 action에서 copy-ready prompt를 출력할 수 있는 조건
- 해당 action에서 다음 action으로 넘어가면 안 되는 조건

개별 action 규칙이 더 엄격하면 개별 action 규칙을 우선한다.

---

## 9. SKILL.md Reference Snippet

각 skill의 `SKILL.md`에는 다음 요약 규칙을 둔다.

```md
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.
```

상세 규칙은 매번 읽는 기본 문맥이 아니라, wizard 동작이 애매할 때만 참조한다.

---

## 10. Stage Transition Rule

session, doc, plan, dev 사이의 단계 전환은 자동으로 수행하지 않는다.

규칙:

- doc action은 자동으로 plan action을 실행하지 않는다.
- plan action은 자동으로 dev action을 실행하지 않는다.
- dev action은 자동으로 session save를 실행하지 않는다.
- session action은 doc, plan, dev 작업을 대신하지 않는다.
- 단계 전환이 필요하면 copy-ready prompt로 제안할 수 있다.
- 단, 사람 검토 또는 확정이 먼저 필요하면 copy-ready prompt를 출력하지 않는다.

---

## 11. Version-control Boundary

SpecDrive skill은 version-control 작업을 자동 수행하지 않는다.

규칙:

- branch, commit, PR, push, merge, release 작업을 수행하지 않는다.
- version-control 상태를 요청하거나 해석하지 않는다.
- version-control 작업을 위한 copy-ready prompt를 출력하지 않는다.
- 필요한 version-control 작업은 개발자가 별도로 처리한다.

---

## 12. Final Rule

SpecDrive skill은 자동 연쇄 실행 도구가 아니다.

SpecDrive skill은 현재 action을 수행하고, 필요한 경우 다음 action을 사용자가 명시적으로 실행할 수 있게 안내하는 wizard다.

따라서 skill은 현재 action만 수행하고, 후속 작업이 명확할 때만 하나의 copy-ready prompt를 출력한다.
