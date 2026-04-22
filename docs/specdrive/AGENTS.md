# docs/specdrive/AGENTS.md

## 1. 문서 목적

이 문서는 specdrive 자체를 설계·운영할 때 적용하는 **전용 작업 규칙**을 정의한다.

루트 `AGENTS.md` 가 저장소 전체의 최상위 작업 기준 문서(공통 헌법)라면,  
이 문서는 그 위에서 **specdrive를 문서 기반 AI 협업 엔진 / 운영체계 / CLI 도구로 설계하고 운영할 때의 추가 규칙**을 다룬다.

현재는 검증을 위해 `projects`와 같은 저장소 안에서 함께 운영하지만,  
장기적으로는 specdrive가 독립된 도구/플랫폼으로 분리 가능한 구조를 전제로 한다.

이 문서는 다음에 집중한다.

- specdrive 도구 문서의 역할과 경계
- specdrive 문서 구조와 책임 분리
- `doc` / `dev` 작업 흐름의 구분
- 세션 시작, 문맥 복구, 검토, 동기화 같은 협업 흐름의 원칙
- projects 문서와 specdrive 문서의 분리 기준
- specdrive 자체를 문서 기반 AI 협업 도구로 유지하기 위한 금지/주의 사항

---

## 2. 적용 범위

이 문서는 다음 범위에 적용된다.

- `docs/specdrive/**`
- specdrive 자체 설계/운영 관련 문서
- specdrive 엔진, 절차, 프롬프트 흐름, 협업 구조 문서
- `specdrive/scripts/**`
- `specdrive/scripts/common/**` 중 specdrive 전용 흐름과 직접 연결되는 부분
- `specdrive/config/**` 중 specdrive 명령/문서 매핑/상태 관리와 연결되는 부분
- `specdrive/skills/**` 중 specdrive 작업 흐름과 직접 연결되는 자산
- `.speclab/**` 중 specdrive 상태 관리와 직접 연결되는 자산

개별 애플리케이션의 요구사항, 설계, 구현 판단은 이 문서의 직접 대상이 아니다.  
그 내용은 `docs/projects/**` 에서 다룬다.

현재 단계에서는 특히 다음 분리를 유지한다.

- `docs/specdrive/**` = specdrive 개념, 규칙, 구조, 흐름 설명 문서
- `docs/projects/**` = 실제 애플리케이션 개발 스펙 문서
- `specdrive/scripts/**` = specdrive 실행용 스크립트 자산
- `specdrive/skills/**` = 반복 작업 정규화를 위한 작업 자산
- `specdrive/config/**` = 경로, 매핑, 상태, 명령 해석을 위한 설정 자산

---

## 3. specdrive의 현재 성격

specdrive는 현재 **완성된 SaaS 제품**이 아니다.

현재 specdrive는 다음 성격으로 이해해야 한다.

- 문서 기반 AI 협업 엔진
- CLI 중심 작업 오케스트레이터
- 반복 가능한 개발 운영체계 검증 대상
- Codex 중심 협업 흐름 실험 도구
- 실제 프로젝트에 적용 가능한 운영 방식 템플릿

즉 현재 단계에서 specdrive의 핵심은 다음이다.

- 문서 기반 흐름을 안정화하는 것
- `doc` / `dev` 작업 단계를 분리하는 것
- CLI 명령 구조를 작고 명확하게 만드는 것
- Codex와의 작업 절차를 반복 가능하게 고정하는 것
- 실제 프로젝트에 적용 가능한 수준까지 검증하는 것

SaaS 외형, 웹 UI, 조직/사용자/결제 구조는 현재 우선순위가 아니다.

---

## 4. specdrive 문서의 역할 원칙

specdrive 문서는 다음 역할을 가져야 한다.

- 도구의 목적 설명
- 작업 단계 정의
- 명령 구조 정의
- 협업 절차 정의
- 문맥 복구 규칙 정의
- 상태/히스토리 운영 규칙 정의
- 문서와 스크립트의 연결 규칙 정의

specdrive 문서는 **특정 애플리케이션을 설계하는 문서**가 아니다.  
specdrive 문서는 **애플리케이션 문서를 기반으로 AI 협업을 실행하는 방식**을 정의하는 문서다.

즉 specdrive 문서에는 다음이 직접 들어가지 않도록 주의한다.

- board 같은 특정 프로젝트의 상세 요구사항
- 특정 프로젝트의 API/DB/패키지 설계 판단
- 특정 기능의 구현 상세
- 개별 애플리케이션의 도메인 설명

이런 내용은 `docs/projects/**` 로 분리한다.

---

## 5. specdrive와 projects의 분리 원칙

### 5.1 specdrive는 협업 방식을 다룬다
specdrive는 다음을 다룬다.

- 세션 시작
- 문맥 복구
- 문서 보강 절차
- 문서 확정 절차
- history 저장 절차
- task 분해 절차
- phase / cycle 상태 관리
- 명령 실행 흐름
- AI 협업 규칙

### 5.2 projects는 실제 개발 내용을 다룬다
projects는 다음을 다룬다.

- 요구사항
- 설계
- 구현 계획
- 상태
- 히스토리
- 실제 애플리케이션 코드/문서

### 5.3 혼합 금지
specdrive 문서 안에 특정 프로젝트 설계를 과하게 집어넣지 않는다.  
반대로 project 문서 안에 specdrive 자체 운영 규칙을 넣지 않는다.

---

## 6. specdrive 작업 흐름 원칙

현재 specdrive는 핵심 작업 흐름을 `doc`, `dev` 로 나누고,  
세션 운영을 위한 `session`, 전달 단위 생성을 위한 `git` 단계를 별도로 둔다.

### 6.1 doc 단계
문서를 구현 가능한 상태로 만드는 단계다.

핵심 흐름:

- reinforce
- confirm
- history-save

원칙:

- 문서 초안이 먼저 있어야 한다.
- AI는 현재 문서를 기준으로 보강한다.
- confirm 전에는 기준 문서로 간주하지 않는다.
- history-save는 중요한 판단 흔적을 남기는 절차다.

### 6.2 dev 단계
확정된 문서를 실제 개발 작업 단위로 실행하는 단계다.

핵심 흐름:

- task-split
- phase
- cycle
- status

원칙:

- `dev` 단계는 confirm 된 문서를 기준으로 시작한다.
- task-split은 구현 전에 작업 범위를 쪼개는 절차다.
- phase / cycle은 개발 상태와 검증 수준을 표현하는 운영 단위다.
- dev 단계는 문서 단계 문제를 대신하지 않는다.

### 6.3 session 단계
세션 시작/종료와 전달 메시지 생성을 다루는 운영 단계다.

핵심 흐름 예:

- start
- save

원칙:

- `session` 은 세션 복구와 저장을 돕는 메타 운영 단계다.
- `session start` 는 현재 상태 복구와 진입점 정리를 돕는다.
- `session save` 는 세션 메모와 다음 진입점 정리를 돕는다.
- `session` 은 `doc` / `dev` 내부 처리 로직을 대신하지 않는다.

### 6.4 git 단계
브랜치명, commit message, PR 메시지 같은 Git 전달 단위를 만드는 단계다.

핵심 흐름 예:

- branch-name
- git-message
- pr-message

원칙:

- `git` 은 전달 단위 생성 단계다.
- `git branch-name` 은 앞으로 phase / cycle 과 관련 문서를 읽어 브랜치명을 만드는 방향을 지향한다.
- `git git-message` 는 Git commit message 초안을 만든다.
- `git pr-message` 는 PR 제목(영문)과 설명(국문) 초안을 만든다.
- `git` 은 실제 Git/PR 실행 자체를 대신하지 않는다.

### 6.5 단계 혼합 금지
specdrive 문서와 스크립트를 설계할 때 `doc`, `dev`, `session`, `git` 의 책임을 섞지 않는다.

예:

- 문서 보강 로직을 개발 상태 관리 로직에 섞지 않는다.
- phase / cycle 로직을 문서 확정 로직에 섞지 않는다.
- confirm 되지 않은 문서를 바로 task 실행 기준으로 사용하지 않는다.
- 세션 메모 로직을 문서 확정 절차와 같은 단계로 섞지 않는다.
- Git 전달 단위 생성 로직을 세션 메모 로직과 같은 단계로 섞지 않는다.

---

## 7. 현재 구현 우선순위

현재 specdrive의 우선 구현 범위는 다음과 같다.

### 문서 단계
- `doc reinforce`
- `doc confirm`
- `doc history-save`

### 개발 단계
- `dev phase set`
- `dev cycle set`
- `dev status`
- `dev task-split`

### 세션 단계
- `session start`
- `session save`

### Git 단계
- `git branch-name`
- `git git-message`
- `git pr-message`

현재는 문서 단계 명령이 더 중요하다.  
개발 단계와 세션/Git 단계는 문서 단계가 어느 정도 안정된 뒤 확장한다.

---

## 8. 현재 기술 방향

현재 기준 기술 방향은 다음과 같다.

- AI 엔진: Codex 중심
- 실행 인터페이스: PowerShell CLI
- 현재 목표: 최소 작업 흐름 검증
- 현재 저장소 성격: 통합 검증 저장소
- 추후 후보: Go 또는 Python 재구현 가능
- 현재는 멀티 AI 엔진 지원을 우선하지 않음

specdrive 전용 문서와 스크립트는 위 전제를 기준으로 설계한다.

---

## 9. CLI 원칙

현재 specdrive는 CLI 중심으로 흐름을 검증한다.

CLI는 다음 역할을 가져야 한다.

- 작업 단계를 분명히 드러낼 것
- 사용자가 문서 작업과 개발 작업을 구분할 수 있게 할 것
- 복잡한 내부 로직을 감추고, 단순한 명령으로 진입하게 할 것
- 작업 절차를 정규화할 것

현재 기준 명령 방향:

- `specdrive/specdrive.ps1 doc ...`
- `specdrive/specdrive.ps1 dev ...`
- `specdrive/specdrive.ps1 session ...`
- `specdrive/specdrive.ps1 git ...`

원칙:

- 명령은 작업 목적 중심으로 자른다.
- 문서 종류보다 작업 액션을 우선한다.
- 사용자가 Codex CLI를 직접 다루는 부담은 줄인다.
- specdrive CLI는 Codex 실행을 내부 구현으로 감추는 방향을 우선한다.

CLI의 세부 문법은 별도 문서에서 다루고, 이 문서에서는 방향과 원칙만 다룬다.

---

## 10. skill 원칙

skill은 반복 작업을 정규화하는 내부 작업 단위로 본다.

현재 단계에서 skill은 다음 역할을 가진다.

- 문서 보강 규칙 재사용
- 문서 검토 규칙 재사용
- history 저장 규칙 재사용
- task 분해 규칙 재사용

원칙:

- skill은 거대한 설명서가 아니라 **짧고 반복 가능한 작업 규칙 자산**이어야 한다.
- skill은 문서 종류별 중복을 줄이고, 작업 절차를 표준화하는 데 집중한다.
- skill은 엔진 추상화보다 현재 작업 정규화에 우선 사용한다.
- 현재는 Codex 중심이므로 범용 멀티엔진 skill 구조를 먼저 만들지 않는다.

---

## 11. Codex 연동 원칙

현재 specdrive의 AI 실행 기준은 Codex다.

원칙:

- Codex는 문서를 읽고 보강/검토/분해를 수행하는 협업 엔진으로 사용한다.
- Codex에게 현재 저장소의 방향을 README/AGENTS/AI_CONTEXT로 먼저 전달한다.
- Codex는 현재 문서를 기준으로 보강하도록 유도한다.
- Codex는 재설계자보다 보강자/검토자 역할을 우선한다.

장기적으로 `codex exec` 자동화를 검토할 수 있지만,  
현재는 **작업 흐름의 안정화와 CLI 검증**이 먼저다.

즉 이 문서에서 중요한 것은 Codex 호출 상세보다 **Codex가 어떤 규칙 아래 일해야 하는가**다.

---

## 12. 문맥 복구 원칙

specdrive는 세션이 자주 바뀌는 환경을 전제로 한다.

따라서 specdrive 문서 구조는 다음을 지원해야 한다.

- 현재 상태를 빠르게 복구할 수 있어야 한다.
- 다음 진입점을 쉽게 찾을 수 있어야 한다.
- 문서 역할과 계층이 흔들리지 않아야 한다.
- 긴 대화가 없어도 핵심 흐름을 재구성할 수 있어야 한다.

이를 위해 다음 문서들은 중요하다.

- `README.md`
- 루트 `AGENTS.md`
- `docs/specdrive/AGENTS.md`
- `docs/AI_CONTEXT.md`
- 각 영역별 README / index / 상태 문서

---

## 13. 금지 및 주의 사항

### 13.1 금지
다음을 먼저 제안하거나 구현하지 말 것.

- specdrive를 곧바로 SaaS UI 프로젝트처럼 재구성하는 것
- 현재 필요 이상의 멀티엔진 추상화를 도입하는 것
- 문서 단계와 개발 단계를 섞는 구조를 만드는 것
- 특정 프로젝트 설계를 specdrive 공통 문서에 넣는 것
- specdrive 문서를 애플리케이션 설계 문서처럼 사용하는 것
- 현재 쓰지 않는 복잡한 추상화/플러그인 구조를 먼저 도입하는 것

### 13.2 주의
다음을 특히 주의한다.

- specdrive 문서는 현재 운영 기준을 먼저 담아야 한다.
- 미래 아이디어는 현재 결정과 분리해서 기록한다.
- 명령 구조를 설명할 때도 현재 검증 가능한 최소 흐름을 우선한다.
- 구조를 키우기보다 현재 실제로 반복 가능한지 먼저 본다.

---

## 14. 권장 작업 흐름

specdrive 자체를 다룰 때의 기본 권장 흐름은 다음과 같다.

1. 현재 작업 대상이 specdrive 문서인지, project 문서인지 먼저 구분한다.
2. specdrive 문서라면 루트 `AGENTS.md`와 이 문서를 먼저 확인한다.
3. 현재 단계(`doc` / `dev`)와 현재 범위를 확인한다.
4. 현재 문서를 기준으로 보강 또는 정리한다.
5. 필요한 경우 연관 문서와 상태 문서를 함께 반영한다.
6. 중요한 변경은 history를 남긴다.
7. 구조 변경이면 projects와의 경계가 흐려지지 않았는지 다시 확인한다.

---

## 15. 이 문서가 직접 다루는 것과 다루지 않는 것

### 이 문서가 직접 다루는 것
- specdrive 전용 작업 규칙
- specdrive 문서와 스크립트의 역할/경계
- specdrive 문서 구조 원칙
- doc/dev/session/git 단계 구분의 전용 기준
- CLI/skill/Codex 연동의 방향 원칙
- projects와 specdrive의 분리 기준

### 이 문서가 직접 다루지 않는 것
- 특정 프로젝트의 상세 설계
- 특정 기능의 요구사항
- 특정 애플리케이션의 API/DB/패키지 설계
- 개별 명령어의 상세 문법
- Codex exec/skill/CLI의 상세 기술 구현
- 현재 시점의 구체적인 활성 상태 자체

이런 내용은 별도 기술 문서, 상태 문서, 프로젝트 문서에서 다룬다.

---

## 16. 최종 원칙

specdrive의 핵심은  
문서를 많이 늘리는 것이 아니라,  
**문서 기반 AI 협업 흐름을 반복 가능하게 만드는 것**이다.

따라서 specdrive를 다룰 때는 항상 다음을 먼저 확인한다.

- 이 내용이 specdrive 자체 규칙인가?
- 이 내용이 특정 project 판단인가?
- 지금 필요한 최소 흐름을 강화하는가?
- `doc`, `dev`, `session`, `git` 의 경계를 흐리지 않는가?
- 현재 Codex 중심 / CLI 중심 검증 단계에 맞는가?

이 질문에 답하지 못하면,  
기능 추가보다 문서 위치와 역할부터 다시 정리한다.
