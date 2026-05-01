# Templates

## 1. 문서 목적

이 문서는 SpecDrive에서 제공하는 문서 템플릿의 역할과 사용 방법을 설명한다.

`templates/` 디렉터리는 프로젝트별 문서를 처음 구성할 때 복사해서 사용할 기준 템플릿을 보관한다.

템플릿은 완성된 프로젝트 문서가 아니다.  
각 프로젝트의 목적, Phase, Cycle, Work Package, 실행 환경에 맞게 복사 후 수정해서 사용한다.

---

## 2. 템플릿 사용 원칙

템플릿 사용 원칙은 다음과 같다.

- 템플릿은 프로젝트 문서의 시작점이다.
- 템플릿을 그대로 확정 문서로 사용하지 않는다.
- 프로젝트 상황에 맞지 않는 섹션은 삭제하거나 `N/A`로 표시한다.
- 모르는 값은 임의로 채우지 않는다.
- 확인되지 않은 내용은 `확인 필요`로 표시한다.
- 프로젝트별 정책은 `work-policy.md`에 명시한다.
- 프로젝트별 실행 절차는 `manual/` 문서에 명시한다.
- 템플릿 수정은 기존 프로젝트 문서에 영향을 줄 수 있으므로 필요한 최소 범위로 수행한다.

---

## 3. 템플릿 구조

현재 템플릿 구조는 다음과 같다.

~~~text
templates/
|-- README.md
|
|-- work/
|   |-- README.template.md
|   |-- work-candidates.template.md
|   |-- work-policy.template.md
|   |-- work-roadmap.template.md
|   |-- work-index.template.md
|   +-- work-log.template.md
|
|-- manual/
|   |-- project-manual.template.md
|   |-- phase-manual.template.md
|   +-- phase-transition-checklist.template.md
|
+-- rules/
    +-- affected-docs-rules.template.md
~~~

---

## 4. Work Templates

`work/` 템플릿은 프로젝트의 작업 운영 문서를 만들기 위한 템플릿이다.

Work System은 다음 흐름을 기준으로 한다.

~~~text
work-candidates.md
  ↓ review / promote

work-roadmap.md
  ↓ select current scope

work-index.md
  ↓ run

Codex / Developer execution
  ↓ sync

work-log.md
~~~

### 4.1 README.template.md

복사 대상:

~~~text
project/work/README.md
~~~

역할:

- 프로젝트별 `work/` 디렉터리 사용 방법 설명
- Candidate / Roadmap / Index / Log 관계 설명
- 사람이 읽는 순서와 Codex가 읽는 순서 안내
- Candidate 생성과 승격 기준 안내

---

### 4.2 work-candidates.template.md

복사 대상:

~~~text
project/work/work-candidates.md
~~~

역할:

- 아직 확정되지 않은 작업 후보 관리
- Codex가 프로젝트 문서에서 추출한 후보 초안 관리
- Candidate 상태 관리
- Accepted / Deferred / Rejected / Merged / Needs Clarification 판단 지원

원칙:

~~~text
Candidate는 바로 Task가 아니다.
Accepted Candidate만 Roadmap에 승격된다.
~~~

---

### 4.3 work-policy.template.md

복사 대상:

~~~text
project/work/work-policy.md
~~~

역할:

- 프로젝트별 Work System 적용 정책 정의
- Candidate 생성/검토/승격 기준 정의
- Phase / Cycle / Work Package / Task 기준 정의
- Codex 실행 제한 기준 정의
- 상태 전환 기준 정의

---

### 4.4 work-roadmap.template.md

복사 대상:

~~~text
project/work/work-roadmap.md
~~~

역할:

- 확정된 전체 작업 구조 관리
- Accepted Candidate를 Phase / Cycle / Work Package / Task 구조로 승격
- 완료 기준과 검증 기준 관리
- Deferred Roadmap Item 관리

원칙:

~~~text
전체 작업 구조는 work-roadmap.md에서 관리한다.
현재 작업 포인터는 work-index.md에서 관리한다.
~~~

---

### 4.5 work-index.template.md

복사 대상:

~~~text
project/work/work-index.md
~~~

역할:

- 현재 작업 포인터 관리
- Current Phase / Cycle / Work Package / Focus 표시
- Codex가 현재 작업을 판단할 기준 제공
- 다음 Task와 Blocker 관리

원칙:

~~~text
work-index.md는 전체 Roadmap을 반복하지 않는다.
현재 실행 위치만 짧게 관리한다.
~~~

---

### 4.6 work-log.template.md

복사 대상:

~~~text
project/work/work-log.md
~~~

역할:

- 최근 작업 실행 결과 요약
- sync 판단 기록
- 다음 작업 판단 기록
- 새 Candidate 발견 기록
- status/manual/history 갱신 필요 여부 기록

원칙:

~~~text
work-log.md는 상세 history 저장소가 아니다.
상세 변경 이력은 기존 history 관리 방식을 따른다.
~~~

---

## 5. Manual Templates

`manual/` 템플릿은 프로젝트 실행, 검증, 복구, 재현 절차를 만들기 위한 템플릿이다.

Manual 문서는 상태 보고서가 아니라 실행자 관점의 절차 문서다.

~~~text
work = 작업 진행
manual = 실행 재현
status = 현재 상태 요약
history = 상세 변경 이력
~~~

### 5.1 project-manual.template.md

복사 대상:

~~~text
project/manual/project-manual.md
~~~

역할:

- 프로젝트 전체 공통 실행 매뉴얼
- 공통 실행/설정/검증/복구/롤백 절차 정리
- Phase manual 목록 연결
- 운영 재현 절차 정리

---

### 5.2 phase-manual.template.md

복사 대상:

~~~text
project/manual/phases/phase-XX-manual.md
~~~

역할:

- Phase별 실행자 매뉴얼
- Phase 산출물 실행 방법 정리
- Phase별 설정/검증/로그/복구/롤백 절차 정리
- Phase별 운영 재현 절차 정리
- 후속 작업 후보 정리

원칙:

~~~text
Cycle 3 산출물은 status 문서보다 phase manual에 우선 정리한다.
~~~

---

### 5.3 phase-transition-checklist.template.md

복사 대상:

~~~text
project/manual/phase-transition-checklist.md
~~~

역할:

- Cycle 전환 전 확인
- Phase 전환 전 확인
- 완료 기준과 검증 기준 확인
- blocker와 decision 항목 확인
- manual/status/history 갱신 여부 확인

---

## 6. Rules Templates

`rules/` 템플릿은 프로젝트별 운영 규칙 문서를 만들기 위한 템플릿이다.

`specdrive/docs/templates/rules/` 는 프로젝트에 복사해서 사용할 시작 문서만 둔다.  
SpecDrive Core 자체의 운영 규칙은 `specdrive/docs/rules/` 에 둔다.

### 6.1 affected-docs-rules.template.md

복사 대상:

~~~text
project/rules/affected-docs-rules.md
~~~

역할:

- 문서 변경 시 함께 검토해야 할 영향 문서 정의
- specs / work / manual / status / AGENTS / README 변경 전파 기준 정의
- Codex가 문서 변경 후 영향 문서를 제안할 기준 제공
- 프로젝트별 문서 구조에 맞춘 변경 전파 규칙의 시작점 제공

원칙:

~~~text
모든 문서를 무조건 수정하지 않는다.
영향 가능성이 높은 문서만 검토한다.
수정이 필요 없으면 No Change로 기록한다.
~~~

---

## 7. 프로젝트 적용 순서

새 프로젝트에 템플릿을 적용할 때는 다음 순서를 권장한다.

~~~text
1. manual/project-manual.md
2. work/README.md
3. work/work-policy.md
4. work/work-candidates.md
5. work/work-roadmap.md
6. work/work-index.md
7. work/work-log.md
8. manual/phase-transition-checklist.md
9. manual/phases/phase-XX-manual.md
10. rules/affected-docs-rules.md
~~~

단, 실제 프로젝트에서 먼저 필요한 문서가 있다면 순서를 조정할 수 있다.

초기 프로젝트에서는 다음 최소 세트를 먼저 만들 수 있다.

~~~text
work/README.md
work/work-policy.md
work/work-candidates.md
work/work-roadmap.md
work/work-index.md
~~~

---

## 8. Codex 사용 기준

Codex는 템플릿을 프로젝트 문서로 적용할 때 다음 기준을 따른다.

- 템플릿을 그대로 복사한 뒤 프로젝트 상황에 맞게 최소 수정한다.
- 모르는 값을 임의로 채우지 않는다.
- 확인되지 않은 내용은 `확인 필요`로 표시한다.
- Candidate는 바로 Task로 확정하지 않는다.
- Accepted Candidate만 Roadmap에 승격한다.
- 현재 작업 포인터는 `work-index.md`에만 둔다.
- 전체 작업 구조는 `work-roadmap.md`에 둔다.
- 실행/검증/복구 절차는 `manual/` 문서에 둔다.
- 문서 변경 후 `rules/affected-docs-rules.md` 기준으로 영향 문서를 점검한다.

---

## 9. 템플릿 수정 기준

템플릿 자체를 수정할 때는 다음을 확인한다.

| 확인 항목 | 결과 | 비고 |
|---|---|---|
| 기존 프로젝트 문서와 충돌하지 않는가? |  |  |
| Work System 기준과 충돌하지 않는가? |  |  |
| Candidate / Roadmap / Index / Log 역할이 유지되는가? |  |  |
| Manual 문서가 상태 보고서처럼 변하지 않았는가? |  |  |
| Rules 템플릿이 모든 문서 수정을 강제하지 않는가? |  |  |
| README의 템플릿 목록이 실제 파일 구조와 맞는가? |  |  |
| 관련 템플릿도 함께 수정해야 하는가? |  |  |

---

## 10. 금지 사항

다음을 금지한다.

- 템플릿을 프로젝트 확정 문서처럼 사용하는 것
- 프로젝트별 판단이 필요한 값을 임의로 채우는 것
- Candidate를 바로 Task로 확정하는 구조로 템플릿을 변경하는 것
- Roadmap과 Index의 역할을 섞는 것
- work-log를 상세 history 저장소로 만드는 것
- manual 문서를 status 문서처럼 작성하는 것
- affected-docs-rules를 모든 문서 강제 수정 규칙으로 사용하는 것
- 템플릿 변경만으로 기존 프로젝트 문서가 자동 변경된 것으로 간주하는 것
