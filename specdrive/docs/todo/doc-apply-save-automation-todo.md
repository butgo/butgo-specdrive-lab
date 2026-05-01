# specdrive/docs/todo/doc-apply-save-automation-todo.md

## 1. 문서 목적

이 문서는 `doc apply-prompt` 이후의 실제 저장 자동화 범위를 나중에 검토하기 위한
**후속 판단 메모**다.

이 문서는 현재 확정 규칙이 아니다.
현재 `doc` 단계 기준은 `confirm-prompt`, `apply-prompt`, `apply-only-prompt` 중심의
copy prompt 흐름을 따른다.

이 문서는 개발자가 나중에 아래를 다시 판단할 때만 참고하기 위해 남긴다.

- `apply-prompt` 이후에도 저장을 계속 prompt-first 로만 유지할지
- 별도 저장용 prompt 를 둘지
- Codex 출력 형식을 저장에 유리하게 더 엄격히 고정할지
- 이후 반자동 저장 계층이 정말 필요한지

---

## 2. 현재 기준

현재 `doc` 단계의 기준은 다음과 같다.

- `confirm-prompt`
  - 반영 전 검토용 copy prompt 를 출력한다.
- `apply-prompt`
  - 실제 문서 반영 + history 저장 초안을 위한 copy prompt 를 출력한다.
- `apply-only-prompt`
  - history 없이 문서 반영만 필요한 예외 경로용 copy prompt 를 출력한다.

현재 기준에서 저장도 CLI 직접 실행보다
**copy prompt 를 출력하고 사람이 Codex에 붙여넣는 흐름**을 우선한다.

즉 현재는 아래를 기본으로 본다.

1. CLI가 apply 관련 copy prompt 를 출력한다.
2. 개발자가 그 prompt 를 Codex에 붙여넣는다.
3. Codex가 문서 반영안과 history 초안을 제안한다.
4. 개발자가 검토 후 실제 반영 여부를 결정한다.

---

## 3. 후속 검토 후보

나중에 다시 검토할 수 있는 후보는 아래 정도다.

### 3.1 copy prompt 유지

가장 보수적인 현재 방식이다.

- 저장도 계속 prompt-first 로 유지한다.
- CLI는 반영/저장용 copy prompt 만 출력한다.
- 실제 반영은 Codex 제안 + 개발자 승인으로 처리한다.

현재 판단:

- 이 방식을 기본으로 유지한다.

### 3.2 저장용 prompt 분리

가능한 방향:

- `apply-prompt` 는 반영 초안 중심
- 별도 저장용 prompt 는 snapshot / note 저장 중심

검토 포인트:

- 단계가 과하게 늘어나는지
- `apply-prompt` 하나로 충분한지

현재 판단:

- 아직 도입하지 않는다.

### 3.3 반자동 저장

가능한 방향:

- Codex가 정해진 형식으로 결과를 출력한다.
- 별도 스크립트가 그 결과를 읽어 문서와 history 파일 저장을 돕는다.

검토 포인트:

- 현재 alpha 단계에 과한 자동화인지
- 사람 승인 원칙과 충돌하지 않는지
- prompt-first 흐름을 흐리지 않는지

현재 판단:

- 후속 후보로만 둔다.

---

## 4. 현재 보류 결정

현재는 아래를 확정하지 않는다.

- `apply-prompt` 이후 저장 자동화 도입
- 저장 전용 별도 CLI 명령 추가
- Codex 출력 파싱 기반 반자동 저장
- 문서 반영과 history 저장의 자동 실행 확대

현재 확정된 것은 다음뿐이다.

- `doc` 단계는 prompt-first 로 해석한다.
- 저장도 현재는 copy prompt 기반 흐름을 우선한다.
- 저장 자동화 문제는 현재 운영 기준 문서의 기본 참조 범위에 넣지 않는다.

---

## 5. 최종 정리

현재 단계에서 가장 안전한 기준은
**문서 반영과 저장 모두 prompt-first 흐름을 유지하고,
저장 자동화는 todo 메모로만 남기는 것**이다.

이 주제는 현재 기준 문서의 active focus 로 다루지 않고,
개발자가 나중에 다시 보고 판단할 후속 후보로만 보관한다.
