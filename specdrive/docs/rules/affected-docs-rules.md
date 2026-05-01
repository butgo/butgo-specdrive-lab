# Affected Docs Rules

## 1. 문서 목적

이 문서는 SpecDrive Core 전체에 적용되는 공통 영향 점검 규칙을 정의한다.

`specdrive/docs/rules/` 는 프로젝트에 복사할 템플릿이 아니라 SpecDrive Core 자체의 운영 규칙을 둔다.
이 규칙은 문서뿐 아니라 skill, script, codex-skill, runtime 구조처럼 SpecDrive Core 운영에 연결되는 자산에도 적용될 수 있다.

프로젝트별 세부 적용 규칙은 각 프로젝트의 `rules/affected-docs-rules.md` 에서 다룬다.
프로젝트에 복사해서 시작할 규칙 문서 템플릿은 `specdrive/docs/templates/rules/` 아래에 둔다.

규칙 문서군의 전체 목록과 역할은 `specdrive/docs/rules/README.md` 를 따른다.

## 2. 공통 원칙

- 요구사항 변경은 설계, 구현 계획, work 후보에 영향을 줄 수 있다.
- 설계 변경은 API, DB, 도메인, 구현 계획 문서에 영향을 줄 수 있다.
- work 문서 변경은 `work-index.md`, `work-log.md`, status 문서 반영 여부를 함께 확인한다.
- phase 또는 cycle 기준 변경은 manual과 status 문서 반영 여부를 함께 확인한다.
- Candidate가 `Accepted` 되면 `work-roadmap.md`, `work-index.md`, `work-log.md` 반영 여부를 확인한다.
- Sync 결과는 `work-log.md`에 요약하고, 현재 작업 포인터 변경은 `work-index.md`에서 판단한다.
- Cycle 3의 실행 방법, 설정 절차, 복구 절차, 운영 재현 절차는 manual 문서 반영 여부를 우선 확인한다.
- Core skill 변경은 `.agents/skills/**` 사용본과 `specdrive/codex-skills/**` 배포 후보 원본의 동기화 필요 여부를 확인한다.
- Core script 변경은 관련 `specdrive/docs/**` 설명, `specdrive/config/**` 설정, runtime 구조 문서 반영 여부를 확인한다.
- Core runtime 구조 변경은 `specdrive/docs/runtime-structure.md`, `specdrive/docs/skill-wizard-manual.md`, 관련 stage 문서 반영 여부를 확인한다.

## 3. Codex 확인 기준

Codex는 문서 수정 전후에 다음을 확인한다.

- 이 변경이 공통 규칙인지 프로젝트별 적용인지 구분한다.
- 변경 대상 문서의 상위 기준 문서를 확인한다.
- 현재 문서만 수정해도 되는지, 연관 문서 동기화가 필요한지 판단한다.
- 필요한 경우 연관 문서 갱신안을 제안하되, 사람 확인이 필요한 상태/포인터/전환 변경을 임의로 확정하지 않는다.
- 확정되지 않은 변경은 확정 상태처럼 기록하지 않는다.
