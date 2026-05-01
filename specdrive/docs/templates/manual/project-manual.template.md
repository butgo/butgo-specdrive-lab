# Project Manual

## 1. 문서 목적

이 문서는 이 프로젝트를 실행, 검증, 복구, 재현하기 위한 프로젝트 전체 매뉴얼이다.

이 문서는 상태 보고서가 아니다.  
프로젝트를 처음 보는 개발자 또는 미래의 내가 다시 실행할 수 있도록 정리하는 실행자 관점의 문서다.

Phase별 상세 실행/검증/복구 절차는 `manual/phases/phase-XX-manual.md`를 따른다.

---

## 2. 프로젝트 개요

| 항목 | 내용 |
|---|---|
| Project Name |  |
| Project Goal |  |
| Repository |  |
| Main Branch |  |
| Current Phase |  |
| Current Cycle |  |
| Manual Version | 0.1 |
| Updated At | YYYY-MM-DD |

---

## 3. 문서 구조

이 프로젝트의 주요 문서 구조는 다음과 같다.

~~~text
project-root/
|-- 01-overview.md
|-- index.md
|-- AGENTS.md
|-- AGENTS.compact.md
|
|-- specs/
|   |-- 02-requirements.md
|   |-- 03-design.md
|   |-- 04-application-structure.md
|   |-- 05-domain-model.md
|   |-- 06-api-spec.md
|   +-- 07-db-design.md
|
|-- work/
|   |-- README.md
|   |-- work-candidates.md
|   |-- work-policy.md
|   |-- work-roadmap.md
|   |-- work-index.md
|   +-- work-log.md
|
|-- manual/
|   |-- README.md
|   |-- project-manual.md
|   |-- phase-transition-checklist.md
|   +-- phases/
|       |-- phase-01-manual.md
|       |-- phase-02-manual.md
|       +-- phase-03-manual.md
|
|-- status/
|   +-- current-status.md
|
+-- rules/
    +-- affected-docs-rules.md
~~~

문서 역할은 다음과 같다.

| 문서/폴더 | 역할 |
|---|---|
| `01-overview.md` | 프로젝트 목적, 범위, 제외 범위 |
| `specs/` | 요구사항, 설계, API, DB 등 기준 문서 |
| `work/` | 작업 후보, roadmap, 현재 포인터, 작업 결과 |
| `manual/` | 실행, 검증, 복구, 재현 절차 |
| `status/` | 사람이 보는 현재 상태 요약 |
| `rules/` | 문서 변경 전파 규칙 |
| `history` | 상세 변경 이력 |

---

## 4. 읽는 순서

### 4.1 처음 보는 사람이 읽는 순서

~~~text
1. README.md
2. 01-overview.md
3. index.md
4. status/current-status.md
5. work/README.md
6. work/work-index.md
7. manual/project-manual.md
8. 필요한 phase manual
~~~

### 4.2 개발 작업 전 읽는 순서

~~~text
1. AGENTS.md
2. AGENTS.compact.md
3. work/README.md
4. work/work-policy.md
5. work/work-index.md
6. work/work-roadmap.md
7. 현재 작업에 필요한 specs 문서
~~~

### 4.3 실행 / 검증 목적 읽는 순서

~~~text
1. manual/project-manual.md
2. manual/phases/phase-XX-manual.md
3. work/work-index.md
4. status/current-status.md
5. 필요한 specs 문서
~~~

---

## 5. 지원 환경

프로젝트 실행에 필요한 공통 환경을 정리한다.

| 항목 | 기준 |
|---|---|
| OS |  |
| Runtime |  |
| Language / Framework |  |
| Build Tool |  |
| Database |  |
| External Service |  |
| CLI Tool |  |
| Required Permission |  |

아래 예시는 기술 스택별 작성 형식을 보여주기 위한 샘플이다.  
실제 프로젝트에 적용할 때는 해당 프로젝트의 OS, runtime, framework, build tool, database 기준으로 대체한다.

~~~text
OS: Windows 10/11, Linux
Runtime: Java 21
Framework: Spring Boot 3.x
Build Tool: Gradle
Database: H2 / PostgreSQL
CLI Tool: PowerShell 7.x, Git
~~~

---

## 6. 저장소 준비

### 6.1 Clone

~~~powershell
git clone {{repository-url}}
cd {{project-root}}
~~~

### 6.2 Branch 확인

~~~powershell
git branch --show-current
git status
~~~

### 6.3 의존성 확인

~~~powershell
# 예시
java -version
git --version
pwsh --version
~~~

### 6.4 프로젝트 구조 확인

~~~powershell
# 예시
tree /F
~~~

---

## 7. 설정 절차

프로젝트 전체 공통 설정 절차를 정리한다.

### 7.1 환경 변수

| 환경 변수 | 필수 여부 | 예시 | 설명 |
|---|---|---|---|
|  |  |  |  |

### 7.2 설정 파일

| 파일 | 위치 | 설명 | 예시 |
|---|---|---|---|
|  |  |  |  |

### 7.3 Profile / Environment

| Profile | 목적 | 사용 시점 |
|---|---|---|
| local | 로컬 개발 |  |
| test | 테스트 |  |
| prod | 운영 |  |

### 7.4 Database

| 항목 | 내용 |
|---|---|
| DB Type |  |
| Schema 관리 방식 |  |
| Migration Tool |  |
| 초기 데이터 필요 여부 |  |
| Seed Data 위치 |  |

### 7.5 External Services

| 서비스 | 필수 여부 | 설정 방법 | 비고 |
|---|---|---|---|
|  |  |  |  |

---

## 8. 실행 방법

프로젝트 전체 공통 실행 방법을 정리한다.
아래 명령은 예시이며, 실제 프로젝트의 실행 명령으로 대체한다.

### 8.1 기본 실행

~~~powershell
# 예시
./gradlew bootRun
~~~

### 8.2 빌드 후 실행

~~~powershell
# 예시
./gradlew build
java -jar build/libs/{{artifact-name}}.jar
~~~

### 8.3 테스트용 실행

~~~powershell
# 예시
./gradlew bootRun --args='--spring.profiles.active=test'
~~~

### 8.4 실행 확인

| 확인 항목 | 방법 | 기대 결과 |
|---|---|---|
| 프로세스 실행 |  |  |
| 포트 확인 |  |  |
| Health Check |  |  |
| 로그 확인 |  |  |
| 주요 화면/API 접근 |  |  |

---

## 9. 테스트 / 검증 방법

### 9.1 전체 테스트

~~~powershell
# 예시
./gradlew test
~~~

### 9.2 통합 테스트

~~~powershell
# 예시
./gradlew integrationTest
~~~

### 9.3 수동 검증

| 시나리오 | 절차 | 기대 결과 | 결과 |
|---|---|---|---|
|  |  |  |  |

### 9.4 API 검증

| API | Method | 검증 방법 | 기대 결과 |
|---|---|---|---|
|  |  |  |  |

### 9.5 DB 검증

| 확인 항목 | SQL / 방법 | 기대 결과 |
|---|---|---|
|  |  |  |

---

## 10. 로그 확인 방법

### 10.1 애플리케이션 로그

~~~powershell
# 예시
Get-Content ./logs/app.log -Tail 100
~~~

### 10.2 시스템 로그

~~~powershell
# 예시
journalctl -u {{service-name}} -n 100
~~~

### 10.3 주요 로그 패턴

| 패턴 | 의미 | 조치 |
|---|---|---|
|  |  |  |

---

## 11. 문제 해결

### 11.1 실행 실패

| 증상 | 가능 원인 | 확인 방법 | 조치 |
|---|---|---|---|
|  |  |  |  |

### 11.2 설정 오류

| 증상 | 가능 원인 | 확인 방법 | 조치 |
|---|---|---|---|
|  |  |  |  |

### 11.3 DB 오류

| 증상 | 가능 원인 | 확인 방법 | 조치 |
|---|---|---|---|
|  |  |  |  |

### 11.4 테스트 실패

| 증상 | 가능 원인 | 확인 방법 | 조치 |
|---|---|---|---|
|  |  |  |  |

---

## 12. 복구 절차

### 12.1 Git 기준 복구

~~~powershell
git status
git diff
git log --oneline -n 10
~~~

주의:

- 되돌리기 전 현재 변경 내용을 반드시 확인한다.
- destructive 명령은 사람 승인 없이 실행하지 않는다.

### 12.2 설정 복구

| 설정 | 복구 방법 | 주의사항 |
|---|---|---|
|  |  |  |

### 12.3 DB 복구

| 항목 | 복구 방법 | 주의사항 |
|---|---|---|
|  |  |  |

### 12.4 빌드/캐시 복구

| 항목 | 복구 방법 | 주의사항 |
|---|---|---|
|  |  |  |

---

## 13. 롤백 절차

### 13.1 코드 롤백

~~~powershell
# 변경 사항 확인
git status
git diff

# 최근 커밋 확인
git log --oneline -n 10
~~~

### 13.2 설정 롤백

| 설정 | 롤백 방법 | 주의사항 |
|---|---|---|
|  |  |  |

### 13.3 DB 롤백

| 항목 | 롤백 방법 | 주의사항 |
|---|---|---|
|  |  |  |

주의:

- DB 롤백은 데이터 손실 가능성을 먼저 확인한다.
- 운영 데이터에 영향을 줄 수 있는 명령은 사람 승인 없이 실행하지 않는다.
- 롤백 전 현재 상태를 기록한다.

---

## 14. 운영 재현 절차

새 환경에서 프로젝트를 다시 재현하는 절차를 정리한다.

### 14.1 새 환경에서 재현

~~~powershell
git clone {{repository-url}}
cd {{project-root}}
git checkout {{branch-or-tag}}

# 의존성 확인
java -version
git --version

# 테스트
./gradlew test

# 실행
./gradlew bootRun
~~~

### 14.2 재현 체크리스트

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 저장소 clone 가능 |  |  |
| 올바른 branch/tag checkout |  |  |
| 필수 도구 설치 확인 |  |  |
| 설정 파일 준비 완료 |  |  |
| 환경 변수 준비 완료 |  |  |
| 의존성 다운로드 성공 |  |  |
| 빌드 성공 |  |  |
| 테스트 통과 |  |  |
| 애플리케이션 실행 성공 |  |  |
| 주요 기능 검증 완료 |  |  |

---

## 15. Phase Manual 목록

Phase별 상세 매뉴얼은 아래 문서를 따른다.

| Phase | Manual | Status | Note |
|---|---|---|---|
| Phase 1 | `manual/phases/phase-01-manual.md` | Planned |  |
| Phase 2 | `manual/phases/phase-02-manual.md` | Planned |  |
| Phase 3 | `manual/phases/phase-03-manual.md` | Planned |  |

Phase manual에는 다음 내용을 정리한다.

- Phase 범위
- Phase 산출물
- Phase별 실행 방법
- Phase별 설정 절차
- Phase별 테스트 / 검증 절차
- Phase별 로그 확인 방법
- Phase별 복구 절차
- Phase별 롤백 절차
- Phase별 운영 재현 절차
- 알려진 제한 사항
- 후속 작업 후보

---

## 16. Phase / Cycle 전환 기준

Phase 또는 Cycle 전환 전에는 다음 문서를 확인한다.

~~~text
manual/phase-transition-checklist.md
work/work-roadmap.md
work/work-index.md
work/work-log.md
status/current-status.md
~~~

전환 원칙:

- 완료 기준 없이 전환하지 않는다.
- 검증 기준 없이 전환하지 않는다.
- Open Blocker가 있으면 전환하지 않는다.
- Open Decision이 있으면 전환하지 않는다.
- Cycle 3 산출물은 manual 문서에 우선 정리한다.
- 필요한 history가 저장되어야 한다.

---

## 17. 알려진 제한 사항

프로젝트 전체의 알려진 제한 사항을 정리한다.

| 제한 사항 | 영향 | 후속 처리 |
|---|---|---|
|  |  |  |

---

## 18. 후속 작업 후보

프로젝트 운영 또는 재현 과정에서 발견된 후속 작업 후보를 정리한다.

후속 작업은 바로 구현하지 않는다.  
필요 시 `work/work-candidates.md`에 반영한다.

| Candidate | Reason | Suggested Status | Note |
|---|---|---|---|
|  |  | Proposed |  |

---

## 19. 관련 문서

| 문서 | 역할 |
|---|---|
| `01-overview.md` | 프로젝트 목적과 범위 |
| `index.md` | 프로젝트 문서 카탈로그 |
| `AGENTS.md` | AI/개발 작업 규칙 |
| `AGENTS.compact.md` | Codex용 압축 작업 규칙 |
| `specs/` | 요구사항, 설계, API, DB 기준 문서 |
| `work/README.md` | Work System 적용 안내 |
| `work/work-policy.md` | 작업 운영 정책 |
| `work/work-candidates.md` | 후보 작업 관리 |
| `work/work-roadmap.md` | 전체 작업 구조 |
| `work/work-index.md` | 현재 작업 포인터 |
| `work/work-log.md` | 작업 결과와 sync 판단 |
| `manual/phase-transition-checklist.md` | Phase/Cycle 전환 체크리스트 |
| `manual/phases/phase-XX-manual.md` | Phase별 실행/검증/복구 매뉴얼 |
| `status/current-status.md` | 현재 상태 요약 |
| `rules/affected-docs-rules.md` | 변경 전파 규칙 |
| `history` | 상세 변경 이력 |

---

## 20. Codex 사용 기준

Codex는 이 문서를 작성하거나 보강할 때 다음을 따른다.

- 상태 보고가 아니라 실행자 관점의 절차를 작성한다.
- 전체 프로젝트 공통 절차와 Phase별 절차를 구분한다.
- Phase별 상세 절차는 `manual/phases/phase-XX-manual.md`로 연결한다.
- 실제 실행 가능한 명령과 확인 방법을 우선한다.
- 모르는 값을 임의로 채우지 않는다.
- 확인되지 않은 절차는 `확인 필요`로 표시한다.
- 현재 Phase 범위 밖 내용을 과도하게 포함하지 않는다.
- 후속 작업 후보는 바로 구현하지 않고 `work-candidates.md` 반영 대상으로 남긴다.
- 위험한 복구/삭제/롤백 명령은 사람 승인 없이 실행하지 않는다.
- 운영 데이터에 영향을 줄 수 있는 명령은 사람 승인 없이 실행하지 않는다.

---

## 21. 금지 사항

다음을 금지한다.

- 이 문서를 상태 보고서처럼 작성하는 것
- Phase별 상세 절차를 모두 이 문서에 중복 작성하는 것
- 실행 방법 없이 완료 상태만 적는 것
- 검증 절차 없이 프로젝트 실행 가능 상태로 선언하는 것
- 복구 절차 없이 운영 준비 완료로 처리하는 것
- 확인하지 않은 명령을 확정 절차처럼 작성하는 것
- 현재 Phase 범위 밖 작업을 manual에 섞는 것
- 후속 후보를 manual 작성 중 바로 구현하는 것
- destructive 명령을 사람 승인 없이 실행하는 것
- `status/current-status.md`만 갱신하고 manual 문서를 생략하는 것
