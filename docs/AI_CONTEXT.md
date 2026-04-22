# docs/AI_CONTEXT.md

## 1. 문서 목적

이 문서는 현재 저장소의 **작업 상태, 핵심 결정 사항, 보류 사항, 다음 진입점**을 빠르게 복구하기 위한 공용 운영 문서다.

이 문서는 다음 목적을 가진다.

- 현재 작업 상태를 빠르게 파악한다.
- 지금 기준의 활성 범위와 현재 focus를 확인한다.
- 다음 세션에서 가장 먼저 확인해야 할 문서를 안내한다.
- 최근 결정 사항과 아직 남은 판단 사항을 요약한다.
- 회사, 집, 다른 장소에서 작업을 이어갈 때 동일한 진입점을 제공한다.

이 문서는 상세 설계 문서, 전용 규칙 문서, 개별 프로젝트 문서를 대체하지 않는다.  
이 문서는 현재 상태와 다음 진입점을 요약하는 **공용 대시보드 문서**다.

---

## 2. 현재 상태 한 줄 요약

- 현재는 `specdrive`를 **개발 스펙 문서를 기반으로 AI 협업을 실행하는 엔진 / 운영체계 / CLI 도구**로 정리한 상태에서, `doc reinforce / confirm / history-save` 최소 흐름이 `docs/projects/board/01-overview.md` 기준으로 기대한 역할대로 동작하는지 검증하는 한편, `doc reinforce` 는 실제 `codex exec` 로 좁게 연결하고 `session` 과 `git` 단계를 별도 운영/전달 단계로 정리하는 단계다.

현재 전체 개념에서 특히 중요한 점은, specdrive를 `.speclab` preview 생성 도구로 이해하지 않는 것이다.  
현재 기준으로 specdrive는 project 문서를 읽고 AI 협업 흐름을 실행한 뒤, 의미 있는 변경을 실제 문서와 `docs/history/projects/**` 문서 이력으로 정착시키는 운영체계로 이해하는 편이 맞다.

---

## 3. 현재 작업 모드

- 문서 정체성 재정리
- 문서 계층 분리
- README / AGENTS / AI_CONTEXT 우선 정비
- specdrive / projects / board / standards 역할 구분 정리
- `doc` / `dev` 단계 분리 정리
- `session` 단계 분리 정리
- `git` 단계 분리 정리
- Codex 중심 CLI 흐름 최소 구현 및 preview 검증
- key 기반 registry routing 문서/스크립트 정합성 정리

현재는 실제 제품 구현보다  
**엔진/운영체계 문서와 애플리케이션 문서의 경계를 고정한 뒤, `doc` 단계 흐름을 반복 가능한 최소 구조로 검증하는 작업 모드**에 가깝다.

---

## 4. 현재 활성 범위

현재 활성 범위는 다음과 같다.

- 루트 `README.md` 정리
- 루트 `AGENTS.md` 정리
- `docs/AI_CONTEXT.md` 정리
- `docs/specdrive/AGENTS.md` 정리
- `docs/projects/board/AGENTS.md` 정리
- specdrive / projects / board / standards 정의 고정
- `doc` / `dev` / `session` / `git` 작업 단계 구분 고정
- Codex가 프로젝트 성격을 안정적으로 이해할 수 있도록 진입 문서 정비
- `specdrive/{scripts,skills,config}` 구조 고정
- `doc reinforce / confirm / history-save` 최소 흐름 문서화
- `target / skill / context-set / action` registry 기준 설명 정리
- action registry / output policy 를 활용한 최소 rule/config 분리 적용 시작
- PowerShell 스크립트 기반 preview 출력 검증
- board `01-overview.md` 를 첫 테스트 문서로 사용한 흐름 검증
- `01-overview.md` 기준 `reinforce / confirm / history-save` 역할 분리 테스트 정리
- 의미 있는 문서 변경을 `docs/history/projects/**` 에 실제 이력으로 남기는 흐름 정리

현재 범위에 포함하지 않는 것은 다음과 같다.

- board의 상세 요구사항 본문 확정
- board의 상세 API / DB / 패키지 설계 본문 확정
- specdrive CLI 실제 제품화 착수
- skill 상세 구조의 일반화/추상화
- `codex exec` 실제 실행 연동 전면 확대
- 모바일 앱 구조 본격 착수
- standards 2차 문서 전체 작성
- phase / cycle 기반 실제 구현 운영의 본격 재도입

---

## 5. 현재 기준 핵심 문서

현재 세션에서 우선 확인할 문서는 다음과 같다.

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/runtime-structure.md`
6. `docs/specdrive/doc-stage-testing.md`
7. `docs/specdrive/cli-manual.md`
8. `docs/specdrive/cli-key-routing.md`
9. `docs/specdrive/cli-single-entry.md`
10. `docs/specdrive/session-stage.md`
11. `docs/specdrive/git-stage.md`

필요 시 다음 문서를 후속 참조한다.

12. `docs/projects/board/AGENTS.md`
13. `docs/specdrive/doc-reinforce-flow.md`
14. `docs/specdrive/doc-confirm-flow.md`
15. `docs/specdrive/doc-history-save-flow.md`
16. `docs/README.md`
17. `docs/specdrive/README.md`
18. `docs/projects/README.md`
19. `docs/projects/standards/index.md`

---

## 6. 현재까지 완료된 것

- 루트 `README.md` 방향 재정리
- 루트 `AGENTS.md` 를 저장소 전체 공통 헌법 문서로 재정리
- `docs/specdrive/AGENTS.md` 를 specdrive 전용 규칙 문서로 재정리
- `docs/projects/board/AGENTS.md` 를 board 전용 규칙 문서로 재정리
- specdrive를 SaaS보다 **엔진 / 운영체계 / CLI 중심 도구**로 보는 방향 정리
- projects를 **실제 애플리케이션 개발 스펙 문서 작업공간**으로 보는 방향 정리
- board를 specdrive 하위 기능이 아니라 **첫 번째 실제 애플리케이션 프로젝트**로 보는 방향 정리
- standards를 projects 하위 공통 개발 기준 문서군으로 유지하는 방향 정리
- `doc` / `dev` 2단계 구분 방향 정리
- `session` 을 별도 운영 단계로 추가하는 방향 정리
- 현재는 **Codex 중심 + PowerShell CLI**로 최소 흐름을 검증한다는 방향 정리
- README / AGENTS / AI_CONTEXT를 먼저 만든 뒤 이 문서들로 CLI 테스트를 진행하는 흐름 정리
- `specdrive/{scripts,skills,config}` 폴더 구조 고정
- `doc reinforce / confirm / history-save` 흐름 문서 초안 작성
- `specdrive/scripts/doc/*.ps1`, `specdrive/scripts/exec/codex-exec.ps1`, `specdrive/scripts/common/specdrive-common.ps1` 최소 골격 작성
- `specdrive/skills/doc/*.md`, `specdrive/config/*.json` 최소 자산 작성
- `.speclab/review-output`, `.speclab/history-output` preview 출력 흐름 검증
- `.speclab/**` 를 재생성 가능한 실행 산출물로 보고 필요 시 정리 가능한 대상으로 유지
- `target-registry / skill-registry / context-set-registry / doc-action-registry` 기준 key routing 초안 반영
- `doc confirm`, `doc history-save` 에서 preview 탐색 규칙을 action config 우선, output policy fallback 구조로 해석하도록 최소 rule/config 분리 반영
- `doc` 단계 기본 target 해석을 `target-registry.json` 우선, legacy target config fallback 구조로 정리 시작
- `doc-action-registry.json` 에 execute 허용 여부와 일부 execute 선행조건을 올리는 최소 실행 규칙 분리 시작
- `doc-action-registry.json` 에 preview prefix / history suffix 일부를 올리는 최소 artifact naming 규칙 분리 시작
- `docs/specdrive/**` 주요 문서를 현재 registry 기준과 legacy fallback 상태에 맞춰 동기화
- `docs/specdrive/cli-single-entry.md` 로 `specdrive/specdrive.ps1` 단일 진입점 최소 설계 방향 정리
- `specdrive/specdrive.ps1` 에 `doc`, `session` 최소 라우팅 추가
- `specdrive/scripts/session/*.ps1` 최소 preview 스크립트 추가
- `specdrive/specdrive.ps1` 에 `git` 최소 라우팅 추가
- `specdrive/scripts/git/*.ps1` 최소 preview 스크립트 추가
- `docs/specdrive/cli-manual.md` 에 실제 `specdrive/specdrive.ps1`, `session` 사용 예시 반영
- `session start / status / save` 출력이 긴 파일 목록보다 현재 상태 서술, 변경 수, 변경 영역, 변경 파일 샘플 중심이 되도록 정리
- `git branch-name / git-message / pr-message` 출력이 Git 정책을 참고하면서도 기본적으로 변경 요약과 샘플만 출력하도록 정리
- `specdrive/scripts/util/context-bundle.ps1`, `project-tree.ps1`, `doc-tree.ps1` 유틸 스크립트 추가
- `specdrive/config/context-bundle-map.json`, `doc-map.json`, `affected-docs-map.json` draft 설정 추가
- `doc reinforce` 에 한해 `specdrive/scripts/exec/codex-exec.ps1` 를 실제 `codex exec` 로 좁게 연결
- `docs/projects/board/01-overview.md` 기준으로 `reinforce / confirm / history-save` 1차 흐름 검증 수행
- 현재 확인된 실행 환경 기준으로 `codex-cli 0.121.0` 버전을 기록

---

## 7. 현재 결정된 사항

- `specdrive`는 개발 스펙 문서를 기반으로 AI 협업을 실행하는 도구로 본다.
- 현재 specdrive는 SaaS 외형보다 **엔진 / 운영체계 / CLI 흐름 검증**을 우선한다.
- `projects`는 실제 애플리케이션의 개발 스펙 문서 작업공간으로 본다.
- `board`는 specdrive의 하위 기능이 아니라 첫 번째 실제 애플리케이션 프로젝트 문서군으로 본다.
- `standards`는 `projects` 하위의 공통 개발 기준 문서군으로 본다.
- 현재는 검증을 위해 `specdrive`와 `projects`를 한 저장소 안에서 함께 운영한다.
- 다만 장기적으로는 `specdrive`와 `projects`가 분리 가능한 구조를 지향한다.
- 루트 `AGENTS.md` 는 저장소 전체 공통 작업 기준 문서(공통 헌법)로 둔다.
- `docs/specdrive/AGENTS.md` 는 specdrive 자체 운영 규칙을 다룬다.
- `docs/projects/board/AGENTS.md` 는 board 애플리케이션 문서군의 전용 규칙을 다룬다.
- 현재는 README / AGENTS / AI_CONTEXT를 먼저 정비한 뒤 이 문서들로 CLI 흐름을 검증한다.
- 현재 작업 단계는 구조적으로 핵심 작업 단계 `doc`, `dev`, 별도 운영 단계 `session`, 전달 단계 `git` 으로 정리한다.
- 문서 단계 핵심 흐름은 `reinforce / confirm / history-save` 다.
- 개발 단계 핵심 흐름은 `task-split / phase / cycle / status` 다.
- 세션 단계 핵심 흐름은 `start / save` 다.
- Git 단계 핵심 흐름은 `branch-name / git-message / pr-message` 다.
- 현재 AI 엔진 기준은 Codex다.
- 현재 실행 인터페이스 기준은 PowerShell CLI다.
- 현재는 멀티 AI 엔진 지원을 우선하지 않는다.
- 현재 테스트 대상 문서는 `docs/projects/board/01-overview.md` 다.
- 현재 `doc` 단계는 preview 출력까지 검증된 상태다.
- 현재 `doc` 단계 테스트는 `docs/projects/board/01-overview.md` 문서를 기준으로 `reinforce / confirm / history-save` 흐름을 반복 검증하는 방식으로 진행한다.
- 현재 `01-overview.md` 기준으로 `reinforce / confirm / history-save` 가 각각 보강 초안 / 사람 검토 / 기록 후보 생성 단계로 분리되어 동작하는지 확인하는 것이 우선이다.
- 현재 `doc` 단계의 주 config 경로는 `target / skill / context-set / action` registry 구조다.
- 현재는 rule layer 를 별도 폴더로 크게 도입하지 않고, `config` 를 최소 rule/config layer 로 확장하는 방향을 택한다.
- 현재 기본 target 은 action별 legacy config 보다 `target-registry.json` 의 공통 `default_target` 을 우선 해석한다.
- 현재 action 실행 조건 중 일부는 `doc-action-registry.json` 에서 읽고, 스크립트는 이를 검사하는 방향으로 옮기기 시작했다.
- 현재 artifact naming 규칙 중 일부는 `doc-action-registry.json` 에서 읽고, 스크립트는 이를 소비하는 방향으로 옮기기 시작했다.
- `doc-reinforce-targets.json`, `doc-confirm-targets.json`, `doc-history-targets.json` 는 현재 기준으로 주로 `default_target` fallback 용 legacy config 로 남아 있다.
- 현재 `specdrive/specdrive.ps1` 는 `doc`, `session`, `git` 상위 라우팅을 지원한다.
- 현재 `session` 단계는 `start / status / save` 를 콘솔 출력 중심으로 실행하며, `status` 는 `docs/AI_CONTEXT.md` 기준의 서술형 현재 상태 조회로 본다.
- 현재 `git` 단계는 `branch-name / git-message / pr-message` 를 콘솔 출력 중심으로 실행하며, 기본 출력은 변경 수, 변경 영역, 변경 파일 샘플로 제한한다.
- 현재 util 스크립트는 상위 CLI 라우팅에 연결하지 않고 직접 실행하며, 출력은 `.speclab/**` 아래 재생성 가능한 산출물로 둔다.
- 현재 `context-bundle-map.json` 은 ChatGPT 업로드용 문서 묶음 설정, `doc-map.json` 은 문서 인벤토리 draft, `affected-docs-map.json` 은 문서 영향 관계 draft 로 분리한다.
- 현재 `codex exec` 래퍼는 preview 생성 중심을 유지하되, `doc reinforce` 에 한해 실제 Codex 실행을 좁게 연결한다.
- 원래 의도한 `doc` 단계의 목적은 preview 파일을 쌓는 것이 아니라, 의미 있는 문서 작업이 발생할 때 SI 프로젝트의 문서대장처럼 실제 문서 이력을 남기는 것이다.
- 현재 기준에서 `confirm -Execute` 는 Codex가 보강한 문서를 실제 `docs/projects/**` 대상 문서에 반영하고, 적용 근거와 snapshot 을 `docs/history/projects/**` 아래 남기는 실행 경로로 본다.
- 현재 기준에서 `history-save -Execute` 는 프롬프트 대화 기반 수정이나 사람이 직접 반영한 현재 문서 상태를 `docs/history/projects/**` 아래 snapshot 과 note 로 남기는 실행 경로로 본다.
- 현재는 `dev` 단계 설계보다 **문서 정체성과 `doc` 단계 검증 안정화**가 우선이다.
- 현재 `dev` 단계 테스트는 아직 시작하지 않으며, 실제 코딩 작업에 들어갈 때 검증을 시작한다.

---

## 8. 현재 보류 사항

다음 항목은 현재 보류 또는 후속 판단 대상이다.

- `docs/projects/standards/index.md` 와 `phase1-standards-checklist.md` 정합성 최종 점검
- board 하위 상세 요구사항 문서 구조 확정
- board 하위 설계 문서 구조 확정
- board 하위 구현 계획 문서 구조 확정
- CLI 세부 명령 문법 확정
- `specdrive/specdrive.ps1` 에 `dev` 단계 상위 라우팅 추가 여부 판단
- `git branch-name` 에 phase / cycle / 문서 읽기 연결 범위 확정
- skill 상세 구조 일반화 여부 판단
- `doc reinforce` 외 단계까지 `codex exec` 실제 실행 연동 범위 확정
- `01-overview.md` 기준 `doc reinforce / confirm / history-save` 완료 판정 기준 확정
- `doc reinforce / confirm / history-save` 반복 테스트와 출력 품질 검증
- `docs/history/projects/**` 폴더 구조와 문서대장 운영 규칙 고정
- `doc reinforce -Execute` 실행 시 Codex 환경 경고 처리 기준 확정
- `dev phase / cycle / status / task-split` 실제 흐름 검증
- 장기적으로 specdrive와 projects 분리 시 저장소 구조 구체화
- Go 또는 Python 재구현 시점 판단

---

## 9. 영역별 현재 상태

### 9.1 공통
- 루트 `README.md`, 루트 `AGENTS.md`, `docs/AI_CONTEXT.md` 를 중심으로 공통 진입 구조를 다시 고정하는 단계다.
- 공통 / 도구 / 애플리케이션 / 표준 문서 구분 원칙은 비교적 선명해진 상태다.

### 9.2 specdrive
- specdrive는 현재 **문서 기반 AI 협업 엔진 / 운영체계 / CLI 도구**로 정리된 상태다.
- `docs/specdrive/AGENTS.md` 는 specdrive 전용 규칙 문서로 재정리된 상태다.
- `docs/specdrive/runtime-structure.md` 로 실행 자산 책임 구조가 정리된 상태다.
- 현재 적용 가능한 범위에서 `config` 를 고정값 + 판단 기준을 담는 최소 rule/config layer 로 해석하기 시작한 상태다.
- `docs/specdrive/doc-reinforce-flow.md`, `doc-confirm-flow.md`, `doc-history-save-flow.md` 로 `doc` 단계 최소 흐름이 정리된 상태다.
- `docs/specdrive/cli-manual.md`, `cli-key-routing.md`, `doc-stage-testing.md` 는 현재 key 기반 registry routing 과 preview 테스트 기준에 맞게 정리된 상태다.
- `docs/specdrive/cli-single-entry.md` 로 단일 진입 상위 라우터 책임과 최소 명령 형태를 정리한 상태다.
- `docs/specdrive/session-stage.md` 로 `session` 단계의 역할과 세션 복구/저장 범위를 정리한 상태다.
- `docs/specdrive/git-stage.md` 로 `git` 단계의 역할과 브랜치/메시지 생성 범위를 정리한 상태다.
- `specdrive/specdrive.ps1` 와 `specdrive/scripts/session/*.ps1` 로 `doc`, `session` 최소 실행 경로가 연결된 상태다.
- `specdrive/specdrive.ps1` 와 `specdrive/scripts/git/*.ps1` 로 `git` 최소 실행 경로가 연결된 상태다.
- `specdrive/scripts/**`, `specdrive/skills/**`, `specdrive/config/**` 아래 최소 검증 골격이 생성된 상태다.
- 현재 `doc` 스크립트는 registry 를 주 경로로 사용하고, legacy action별 target config 는 `default_target` fallback 용으로 일부 남아 있다.
- 현재 `doc confirm`, `doc history-save` 는 preview 탐색 규칙을 action config 와 output policy 조합으로 해석하도록 반영된 상태다.
- 현재 `doc reinforce`, `doc confirm`, `doc history-save` 는 공통 helper 로 기본 target 해석을 공유하도록 반영된 상태다.
- 현재 `doc confirm` 은 `execute_requires` 로 `reinforce_codex_output` 선행조건을 확인하도록 반영된 상태다.
- 현재 `doc confirm`, `doc history-save` 는 preview prefix 와 history suffix 일부를 action config 에서 읽도록 반영된 상태다.
- 현재는 preview 기반 반복 검증을 우선하되, `doc reinforce` 에 한해 실제 Codex 실행까지 좁게 확인하기 시작한 단계다.
- 현재 `01-overview.md` 기준으로 세 단계가 기대한 운영 역할대로 분리되는지 1차 확인을 마친 상태다.
- 현재 `confirm -Execute`, `history-save -Execute` 는 preview 검토를 넘어서 실제 문서 이력을 `docs/history/projects/**` 에 남기는 방향으로 의미를 바꿔 정리한 상태다.

### 9.3 projects
- projects는 “예제 문서 모음”이 아니라 “실제 애플리케이션 개발 스펙 문서 작업공간”으로 정리된 상태다.
- 현재는 specdrive와 함께 검증하는 구조지만, 장기 분리 가능성을 전제로 서술하는 방향이 정리된 상태다.

### 9.4 board
- board는 specdrive의 하위 기능이 아니라 첫 번째 실제 애플리케이션 프로젝트 문서군으로 정리된 상태다.
- `docs/projects/board/AGENTS.md` 는 board 전용 규칙 문서로 재정리된 상태다.
- 아직 board의 상세 요구사항 / 설계 / 구현 계획 문서는 본격 진행 전 단계다.

### 9.5 standards
- `docs/projects/standards/**` 는 projects 하위의 공통 개발 기준 문서군으로 보는 방향이 유지되고 있다.
- 현재는 1차 standards 문서 세트가 작성된 상태이며, `exception-standard.md`, `test-standard.md` 는 2차 문서 후보로 남아 있다.

---

## 10. 다음 세션 시작 시 확인할 것

다음 세션에서는 보통 아래 순서로 확인한다.

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. 현재 작업 대상 영역의 `AGENTS.md`
5. 현재 작업 대상 영역의 `README.md` 또는 관련 진입 문서
6. 현재 수정 또는 작성할 대상 문서
7. 필요 시 `docs/projects/standards/**` 관련 문서

---

## 11. 다음 진입점

현재 기준 다음 진입점 후보는 다음과 같다.

### 우선순위 1
- `docs/projects/board/01-overview.md` 기준 `doc confirm / history-save` 실행 결과와 `docs/history/projects/**` 산출물 묶음이 현재 의도한 문서대장 흐름에 맞는지 최종 점검
- `01-overview.md` 기준 `doc` 단계 테스트 완료 판정 문구 정리
- `history-save` 는 최신 confirm preview 를 기준으로 순차 실행해야 한다는 운영 규칙을 관련 문서에 더 명시할지 판단

### 우선순위 2
- `docs/AI_CONTEXT.md` 와 `docs/specdrive/**` 상태 문서의 최신성 유지
- `session` 단계 출력 형식과 실제 사용감 점검
- `session save` 에 이번 작업의 다음 진입점 후보를 어떻게 남길지 정리

### 우선순위 3
- `specdrive/specdrive.ps1` 에 `dev` 단계 상위 라우팅 추가 여부 판단
- 현재 변경 집합 기준으로 개선한 `git branch-name / git-message / pr-message` 초안이 충분한지 점검
- `doc reinforce -Execute` 실제 사용감 점검
- `codex exec` 실제 실행 연결 범위 확대 여부 판단
- `dev phase / cycle / status / task-split` 흐름은 실제 코딩 시작 시점의 후속 테스트 대상으로 유지

### 우선순위 4
- board 하위 실제 문서 목록 정의
- 요구사항 / 설계 / 구현 계획 문서 최소 세트 정리

---

## 12. 현재 focus

현재 focus는 다음과 같다.

- specdrive를 **도구/엔진/운영체계**로, projects를 **애플리케이션 스펙 작업공간**으로 명확히 분리하는 것
- 현재는 함께 검증하지만 장기적으로 분리 가능한 구조를 전제로 문서 서술을 고정하는 것
- README / AGENTS / AI_CONTEXT를 통해 새 세션에서 빠르게 복귀 가능한 문서 체계를 만드는 것
- `doc` 단계의 최소 흐름을 preview 출력까지 반복 가능하게 유지하는 것
- `docs/specdrive` 문서가 실제 registry 기반 라우팅 상태를 정확히 설명하도록 유지하는 것
- `specdrive/specdrive.ps1` 단일 진입점이 생기더라도 하위 스크립트 책임 경계가 무너지지 않게 하는 것
- `session` 단계가 `doc` / `dev` 를 침범하지 않고 세션 운영 보조로만 유지되게 하는 것
- `git` 단계가 브랜치/메시지 생성에 집중하고 `session` 과 섞이지 않게 유지하는 것
- `doc` 단계는 `docs/projects/board/01-overview.md` 기준으로 먼저 충분히 테스트하고 완료 기준을 정리하는 것
- 현재 적용한 최소 rule/config 분리 방식을 `dev`, `session`, `git`, 후속 project 문서 흐름에도 점진 적용 가능한지 확인하는 것
- 현재 실행까지 끝낸 `confirm / history-save` 결과와 실제 history 산출물 묶음이 다음 세션에서도 이해 가능한지 확인하는 것
- `dev` 단계는 아직 본격 설계/테스트하지 않고 실제 코딩 작업이 시작될 때 검증하는 것

---

## 13. 작업 시 확인 원칙

현재 단계에서는 다음을 계속 확인한다.

- 이 문서가 공통 운영 문서인가?
- 이 문서가 specdrive 도구 문서인가?
- 이 문서가 projects 애플리케이션 문서인가?
- 이 문서가 `docs/projects/standards/**` 아래에 있어야 하는 프로젝트 공통 표준 문서인가?
- 이 내용이 README에 있어야 하는가, AGENTS에 있어야 하는가, AI_CONTEXT에 있어야 하는가?
- 현재 결정과 후속 후보가 섞이지 않았는가?
- 지금 함께 운영하는 구조가 최종 구조로 오해되지 않도록 서술하고 있는가?
- `doc` / `dev` 단계가 문서에서 섞이지 않았는가?

---

## 14. 마지막 갱신 기준

- 마지막 갱신 일시: 2026-04-22
- 마지막으로 반영한 주요 변경:
  - 루트 README / 루트 AGENTS / specdrive 전용 AGENTS / board 전용 AGENTS 재정리
  - specdrive를 엔진 / 운영체계 / CLI 중심 도구로 재정의
  - board를 첫 번째 실제 애플리케이션 프로젝트로 재정의
- 제품명을 `butgo-specdrive` 로, GitHub 저장소명을 `butgo-specdrive-lab` 으로 변경하는 방향 반영
- 현재 기준 문서와 실행 자산 경로를 `docs/specdrive/**`, `specdrive/**`, `specdrive/specdrive.ps1` 로 정리
- 과거 실행 이력인 `docs/history/**` 산출물은 당시 경로와 명칭을 보존하는 이력 문서로 유지
- `doc` / `dev` 흐름 구분 반영
- `session` 단계를 별도 운영 단계로 문서 반영
- `git` 단계를 별도 전달 단계로 문서 반영
- `specdrive/{scripts,skills,config}` 구조 반영
- `doc reinforce / confirm / history-save` 흐름 문서 및 최소 스크립트 골격 반영
- `target / skill / context-set` registry 초안 반영 및 `doc` 스크립트 연동 시작
- `codex-exec.ps1` 의 `-TargetKey` 기반 preview 테스트 경로 반영
- `docs/specdrive/runtime-structure.md`, `doc-stage-testing.md`, `cli-manual.md`, `cli-key-routing.md` 최신 상태 반영
- `docs/specdrive/doc-reinforce-flow.md`, `doc-confirm-flow.md`, `doc-history-save-flow.md` 를 현재 registry 기준으로 정리
- legacy `doc-*-targets.json` 이 현재는 `default_target` fallback 용 호환 레이어라는 점 반영
- `docs/specdrive/cli-single-entry.md` 로 `specdrive/specdrive.ps1` 단일 진입점 최소 설계 문서 추가
- `docs/specdrive/session-stage.md` 로 `session` 단계 문서 추가
- `docs/specdrive/git-stage.md` 로 `git` 단계 문서 추가
- `specdrive/specdrive.ps1` 와 `specdrive/scripts/session/*.ps1` 최소 구현 반영
- `specdrive/specdrive.ps1` 와 `specdrive/scripts/git/*.ps1` 최소 구현 반영
- `docs/specdrive/cli-manual.md` 에 단일 진입점 및 session 명령 예시 반영
- `doc reinforce` 에 한해 `codex exec` 실제 호출 경로를 좁게 연결
- README / AGENTS / AI_CONTEXT를 먼저 정비한 뒤 CLI 테스트를 진행하는 방향 반영
- standards 1차 문서 세트와 후속 2차 문서 후보 상태 반영
- `doc` 단계 기본 target, preview 탐색 규칙, execute 조건, artifact naming 일부를 config 중심으로 이동
- `docs/projects/board/01-overview.md` 에 `confirm -Execute` 적용 및 관련 근거/history 산출물 저장
- `history-save -Execute` 를 최신 confirm preview 기준으로 다시 실행해 실제 history 산출물 묶음 정리
- 현재 변경 집합에 맞게 `git branch-name / git-message / pr-message` 초안 생성 로직 보정
- `session status` 를 파일 변경 상태가 아니라 `docs/AI_CONTEXT.md` 기반 서술형 상태 조회 명령으로 추가
- session/git 명령의 기본 출력은 토큰 사용량을 줄이기 위해 상세 파일 목록 대신 변경 요약과 샘플을 우선하도록 정리
- ChatGPT 업로드 편의를 위해 `context-bundle-map.json` 기반 bundle key 선택 방식과 번호 선택 메뉴를 추가
- `readme-ko-all`, `readme-en-all`, `readme-all`, `agents-all`, `onboarding-all` bundle key 를 추가
- `doc-map.json`, `affected-docs-map.json` draft 설정은 아직 기본 스크립트 동작에는 연결하지 않고 후속 검토 대상으로 유지
- 현재 기준 작업자 메모:
  - 지금은 `doc` 단계 흐름을 더 만들어내기보다 실제 반복 테스트를 통해 어색한 지점을 찾는 것이 중요하다.
  - 새 세션에서는 먼저 이 문서와 `docs/specdrive/doc-stage-testing.md` 에서 현재 테스트 상태를 복구한 뒤 작업 대상 문서로 들어간다.
  - 현재 `doc` 단계는 `docs/projects/board/01-overview.md` 를 대상으로 `reinforce / confirm / history-save` 를 테스트한다.
  - `docs/projects/board/01-overview.md` 기준으로 `reinforce / confirm / history-save` preview 생성이 실제로 정상 동작하는 것을 확인했다.
  - `01-overview.md` 기준으로 `reinforce` 는 보강 초안, `confirm` 은 사람 검토 체크리스트, `history-save` 는 기록 후보 생성 단계로 분리되어 동작하는 것을 1차 확인했다.
  - 이후 원래 의도했던 문서 이력 자동 저장 목적에 맞게 `confirm -Execute`, `history-save -Execute` 를 `docs/history/projects/**` 에 실제 적용 문서와 관련 산출물을 남기는 실행 경로로 확장했다.
  - `confirm` 과 `history-save` 는 병렬보다 순차 실행이 맞고, 최신 confirm preview 를 기준으로 history preview 를 생성해야 한다.
  - 이번 세션에서는 `docs/projects/board/01-overview.md` 에 실제 `confirm -Execute` 를 적용했고, `history-save -Execute` 는 최신 confirm preview 기준으로 다시 실행해 산출물을 정리했다.
  - 현재 `docs/history/projects/board/01-overview/**` 아래에는 2026-04-19 00:01:55, 00:02:07 기준 confirm/history 산출물이 추가된 상태다.
  - `specdrive/config/target-registry.json`, `skill-registry.json`, `context-set-registry.json`, `doc-action-registry.json` 초안을 만들었고 `reinforce / confirm / history-save` 는 이 registry 를 주 경로로 읽도록 연결했다.
  - 현재 `doc-action-registry.json` 은 execute 허용 여부, 일부 execute 선행조건, preview prefix, history suffix 일부를 담는 최소 rule/config layer 역할을 시작했다.
  - `doc-reinforce-targets.json`, `doc-confirm-targets.json`, `doc-history-targets.json` 는 현재 `default_target` fallback 용 legacy config 로 남아 있다.
  - `specdrive/scripts/exec/codex-exec.ps1` 는 `-TargetKey board-overview` 로 registry 기반 preview 테스트가 가능하고, `doc reinforce -Execute` 에서 실제 Codex 호출도 좁게 수행할 수 있다.
  - 현재 확인한 Codex CLI 버전은 `codex-cli 0.121.0` 이고, 이후 버전이 올라가면 PowerShell/plugin 경고 양상이 달라지는지 재검증할 필요가 있다.
  - `specdrive/specdrive.ps1` 는 상위 라우터로만 두고 실제 업무 로직은 계속 하위 스크립트에 두는 방향이 현재 기준에 맞다.
  - `session` 단계는 `doc` / `dev` 와 다른 메타 운영 단계로 두고 `start`, `status`, `save` 를 담당하는 방향이 현재 기준에 맞다.
  - `git` 단계는 브랜치명, commit message, PR 메시지 생성을 담당하는 방향이 현재 기준에 맞다.
  - 현재 `specdrive/specdrive.ps1` 는 `doc`, `session`, `git` 최소 라우팅을 수행할 수 있다.
  - `context-bundle.ps1` 는 그냥 실행하면 bundle key 번호 선택 메뉴를 보여주고, 비대화식 실행은 `-BundleKey` 로 유지한다.
  - 실제 Codex 실행 시에는 non-zero exit code 가 나와도 `output-last-message` 파일에 본문이 남을 수 있으므로 preview 파일과 output 파일을 함께 확인하는 편이 안전하다.
  - 다음 선택지는 `01-overview.md` 기준 테스트 완료 판정을 먼저 정리할지, `session save` 에 다음 진입점을 어떻게 남길지 정리할지, 또는 `doc reinforce -Execute` 사용감을 더 검증할지 판단하는 것이다.
  - `dev` 단계는 board 문서 세트가 더 쌓이고 실제 프로그램 작업에 들어갈 시점에 시작한다.

---

## 15. 최종 정리

이 문서는 현재 저장소의 **작업 상태 복구 문서**다.

즉, 이 문서는 다음 질문에 빠르게 답하기 위해 존재한다.

- 지금 무엇을 하고 있는가?
- specdrive와 projects를 어떤 관계로 보고 있는가?
- 현재 왜 한 저장소 안에서 함께 운영하고 있는가?
- 현재 왜 README / AGENTS / AI_CONTEXT를 먼저 고정하고 있는가?
- 현재 `doc` / `dev` 흐름을 어떻게 보고 있는가?
- 다음에 어디서 다시 시작해야 하는가?

구조 문서는 `README.md` 와 `AGENTS.md` 가 담당하고,  
현재 상태 복구는 `docs/AI_CONTEXT.md` 가 담당한다.

