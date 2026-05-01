# Phase {{phase-number}} Manual

## 1. 문서 목적

이 문서는 Phase {{phase-number}} 결과물을 실행, 검증, 복구, 재현하기 위한 실행자 관점의 매뉴얼이다.

이 문서는 상태 보고서가 아니다.  
Phase {{phase-number}}의 산출물을 다른 개발자 또는 미래의 내가 다시 실행할 수 있도록 정리하는 문서다.

Cycle 3의 실행 방법, 설정 절차, 복구 절차, 운영 재현 절차는 `status/` 문서보다 이 문서에 우선 정리한다.

---

## 2. Phase 범위

| 항목 | 내용 |
|---|---|
| Phase | Phase {{phase-number}} |
| Phase Goal |  |
| Related Roadmap | `work/work-roadmap.md` |
| Related Work Index | `work/work-index.md` |
| Related Work Log | `work/work-log.md` |
| Related Specs |  |
| Manual Version | 0.1 |
| Updated At | YYYY-MM-DD |

---

## 3. Phase 산출물 요약

이 Phase에서 실행 가능한 상태로 정리된 산출물을 요약한다.

| 구분 | 산출물 | 위치 | 설명 |
|---|---|---|---|
| Document |  |  |  |
| Source Code |  |  |  |
| Config |  |  |  |
| Script |  |  |  |
| Test |  |  |  |
| Runtime |  |  |  |

---

## 4. 지원 환경

이 Phase 결과물을 실행하거나 검증하기 위해 필요한 환경을 정리한다.

| 항목 | 기준 |
|---|---|
| OS |  |
| Runtime |  |
| Language / Framework |  |
| Database |  |
| External Service |  |
| CLI Tool |  |
| Required Permission |  |

아래 예시는 기술 스택별 작성 형식을 보여주기 위한 샘플이다.  
실제 프로젝트에 적용할 때는 해당 프로젝트의 OS, runtime, framework, database 기준으로 대체한다.

~~~text
OS: Windows 10/11, Linux
Runtime: Java 21
Framework: Spring Boot 3.x
Database: H2 / PostgreSQL
CLI Tool: PowerShell 7.x, Git
~~~

---

## 5. 사전 준비

실행 전에 필요한 준비 사항을 정리한다.

### 5.1 저장소 준비

~~~powershell
# 예시
git clone {{repository-url}}
cd {{project-root}}
~~~

### 5.2 브랜치 확인

~~~powershell
git branch --show-current
git status
~~~

### 5.3 필수 도구 확인

~~~powershell
# 예시
java -version
git --version
pwsh --version
~~~

### 5.4 설정 파일 확인

| 설정 파일 | 필요 여부 | 설명 |
|---|---|---|
|  |  |  |

---

## 6. 설정 절차

Phase 결과물을 실행하기 위해 필요한 설정 절차를 정리한다.

### 6.1 환경 변수

| 환경 변수 | 필수 여부 | 예시 | 설명 |
|---|---|---|---|
|  |  |  |  |

### 6.2 설정 파일

| 파일 | 위치 | 설명 | 예시 |
|---|---|---|---|
|  |  |  |  |

### 6.3 데이터베이스 설정

| 항목 | 내용 |
|---|---|
| DB Type |  |
| Schema 관리 방식 |  |
| 초기 데이터 필요 여부 |  |
| Migration 필요 여부 |  |

### 6.4 외부 서비스 설정

| 서비스 | 필요 여부 | 설정 방법 | 비고 |
|---|---|---|---|
|  |  |  |  |

---

## 7. 실행 방법

Phase 결과물을 실행하는 방법을 정리한다.
아래 명령은 예시이며, 실제 프로젝트의 실행 명령으로 대체한다.

### 7.1 기본 실행

~~~powershell
# 예시
./gradlew bootRun
~~~

### 7.2 대체 실행 방법

~~~powershell
# 예시
java -jar build/libs/{{artifact-name}}.jar
~~~

### 7.3 스크립트 실행

~~~powershell
# 예시
./scripts/run.ps1
~~~

### 7.4 실행 확인

| 확인 항목 | 방법 | 기대 결과 |
|---|---|---|
| 애플리케이션 실행 여부 |  |  |
| 포트 확인 |  |  |
| Health Check |  |  |
| 로그 확인 |  |  |

---

## 8. 테스트 / 검증 절차

Phase 결과물이 의도대로 동작하는지 확인하는 절차를 정리한다.
아래 명령은 예시이며, 실제 프로젝트의 테스트/검증 명령으로 대체한다.

### 8.1 자동 테스트

~~~powershell
# 예시
./gradlew test
~~~

### 8.2 통합 테스트

~~~powershell
# 예시
./gradlew integrationTest
~~~

### 8.3 수동 검증

| 시나리오 | 절차 | 기대 결과 | 결과 |
|---|---|---|---|
|  |  |  |  |

### 8.4 API 검증

| API | Method | 검증 방법 | 기대 결과 |
|---|---|---|---|
|  |  |  |  |

### 8.5 DB 검증

| 확인 항목 | SQL / 방법 | 기대 결과 |
|---|---|---|
|  |  |  |

---

## 9. 로그 확인 방법

실행 중 문제를 확인하기 위한 로그 확인 방법을 정리한다.

### 9.1 애플리케이션 로그

~~~powershell
# 예시
Get-Content ./logs/app.log -Tail 100
~~~

### 9.2 시스템 로그

~~~powershell
# 예시
journalctl -u {{service-name}} -n 100
~~~

### 9.3 주요 로그 패턴

| 패턴 | 의미 | 조치 |
|---|---|---|
|  |  |  |

---

## 10. 복구 절차

실행 실패 또는 검증 실패 시 복구 절차를 정리한다.

### 10.1 설정 오류 복구

| 증상 | 원인 | 복구 방법 |
|---|---|---|
|  |  |  |

### 10.2 DB 오류 복구

| 증상 | 원인 | 복구 방법 |
|---|---|---|
|  |  |  |

### 10.3 실행 실패 복구

| 증상 | 원인 | 복구 방법 |
|---|---|---|
|  |  |  |

### 10.4 테스트 실패 복구

| 증상 | 원인 | 복구 방법 |
|---|---|---|
|  |  |  |

---

## 11. 롤백 절차

Phase 결과물을 이전 상태로 되돌려야 할 때의 절차를 정리한다.

### 11.1 Git 롤백

~~~powershell
# 예시: 변경 사항 확인
git status
git diff

# 예시: 특정 커밋으로 되돌리기 전 반드시 검토
git log --oneline -n 10
~~~

### 11.2 설정 롤백

| 설정 | 롤백 방법 | 주의사항 |
|---|---|---|
|  |  |  |

### 11.3 DB 롤백

| 항목 | 롤백 방법 | 주의사항 |
|---|---|---|
|  |  |  |

주의:

- DB 롤백은 데이터 손실 가능성을 먼저 확인한다.
- destructive 명령은 사람 승인 없이 실행하지 않는다.
- 롤백 전 현재 상태를 기록한다.

---

## 12. 운영 재현 절차

다른 환경에서 Phase 결과물을 다시 재현하기 위한 절차를 정리한다.

### 12.1 새 환경에서 재현

~~~powershell
# 예시
git clone {{repository-url}}
cd {{project-root}}
git checkout {{branch-or-tag}}
./gradlew test
./gradlew bootRun
~~~

### 12.2 재현 확인 체크리스트

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 저장소 clone 가능 |  |  |
| 필수 도구 설치 확인 |  |  |
| 설정 파일 준비 완료 |  |  |
| 의존성 다운로드 성공 |  |  |
| 테스트 통과 |  |  |
| 애플리케이션 실행 성공 |  |  |
| 주요 기능 검증 완료 |  |  |

---

## 13. 알려진 제한 사항

이 Phase 결과물의 제한 사항을 정리한다.

| 제한 사항 | 영향 | 후속 처리 |
|---|---|---|
|  |  |  |

예시:

~~~text
- 인증/인가는 Phase 1 범위에서 제외한다.
- 운영 DB 마이그레이션 자동화는 Phase 2 이후로 보류한다.
- 성능 테스트는 Cycle 3의 최소 재현 범위까지만 확인한다.
~~~

---

## 14. 후속 작업 후보

이 Phase를 진행하면서 발견된 후속 작업 후보를 정리한다.

후속 작업은 바로 구현하지 않는다.  
필요 시 `work/work-candidates.md`에 반영한다.

| Candidate | Reason | Suggested Status | Note |
|---|---|---|---|
|  |  | Proposed |  |

---

## 15. Phase 완료 확인

Phase 완료 전 다음 항목을 확인한다.

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 실행 방법이 정리되었는가? |  |  |
| 설정 절차가 정리되었는가? |  |  |
| 테스트 / 검증 절차가 정리되었는가? |  |  |
| 로그 확인 방법이 정리되었는가? |  |  |
| 복구 절차가 정리되었는가? |  |  |
| 롤백 절차가 필요한 경우 정리되었는가? |  |  |
| 운영 재현 절차가 정리되었는가? |  |  |
| 알려진 제한 사항이 정리되었는가? |  |  |
| 후속 후보가 `work-candidates.md`에 반영되었는가? |  |  |
| `phase-transition-checklist.md`를 통과했는가? |  |  |

---

## 16. 관련 문서

| 문서 | 역할 |
|---|---|
| `work/work-roadmap.md` | Phase / Cycle / Work Package / Task 전체 구조 |
| `work/work-index.md` | 현재 작업 포인터 |
| `work/work-log.md` | 최근 작업 결과와 sync 판단 |
| `manual/phase-transition-checklist.md` | Phase / Cycle 전환 체크리스트 |
| `status/current-status.md` | 현재 상태 요약 |
| `rules/affected-docs-rules.md` | 문서 변경 전파 규칙 |
| `history` | 상세 변경 이력 |

---

## 17. Codex 사용 기준

Codex는 이 문서를 작성하거나 보강할 때 다음을 따른다.

- 상태 보고가 아니라 실행자 관점의 절차를 작성한다.
- 실제 실행 가능한 명령과 확인 방법을 우선한다.
- 실행 방법, 설정 절차, 검증 절차, 복구 절차를 분리한다.
- 모르는 값을 임의로 채우지 않는다.
- 확인되지 않은 절차는 `확인 필요`로 표시한다.
- 현재 Phase 범위 밖 내용을 과도하게 포함하지 않는다.
- 후속 작업 후보는 바로 구현하지 않고 `work-candidates.md` 반영 대상으로 남긴다.
- 위험한 복구/삭제/롤백 명령은 사람 승인 없이 실행하지 않는다.

---

## 18. 금지 사항

다음을 금지한다.

- 이 문서를 상태 보고서처럼 작성하는 것
- 실행 방법 없이 완료 상태만 적는 것
- 검증 절차 없이 Phase 완료를 선언하는 것
- 복구 절차 없이 운영 준비 완료로 처리하는 것
- 확인하지 않은 명령을 확정 절차처럼 작성하는 것
- 현재 Phase 범위 밖 작업을 manual에 섞는 것
- 후속 후보를 manual 작성 중 바로 구현하는 것
- destructive 명령을 사람 승인 없이 실행하는 것
- `status/current-status.md`만 갱신하고 phase manual을 생략하는 것
