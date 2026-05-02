# Skill Rules

## 1. 문서 목적

이 문서는 SpecDrive Core의 repo-local Codex skill 사용본을 다루는 운영 규칙을 정의한다.

현재 사용본은 `.agents/skills/**` 아래에 둔다.  
배포/패키징 후보 원본은 `specdrive/codex-skills/**` 아래에 둔다.

---

## 2. 기본 원칙

- skill은 현재 작업을 바로 확정하는 자동화가 아니라, 반복 가능한 작업 절차와 출력 형식을 고정하는 자산이다.
- skill은 `doc`, `dev`, `session`, `git` 단계의 책임을 섞지 않는다.
- skill은 개발자 확인이 필요한 전환 지점을 자동 확정하지 않는다.
- skill은 필요한 문맥만 읽고, `docs/history/**` 는 명시 요청이 있을 때만 확인한다.
- skill 출력은 사람이 검토하고 복사해 사용할 수 있는 형태를 우선한다.

---

## 3. 사용본과 원본 구분

`.agents/skills/**` 는 현재 저장소에서 직접 사용하는 repo-local Codex skill 사용본이다.

`specdrive/codex-skills/**` 는 후속 배포, 패키징, 재사용 후보 원본이다.

skill 변경 시에는 다음을 확인한다.

- 사용본만 바꿀 변경인가?
- 원본도 함께 바꿔야 하는 변경인가?
- 두 위치의 차이가 의도된 실험 상태인가?
- README, index, stage 문서의 설명도 바뀌어야 하는가?

---

## 4. SKILL.md 공통 Wizard Rule

새 skill을 만들거나 기존 `SKILL.md`를 정리할 때는 다음 요약 규칙을 포함한다.

```md
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.
```

이 요약 규칙은 매번 상세 문서를 읽게 하려는 목적이 아니다.  
상세 규칙은 wizard 동작이 애매할 때만 참조한다.

---

## 5. 금지 사항

- skill이 개발자 승인 없이 문서 확정, 단계 전환, Git 전달 단위를 실행하지 않는다.
- session skill이 doc/dev/git 작업을 대신하지 않는다.
- git skill이 session 저장이나 doc history-save를 대신하지 않는다.
- doc skill이 confirm 전 문서를 구현 기준으로 확정하지 않는다.
