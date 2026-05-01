# Plan Manual

## 1. 문서 목적

이 문서는 SpecDrive의 `$plan` 사용 절차를 정리하는 실행 매뉴얼이다.

`plan` 단계는 `doc` 단계에서 준비한 기준 문서를 실제 `dev` 실행 가능한 작업 구조로 분해하는 단계다.  
이 단계에서는 코딩하지 않고, 현재 실행 포인터도 설정하지 않는다.

나중에 `specdrive/manual/**` 문서를 통합해 SpecDrive 전체 매뉴얼을 만들 때 이 문서를 `plan` 단계 매뉴얼의 기준으로 사용한다.

---

## 2. plan 단계 위치

SpecDrive의 핵심 흐름은 다음과 같다.

```text
doc
  ↓
plan
  ↓
dev
```

각 단계의 의미는 다음과 같다.

```text
doc
= 기준 문서를 만든다.

plan
= 기준 문서를 작업 후보, Phase, Cycle, Work Package, Task 구조로 분해한다.

dev
= 승인된 plan 결과를 기준으로 코딩하고 테스트한다.
```

`session` 은 세션 복구와 저장을 돕는 운영 단계이고, `git` 은 commit/PR 전달 단위를 준비하는 단계다.

---

## 3. plan action 목록

현재 `$plan` 은 다음 action을 가진다.

```text
$plan extract-candidates
$plan wp-split
$plan phase-split
$plan cycle-split
$plan task-split
```

기본 순서는 다음과 같다.

```text
개발 문서
  ↓
extract-candidates
  ↓
wp-split
  ↓
phase-split
  ↓
cycle-split
  ↓
task-split
  ↓
dev start
```

plan 단계 흐름은 다음과 같이 이해한다.

```text
개발 문서
  ↓
work-candidates.md
  ↓
work-roadmap.md
  - Phase
  - Cycle
  - WP
  - Task
  ↓
dev start
  ↓
work-index.md
```

용어 방향은 다음 기준으로 통일한다.

```text
WP -> Task

Task = WP 안의 세부 실행 항목
dev 기본 실행 단위 = WP
Task 분해 action = $plan task-split
```

표현은 항상 `WP -> Task` 방향으로 쓴다.  
WP는 dev에서 의미 있게 실행할 수 있는 작업 묶음이며, Task는 그 WP 안의 세부 실행 항목이다.

Taskmaster류 도구를 참고할 때도 SpecDrive 용어를 우선한다.

```text
외부 Task ~= SpecDrive Work Package
외부 Subtask ~= SpecDrive Task
```

외부 도구의 task/subtask 구조를 그대로 가져오지 않고, SpecDrive에서는 `Candidate -> Work Package -> Task` 흐름으로 해석한다.  
외부 도구에서 유용한 `Dependencies`, `Priority`, `Test Strategy` 성격의 정보는 Work Package의 선후행 관계, 우선순위, 검증 기준으로만 선택 반영한다.

---

## 4. action별 사용 기준

### 4.1 `$plan extract-candidates`

개발 문서에서 일반 작업 후보를 추출한다.

입력 후보:

- `docs/projects/{project}/01-overview.md`
- `docs/projects/{project}/specs/**`
- 프로젝트별 `AGENTS.md`
- 필요한 경우 `work/work-candidates.md`

출력:

- 작업 후보 목록
- 후보별 source 문서
- 후보 유형
- 영향 영역 후보
- 영향 영역 신뢰도
- 다음 action 제안
- `Proposed` 또는 `Needs Clarification` 상태

주의:

- 이 단계는 Work Package나 Task를 확정하지 않는다.
- Phase, Cycle, 구현 위치를 확정하지 않는다.
- 문서에 근거가 약한 후보는 `Needs Clarification` 으로 둔다.
- 영향 영역은 후보일 뿐이며 모듈, 패키지, 클래스, 의존성 방향을 확정하지 않는다.

#### 4.1.1 목적

`$plan extract-candidates` 의 목적은 개발 문서에서 **작업 후보**만 추출하는 것이다.

이 결과는 확정 계획이 아니라 `work-candidates.md` 에 들어갈 수 있는 후보 초안이다.  
따라서 이 단계에서는 Phase, Cycle, Work Package, Task, 구현 위치를 확정하지 않는다.

#### 4.1.2 입력값

`extract-candidates` 에서 주로 사용하는 입력값은 다음과 같다.

- Project Name
- Source Scope
- Source Files
- Scope Note
- Run Mode
- Output Mode

기본값은 다음과 같이 본다.

- Source Scope: `all`
- Run Mode: `generate`
- Output Mode: `markdown`

#### 4.1.3 Project Name 결정

Project Name은 표시 이름이 아니라 `docs/projects/{project}` 의 `{project}` key다.  
예를 들어 Project Name이 `board`이면 대상 프로젝트 root는 `docs/projects/board` 이다.

Project Name의 기준 목록과 기본 경로는 `specdrive/config/project-registry.json` 에서 관리한다.

Project Name은 다음 순서로 결정한다.

1. 사용자가 입력한 Project Name을 우선 사용한다.
2. 없으면 현재 세션의 Active Project를 사용한다.
3. 그래도 없으면 현재 문맥에서 식별 가능한 Project를 사용한다.
4. `specdrive/config/project-registry.json` 에 등록된 프로젝트가 하나뿐이면 해당 프로젝트를 사용한다.
5. 그래도 불명확하면 질문한다.

여기서 Active Project는 별도 상태값이 확정되어 있지 않다면 `docs/AI_CONTEXT.md` 의 current focus, next entry, 현재 작업 대상 문서에서 추정 가능한 프로젝트로 본다.  
추정이 불명확하면 임의로 선택하지 않고 질문한다.

현재 저장소의 기본 프로젝트는 `project-registry.json` 의 `default_project` 를 따른다.  
현재 기준 기본값은 `board` 이지만, 사용자 입력이나 현재 작업 문맥이 더 명확하면 그 값을 우선한다.

#### 4.1.4 Source Scope 결정

Source Scope별 실제 문서 묶음은 `specdrive/config/project-registry.json`를 기준으로 삼는다.

```text
projects.<project>.plan.extract_candidates.source_scopes
```

`extract-candidates` 의 기본 Source Scope는 `project-registry.json` 의
`projects.<project>.plan.extract_candidates.default_source_scope` 를 따른다.  
현재 기본값은 `all` 이다.

`all`, `current`, `file` 의 세부 의미, 실제 문서 목록, 기본값은 registry 값을 기준으로 해석한다.

`current` 모드는 현재 작업 대상이 명확할 때만 사용한다.  
IDE active file 같은 우연한 문맥만으로 대상 문서를 확정하기 어렵다면 질문한다.

현재 `board` 프로젝트의 `extract-candidates` Source Scope 기준은 `project-registry.json` 에 등록된 값을 따른다.

#### 4.1.5 Source Files 결정

Source Files는 `Source Scope = file`일 때 사용자가 지정한 문서 목록이다.

`file` 모드에서 Source Files와 함께 읽을 기본 문서도 `project-registry.json` 을 따른다.

`docs/history/**` 는 사용자가 명시적으로 요청하지 않으면 보지 않는다.

#### 4.1.6 기존 work-candidates 확인

기존 `work/work-candidates.md` 가 있으면 다음을 확인한다.

- 기존 Candidate ID와 중복되지 않게 다음 번호를 준비한다.
- 기존 후보와 중복 가능성이 있는 항목은 `review` 또는 `apply` 출력에서 표시한다.

기존 파일이 없으면 `CAND-001` 부터 시작한다.

#### 4.1.7 Candidate Type

작업 후보에는 다음 Candidate Type 중 하나를 부여한다.

- Feature
- Fix
- Refactor
- Test
- Documentation
- Operation
- Needs Classification

분류가 애매하면 억지로 확정하지 않고 `Needs Classification` 으로 둔다.

#### 4.1.8 Impact Area

Impact Area는 작업 후보가 영향을 줄 가능성이 있는 구조 영역이다.

이 이름은 Java 멀티모듈의 module만 뜻하지 않도록 선택한 것이다.  
멀티모듈 프로젝트에서는 module에 가까울 수 있지만, 단일 모듈, CLI, Frontend, 문서 작업에서는 layer, package, command, component, document section 같은 영향 영역을 넓게 가리킨다.

예시는 다음과 같다.

- Spring 멀티모듈: `board-domain`, `board-application`, `board-infrastructure`, `board-api`
- Spring 단일모듈: `domain`, `service`, `repository`, `controller`, `config`
- Frontend: `page`, `component`, `api-client`, `state`, `routing`
- CLI: `command`, `config`, `usecase`, `adapter`, `output`
- Documentation: `specs`, `work`, `status`, `manual`

Impact Area는 후보일 뿐이며 구현 위치를 확정하지 않는다.  
모듈 생성, 패키지명, 클래스명, 의존성 방향도 이 단계에서 확정하지 않는다.

#### 4.1.9 Impact Confidence

Impact Confidence는 영향 영역 추정의 신뢰도를 나타낸다.

- `High`: 문서에 영역, 모듈, 패키지 같은 근거가 명확히 있다.
- `Medium`: 구조상 추정 가능하다.
- `Low`: 구조 문서가 부족해 추정 수준이다.

Impact Confidence는 정답 판정이 아니라 문서 근거 기반 추정 신뢰도다.  
따라서 가능한 경우 `Impact Evidence`를 함께 적어 왜 해당 신뢰도로 판단했는지 남긴다.

판단 근거는 다음 기준을 따른다.

- `High`: 대상 문서에 module, layer, package, API 영역, 문서 섹션 같은 영향 영역이 직접 언급되어 있다.
- `High`: 대상 문서 자체가 특정 영역 문서다. 예를 들어 `06-api-spec.md`는 API 영향 근거가 강하다.
- `Medium`: 요구사항이나 설계 흐름상 영향 영역을 추정할 수 있지만, 문서에 정확한 module/layer/package가 확정되어 있지는 않다.
- `Medium`: 기존 프로젝트 구조나 일반 아키텍처 기준으로 영향 영역을 좁힐 수 있지만, 현재 문서 근거가 간접적이다.
- `Low`: 기능 요구만 있고 구조 문서가 부족하다.
- `Low`: 여러 영역 후보가 가능하며 어느 쪽인지 결정이 필요하다.

`Low`인 후보는 필요하면 `Status: Needs Clarification` 또는 `Suggested Next Action: clarify` 로 이어질 수 있다.

#### 4.1.10 Status

초기 추출 단계에서는 다음 Status만 사용한다.

- `Proposed`: 문서 근거가 명확하고 후보로 둘 수 있다.
- `Needs Clarification`: 문서 근거가 약하거나 범위 확인이 필요하다.

#### 4.1.11 Suggested Next Action

Suggested Next Action은 다음 중 하나로 제안한다.

- `wp-split`: 구현 묶음 후보로 분해 가능하다.
- `phase-split`: 먼저 큰 범위 배치가 필요하다.
- `defer`: 현재 범위가 아니다.
- `clarify`: 질문이나 결정이 필요하다.

#### 4.1.12 Run Mode별 출력

Run Mode별 출력 기준은 `.agents/skills/plan/inputs.md` 의 Common Output Contract를 따른다.

- `generate`: 개발자가 후보 초안을 직접 작성하지 않아도 기준 문서에서 후보 초안을 생성한다.
- `review`: 기존 `work-candidates.md` 와 비교해 Review Notes를 함께 출력한다.
- `apply`: `work-candidates.md` 반영안을 Apply Draft로 출력한다.

`apply` 는 자동 반영을 뜻하지 않는다.  
실제 `work-candidates.md` 수정은 개발자가 명시적으로 반영을 요청한 경우에만 수행한다.

`generate` 결과에 `work-candidates.md` 에 반영할 후보가 있으면 후속작업이 있는 것으로 본다.  
이 경우 결과 출력에는 Apply Draft와 승인용 copy-ready prompt를 포함한다.  
개발자가 그 프롬프트로 명시 승인하기 전에는 `work-candidates.md` 와 history 파일을 수정하지 않는다.

plan 단계 history 파일명은 공통 context/action 구분 규칙을 따른다.  
`extract-candidates` 로 `work-candidates.md` 를 반영할 때는 다음 형태를 사용한다.

```text
yyyy-MM-dd_HHmmss_generate-candidates_extract-candidates.md
yyyy-MM-dd_HHmmss_generate-candidates_extract-candidates.note.md
```

기존 `doc-work` 계열과의 차이는 다음과 같다.

- `doc-work draft`: 개발자가 이미 작성한 대상 문서를 현재 초안으로 보고 history snapshot을 남기는 흐름이다.
- `doc-work reinforce/revise`: 대상 문서 preview를 만들고, 승인 후 대상 문서와 history에 반영하는 흐름이다.
- `plan extract-candidates generate`: 개발자가 후보 초안을 직접 작성하지 않아도, registry에 등록된 Source Scope 문서를 Codex가 읽고 후보 초안을 생성하는 흐름이다.
- `plan extract-candidates review`: Codex가 생성하거나 기존 `work-candidates.md`에 있는 후보를 문서 근거와 비교 검토하는 흐름이다.
- `plan extract-candidates apply`: 승인된 후보 초안을 `work-candidates.md`에 반영하기 위한 변경안과 history snapshot/note 후보를 출력하는 흐름이며, 자동 수정은 아니다.

즉 `doc-work draft`는 **개발자 초안 보존**이고, `plan extract-candidates generate`는 **문서 기반 후보 생성**이다.

#### 4.1.13 Output Mode별 출력

Output Mode별 출력 기준은 다음과 같다.

- `table`: 표 중심으로 출력한다.
- `markdown`: `work-candidates.md` 반영에 적합한 Markdown 형태로 출력한다.
- `prompt`: 다음 Codex 실행 프롬프트 형태로 출력한다.

후속작업 프롬프트 출력 기준은 `specdrive/docs/skill-wizard-manual.md` 의 공통 Skill 출력 UX 규칙을 따른다.
즉 후속작업이 필요할 때만 copy-ready prompt를 출력하고, 후속작업이 없으면 프롬프트를 출력하지 않는다.

기본 출력 형태는 다음을 따른다.

```text
Plan action: extract-candidates
Target project: <project>
Project root: docs/projects/<project>
Source Scope: <current|all|file>
Source Docs:
Run Mode: <generate|review|apply>
Output Mode: <table|markdown|prompt>

Work Candidates:

- ID: CAND-001
  Title:
  Source Docs:
  Candidate Type:
  Impact Area:
  Impact Confidence:
  Impact Evidence:
  Suggested Next Action:
  Status:
  Notes:

Review Notes:
- Duplicate Candidates:
- Possible Missing Candidates:
- Needs Clarification:

Apply Draft:
- Target file:
- Changes:
- History snapshot:
- History note:
- Approval required: yes

Approval Prompt:
- `work-candidates.md` 반영이 필요한 경우에만 출력
```

### 4.2 `$plan wp-split`

작업 후보를 dev 코딩 한 묶음인 Work Package 후보로 분해한다.

Work Package 기준:

- dev 코딩의 한 묶음이어야 한다.
- 완료 시 의미 있는 동작, 구조, 검증 결과 중 하나 이상이 남아야 한다.
- Task보다 크고 Phase보다 작아야 한다.
- `dev run` 의 기본 실행 단위가 될 수 있어야 한다.
- 필요한 경우 선행 Work Package, 우선순위, 검증 기준을 함께 둔다.

출력:

- Work Package 후보 목록
- source candidate 또는 source 문서
- 기대 산출물
- 제안 Phase
- 제안 Cycle
- 선행 관계 또는 의존성
- 우선순위
- 검증 기준
- `Proposed` 또는 `Needs Clarification` 상태

주의:

- 이 단계는 Task를 확정하지 않는다.
- 현재 실행 포인터를 설정하지 않는다.

### 4.3 `$plan phase-split`

Work Package 후보를 Phase 범위로 배치한다.

Phase 기준:

- 사용자 또는 프로젝트 관점에서 의미 있는 기능 범위여야 한다.
- 단순 파일 수정 묶음이 아니라 결과가 설명 가능한 개발 범위여야 한다.

출력:

- Phase 초안
- Phase별 목표
- 포함할 Work Package 후보
- 제외 또는 보류할 후보
- 확인 질문

### 4.4 `$plan cycle-split`

Work Package 후보를 Cycle 완성도 단계에 배치한다.

기본 Cycle:

```text
Cycle 1 - Minimal Implementation
Cycle 2 - Stability
Cycle 3 - Operational Readiness
```

출력:

- Cycle별 Work Package 배치 초안
- Cycle별 완료 기준
- Cycle 3에서 manual 반영 필요 여부

주의:

- Cycle 1에는 최소 동작과 구조 관통에 필요한 항목만 둔다.
- 안정화, 운영 준비, 문서화 성격의 항목은 Cycle 2 또는 Cycle 3으로 분리한다.

### 4.5 `$plan task-split`

선택된 Work Package 내부를 실제 실행 Task로 분해한다.

Task 기준:

- 특정 Work Package 아래에 있어야 한다.
- 가능한 경우 검증 기준과 연결되어야 한다.
- 현재 Phase/Cycle 범위를 넘지 않아야 한다.

출력:

- Task 목록
- Task별 목적
- 입력 문서 또는 선행 조건
- 기대 산출물
- 검증 방법

주의:

- Task는 Work Package를 완료하기 위한 세부 실행 단위다.
- dev의 기본 실행 단위는 여전히 Work Package다.

---

## 5. 문서 반영 기준

`$plan` 결과는 기본적으로 초안이다.

현재 `$plan` action은 기본적으로 파일을 자동 생성하지 않는다.  
action 실행 결과는 먼저 초안으로 출력하고, 개발자가 승인한 뒤 프로젝트 `work/` 문서에 반영한다.

### 5.1 공통 입력값 요약

`$plan` action에서 사용할 수 있는 공통 입력값은 다음과 같다.

- Project Name: 대상 프로젝트. 생략 가능.
- Project Name은 `docs/projects/{project}` 의 `{project}` key이며, 기준 목록은 `specdrive/config/project-registry.json` 을 따른다.
- Action: 실행할 plan action.
- Source Scope: `current` | `all` | `file`
- Source Files: Source Scope가 `file`일 때 대상 문서 목록.
- Target Mode: `current` | `candidate` | `wp` | `phase` | `cycle`
- Phase: 대상 Phase.
- Cycle: 대상 Cycle.
- Work Package ID: 대상 WP ID.
- Task ID: 대상 Task ID.
- Scope Note: 범위 제한 또는 제외 조건.
- Run Mode: `generate` | `review` | `apply`
- Output Mode: `table` | `markdown` | `prompt`

상세 기준은 `.agents/skills/plan/inputs.md` 를 따른다.

문서 반영이 필요하면 다음 문서를 후보로 본다.

```text
docs/projects/{project}/work/work-candidates.md
docs/projects/{project}/work/work-roadmap.md
```

`work-index.md` 는 plan 단계에서 설정하지 않는다.  
현재 실행 포인터 설정은 `dev start` 단계에서 다룬다.

프로젝트 `work/` 문서를 생성하거나 갱신하는 apply는 승인 후 history snapshot과 note를 함께 남긴다.
history 경로, prefix, suffix는 `specdrive/config/project-registry.json` 의 action별 history 규칙을 따른다.
프로젝트 history는 단계 기준으로 먼저 나누며, plan 단계 산출물은 `docs/history/projects/{project}/plan/**` 아래에 남긴다.
단, 기존 `docs/history/**` 파일 본문 조회는 개발자가 명시적으로 요청한 경우에만 수행한다.

---

## 6. action별 생성/갱신 대상 파일

아래 표는 `$plan` action 결과를 승인했을 때 생성하거나 갱신할 수 있는 파일 기준이다.

| Action | 생성/갱신 대상 | 반영 내용 | 비고 |
|---|---|---|---|
| `$plan extract-candidates` | `docs/projects/{project}/work/work-candidates.md` | 일반 작업 후보, source 문서, 후보 유형, 다음 action 제안, 상태 | 파일이 없으면 템플릿 기준으로 생성 후보 |
| `$plan wp-split` | `docs/projects/{project}/work/work-candidates.md` | Work Package 후보, 기대 산출물, 제안 Phase/Cycle, 상태 | 아직 roadmap 확정 아님 |
| `$plan phase-split` | `docs/projects/{project}/work/work-roadmap.md` | Phase 초안, Phase 목표, 포함/보류 후보 | 개발자 확인 후 roadmap 반영 |
| `$plan cycle-split` | `docs/projects/{project}/work/work-roadmap.md` | Cycle 1/2/3 배치, Cycle별 완료 기준 | Cycle 3은 manual 반영 필요 여부 확인 |
| `$plan task-split` | `docs/projects/{project}/work/work-roadmap.md` | 선택된 Work Package 내부 Task 목록, 검증 기준 | `work-index.md`는 갱신하지 않음 |

필요한 경우 함께 확인할 수 있는 파일은 다음과 같다.

| 파일 | 확인 목적 |
|---|---|
| `docs/projects/{project}/work/work-policy.md` | Phase/Cycle/Work Package/Task 분해 기준 확인 |
| `docs/projects/{project}/work/work-log.md` | plan 반영 이후 후속 sync 또는 판단 기록 후보 확인 |
| `docs/projects/{project}/rules/affected-docs-rules.md` | plan 반영 후 영향 문서 점검 |
| `docs/projects/{project}/status/current-status.md` | 현재 상태 요약 반영 필요 여부 확인 |

`$plan` 단계에서 직접 생성/갱신하지 않는 파일은 다음과 같다.

| 파일 | 이유 |
|---|---|
| `docs/projects/{project}/work/work-index.md` | 현재 실행 포인터는 `dev start` 책임 |
| `docs/projects/{project}/manual/**` | 실행/검증/복구 절차는 주로 dev sync 또는 Cycle 3 책임 |
| `docs/history/**` | history 조회/저장은 명시 요청 시에만 수행 |

---

## 7. 파일 생성 기준

프로젝트에 `work/` 문서가 아직 없으면 `$plan` 결과를 바로 확정 파일로 쓰지 않는다.

먼저 다음 템플릿을 기준으로 생성 후보를 제안한다.

```text
specdrive/docs/templates/work/work-candidates.template.md
specdrive/docs/templates/work/work-roadmap.template.md
specdrive/docs/templates/work/work-policy.template.md
specdrive/docs/templates/work/work-log.template.md
```

생성 우선순위는 다음과 같다.

1. `work-candidates.md`
2. `work-roadmap.md`
3. 필요한 경우 `work-policy.md`
4. 필요한 경우 `work-log.md`

`work-index.md` 는 `dev start` 단계에서 생성 또는 갱신하는 것이 원칙이다.

---

## 8. 금지 사항

`plan` 단계에서는 다음을 하지 않는다.

- 코딩
- 테스트 실행
- `work-index.md` 현재 포인터 설정
- Candidate를 곧바로 Task로 확정
- Work Package 후보를 개발자 확인 없이 확정
- 현재 문서에 없는 미래 확장을 확정 범위처럼 반영
- `docs/history/**` 기본 조회

---

## 9. board 프로젝트 적용 예시

board 프로젝트에 적용하면 기본 흐름은 다음과 같다.

```text
$plan extract-candidates
  - 01-overview.md와 specs 문서에서 작업 후보를 뽑는다.

$plan wp-split
  - 후보를 게시글 등록/조회, 수정/삭제, 검증 보강 같은 dev 코딩 묶음으로 나눈다.

$plan phase-split
  - 예: Phase 1 - 게시판 CRUD 최소 흐름

$plan cycle-split
  - Cycle 1: 최소 구현
  - Cycle 2: 안정화
  - Cycle 3: 운영 준비

$plan task-split
  - 선택된 Work Package 내부의 세부 Task 목록을 작성한다.
```

이후 개발자가 plan 결과를 승인하면 `dev start` 에서 현재 실행할 Work Package를 선택한다.

---

## 10. 관련 문서

- `specdrive/docs/stages/plan-stage.md`
- `specdrive/docs/stages/dev-stage.md`
- `specdrive/docs/work-system.md`
- `specdrive/docs/skill-wizard-manual.md`
- `.agents/skills/plan/SKILL.md`
- `.agents/skills/plan/inputs.md`
- `specdrive/config/project-registry.json`
