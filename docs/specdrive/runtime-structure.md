# docs/specdrive/runtime-structure.md

## 1. 문서 목적

이 문서는 `specdrive/{scripts,skills,config}` 구조의 **현재 기준 폴더 책임과 경계**를 정리하는 문서다.

목적은 다음과 같다.

- specdrive 실행 자산이 어디에 놓이는지 빠르게 파악한다.
- `scripts`, `skills`, `config` 의 책임을 구분한다.
- `doc` / `dev` / `exec` / `common` 분리를 현재 기준으로 고정한다.
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
    dev/
    session/
    git/
    exec/
    common/
  skills/
    doc/
    dev/
    session/
    git/
    common/
  config/
```

이 구조의 기본 원칙은 다음과 같다.

- `specdrive/scripts/**` 는 실행 흐름과 스크립트 책임을 가진다.
- `specdrive/skills/**` 는 반복 작업 정규화를 위한 작업 자산을 가진다.
- `specdrive/config/**` 는 경로, 매핑, 상태 연결 같은 설정 자산을 가진다.

---

## 3. `specdrive/scripts/**` 역할

`specdrive/scripts/**` 는  
**specdrive CLI와 내부 실행 흐름을 담당하는 스크립트 영역**이다.

### 3.1 `specdrive/scripts/doc/`
- 문서 단계 명령 실행 흐름
- 예: `doc reinforce`, `doc confirm`, `doc history-save`
- 문서를 읽고, skill 또는 Codex 실행과 연결하고, 결과 반영 흐름을 조합

### 3.2 `specdrive/scripts/dev/`
- 개발 단계 명령 실행 흐름
- 예: `dev task-split`, `dev phase`, `dev cycle`, `dev status`
- confirm 된 문서를 기준으로 실제 작업 흐름을 조합

### 3.3 `specdrive/scripts/session/`
- 세션 단계 명령 실행 흐름
- 예: `session start`, `session save`
- 현재 상태 복구와 세션 메모 저장 흐름을 조합

### 3.4 `specdrive/scripts/git/`
- Git 단계 명령 실행 흐름
- 예: `git branch-name`, `git git-message`, `git pr-message`
- 현재 브랜치/변경 파일 기반 전달 단위 생성 흐름을 조합

### 3.5 `specdrive/scripts/exec/`
- 외부 실행기 호출 책임
- 예: `codex exec` 호출 래퍼
- CLI가 직접 외부 호출 세부를 알지 않도록 중간 실행 계층 역할
### 3.6 `specdrive/scripts/common/`
- 공통 유틸리티와 보조 로직
- 경로 해석, 출력 포맷, 공통 상태 처리, 에러 처리 보조
- `doc`, `dev`, `session` 어느 한쪽 전용 책임을 섞지 않도록 주의
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

### 4.2 `specdrive/skills/dev/`
- task 분해
- phase / cycle / status 관련 후속 작업 자산
- 개발 단계 반복 작업 자산

### 4.3 `specdrive/skills/session/`
- 세션 시작 체크리스트
- 세션 저장 규칙
- 세션 단계 반복 작업 자산

### 4.4 `specdrive/skills/git/`
- 브랜치명 생성 규칙
- Git / PR 메시지 초안 생성 규칙
- Git 단계 반복 작업 자산

### 4.5 `specdrive/skills/common/`
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

예를 들어 현재 `doc confirm`, `doc history-save` 는
preview 탐색 위치를 스크립트 내부 하드코딩 대신
action config 우선, output policy fallback 규칙으로 해석한다.

또한 현재 `doc` 스크립트는
기본 target 을 action별 legacy config 우선으로 읽지 않고,
`target-registry.json` 의 `default_target` 우선, legacy fallback 순서로 해석한다.

또한 일부 execute 규칙도 action registry 로 옮기기 시작했다.
현재 `doc confirm` 은 `execute_requires` 로
`reinforce_codex_output` 선행조건을 읽어 execute 가능 여부를 확인한다.

같은 방식으로 현재 쓰는 preview prefix, history suffix 같은
artifact naming 규칙도 action registry 로 옮기기 시작했다.
현재 `doc confirm`, `doc history-save` 는
preview 파일명과 history 저장 suffix 일부를 config 에서 읽는다.

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

현재 기준 연결 흐름은 아래처럼 이해한다.

1. 사용자는 CLI 명령을 입력한다.
2. `specdrive/scripts/**` 가 현재 단계와 명령 목적에 맞는 흐름을 선택한다.
3. 필요하면 `specdrive/config/**` 에서 문서/경로/상태 연결 정보를 읽는다.
4. 필요하면 `specdrive/skills/**` 에서 해당 작업 규칙 자산을 참조한다.
5. 외부 실행이 필요하면 `specdrive/scripts/exec/**` 를 통해 Codex 실행으로 연결한다.
6. 결과는 다시 문서 또는 상태 반영 흐름으로 돌아온다.

즉 현재 방향은:

- CLI = 진입점
- scripts = 흐름 오케스트레이션
- skills = 반복 작업 규칙 자산
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

`docs/specdrive/runtime-structure.md` 는  
`specdrive/{scripts,skills,config}` 의 현재 기준 책임 구조를 설명하는 문서다.

이 문서를 볼 때는 항상 먼저 아래를 구분한다.

- 이 변경이 실행 흐름 문제인가?
- 반복 작업 자산 문제인가?
- 설정 연결 문제인가?
- 외부 실행기 연결 문제인가?

이 경계가 선명할수록  
CLI, Codex 실행, skill 구조를 더 안정적으로 구체화할 수 있다.
