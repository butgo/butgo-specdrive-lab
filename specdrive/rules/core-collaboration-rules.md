# Core Collaboration Rules

## 1. Purpose

이 문서는 SpecDrive에서 AI Agent가 반드시 지켜야 하는 최소 협업 규칙을 정의한다.

목표는 다음과 같다.

- 토큰 소모 최소화
- 작업 범위 통제
- 문서와 코드의 추적성 확보
- 사용자 승인 전 임의 변경 방지
- Codex 등 여러 AI 도구에 공통 적용 가능한 규칙으로 유지

세부 규칙은 필요한 경우에만 별도 rules 문서를 참조한다.

---

## 2. Core Principles

AI Agent는 항상 다음 원칙을 따른다.

1. 적게 읽는다.
2. 작게 바꾼다.
3. 짧게 보고한다.
4. 단계는 섞지 않는다.
5. 승인 없이 범위를 넓히지 않는다.
6. 문서와 코드의 추적성을 유지한다.
7. Git 작업은 기본적으로 개발자가 직접 수행한다.

---

## 3. Default Read Scope

기본적으로 compact 문서를 우선 읽는다.

- AGENTS.compact.md
- docs/AI_CONTEXT.compact.md
- 현재 대상 문서
- 사용자가 명시한 참조 문서
- 현재 작업에 필요한 최소 rules 문서

compact 문서가 아직 없거나 판단 경계가 불명확한 경우에만 해당 full 문서를 필요한 섹션 중심으로 읽는다.

다음은 사용자가 명시적으로 요청하지 않는 한 읽지 않는다.

- docs/history/**
- full AGENTS.md
- full README 계열 문서
- full docs/AI_CONTEXT.md
- 과거 백업 문서
- 현재 작업과 무관한 문서
- 현재 작업과 무관한 source 파일
- build 결과물
- 대량 로그 파일

판단이 어렵다고 해서 전체 문서를 조회하지 않는다.

추가 문서가 필요하면 먼저 필요한 이유를 짧게 제안한다.

---

## 4. Scope Lock

AI Agent는 사용자가 지정한 대상만 다룬다.

- 대상 문서만 수정한다.
- 참조 문서는 읽기 전용으로 사용한다.
- 대상 외 파일 수정은 먼저 제안하고 승인받는다.
- 문서 작업 중 소스코드를 수정하지 않는다.
- 개발 작업 중 문서 구조를 임의로 재설계하지 않는다.
- reinforce, confirm, apply, task-split, impl-run 단계를 섞지 않는다.

대상 외 변경이 필요하면 다음 형식으로만 제안한다.

### Scope Expansion Proposal

- Reason:
- Affected Files:
- Risk:
- Recommended Action:

---

## 5. Interface First

문서 보강이나 설계 정리 시 내부 구현 상세보다 입출력 계약을 우선한다.

먼저 정리할 것:

- 입력
- 출력
- 데이터 항목
- API endpoint
- 명령어 interface
- DTO 또는 request/response 구조
- 에러 응답 형식

승인 전에는 다음을 장황하게 작성하지 않는다.

- 내부 구현 로직
- 세부 알고리즘
- DB 상세
- Entity 상세
- 미래 확장 구조
- 대규모 리팩터링 계획

단, README, AI_CONTEXT, status, history 문서에는 상황에 맞게 약하게 적용한다.

---

## 6. Spec-to-Anchor

추적이 필요한 핵심 항목에는 ID Anchor를 붙인다.

기본 형식:

- [REQ-001] 요구사항
- [API-001] API
- [DES-001] 설계
- [DB-001] DB
- [TASK-001] 작업
- [TEST-001] 테스트
- [RULE-001] 규칙

규칙:

- 모든 문장에 붙이지 않는다.
- 핵심 항목에만 붙인다.
- 기존 Anchor를 임의로 변경하지 않는다.
- 삭제된 Anchor를 다른 의미로 재사용하지 않는다.
- 변경 범위 밖 문서에 Anchor를 대량 추가하지 않는다.

---

## 7. Shadow Review

AI Agent는 최종 출력 전 스스로 짧게 검토한다.

확인할 것:

- 작업 범위를 벗어나지 않았는가?
- 상위 문서와 충돌하지 않는가?
- 제외 범위를 침범하지 않았는가?
- 과도한 미래 확장을 추가하지 않았는가?
- 현재 단계에 맞지 않는 내용을 추가하지 않았는가?
- 출력이 불필요하게 길지 않은가?

문제가 없으면 다음 한 줄만 출력한다.

- Issues Found: None

문제가 있으면 짧게 출력한다.

### Issues Found

- Issue:
- Impact:
- Recommended Action:

---

## 8. Stage Separation

AI Agent는 현재 단계의 책임만 수행한다.

### reinforce

개발자 초안을 최소 보강한다.

허용:

- 누락 보강
- 표현 정리
- 구조 정돈
- Anchor 추가
- 명백한 모순 표시

금지:

- 새 설계 작성
- 대규모 재작성
- 소스코드 수정
- 관련 문서 자동 수정

### confirm

다음 단계로 넘어가도 되는지 검토한다.

허용:

- 정합성 검토
- 충돌 지점 표시
- 보완 필요 항목 제안
- 승인 가능 여부 판단

금지:

- 승인 없는 문서 수정
- 새 기능 추가
- 구현 상세 작성

### apply

승인된 변경만 반영한다.

허용:

- 지정된 변경 반영
- 승인된 문서 수정
- 짧은 변경 요약

금지:

- 승인 범위 외 수정
- 새로운 판단 추가
- 관련 문서 임의 수정

### task-split

구현 계획을 실행 가능한 작업 단위로 나눈다.

허용:

- Phase / Cycle / Work Package / Task 분해
- 작업 ID 부여
- 선행/후행 관계 정리
- 불명확 항목 표시

금지:

- 소스코드 구현
- 설계 재작성
- 문서 구조 재설계

### impl-run

승인된 작업만 구현한다.

허용:

- 대상 코드 수정
- 필요한 최소 테스트 추가
- 구현 요약 작성

금지:

- 승인되지 않은 기능 구현
- 문서 체계 변경
- Git write 작업

### test-run

승인된 테스트 또는 검증을 수행한다.

허용:

- 테스트 실행
- 결과 요약
- 실패 원인 정리
- 최소 수정 제안

금지:

- 대규모 리팩터링
- 임의 기능 변경
- Git write 작업

### history-save

확정된 변경 이력만 저장한다.

허용:

- 지정된 이력 파일 작성
- 변경 요약 기록
- 관련 문서 목록 기록

금지:

- 미확정 변경 저장
- 소스코드 수정
- Git write 작업

---

## 9. Git and Terminal Safety

Git 작업은 기본적으로 개발자가 직접 수행한다.

AI Agent가 제안할 수 있는 것:

- commit message
- PR title
- PR description
- 변경 파일 분류
- diff 요약

명시 요청 없이 실행하지 않는 것:

- git add
- git commit
- git push
- git reset
- git clean
- git rebase
- git merge
- force push

터미널 명령은 현재 작업에 필요한 최소 명령만 사용한다.

명시 승인 없이 수행하지 않는 것:

- 파일 삭제
- 파일 이동
- 대량 rename
- 환경 설정 변경
- credentials 변경
- 외부 스크립트 다운로드 후 실행
- dependency 대량 업데이트

---

## 10. Output Rule

AI Agent는 짧게 출력한다.

기본 출력 형식:

- Summary:
- Issues Found:
- Next Step:

변경 반영 시:

- Changed:
- Summary:
- Issues Found:
- Next Step:

작업 분해 시:

- Phase:
- Cycle:
- Work Packages:
- Tasks:
- Open Questions:
- Next Step:

후속 작업이 없으면 Copy-ready prompt를 출력하지 않는다.

Copy-ready prompt는 다음 조건일 때만 출력한다.

- 사용자가 요청한 경우
- 다음 AI 작업이 명확한 경우
- 복사해서 실행할 다음 프롬프트가 필요한 경우

---

## 11. Tool Adapter Separation

공통 규칙과 도구별 실행 규칙은 분리한다.

권장 구조:

- AGENTS.md: 공통 헌법
- docs/AI_CONTEXT.md: 현재 상태
- specdrive/rules/core-collaboration-rules.md: 공통 협업 규칙
- .agents/skills/*: 현재 repo-local Codex 실행 기준
- specdrive/codex-skills/*: 배포/패키징 후보 또는 mirror 성격

특정 도구의 제약을 전체 SpecDrive 규칙으로 승격하지 않는다.

---

## 12. Final Rule

SpecDrive의 목표는 AI가 마음대로 개발하는 것이 아니다.

SpecDrive의 목표는 개발자가 문서, 작업 범위, 변경 이력, 구현 흐름을 통제하면서 AI를 반복 가능한 협업 도구로 사용하는 것이다.
