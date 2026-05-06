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

- 현재는 specdrive 자체 문서를 `specdrive/docs/**` 로 분리하고, board 문서 구조를 `01-overview.md / specs / work / rules / status / manual` 기준으로 재정리하면서 `doc` / `session` / `git` / work system 흐름을 skill 중심으로 다시 검증하는 작업을 진행 중이다.

현재 전체 개념에서 특히 중요한 점은, specdrive를 `.speclab` preview 생성 도구로 이해하지 않는 것이다.  
현재 기준으로 specdrive는 project 문서를 읽고 AI 협업 흐름을 실행한 뒤, 의미 있는 변경을 실제 문서와 `docs/history/projects/**` 문서 이력으로 정착시키는 운영체계로 이해하는 편이 맞다.

---

## 3. 현재 작업 모드

- 문서 정체성 재정리
- 문서 계층 분리
- README / AGENTS / AI_CONTEXT 우선 정비
- specdrive / projects / board / standards 역할 구분 정리
- specdrive 자체 문서는 `specdrive/docs/**`, 실제 프로젝트 문서는 `docs/projects/**` 로 분리
- `doc` / `dev` 단계 분리 정리
- `session` 단계 분리 정리
- `git` 단계 분리 정리
- Codex 중심 skill 절차 검증
- 현재 버전에서는 CLI를 기준 흐름에서 제외하고 skill 직접 사용을 우선
- key 기반 registry routing 문서/스크립트 정합성 정리

현재는 실제 제품 구현보다  
**엔진/운영체계 문서와 애플리케이션 문서의 경계를 고정한 뒤, `doc` 단계 흐름을 반복 가능한 최소 구조로 검증하는 작업 모드**에 가깝다.

---

## 4. 현재 활성 범위

현재 활성 범위는 다음과 같다.

- 루트 `README.md` 정리
- 루트 `AGENTS.md` 정리
- `docs/AI_CONTEXT.md` 정리
- `specdrive/docs/AGENTS.md` 정리
- `docs/projects/board/AGENTS.md` 정리
- `specdrive/docs/work-system.md` 기준 work 체계 정리
- specdrive / projects / board / standards 정의 고정
- `doc` / `dev` / `session` / `git` 작업 단계 구분 고정
- Codex가 프로젝트 성격을 안정적으로 이해할 수 있도록 진입 문서 정비
- `specdrive/{scripts,skills,config}` 구조 고정
- `doc draft-save / reinforce-prompt / reinforce / confirm-prompt / apply-prompt / apply-only-prompt` 최소 흐름 문서화
- `doc` 단계의 prompt-first 해석과 apply 중심 반영 경로 재정리
- `target / skill / context-set / action` registry 기준 설명 정리
- action registry / output policy 를 활용한 최소 rule/config 분리 적용 시작
- PowerShell 스크립트 기반 preview 출력 검증
- board `01-overview.md` 를 첫 테스트 문서로 사용한 흐름 검증
- `01-overview.md` 기준 `reinforce / confirm-prompt / apply-prompt` 역할 분리 테스트 정리
- `draft-save -> reinforce-prompt -> apply-prompt` 수동 보강 루프 정리
- 의미 있는 문서 변경을 `docs/history/projects/**` 에 실제 이력으로 남기는 흐름 정리
- 현재 기준 문서/스크립트 정리 시 `docs/history/**` 는 기본 관리 대상에서 제외하고 보존 이력로만 취급

현재 범위에 포함하지 않는 것은 다음과 같다.

- board의 상세 요구사항 본문 확정
- board의 상세 API / DB / 패키지 설계 본문 확정
- board work roadmap/index/log 본문 확정
- specdrive CLI 실제 제품화 착수는 현재 버전 범위에서 제외
- skill 상세 구조의 일반화/추상화
- `codex exec` 실제 실행 연동 전면 확대
- 모바일 앱 구조 본격 착수
- standards 2차 문서 전체 작성
- phase / cycle 기반 실제 구현 운영의 본격 재도입
- 개발자 명시 요청 없는 `docs/history/**` 재검토, 재정리, 명칭 정비

---

## 5. 현재 기준 핵심 문서

현재 세션에서 우선 확인할 문서는 다음과 같다.

1. `README.md`
2. `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `specdrive/docs/AGENTS.md`
5. `specdrive/docs/runtime-structure.md`
6. `specdrive/docs/skill-wizard-manual.md`
7. `specdrive/docs/doc-stage-testing.md`
8. `specdrive/docs/stages/session-stage.md`
9. `specdrive/docs/stages/git-stage.md`

필요 시 다음 문서를 후속 참조한다.

10. `docs/projects/board/AGENTS.md`
11. `specdrive/docs/flows/doc-reinforce-flow.md`
12. `specdrive/docs/flows/doc-confirm-flow.md`
13. `specdrive/docs/flows/doc-history-save-flow.md`
14. `docs/README.md`
15. `specdrive/docs/README.md`
16. `docs/projects/README.md`
17. `docs/projects/standards/index.md`
18. `docs/projects/board/index.md`
19. `docs/projects/board/01-overview.md`
20. `docs/projects/board/specs/02-requirements.md`
21. `docs/projects/board/specs/03-design.md`

---

## 6. 현재까지 완료된 것

- 루트 `README.md` 방향 재정리
- 루트 `AGENTS.md` 를 저장소 전체 공통 헌법 문서로 재정리
- `specdrive/docs/AGENTS.md` 를 specdrive 전용 규칙 문서로 재정리
- `docs/projects/board/AGENTS.md` 를 board 전용 규칙 문서로 재정리
- specdrive를 SaaS보다 **엔진 / 운영체계 / skill 중심 도구**로 보는 방향 정리
- projects를 **실제 애플리케이션 개발 스펙 문서 작업공간**으로 보는 방향 정리
- board를 specdrive 하위 기능이 아니라 **첫 번째 실제 애플리케이션 프로젝트**로 보는 방향 정리
- standards를 projects 하위 공통 개발 기준 문서군으로 유지하는 방향 정리
- `doc` / `dev` 2단계 구분 방향 정리
- `session` 을 별도 운영 단계로 추가하는 방향 정리
- 현재는 **Codex 중심 + repo-local skill 직접 사용**으로 최소 흐름을 검증한다는 방향 정리
- README / AGENTS / AI_CONTEXT를 먼저 만든 뒤 이 문서들로 skill 테스트를 진행하는 흐름 정리
- `specdrive/{scripts,skills,config}` 폴더 구조 고정
- `doc reinforce / confirm-prompt / apply-prompt` 흐름 문서 초안 작성
- `specdrive/scripts/doc/*.ps1`, `specdrive/scripts/exec/codex-exec.ps1`, `specdrive/scripts/common/specdrive-common.ps1` 최소 골격 작성
- `specdrive/skills/doc/*.md`, `specdrive/config/*.json` 최소 자산 작성
- `.speclab/review-output`, `.speclab/history-output` preview 출력 흐름 검증
- `.speclab/**` 를 재생성 가능한 실행 산출물로 보고 필요 시 정리 가능한 대상으로 유지
- `target-registry / skill-registry / context-set-registry / doc-action-registry` 기준 key routing 초안 반영
- `doc confirm-prompt`, `doc apply-prompt` 에서 preview 탐색 규칙을 action config 우선, output policy fallback 구조로 해석하도록 최소 rule/config 분리 반영
- `doc` 단계 기본 target 해석을 `target-registry.json` 우선, legacy target config fallback 구조로 정리 시작
- `doc-action-registry.json` 에 execute 허용 여부와 일부 execute 선행조건을 올리는 최소 실행 규칙 분리 시작
- `doc-action-registry.json` 에 preview prefix / history suffix 일부를 올리는 최소 artifact naming 규칙 분리 시작
- `specdrive/docs/**` 주요 문서를 현재 registry 기준과 legacy fallback 상태에 맞춰 동기화
- 과거 단일 진입점 CLI 라우터와 명령 예시는 현재 기준에서 제거
- `specdrive/scripts/session/*.ps1` 최소 preview 스크립트 추가
- 과거 `git` 최소 라우팅 검증 결과는 후속 후보로 보류
- `specdrive/scripts/git/*.ps1` 최소 preview 스크립트 추가
- 과거 session/git CLI 출력 검증 결과는 현재 기준 흐름이 아니라 후속 후보 이력으로 보류
- 복구 중 Git safe.directory 및 변경 경로 null 처리 문제를 확인하고, `specdrive/scripts/common/specdrive-common.ps1` 에 최소 보정 반영
- `specdrive/scripts/util/context-bundle.ps1`, `project-tree.ps1`, `doc-tree.ps1` 유틸 스크립트 추가
- `specdrive/config/context-bundle-map.json`, `doc-map.json`, `affected-docs-map.json` draft 설정 추가
- `doc reinforce` 에 한해 `specdrive/scripts/exec/codex-exec.ps1` 를 실제 `codex exec` 로 좁게 연결
- `docs/projects/board/01-overview.md` 기준으로 `reinforce / confirm-prompt / apply-prompt` 1차 흐름 검증 수행
- `specdrive/docs/doc-stage-testing.md` 에 `docs/projects/board/01-overview.md` 기준 `doc` 단계 1차 완료 판정 반영
- `specdrive/scripts/common/specdrive-common.ps1`, `docs/AI_CONTEXT.md`, `specdrive/docs/doc-stage-testing.md` 변경을 `spec(specdrive): stabilize session recovery status` 커밋으로 저장
- board 문서 구조를 `01-overview.md / specs / impl / status` 기준으로 재정리 시작
- `docs/projects/board/specs/04-application-structure.md`, `05-domain-model.md`, `06-api-spec.md`, `07-db-design.md`, `impl/01-implementation-plan.md`, `status/current-status.md` 파일 골격 추가
- `docs/projects/board/index.md`, `docs/projects/board/README.md`, `docs/projects/board/specs/02-requirements.md`, `docs/projects/board/specs/03-design.md` 를 새 구조와 참조 경로에 맞게 정리
- 루트 `AGENTS.md`, `docs/projects/board/AGENTS.md`, `specdrive/docs/stages/session-stage.md`, `specdrive/scripts/session/start.ps1` 에 신규 문서 생성 / 문서 역할 변경 / 단계 전환 전 개발자 확인 규칙을 명시
- `docs/projects/board/03-design.md`, `docs/projects/board/index.md`, `AGENTS.md`, `docs/projects/board/AGENTS.md`, `specdrive/docs/stages/session-stage.md`, `specdrive/scripts/session/start.ps1`, `docs/AI_CONTEXT.md` 변경을 `docs(board): add board design draft and session guardrails` 커밋으로 저장
- 과거 CLI 실행 환경 확인 결과는 현재 기준 경로에서 제외하고 후속 검토 메모로 보류
- `specdrive/config/target-registry.json`, `doc-map.json`, `affected-docs-map.json` 에 새 board 문서 타깃 추가
- 과거 `doc draft-save`, `doc reinforce-prompt` 라우팅 검증 결과는 후속 후보로 보류
- `specdrive/scripts/doc/draft-save.ps1`, `reinforce-prompt.ps1` 추가
- `specdrive/scripts/doc/confirm-prompt.ps1`, `apply-prompt.ps1`, `apply-only-prompt.ps1` 추가
- `README.md`, `specdrive/docs/README.md`, `specdrive/docs/README.ko.md`, `specdrive/docs/flows/doc-reinforce-flow.md`, `specdrive/docs/doc-stage-testing.md` 를 새 `doc` 루프 의도에 맞게 정리
- `specdrive/scripts/session/save.ps1` 를 출력 전용으로 유지하면서 `docs/AI_CONTEXT.md` 반영용 세션 저장 초안 프롬프트를 출력하도록 정리
- `specdrive/scripts/session/start.ps1`, `status.ps1`, `save.ps1` 와 관련 문서를 함께 정리해 `session` 3종의 역할을 현재 기준으로 맞춤
- `specdrive/docs/index.md`, `specdrive/docs/AGENTS.md` 까지 포함해 session skill 해석을 문서 전반에 동기화
- `butgo-specdrive-lab.code-workspace` 멀티루트 workspace 설정 추가
- `$session start` 는 경량 복구, `$session start-full` 은 full recovery copy prompt 를 보여주는 흐름으로 정리
- `$session`, `specdrive-skills` repo-local Codex skill 을 `.agents/skills/**` 아래에 유지하고 Git 관련 skill은 삭제
- 배포/패키징 후보 원본을 `specdrive/codex-skills/**` 아래에 두는 방향으로 정리
- Git 관련 skill은 토큰 절감을 위해 현재 repo-local skill 대상에서 제외
- repo-local Codex skill 흐름 관련 변경을 `feat(specdrive): add repo-local codex skills workflow`, `docs(skill): add push prompt to git commit skill` 커밋으로 저장하고 원격 브랜치에 push

---

## 7. 현재 결정된 사항

- `specdrive`는 개발 스펙 문서를 기반으로 AI 협업을 실행하는 도구로 본다.
- 현재 specdrive는 SaaS 외형보다 **엔진 / 운영체계 / skill 흐름 검증**을 우선한다.
- `projects`는 실제 애플리케이션의 개발 스펙 문서 작업공간으로 본다.
- `board`는 specdrive의 하위 기능이 아니라 첫 번째 실제 애플리케이션 프로젝트 문서군으로 본다.
- `standards`는 `projects` 하위의 공통 개발 기준 문서군으로 본다.
- 현재는 검증을 위해 `specdrive`와 `projects`를 한 저장소 안에서 함께 운영한다.
- 다만 장기적으로는 `specdrive`와 `projects`가 분리 가능한 구조를 지향한다.
- 루트 `AGENTS.md` 는 저장소 전체 공통 작업 기준 문서(공통 헌법)로 둔다.
- `specdrive/docs/AGENTS.md` 는 specdrive 자체 운영 규칙을 다룬다.
- `docs/projects/board/AGENTS.md` 는 board 애플리케이션 문서군의 전용 규칙을 다룬다.
- 현재는 README / AGENTS / AI_CONTEXT를 먼저 정비한 뒤 이 문서들로 skill 흐름을 검증한다.
- 현재 작업 단계는 구조적으로 핵심 작업 단계 `doc`, `plan`, `dev`, 별도 운영 단계 `session`, 전달 단계 `git` 으로 정리한다.
- 문서 단계 핵심 흐름은 현재 기준 `draft-save / reinforce-prompt / reinforce / confirm-prompt / apply-prompt / apply-only-prompt` 로 정리한다.
- 현재 `doc` 단계는 execute-first 보다 prompt-first 해석을 우선하고, 정식 반영은 가능한 한 `apply-prompt` 중심으로 본다.
- plan 단계 핵심 흐름은 `$plan extract-candidates / phase-split / cycle-split / task-split / wp` 다.
- 현재 `$plan extract-candidates` 는 개발 문서에서 작업 후보를 생성하는 plan action 으로 정리했고, Project Name은 `docs/projects/{project}` 의 `{project}` key로 본다.
- 현재 plan Project Name, Source Scope, extract-candidates 문서 묶음, history 규칙은 `specdrive/config/project-registry.json` 을 기준으로 해석한다.
- 현재 board의 `extract-candidates` 기본 Source Scope는 `all` 이며, `docs/history/**` 는 명시 요청 없이는 조회하지 않는다.
- 현재 `Impact Area` 는 Java 멀티모듈의 module만 뜻하지 않고, 단일 모듈, CLI, Frontend, Documentation의 layer/package/command/component/document section 같은 넓은 영향 영역 후보를 뜻한다.
- 현재 `Impact Confidence` 는 문서 근거 기반 추정 신뢰도이며, 가능한 경우 `Impact Evidence` 를 함께 남긴다.
- 현재 `$plan extract-candidates generate` 는 개발자가 후보 초안을 직접 작성하지 않아도 기준 문서를 읽어 후보 초안을 생성하는 흐름이고, `apply` 는 개발자 승인 전 자동 반영하지 않는다.
- 현재 plan history 파일명은 plan 디렉토리 자체가 단계를 드러내므로 `plan` prefix 대신 context/action 구분을 사용한다. `extract-candidates` 로 `work-candidates.md` 를 반영할 때는 `yyyy-MM-dd_HHmmss_generate-candidates_extract-candidates.md` 와 `.note.md` 형식을 사용한다.
- 위저드형 skill 출력은 후속작업이 필요할 때만 copy-ready prompt를 출력하고, 후속작업이 없으면 프롬프트를 출력하지 않는다.
- dev 단계 핵심 흐름은 `$dev start / impl-run / test / sync` 다.
- 현재 Work Package는 dev 코딩의 한 묶음으로 정의하며, 완료 시 의미 있는 동작, 구조, 검증 결과 중 하나 이상이 남아야 한다.
- 세션 단계 핵심 흐름은 `$session start / restore / start-full / status / save` 다.
- Git skill은 현재 repo-local skill 대상에서 제외하고, Git 실행은 개발자가 직접 처리한다.
- 현재 AI 엔진 기준은 Codex다.
- 현재 실행 인터페이스 기준은 repo-local Codex skill 직접 사용이다.
- 현재는 멀티 AI 엔진 지원을 우선하지 않는다.
- 현재 테스트 대상 문서는 `docs/projects/board/01-overview.md` 다.
- 현재 `doc` 단계는 preview 출력까지 검증된 상태다.
- 현재 `doc` 단계 테스트는 `docs/projects/board/01-overview.md` 문서를 기준으로 `reinforce / confirm-prompt / apply-prompt` 흐름을 반복 검증하는 방식으로 진행한다.
- 현재 `01-overview.md` 기준으로 `reinforce / confirm-prompt / apply-prompt` 가 각각 보강 초안 / 사람 검토 / 반영+history 초안 단계로 분리되어 동작하는지 확인하는 것이 우선이다.
- 현재 `doc` 단계의 주 config 경로는 `target / skill / context-set / action` registry 구조다.
- 현재는 rule layer 를 별도 폴더로 크게 도입하지 않고, `config` 를 최소 rule/config layer 로 확장하는 방향을 택한다.
- 현재 기본 target 은 action별 legacy config 보다 `target-registry.json` 의 공통 `default_target` 을 우선 해석한다.
- 현재 action 실행 조건 중 일부는 `doc-action-registry.json` 에서 읽고, 스크립트는 이를 검사하는 방향으로 옮기기 시작했다.
- 현재 artifact naming 규칙 중 일부는 `doc-action-registry.json` 에서 읽고, 스크립트는 이를 소비하는 방향으로 옮기기 시작했다.
- `doc-reinforce-targets.json`, `doc-confirm-targets.json`, `doc-history-targets.json` 는 현재 기준으로 주로 `default_target` fallback 용 legacy config 로 남아 있다.
- 현재 버전에서는 단일 진입점 CLI 라우터를 기준 경로에서 제외하고 파일도 제거했다.
- 현재 `session` 단계는 `$session` 라우터와 `start/restore/start-full/status/save` action 직접 사용을 기준으로 검증한다.
- 현재 `$session restore` 는 VSCode/Codex 재시작 뒤 `docs/AI_CONTEXT.compact.md` 기준으로 현재 focus와 다음 진입점을 확인하는 읽기 전용 복구 절차로 본다.
- 현재 `$session start` 는 경량 복구 절차로 보고, 전체 복구용 copy prompt 는 `$session start-full` 로 분리한다.
- 현재 `$session status` 는 `docs/AI_CONTEXT.compact.md` 상태와 다음 진입점을 6줄 내외로 보여주는 Codex 절차로 본다.
- 현재 `$session save` 는 파일 저장이 아니라 `docs/AI_CONTEXT.compact.md` 반영 초안을 먼저 제안하는 Codex 절차로 본다.
- `$session save` 결과는 먼저 사람 검토를 거치고, 개발자가 "저장해줘" 같이 명시적으로 요청한 경우에만 실제 `docs/AI_CONTEXT.compact.md` 수정으로 이어진다.
- 기존 `session start / status / save` CLI는 현재 버전 기준 흐름에서 제외한다.
- 현재 Git skill은 repo-local skill 대상에서 제외한다.
- 현재 `session` 과 Git handoff는 분리하며, Git은 개발자가 직접 처리한다.
- session 흐름은 Git 상태 확인, Git skill 호출, commit/push/PR 프롬프트를 요구하지 않는다.
- Codex는 Git 도움이 필요할 때 사용자가 제공한 요약 범위에서 메시지 초안만 돕는다.
- 현재 테스트 중인 Codex skill 은 전역 설치 없이 repo-local `.agents/skills/**` 에 둔다.
- 현재 배포/패키징 후보 Codex skill 원본은 `specdrive/codex-skills/**` 아래에 둔다.
- 현재 `$specdrive-skills` 는 repo-local specdrive skill 목록을 빠르게 보여주는 안내 skill 로 둔다.
- 현재 Git 관련 skill은 현재 버전 범위에서 제외한다.
- 기존 Git 상태 조회 helper 관련 처리는 보존하되, 현재 session 흐름에서는 Git 상태 확인을 기본 요구하지 않는다.
- 현재 `$session start-full` 은 공통 compact 문서 외에도 작업 대상 영역이 정해지면 해당 영역의 compact/index/대상 문서를 추가로 확인하도록 안내한다.
- 신규 문서 생성, 문서 역할 변경, 요구사항에서 설계 또는 설계에서 구현 계획으로 넘어가는 전환점은 개발자 확인 후 진행하는 규칙으로 명시했다.
- 현재 util 스크립트는 상위 CLI 라우팅에 연결하지 않고 직접 실행하며, 출력은 `.speclab/**` 아래 재생성 가능한 산출물로 둔다.
- 현재 `context-bundle-map.json` 은 ChatGPT 업로드용 문서 묶음 설정, `doc-map.json` 은 문서 인벤토리 draft, `affected-docs-map.json` 은 문서 영향 관계 draft 로 분리한다.
- 현재 `codex exec` 래퍼는 preview 생성 중심을 유지하되, `doc reinforce` 에 한해 실제 Codex 실행을 좁게 연결한다.
- 원래 의도한 `doc` 단계의 목적은 preview 파일을 쌓는 것이 아니라, 의미 있는 문서 작업이 발생할 때 SI 프로젝트의 문서대장처럼 실제 문서 이력을 남기는 것이다.
- 현재 `doc` 단계의 권장 수동 루프는 개발자 초안 작성 -> `draft-save` -> `reinforce-prompt` -> 사람/Codex 보강 대화 -> 검토/승인 -> 필요 시 history 저장 반복으로 본다.
- 현재 기준에서 정식 문서 반영과 history 저장은 `apply-prompt` 중심의 승인 흐름으로 정리한다.
- 현재 기준에서 history note 는 diff 자체보다 Codex가 실제로 어떤 보강과 정리를 수행했는지 요약하는 기록을 우선한다.
- 현재는 `dev` 단계 설계보다 **문서 정체성과 `doc` 단계 검증 안정화**가 우선이다.
- 현재 `dev` 단계 테스트는 아직 시작하지 않으며, 실제 코딩 작업에 들어갈 때 검증을 시작한다.

---

## 8. 현재 보류 사항

다음 항목은 현재 보류 또는 후속 판단 대상이다.

- `docs/projects/standards/index.md` 와 `phase1-standards-checklist.md` 정합성 최종 점검
- board 하위 상세 요구사항 문서 구조 확정
- board 하위 설계 문서 초안 검토 및 확정
- board 하위 구현 계획 문서 구조 확정
- CLI 세부 명령 문법 확정은 현재 버전 범위에서 제외
- `reinforce` 실제 Codex 실행 범위를 현재 수준으로 유지할지 판단
- `apply-only-prompt` 를 어느 정도 예외 경로로 유지할지 판단
- skill 상세 구조 일반화 여부 판단
- `doc reinforce` 외 단계까지 `codex exec` 실제 실행 연동 범위 확정
- `01-overview.md` 기준 `doc reinforce / confirm-prompt / apply-prompt` 완료 판정 기준 확정
- `doc reinforce / confirm-prompt / apply-prompt` 반복 테스트와 출력 품질 검증
- `docs/history/projects/**` 폴더 구조와 문서대장 운영 규칙 고정
- `doc reinforce -Execute` 실행 시 Codex 환경 경고 처리 기준 확정
- GitHub CLI `gh` 기반 PR 자동화 검증
- Codex GitHub plugin 도입 여부 판단. 현재는 필수로 보지 않고 `gh` 기반 흐름을 우선 검토
- `plan extract-candidates / phase-split / cycle-split / task-split / wp` 실제 흐름 검증
- `dev start / impl-run / test / sync` 실제 흐름 검증
- 장기적으로 specdrive와 projects 분리 시 저장소 구조 구체화
- Go 또는 Python 재구현 시점 판단

---

## 9. 영역별 현재 상태

### 9.1 공통
- 루트 `README.md`, 루트 `AGENTS.md`, `docs/AI_CONTEXT.md` 를 중심으로 공통 진입 구조를 다시 고정하는 단계다.
- 공통 / 도구 / 애플리케이션 / 표준 문서 구분 원칙은 비교적 선명해진 상태다.

### 9.2 specdrive
- specdrive는 현재 **문서 기반 AI 협업 엔진 / 운영체계 / skill 중심 도구**로 정리된 상태다.
- `specdrive/docs/AGENTS.md` 는 specdrive 전용 규칙 문서로 재정리된 상태다.
- `specdrive/docs/runtime-structure.md` 로 실행 자산 책임 구조가 정리된 상태다.
- 현재 적용 가능한 범위에서 `config` 를 고정값 + 판단 기준을 담는 최소 rule/config layer 로 해석하기 시작한 상태다.
- `specdrive/docs/flows/doc-reinforce-flow.md`, `flows/doc-confirm-flow.md`, `flows/doc-history-save-flow.md` 로 `doc` 단계 최소 흐름이 정리된 상태다.
- `specdrive/docs/doc-stage-testing.md` 는 현재 key 기반 registry routing 과 preview 테스트 기준에 맞게 정리된 상태다.
- `specdrive/docs/stages/session-stage.md` 로 `session` 단계의 역할과 세션 복구/저장 범위를 정리한 상태다.
- `specdrive/docs/stages/git-stage.md` 로 `git` 단계의 역할과 브랜치/메시지 생성 범위를 정리한 상태다.
- `specdrive/docs/stages/doc-stage.md`, `plan-stage.md`, `dev-stage.md` 로 핵심 작업 단계를 `doc -> plan -> dev` 로 정리한 상태다.
- 현재 `plan` 단계는 `$plan extract-candidates / phase-split / cycle-split / task-split / wp` 흐름으로 보고, Task를 WP 구성을 위한 후보, Work Package를 AI 작업 단위로 정의했다.
- 현재 `dev` 단계는 승인된 plan 결과에서 Work Package를 선택해 `$dev start / impl-run / test / sync` 로 구현, 테스트, 동기화하는 흐름으로 본다.
- `.agents/skills/**` 와 `specdrive/codex-skills/**` 아래 repo-local skill 사용본과 배포 후보 원본이 생성된 상태다.
- `specdrive/scripts/**`, `specdrive/skills/**`, `specdrive/config/**` 아래 과거 CLI/preview 검증 골격은 보존된 상태다.
- 현재 `doc` 스크립트는 registry 를 주 경로로 사용하고, legacy action별 target config 는 `default_target` fallback 용으로 일부 남아 있다.
- 현재 `doc confirm-prompt`, `doc apply-prompt` 는 preview 탐색 규칙을 action config 와 output policy 조합으로 해석하도록 반영된 상태다.
- 현재 `doc reinforce`, `doc confirm-prompt`, `doc apply-prompt` 는 공통 helper 로 기본 target 해석을 공유하도록 반영된 상태다.
- 현재 `doc confirm-prompt`, `doc apply-prompt` 는 필요한 preview 전제조건과 출력 연결 규칙 일부를 action config 에서 읽도록 반영된 상태다.
- 현재 `doc confirm-prompt`, `doc apply-prompt` 는 preview prefix 와 history suffix 일부를 action config 에서 읽도록 반영된 상태다.
- 현재는 preview 기반 반복 검증을 우선하되, `doc reinforce` 에 한해 실제 Codex 실행까지 좁게 확인하기 시작한 단계다.
- 현재 `01-overview.md` 기준으로 세 단계가 기대한 운영 역할대로 분리되는지 1차 확인을 마친 상태다.
- 현재 `01-overview.md` 기준 `doc` 단계는 registry 기반 key routing, preview 기반 최소 검증, `doc reinforce` 의 좁은 실제 Codex 연결, `confirm-prompt/apply-prompt` 중심 반영 경로까지 1차 완료 판정한 상태다.
- 과거 실행형 반영/history 저장으로 남은 산출물은 `docs/history/projects/**` 아래 이력으로 유지하되, 현재 명령 체계는 prompt-first 기준으로 재정리한 상태다.
- 현재 `draft-save`, `reinforce-prompt` 가 추가되면서 `doc` 단계는 자동 실행 중심보다 정규화 프롬프트 + 명시적 history 저장 루프로 정리되는 중이다.
- 현재 `$session save` 는 `.speclab/**` 저장보다 `docs/AI_CONTEXT.md` 반영 초안을 출력하는 운영 보조 action 으로 해석한다.

### 9.3 projects
- projects는 “예제 문서 모음”이 아니라 “실제 애플리케이션 개발 스펙 문서 작업공간”으로 정리된 상태다.
- 현재는 specdrive와 함께 검증하는 구조지만, 장기 분리 가능성을 전제로 서술하는 방향이 정리된 상태다.

### 9.4 board
- board는 specdrive의 하위 기능이 아니라 첫 번째 실제 애플리케이션 프로젝트 문서군으로 정리된 상태다.
- `docs/projects/board/AGENTS.md` 는 board 전용 규칙 문서로 재정리된 상태다.
- 현재 board 문서 구조는 `01-overview.md`, `specs/**`, `impl/**`, `status/**` 로 재정리되는 중이다.
- `specs/04~07`, `impl/01`, `status/current-status` 는 파일 골격만 생성된 상태다.

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
- `docs/projects/board/work/work-candidates.md` 와 `work-roadmap.md` 를 기준으로 `$plan task-split` 또는 `$plan wp` 실행 여부를 판단
- `$plan task-split` 전 Cycle 내부 후보 관계를 검토
- `$plan task-split` 으로 Task 후보를 나눈 뒤, `$plan wp` 로 AI 실행 단위인 Work Package로 패키징
- `work-index.md` 는 plan 단계에서 수정하지 않고, 현재 실행 포인터는 이후 dev 단계에서 다룸
- `$plan task-split` / `$plan wp` skill과 `specdrive/manual/plan-manual.md` 의 기준이 충분한지 실행 전에 확인
- 새 Work Package / Phase / Cycle 구조를 실제 문서에 반영하기 전에는 개발자 승인을 먼저 받기

### 우선순위 2
- `docs/AI_CONTEXT.md` 와 `specdrive/docs/**` 상태 문서의 최신성 유지
- `specdrive/manual/plan-manual.md`, `.agents/skills/plan/**`, `specdrive/codex-skills/plan/**` 의 extract-candidates 규칙이 계속 같은 의미로 유지되는지 확인
- `draft-save -> reinforce-prompt -> apply-prompt` 루프를 `01-overview.md`, `specs/02-requirements.md`, `specs/03-design.md` 에 어떻게 반복 적용할지 판단
- `confirm-prompt` 를 새 `doc` 루프 안에서 어떤 위치에 둘지 판단
- `$session start`, `$session save` action 을 Codex에서 직접 호출해 5~10회 사용하며 절차를 다듬기
- 테스트 중인 `$session` 은 전역 설치 없이 repo local `.agents/skills/**` 에 설치한다.
- session 실행 기준은 `.agents/skills/session/**` 사용본으로 두고, `specdrive/codex-skills/session/**` mirror는 보존하되 session context bundle에서는 제외한다.
- Git은 초기 버전 정리 중 개발자가 직접 처리하므로 session 흐름에서 Git 상태 조회나 commit/push/PR 프롬프트를 기본 요구하지 않는다.

### 우선순위 3
- GitHub CLI `gh` 기반 PR 자동화 검증은 후속 후보로 둔다. 단, Git 작업은 개발자가 직접 처리한다.
- `doc reinforce -Execute` 실제 사용감 점검
- `codex exec` 실제 실행 연결 범위 확대 여부 판단
- `plan extract-candidates / phase-split / cycle-split / task-split / wp` 흐름은 실제 코딩 전 작업 분해 시점의 후속 테스트 대상으로 유지
- `dev start / impl-run / test / sync` 흐름은 실제 코딩 시작 시점의 후속 테스트 대상으로 유지

### 우선순위 4
- board 하위 실제 문서 목록 정의
- 요구사항 / 설계 / 구현 계획 문서 최소 세트 정리

---

## 12. 현재 focus

현재 focus는 다음과 같다.

- specdrive를 **도구/엔진/운영체계**로, projects를 **애플리케이션 스펙 작업공간**으로 명확히 분리하는 것
- 현재는 함께 검증하지만 장기적으로 분리 가능한 구조를 전제로 문서 서술을 고정하는 것
- README / AGENTS / AI_CONTEXT를 통해 새 세션에서 빠르게 복귀 가능한 문서 체계를 만드는 것
- `doc` 단계의 최소 흐름을 정규화 프롬프트 + 명시적 history 저장 중심으로 반복 가능하게 유지하는 것
- `specdrive/docs` 문서가 실제 registry 기반 라우팅 상태를 정확히 설명하도록 유지하는 것
- `session` 단계가 `doc` / `dev` 를 침범하지 않고 skill 중심 세션 운영 절차로만 유지되게 하는 것
- `$session start`, `$session restore`, `$session start-full`, `$session status`, `$session save` 라우터 흐름과 기존 호환 명령을 함께 검증하는 것
- `git` 단계는 브랜치/메시지/PR 전달 절차로 분리하되, 초기 버전 정리 중에는 Git을 개발자가 직접 처리하고 Codex는 명시 요청이 있을 때만 돕는 것
- CLI는 현재 버전 기준 흐름에서 제외하고 후속 후보로만 보류하는 것
- `plan` 단계는 `specdrive/manual/plan-manual.md` 와 `.agents/skills/plan/**` 기준으로 `$plan extract-candidates` 1차 정리를 마쳤고, 다음은 `$plan phase-split / cycle-split / task-split / wp` 흐름으로 이어갈지 판단하는 것이다.
- board `work-candidates.md` 는 현재 `CAND-001 ~ CAND-018` 상태이며, `CAND-013 ~ CAND-018` 은 specs 문서를 기준으로 추가한 후보다.
- `CAND-014`, `CAND-016`, `CAND-018` 은 기존 후보와 연결/중복 가능성이 있으므로 Work Package 분해 전에 관계를 확인한다.
- `doc` 단계는 `docs/projects/board/01-overview.md` 기준 1차 완료 판정을 마친 상태에서, `specs/02-requirements.md`, `specs/03-design.md` 같은 후속 board 문서에 반복 적용 가능한지 확인하는 것
- 현재 적용한 최소 rule/config 분리 방식을 `dev`, 후속 project 문서 흐름에 점진 적용하되, `session` / `git` 은 먼저 skill 직접 사용으로 절차를 검증하는 것
- 현재 실행까지 끝낸 `confirm / history-save` 결과와 실제 history 산출물 묶음은 `doc-stage-testing.md` 의 1차 완료 판정 근거로 유지하는 것
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
- 현재 작업이 실제 기준 문서 정리인지, 과거 이력(`docs/history/**`) 재확인인지 먼저 구분했는가?

---

## 14. 마지막 갱신 기준

- 마지막 갱신 일시: 2026-05-01
- 마지막으로 반영한 주요 변경:
  - 루트 README / 루트 AGENTS / specdrive 전용 AGENTS / board 전용 AGENTS 재정리
  - specdrive를 엔진 / 운영체계 / skill 중심 도구로 재정의
  - board를 첫 번째 실제 애플리케이션 프로젝트로 재정의
- 제품명을 `butgo-specdrive` 로, GitHub 저장소명을 `butgo-specdrive-lab` 으로 변경하는 방향 반영
- 현재 기준 문서와 실행 자산 경로를 `specdrive/docs/**`, `.agents/skills/**`, `specdrive/codex-skills/**` 중심으로 정리
- 과거 실행 이력인 `docs/history/**` 산출물은 당시 경로와 명칭을 보존하는 이력 문서로 유지
- `doc` / `dev` 흐름 구분 반영
- `session` 단계를 별도 운영 단계로 문서 반영
- `git` 단계를 별도 전달 단계로 문서 반영
- `specdrive/{scripts,skills,config}` 구조 반영
- `doc reinforce / confirm-prompt / apply-prompt` 흐름 문서 및 최소 스크립트 골격 반영
- `target / skill / context-set` registry 초안 반영 및 `doc` 스크립트 연동 시작
- `codex-exec.ps1` 의 `-TargetKey` 기반 preview 테스트 경로 반영
- `specdrive/docs/runtime-structure.md`, `doc-stage-testing.md` 최신 상태 반영
- `specdrive/docs/flows/doc-reinforce-flow.md`, `flows/doc-confirm-flow.md`, `flows/doc-history-save-flow.md` 를 현재 registry 기준으로 정리
- legacy `doc-*-targets.json` 이 현재는 `default_target` fallback 용 호환 레이어라는 점 반영
- `specdrive/docs/stages/session-stage.md` 로 `session` 단계 문서 추가
- `specdrive/docs/stages/git-stage.md` 로 `git` 단계 문서 추가
- `doc reinforce` 에 한해 `codex exec` 실제 호출 경로를 좁게 연결
- README / AGENTS / AI_CONTEXT를 먼저 정비한 뒤 skill 테스트를 진행하는 방향 반영
- standards 1차 문서 세트와 후속 2차 문서 후보 상태 반영
- `doc` 단계 기본 target, preview 탐색 규칙, execute 조건, artifact naming 일부를 config 중심으로 이동
- `$session start`, `$session restore`, `$session start-full`, `$session status`, `$session save` 를 각각 경량 복구 / 재시작 복구 / 전체 복구 prompt / 6줄 상태 스냅샷 / compact 상태 반영 초안 요청용 action 으로 해석하는 현재 기준을 반영
- `doc-work`, `doc-work-ref`, `doc-work-bundle` repo-local skill 을 추가하고, 사용본은 `.agents/skills/**`, 배포 후보 원본은 `specdrive/codex-skills/**` 아래에 두는 기준을 반영
- `$doc-work` 를 단일 target 문서 작업 진입점으로 정리하고, 현재 지원 action 을 `draft`, `reinforce`, `revise` 로 둔 기준을 반영
- `$doc-work <target> revise` 는 초기 Codex 보강 이후 개발자 수정/검토 흐름으로 두며, 실행 시 Preview Prompt 만 출력하고 preview 이후 follow-up / document-only / document-plus-history completion prompt 를 분리 출력하는 기준을 반영
- `revise` 의 `_dev-revised.note.md` 에는 `Developer Revision Request` 와 `Summary` 를 함께 남기는 기준을 반영
- 모든 doc-work history 파일명은 `yyyy-MM-dd_HHmmss_` prefix 를 사용하는 기준을 반영
- `specdrive/docs/index.md`, `specdrive/docs/AGENTS.md` 까지 포함해 `session` 단계 설명을 현재 기준으로 동기화
- `docs/projects/board/01-overview.md` 기준으로 과거 실행형 반영/history 산출물을 `docs/history/projects/**` 아래 이력으로 보존
- `docs/projects/board/01-overview.md` 는 auth와 board의 독립 배포를 즉시 확정이 아니라 장기 고려 방향으로 조정했고, logging/auth/board 같은 재사용 후보 영역의 경계를 overview 수준에서 명시
- `docs/history/projects/board/01-overview/2026-04-25_204400_01-overview_dev-revised.md` 와 `.note.md` 로 해당 revision history 를 저장
- 현재 기준 반영 흐름은 `confirm-prompt`, `apply-prompt`, `apply-only-prompt` 중심으로 재정리
- `$session status` 를 AI_CONTEXT 상태와 다음 진입점을 6줄 내외로 보여주는 action 으로 정리
- Git safe.directory 소유자 차이와 변경 경로 null 처리로 세션 복구 명령이 실패하지 않도록 `specdrive/scripts/common/specdrive-common.ps1` 에 경로 정규화, 빈 변경 목록 처리, `ChangedPaths` null 허용 보정
- `specdrive/docs/doc-stage-testing.md` 에 `01-overview.md` 기준 `doc` 단계 1차 완료 판정 문구 반영
- ChatGPT 업로드 편의를 위해 `context-bundle-map.json` 기반 bundle key 선택 방식과 번호 선택 메뉴를 추가
- `readme-ko-all`, `readme-en-all`, `readme-all`, `agents-all`, `onboarding-all` bundle key 를 추가
- `doc-map.json`, `affected-docs-map.json` draft 설정은 아직 기본 스크립트 동작에는 연결하지 않고 후속 검토 대상으로 유지
- 현재 기준 작업자 메모:
  - 지금은 `doc` 단계 흐름을 더 만들어내기보다 실제 반복 테스트를 통해 어색한 지점을 찾는 것이 중요하다.
  - 새 세션에서는 먼저 이 문서와 `specdrive/docs/doc-stage-testing.md` 에서 현재 테스트 상태를 복구한 뒤 작업 대상 문서로 들어간다.
  - 현재 `doc` 단계는 `docs/projects/board/01-overview.md` 를 대상으로 `reinforce / confirm-prompt / apply-prompt` 를 테스트한다.
  - `docs/projects/board/01-overview.md` 기준으로 `reinforce / confirm-prompt / apply-prompt` preview 생성이 실제로 정상 동작하는 것을 확인했다.
  - `01-overview.md` 기준으로 `reinforce` 는 보강 초안, `confirm` 은 사람 검토 체크리스트, `history-save` 는 기록 후보 생성 단계로 분리되어 동작하는 것을 1차 확인했다.
  - 이후 원래 의도했던 문서 이력 자동 저장 목적에 맞게 과거 실행형 반영/history 저장 경로를 시험했고, 그 산출물은 `docs/history/projects/**` 에 이력으로 남겨 두었다.
  - 현재 기준에서는 `confirm-prompt` 와 `apply-prompt` 를 순차 사용해 검토와 반영을 분리하는 흐름이 더 자연스럽다고 정리했다.
  - 이번 정리 이후에는 문서 반영 흐름을 `confirm-prompt`, `apply-prompt`, `apply-only-prompt` 중심으로 맞추었다.
  - 현재 `docs/history/projects/board/01-overview/**` 아래에는 2026-04-19 00:01:55, 00:02:07 기준 confirm/history 산출물이 추가된 상태다.
  - `specdrive/config/target-registry.json`, `skill-registry.json`, `context-set-registry.json`, `doc-action-registry.json` 초안을 만들었고 `reinforce / confirm-prompt / apply-prompt` 는 이 registry 를 주 경로로 읽도록 연결했다.
  - 현재 `doc-action-registry.json` 은 execute 허용 여부, 일부 execute 선행조건, preview prefix, history suffix 일부를 담는 최소 rule/config layer 역할을 시작했다.
  - `doc-reinforce-targets.json`, `doc-confirm-targets.json`, `doc-history-targets.json` 는 현재 `default_target` fallback 용 legacy config 로 남아 있다.
  - `specdrive/scripts/exec/codex-exec.ps1` 는 `-TargetKey board-overview` 로 registry 기반 preview 테스트가 가능하고, `doc reinforce -Execute` 에서 실제 Codex 호출도 좁게 수행할 수 있다.
  - 과거 CLI 실행 환경 확인 결과는 현재 기준 경로에서 제외하고, 후속 CLI 자동화 검토 시에만 재확인한다.
  - 단일 진입점 CLI 라우터 기반 흐름은 현재 버전 기준 경로에서 제외하고 파일도 제거했다.
  - `session` 단계는 `doc` / `dev` 와 다른 메타 운영 단계로 두고 `start`, `status`, `save` 를 담당하는 방향이 현재 기준에 맞다.
  - `git` 단계는 브랜치명, commit message, PR 메시지 생성을 담당하는 방향이 현재 기준에 맞다.
  - 과거 최소 라우팅 검증 결과는 문서 이력으로만 보존하고 현재 세션 기본 진입점으로 쓰지 않는다.
  - `context-bundle.ps1` 는 그냥 실행하면 bundle key 번호 선택 메뉴를 보여주고, 비대화식 실행은 `-BundleKey` 로 유지한다.
  - 실제 Codex 실행 시에는 non-zero exit code 가 나와도 `output-last-message` 파일에 본문이 남을 수 있으므로 preview 파일과 output 파일을 함께 확인하는 편이 안전하다.
  - session/git 복구 안정화와 `01-overview.md` 기준 `doc` 단계 1차 완료 판정은 `spec(specdrive): stabilize session recovery status` 커밋으로 저장했다.
  - 다음 선택지는 `03-design.md` 초안을 검토/보강할지, 이 문서에 `doc` 흐름을 반복 적용할지, 또는 구현 계획 문서로 넘어갈지 판단하는 것이다.
  - 마지막 세션을 저장하지 못한 뒤 복구한 현재 기준에서는 `README.md`, `AGENTS.md`, `docs/AI_CONTEXT.md` 를 먼저 읽고, 이후 `specdrive/docs/stages/session-stage.md` 와 실제 session/git 명령 출력으로 현재 상태를 다시 확인했다.
  - `specdrive/docs/doc-stage-testing.md` 기준으로 `01-overview.md` 의 `doc` 단계 1차 테스트는 완료 판정했으며, 다음은 `session` 운영 흐름 정리 또는 다음 board 문서에 같은 흐름을 반복 적용할지 판단하는 것이다.
  - 현재는 board 문서 구조를 `specs / impl / status` 기준으로 다시 정리하고, 관련 진입 문서와 참조 경로를 맞추는 작업을 진행했다.
- `doc-work`, `doc-work-ref`, `doc-work-bundle` repo-local skill 을 만들고 `.agents/skills/**` 및 `specdrive/codex-skills/**` 양쪽에 반영했다.
- `$doc-work board-overview` 흐름은 `draft / reinforce / revise` 중심으로 정리했다.
- `draft`, `reinforce` 는 기존 history snapshot 이 있으면 중단하고, `revise` 는 여러 `_dev-revised.md` history snapshot 을 허용하는 흐름으로 정리했다.
- `revise` 는 preview-first 흐름으로 정리했고, `$doc-work board-overview revise` 실행 시에는 Preview Prompt 만 출력한다.
- `revise` Preview Prompt 실행 이후에는 `Preview Follow-up Prompt`, `Completion Prompt A: Document Only`, `Completion Prompt B: Document Plus History` 를 분리된 복사 영역으로 출력한다.
- `revise` note 에는 `Developer Revision Request` 섹션과 `Summary` 를 함께 남기도록 정리했다.
- `docs/projects/board/01-overview.md` 에서 auth와 board의 독립 배포를 즉시 확정이 아니라 장기 고려 방향으로 조정하고, logging/auth/board 같은 재사용 후보 영역의 경계를 overview 수준에서 명시했다.
- 같은 revised 결과를 `docs/history/projects/board/01-overview/2026-04-25_204400_01-overview_dev-revised.md` 와 `.note.md` 에 저장했다.
- 다음 board 문서 작업은 `01-overview.md` 에서 정리한 재사용 가능 경계와 독립 배포 고려 방향을 `specs/03-design.md` 또는 `specs/04-application-structure.md` 에서 어느 수준으로 구체화할지 판단하는 것이 자연스럽다.
- repo-local Codex skill 을 중심으로 `$session`, `specdrive-skills` 를 유지하고 Git 관련 skill은 삭제했다.
- 테스트 중에는 전역 skill 설치를 사용하지 않고 `.agents/skills/**` 를 기준으로 둔다.
- 배포/패키징 후보 원본은 `specdrive/codex-skills/**` 로 둔다.
- GitHub CLI `gh` 기반 PR 자동화 검증은 보류 중이며, Codex GitHub plugin 은 현재 필수로 보지 않는다.
- `feat(specdrive): add repo-local codex skills workflow`, `docs(skill): add push prompt to git commit skill` 커밋을 원격 브랜치에 push한 상태다.
- 현재 `doc` 단계는 `draft-save`, `reinforce-prompt`, `confirm-prompt`, `apply-prompt` 중심의 수동 보강 루프를 먼저 정리하고, 실제 저장 자동화 범위는 후속 판단 대상으로 남겨 두었다.
- 현재 `doc` 단계 문서는 execute-first 보다 prompt-first 해석을 우선하도록 재정리 중이다.
- 현재 구현 명령과 문서 해석 모두 `confirm-prompt`, `apply-prompt`, `apply-only-prompt` 기준으로 정리한 상태다.
- 현재 `$session save` 는 `.speclab` 저장이 아니라 `docs/AI_CONTEXT.compact.md` 반영 초안을 제안하는 action 으로 해석하는 편이 맞다.
- 이후 세션에서는 `$session start` 로 최소 복구 후, 필요할 때만 `$session start-full` 로 작업 대상 영역 문서를 추가 확인한다. 새 문서 생성이나 요구사항/설계/구현 계획 전환 전에는 개발자에게 먼저 확인해야 한다.
- `docs(board): add board design draft and session guardrails` 커밋 이후 작업 트리는 clean 상태로 확인했다.
- `main` pull/merge/push 후 로컬 `main` 과 `origin/main` 은 같은 지점으로 정리했다.
- 다음 board 개발 문서 작업용 브랜치는 `docs/board-spec-structure` 로 잡았고, 생성 직후 작업 트리는 clean 상태다.
- 다음 작업은 `docs/projects/board/01-overview.md`, `docs/projects/board/index.md`, `docs/projects/board/specs/03-design.md` 의 연결과 역할 정합성 점검이다.
- `dev` 단계는 board 문서 세트가 더 쌓이고 실제 프로그램 작업에 들어갈 시점에 시작한다.
- `docs/projects/board/specs/02-requirements.md` 에 대해 `$doc-work board-requirements draft` 와 `reinforce` 흐름을 실행했다.
- `docs/history/projects/board/02-requirements/2026-04-26_172523_02-requirements_dev-draft.md` 및 note를 저장했다.
- `docs/history/projects/board/02-requirements/2026-04-26_173140_02-requirements_codex-reinforced.md` 및 note를 저장했다.
- `specdrive/config/affected-docs-map.json` 에 `reference_docs` 를 추가해 Doc Work Ref는 상위 기준 문서만, Doc Work Bundle은 `include_for_bundle` 중심 상호 영향 문서 묶음을 읽도록 분리했다.
- `$doc-work-ref` 는 `reference / revise` action과 `ref` history prefix 규칙으로 정리했다.
- `$doc-work-bundle` 은 `reference / revise` action과 `bundle` history prefix 규칙으로 정리했다.
- ref/bundle 작업에서 여러 문서가 수정되면 같은 timestamp를 공유하되 문서별 snapshot/note를 각각 남기는 규칙을 추가했다.
- session은 인자형 호출을 지원하도록 `$session start|restore|start-full|status|save` 라우터 스킬을 유지한다.
- 기존 `$session-start-*`, `$session-save` 호환 스킬은 노출을 줄이기 위해 `$session` 내부 action 문서로 통합했다.
- Git은 초기 버전 정리 중 개발자가 직접 처리하며, session save/status/restore 흐름은 Git 상태 확인이나 commit/push/PR 프롬프트를 기본 요구하지 않는 것으로 정리했다.
- `specdrive/manual/plan-manual.md` 에서 `$plan extract-candidates` 실행 기준을 정리했고, Project Name은 `docs/projects/{project}` key이며 `specdrive/config/project-registry.json` 에서 관리하는 것으로 고정했다.
- `specdrive/config/project-registry.json` 을 추가해 board 프로젝트의 plan extract-candidates 기본 프로젝트, Source Scope, 대상 문서 묶음, history 경로/파일명 규칙을 관리한다.
- `docs/projects/board/work/work-candidates.md` 에 `CAND-013 ~ CAND-018` 을 추가했고, 현재 후보 범위는 `CAND-001 ~ CAND-018` 이다.
- `CAND-014`, `CAND-016`, `CAND-018` 은 각각 기존 후보와 연결/중복 가능성이 있으므로 다음 `$plan task-split` 또는 `$plan wp` 전 검토한다.
- plan history는 `docs/history/projects/board/plan/work-candidates/` 아래에 남기며, extract-candidates 반영 이력 파일명은 `generate-candidates_extract-candidates` context/action 형식을 따른다.
- 모든 위저드형 skill은 후속작업이 필요할 때만 copy-ready prompt를 출력하고, 후속작업이 없으면 프롬프트를 출력하지 않는 공통 UX 규칙을 따른다.
- 다음 세션의 가장 가까운 진입점은 `$plan task-split` 또는 `$plan wp` 로 board 작업을 Task 후보와 Work Package 후보로 정리하는 것이다.

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

