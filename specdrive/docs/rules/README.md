# SpecDrive Core Rules

## 1. 문서 목적

이 문서는 `specdrive/docs/rules/**` 아래 Core 운영 규칙 문서들의 목록과 역할을 안내한다.

`specdrive/docs/rules/` 는 프로젝트에 복사해서 쓰는 템플릿 영역이 아니다.  
이 영역은 SpecDrive Core 자체를 운영하기 위한 규칙을 둔다.

프로젝트에 복사해서 사용할 규칙 문서 템플릿은 `specdrive/docs/templates/rules/` 아래에 둔다.

---

## 2. 적용 범위

이 규칙 문서군은 다음 Core 자산을 다룬다.

- `specdrive/docs/**`
- `specdrive/config/**`
- `specdrive/scripts/**`
- `.agents/skills/**`
- `specdrive/codex-skills/**`
- `.speclab/**` 중 runtime 산출물과 연결되는 영역

개별 프로젝트의 요구사항, 설계, 구현 판단은 각 프로젝트 문서와 프로젝트별 `rules/` 문서에서 다룬다.

---

## 3. 문서 목록

### 3.1 `affected-docs-rules.md`

Core 자산 변경 시 어떤 문서와 자산을 함께 점검해야 하는지 정의한다.

주요 관심사:

- 문서 변경 전파
- 관련 stage 문서 반영 여부
- 설정, 스크립트, skill 동기화 필요 여부
- 프로젝트별 규칙과 Core 규칙의 구분

### 3.2 `skill-rules.md`

repo-local Codex skill 사용본을 다루는 규칙이다.

주요 관심사:

- `.agents/skills/**` 사용본의 역할
- skill action 경계
- skill 출력 형식
- 세션, 문서, Git 단계의 책임 분리

### 3.3 `script-rules.md`

SpecDrive script 자산을 다루는 규칙이다.

주요 관심사:

- `specdrive/scripts/**` 책임 분리
- preview 출력과 실제 반영의 구분
- config 기반 해석 우선
- destructive action 제한

### 3.4 `codex-skill-rules.md`

배포/패키징 후보 Codex skill 원본을 다루는 규칙이다.

주요 관심사:

- `specdrive/codex-skills/**` 원본의 역할
- `.agents/skills/**` 사용본과의 동기화 기준
- repo-local 검증 후 승격 기준
- skill 문서의 배포 가능성 유지

### 3.5 `runtime-rules.md`

SpecDrive runtime 구조를 다루는 규칙이다.

주요 관심사:

- `.speclab/**` 실행 산출물의 성격
- 재생성 가능한 preview와 보존해야 하는 history의 구분
- `specdrive/config/**` 와 runtime 해석의 관계
- session/doc/git 실행 흐름의 runtime 경계

---

## 4. 운영 원칙

- Core 규칙은 프로젝트 템플릿보다 상위 기준으로 본다.
- 프로젝트에 복사할 내용은 `specdrive/docs/templates/rules/**` 에 둔다.
- Core 규칙 문서는 특정 프로젝트의 상세 설계를 직접 확정하지 않는다.
- 새 규칙 문서를 추가할 때는 이 README와 `specdrive/docs/index.md`의 목록을 함께 점검한다.
- 규칙 변경이 skill, script, codex-skill, runtime 구조에 영향을 주면 관련 문서와 자산의 동기화 필요 여부를 확인한다.

