# specdrive/docs/AGENTS.compact.md

## 1. 역할

이 문서는 `specdrive/docs/AGENTS.md`의 대체 원본이 아니다.

이 문서는 Codex 기본 주입용 compact 규칙이다.  
specdrive 영역 작업에서 긴 원본을 매번 읽지 않기 위해 필요한 실행 규칙만 남긴다.

원본 `specdrive/docs/AGENTS.md`는 specdrive 전용 기준 문서로 그대로 유지한다.

---

## 2. specdrive의 현재 성격

specdrive는 현재 완성된 SaaS 제품이 아니다.

현재 specdrive는 다음을 검증하는 영역이다.

- 문서 기반 AI 협업 방식
- 운영체계와 작업 단계
- repo-local Codex skill-first 흐름
- 반복 가능한 문서 보강, 검토, 저장 절차
- 실제 프로젝트에 적용 가능한 작업 템플릿

specdrive 문서는 특정 애플리케이션을 설계하는 문서가 아니다.  
specdrive 문서는 애플리케이션 문서를 기반으로 협업을 실행하는 방식을 다룬다.

---

## 3. projects와 섞지 않는다

specdrive는 협업 방식을 다룬다.

예:

- 세션 시작
- 문맥 복구
- 문서 보강 절차
- 문서 검토와 반영 절차
- history 저장 절차
- task 분해 절차
- phase / cycle 상태 관리
- skill 실행 흐름

projects는 실제 개발 내용을 다룬다.

예:

- 요구사항
- 설계
- 구현 계획
- 상태
- 실제 애플리케이션 판단

specdrive 문서에 board 같은 특정 프로젝트의 상세 요구사항, API, DB, 패키지 설계를 넣지 않는다.

---

## 4. repo-local Codex skill 중심

현재 specdrive의 실행 기준은 repo-local Codex skill이다.

현재 사용본은 `.agents/skills/**` 아래에 둔다.  
배포나 패키징 후보 원본은 `specdrive/codex-skills/**` 아래에 둘 수 있다.

실행 시에는 기본적으로 `.agents/skills/**`를 기준으로 본다.  
`specdrive/codex-skills/**`는 mirror/export 성격이면 기본 문맥에서 제외하고, 동기화나 배포 검토가 필요할 때만 읽는다.

---

## 5. skill 작성 원칙

skill은 거대한 설명서가 아니라 짧은 작업 규칙 자산이어야 한다.

skill은 다음에 집중한다.

- 작업 목적
- 읽을 문서 범위
- 중단 조건
- 승인 지점
- 출력 형식
- 완료 시 검증 기준

위저드형 skill 출력에서는 후속작업이 필요할 때만 copy-ready prompt를 출력한다.  
작업이 끝났거나 유용한 후속작업이 없으면 prompt를 출력하지 않고 짧은 결과 요약으로 끝낸다.

history snapshot/note 파일명은 `yyyy-MM-dd_HHmmss_<context>_<action-or-purpose>.md` 형태를 따른다.  
`context`는 `doc`, `ref`, `bundle`, `dev`, `generate-candidates`처럼 어떤 흐름이나 실행 구분에서 만든 history인지 드러내야 한다.

skill이 모든 배경 설명을 길게 포함하지 않도록 한다.  
긴 설명, 반복 템플릿, 예시는 후속으로 template 분리 후보로 둔다.

---

## 6. 작업 단계 구분

specdrive는 `doc`, `dev`, `session`, `git` 단계를 구분한다.

- `doc`: 문서 보강, 검토, 반영, history 저장
- `dev`: 확정 문서 기반 task, phase, cycle, status
- `session`: 세션 복구와 저장을 돕는 메타 운영
- `git`: commit, push, PR 전달 단위 준비

초기 버전 정리 중에는 Git을 개발자가 직접 처리한다.  
session 흐름은 Git 상태 확인이나 Git skill 호출을 기본 요구하지 않고, 필요한 경우 개발자가 별도로 질문한다.

각 단계가 다른 단계의 내부 처리를 대신하지 않는다.

---

## 7. compact/read-minimal 원칙

기본은 compact 문서와 대상 문서만 읽는다.

다음은 명시 요청이나 필요가 있을 때만 읽는다.

- 원본 `AGENTS.md`
- 참조 문서
- bundle 문서
- `docs/history/**`
- `specdrive/codex-skills/**`
- 긴 과거 산출물

원본 규칙을 수정하거나 우선순위를 판단해야 할 때는 compact 대신 full 원본을 읽는다.

---

## 8. 현재 결정

- specdrive는 협업 방식과 운영체계를 다루는 영역으로 유지한다.
- projects의 실제 애플리케이션 판단과 섞지 않는다.
- repo-local Codex skill-first 검증을 현재 실행 기준으로 둔다.
- 기본 context는 compact/read-minimal을 우선한다.
- `.agents/skills/**`는 실행 기준 원본으로 본다.

---

## 9. 후속 후보

- context bundle에서 compact 우선 선택을 자동화한다.
- thin skill + template 분리로 skill 본문을 줄인다.
- `.agents/skills/**`와 `specdrive/codex-skills/**`의 동기화 검증 절차를 만든다.
