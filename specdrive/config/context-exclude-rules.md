# context-exclude-rules.md

## 1. 문서 목적

이 문서는 Codex context bundle과 skill bundle을 만들 때 기본 제외할 경로와 compact 문서 우선 규칙을 정리한다.

이 문서는 현재 기준 문서의 원본을 대체하지 않는다.  
context 구성 시 토큰 소비를 줄이기 위한 운영 기준이다.

---

## 2. 기본 원칙

기본 context는 필요한 문서만 포함한다.

우선순위는 다음과 같다.

1. compact 문서
2. 현재 작업 대상 문서
3. 명시적으로 필요한 참조 문서
4. 필요한 경우에만 원본 규칙 문서

긴 원본, history, mirror/export 산출물은 기본 context에 넣지 않는다.

---

## 3. 기본 제외 경로

Codex 기본 context bundle에서는 다음 경로를 제외한다.

| 경로 | 기본 판단 | 이유 |
|---|---|---|
| `docs/history/**` | 제외 | 과거 판단과 산출물 보존 영역 |
| `.speclab/**` | 제외 | 생성 산출물과 임시 output 영역 |
| `.git/**` | 제외 | Git 내부 데이터 |
| `specdrive/codex-skills/**` | 제외 | mirror/export 성격일 때 기본 실행 문맥이 아님 |
| 긴 preview/output 파일 | 제외 | 현재 기준 문서가 아님 |

위 경로는 개발자가 특정 이력 확인, 배포 후보 검토, 산출물 비교를 명시적으로 요청한 경우에만 읽는다.

---

## 4. compact 문서 우선 기준

compact 문서가 있는 경우 기본 context에서는 원본보다 compact를 우선 읽는다.

| 원본 | compact |
|---|---|
| `AGENTS.md` | `AGENTS.compact.md` |
| `docs/specdrive/AGENTS.md` | `docs/specdrive/AGENTS.compact.md` |
| `docs/projects/board/AGENTS.md` | `docs/projects/board/AGENTS.compact.md` |

compact 문서는 원본의 대체 원본이 아니다.  
원본은 authoritative source로 유지한다.

---

## 5. 원본 AGENTS.md를 읽어야 하는 예외

다음 경우에는 compact 대신 원본을 읽는다.

- AGENTS 규칙 자체를 수정하는 경우
- compact 규칙과 실제 판단이 충돌하거나 불분명한 경우
- 문서 역할, 단계 전환, 승인 필요 여부가 애매한 경우
- 새 영역 규칙이나 새 프로젝트 규칙을 만들려는 경우
- 금지 사항이나 우선순위를 세밀하게 확인해야 하는 경우
- compact 문서가 오래되어 원본과 drift가 의심되는 경우

---

## 6. history 제외 기준

`docs/history/**`는 기본 제외한다.

읽을 수 있는 경우는 다음으로 제한한다.

- 개발자가 특정 history 파일 확인을 요청한 경우
- 특정 snapshot 존재 여부를 파일명으로 확인해야 하는 경우
- history 저장 작업에서 대상 경로의 존재 여부만 확인하는 경우
- 근거 추적이나 비교 검토를 명시적으로 요청한 경우

파일명 확인은 가능하지만, 본문 비교나 정리는 명시 요청이 있을 때만 한다.

---

## 7. skill 경로 구분

skill 관련 경로는 다음처럼 구분한다.

| 경로 | 성격 | 기본 context 판단 |
|---|---|---|
| `.agents/skills/**` | repo-local Codex 실행 기준 원본 | skill 실행/수정 작업에서 포함 가능 |
| `specdrive/codex-skills/**` | 배포/패키징 후보 또는 mirror/export 원본 | 기본 제외 |
| `specdrive/skills/**` | 기존 specdrive skill 문서 | legacy 검토 시만 포함 |

Codex skill 실행 시 기본적으로 `.agents/skills/**`를 기준으로 본다.  
`specdrive/codex-skills/**`를 동시에 읽지 않는다.

---

## 8. bundle 생성 기준

context bundle은 목적별로 나눠 만든다.

- 기본 세션 복구: compact 규칙과 현재 상태 중심
- repo skill 검토: `.agents/skills/**`
- codex skill export 검토: `specdrive/codex-skills/**`
- legacy skill 검토: `specdrive/skills/**`
- history 확인: 명시된 history 파일 또는 디렉터리만

서로 성격이 다른 skill 경로를 기본 bundle에서 동시에 묶지 않는다.

---

## 9. 현재 결정

- compact 문서가 있으면 기본 context에서 compact를 우선한다.
- 원본 AGENTS 문서는 삭제하지 않는다.
- `docs/history/**`는 기본 제외한다.
- `specdrive/codex-skills/**`는 mirror/export 성격이면 기본 제외한다.
- `.agents/skills/**`는 실행 기준 원본으로 본다.
- 기존 skill 동작은 이번 작업에서 변경하지 않는다.

---

## 10. 후속 후보

- `context-bundle.ps1`에서 compact 우선 선택을 자동화한다.
- context bundle preset에 compact 기반 세션 복구 묶음을 추가한다.
- thin skill + template 분리로 skill 본문 토큰을 줄인다.
- `.agents/skills/**`와 `specdrive/codex-skills/**` 동기화 점검 규칙을 추가한다.
