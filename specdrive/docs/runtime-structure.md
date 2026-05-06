# specdrive/docs/runtime-structure.md

## 1. 문서 목적

이 문서는 `specdrive/{scripts,skills,config}` 구조의 **현재 기준 폴더 책임과 경계**를 정리하는 문서다.

목적은 다음과 같다.

- specdrive 실행 자산이 어디에 놓이는지 빠르게 파악한다.
- `scripts`, `skills`, `config` 의 책임을 구분한다.
- `doc` / `plan` / `dev` / `exec` / `common` 분리를 현재 기준으로 고정한다.
- CLI, Codex 실행, skill 자산이 어디에서 연결되는지 설명한다.

이 문서는 구현 상세를 모두 설명하는 문서가 아니다.  
상세 명령 문법이나 실제 스크립트 구현은 후속 문서 또는 실제 파일을 따른다.

---

## 2. 현재 기준 최상위 구조

현재 specdrive 실행 자산은 아래 구조를 기준으로 둔다.

```text
specdrive/
  scripts/
    doc/
    # plan/  (후속 후보: 계획 분해 스크립트 영역)
    dev/
    session/
    git/
    exec/
    common/
  skills/
    doc/
    # plan/  (후속 후보: 계획 분해 작업 자산 영역)
    dev/
    session/
    git/
    common/
  config/
  manual/
```

이 구조의 기본 원칙은 다음과 같다.

- `specdrive/scripts/**` 는 실행 흐름과 스크립트 책임을 가진다.
- `specdrive/skills/**` 는 반복 작업 정규화를 위한 작업 자산을 가진다.
- `specdrive/config/**` 는 경로, 매핑, 상태 연결 같은 설정 자산을 가진다.
- `specdrive/manual/**` 은 실행자 관점의 매뉴얼 초안과 후속 통합 매뉴얼 후보를 가진다.

---

## 3. `specdrive/scripts/**` 역할

`specdrive/scripts/**` 는  
**specdrive CLI와 내부 실행 흐름을 담당하는 스크립트 영역**이다.

### 3.1 `specdrive/scripts/doc/`
- 문서 단계 명령 실행 흐름
- 예: `doc reinforce`, `doc confirm-prompt`, `doc apply-prompt`
- 문서를 읽고, skill 또는 Codex 실행과 연결하고, 결과 반영 흐름을 조합

### 3.2 `specdrive/scripts/plan/` 후속 후보
- 계획 단계 명령 실행 흐름
- 예: `plan extract-candidates`, `plan phase-split`, `plan cycle-split`, `plan task-split`, `plan wp`
- 기준 문서를 Work Package 후보, Phase/Cycle 구조, Task 구조로 분해
- 현재 구조에는 아직 별도 폴더가 없으며, 후속 plan skill 검증 뒤 추가 여부를 판단

### 3.3 `specdrive/scripts/dev/`
- 개발 단계 명령 실행 흐름
- 예: `dev start`, `dev impl-run`, `dev test`, `dev sync`
- 승인된 plan 결과를 기준으로 현재 Work Package의 코딩, 테스트/검증, 동기화 흐름을 조합

### 3.4 `specdrive/scripts/session/`
- 세션 단계 명령 실행 흐름
- 예: `session start`, `session save`
- 현재 상태 복구와 세션 메모 저장 흐름을 조합

### 3.5 `specdrive/scripts/git/`
- Git 단계 명령 실행 흐름
- 예: `git branch-name`, `git git-message`, `git pr-message`
- 현재 브랜치/변경 파일 기반 전달 단위 생성 흐름을 조합

### 3.6 `specdrive/scripts/exec/`
- 외부 실행기 호출 책임
- 예: `codex exec` 호출 래퍼
- CLI가 직접 외부 호출 세부를 알지 않도록 중간 실행 계층 역할
### 3.7 `specdrive/scripts/common/`
- 공통 유틸리티와 보조 로직
- 경로 해석, 출력 포맷, 공통 상태 처리, 에러 처리 보조
- `doc`, `plan`, `dev`, `session` 어느 한쪽 전용 책임을 섞지 않도록 주의
- 현재 예시: `specdrive/scripts/common/specdrive-common.ps1`

---

## 4. `specdrive/skills/**` 역할

`specdrive/skills/**` 는  
**반복 작업을 정규화하는 내부 작업 자산 영역**이다.

현재 기준 원칙은 다음과 같다.

- skill은 실행기 자체가 아니라 작업 규칙 자산이다.
- skill은 짧고 반복 가능한 단위여야 한다.
- skill은 문서 종류보다 작업 목적 중심으로 나눈다.

### 4.1 `specdrive/skills/doc/`
- 문서 보강
- 문서 검토
- history 저장
- 문서 단계 반복 작업 자산

### 4.2 `specdrive/skills/plan/` 후속 후보
- 일반 작업 후보 추출
- Work Package 후보 추출
- Phase / Cycle 배치
- Task 분해
- 계획 단계 반복 작업 자산
- 현재 구조에는 아직 별도 폴더가 없으며, 후속 plan skill 검증 뒤 추가 여부를 판단

### 4.3 `specdrive/skills/dev/`
- 현재 Work Package 실행
- 코딩 / 테스트 / sync 관련 후속 작업 자산
- 개발 단계 반복 작업 자산

### 4.4 `specdrive/skills/session/`
- 세션 시작 체크리스트
- 세션 저장 규칙
- 세션 단계 반복 작업 자산

### 4.5 `specdrive/skills/git/`
- 브랜치명 생성 규칙
- Git / PR 메시지 초안 생성 규칙
- Git 단계 반복 작업 자산

### 4.6 `specdrive/skills/common/`
- 문서/개발 단계 공통으로 참조할 수 있는 작업 자산
- 예: 공통 응답 형식, 공통 검토 기준, 공통 출력 규칙

---

## 5. `specdrive/config/**` 역할

`specdrive/config/**` 는  
**명령과 문서/상태/경로를 연결하는 설정 자산 영역**이다.

현재 기준으로는 다음 책임을 가진다.

- 문서 매핑 규칙
- 경로 규칙
- 명령과 상태의 연결 설정
- CLI 입력과 내부 처리 흐름을 잇는 설정

현재 기준 핵심 예시는 다음과 같다.

- `specdrive/config/target-registry.json`
  - 대상 문서 키와 실제 문서 경로를 연결하고, 기본 target 같은 공통 라우팅 기준을 두는 registry
- `specdrive/config/skill-registry.json`
  - 작업 키와 실제 skill 자산 경로를 연결하는 registry
- `specdrive/config/context-set-registry.json`
  - context 문서 묶음을 키 기반으로 재사용하기 위한 registry
- `specdrive/config/doc-action-registry.json`
  - action 별 skill key, output mode, 사람 검토 요구 여부, 일부 execute 규칙과 artifact naming 규칙을 정의하는 registry
- `specdrive/config/output-policy.json`
  - `review_patch`, `history_entry` 같은 출력 정책 초안

현재는 여기에 더해 다음 방향을 최소 적용하기 시작했다.

- 고정값은 registry / policy config 로 이동한다.
- action 별 판단 기준은 `doc-action-registry.json` 같은 action registry 로 모은다.
- 스크립트는 가능한 한 config 에서 해석된 결과를 소비한다.

예를 들어 현재 `doc confirm-prompt`, `doc apply-prompt` 는
preview 탐색 위치를 스크립트 내부 하드코딩 대신
action config 우선, output policy fallback 규칙으로 해석한다.

또한 현재 `doc` 스크립트는
기본 target 을 action별 legacy config 우선으로 읽지 않고,
`target-registry.json` 의 `default_target` 우선, legacy fallback 순서로 해석한다.

또한 일부 action 전제조건과 산출물 규칙도 action registry 로 옮기기 시작했다.
현재는 실행 중심보다 prompt-first 해석을 우선하며,
필요한 preview 전제조건과 출력 연결 규칙을 config 에서 읽는 방향으로 정리 중이다.

같은 방식으로 현재 쓰는 preview prefix, history suffix 같은
artifact naming 규칙도 action registry 로 옮기기 시작했다.
현재 `doc confirm-prompt`, `doc apply-prompt` 는
preview 파일명과 history 저장 관련 suffix 일부를 config 에서 읽는다.

즉 현재 `config` 는 단순 경로 모음이 아니라
**고정값 + 실행 판단 기준의 최소 rule/config layer** 로 확장되는 방향을 가진다.

추가로 현재 스크립트에는 다음 legacy config 도 남아 있다.

- `specdrive/config/doc-reinforce-targets.json`
- `specdrive/config/doc-confirm-targets.json`
- `specdrive/config/doc-history-targets.json`

이 파일들은 현재 기준으로는 주로 `default_target` fallback 같은 호환 책임을 가진다.  
실제 문서/skill/context 연결의 주 경로는 registry 구조다.

즉 `config` 는  
실행 로직을 직접 수행하기보다,  
**무엇을 어디에 연결할 것인가**를 정의하는 역할에 가깝다.

---

## 6. CLI / Codex / skill 연결 기준

현재 기준 연결 흐름은 두 갈래로 이해한다.

### 6.1 skill 중심 흐름

`session` 과 `git` 처럼 절차가 아직 검증 중인 영역은 먼저 skill 중심으로 사용한다.

1. 개발자는 Codex에서 필요한 skill을 직접 호출한다.
2. Codex는 repo local `.agents/skills/**` 에 설치된 skill 절차를 따른다.
3. Codex는 필요한 기준 문서를 직접 읽는다.
4. Codex는 먼저 요약, 초안, 확인 지점을 제안한다.
5. 개발자 확인 전에는 파일 수정이나 자동 실행으로 넘어가지 않는다.

즉 현재 `session` / `git` 의 우선순위는 CLI 확장이 아니라
skill 절차를 5~10회 실제 사용하며 다듬는 것이다.
테스트 중인 skill은 전역 `~/.agents/skills/**` 또는 `~/.codex/skills/**` 에 설치하지 않는다.

### 6.2 CLI 보조 흐름

반복이 증명된 뒤에는 아래처럼 CLI 보조 흐름을 둘 수 있다.

1. 사용자는 CLI 명령을 입력한다.
2. `specdrive/scripts/**` 가 현재 단계와 명령 목적에 맞는 흐름을 선택한다.
3. 필요하면 `specdrive/config/**` 에서 문서/경로/상태 연결 정보를 읽는다.
4. 필요하면 `specdrive/skills/**` 에서 해당 작업 규칙 자산을 참조한다.
5. 외부 실행이 필요하면 `specdrive/scripts/exec/**` 를 통해 Codex 실행으로 연결한다.
6. 결과는 다시 문서 또는 상태 반영 흐름으로 돌아온다.

즉 현재 방향은:

- skills = Codex가 따르는 절차와 반복 작업 규칙 자산
- CLI = 반복이 증명된 로컬 상태 수집과 prompt 생성 보조 도구
- scripts = 흐름 오케스트레이션
- config = 연결 정보
- exec = 외부 실행기 연결

---

## 7. 현재 단계에서 중요한 원칙

현재 단계에서는 다음을 특히 유지한다.

- `doc`, `dev`, `session`, `git` 의 책임을 폴더 구조에서도 섞지 않는다.
- `skills` 를 실행기처럼 비대하게 만들지 않는다.
- `config` 에 업무 로직을 넣지 않는다.
- `exec` 는 외부 호출 책임만 가지도록 제한한다.
- 현재는 Codex 중심이므로 과도한 멀티엔진 추상화는 먼저 넣지 않는다.
- 현재 적용 가능한 rule/config 분리는 먼저 작게 반영하고,
  이후 `dev`, `session`, `git`, 개별 project 적용 범위는 검증 결과를 보며 넓힌다.

---

## 8. 최종 정리

`specdrive/docs/runtime-structure.md` 는  
`specdrive/{scripts,skills,config}` 의 현재 기준 책임 구조를 설명하는 문서다.

이 문서를 볼 때는 항상 먼저 아래를 구분한다.

- 이 변경이 실행 흐름 문제인가?
- 반복 작업 자산 문제인가?
- 설정 연결 문제인가?
- 외부 실행기 연결 문제인가?

이 경계가 선명할수록  
CLI, Codex 실행, skill 구조를 더 안정적으로 구체화할 수 있다.
