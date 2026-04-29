# docs/projects/board/AGENTS.compact.md

## 1. 역할

이 문서는 `docs/projects/board/AGENTS.md`의 대체 원본이 아니다.

이 문서는 Codex 기본 주입용 compact 규칙이다.  
board 문서 작업에서 긴 원본을 매번 읽지 않기 위해 필요한 실행 규칙만 남긴다.

원본 `docs/projects/board/AGENTS.md`는 board 전용 기준 문서로 그대로 유지한다.

---

## 2. board의 성격

board는 specdrive의 기능이 아니다.

board는 specdrive가 다루는 실제 애플리케이션 프로젝트다.  
현재는 specdrive의 문서 기반 AI 협업 방식이 실제 프로젝트에도 유효한지 검증하기 위해 같은 저장소에서 운영한다.

board 문서는 실제 애플리케이션 개발 내용을 다룬다.

---

## 3. board 문서가 다루는 것

board 문서는 다음을 다룬다.

- 요구사항
- 설계
- 구현 계획
- 상태
- 히스토리
- 기능 단위 결정
- 패키지와 레이어 구성
- API/DB 정책의 board 적용 판단

board 문서는 specdrive 운영 규칙을 설명하는 문서가 아니다.

---

## 4. specdrive 운영 규칙을 과하게 넣지 않는다

board 문서에 다음을 중심 내용으로 넣지 않는다.

- specdrive 자체 CLI 자동화 설계
- specdrive skill 구조
- Codex exec 상세 설계
- specdrive 전용 협업 절차
- 저장소 전체 공통 운영 규칙

이런 내용은 루트 문서나 `docs/specdrive/**`에서 다룬다.

board 문서에는 board가 무엇을 만들고, 어떤 구조로 만들고, 어떤 순서로 구현할지를 적는다.

---

## 5. 문서 역할 분리

board 문서는 역할을 섞지 않는다.

- 요구사항 문서: 무엇을 할지
- 설계 문서: 어떤 구조로 할지
- 구현 계획 문서: 어떤 순서로 만들지
- 상태 문서: 현재 어디까지 왔는지
- 히스토리 문서: 어떤 판단과 산출물이 남았는지

요구사항에서 설계로, 설계에서 구현 계획으로 넘어갈 때는 개발자 확인을 먼저 받는다.

---

## 6. 현재 구조 방향

현재 board는 Spring Boot 기반 레이어드 구조를 우선한다.

현재 결정:

- 처음부터 과한 구조 확장을 하지 않는다.
- 현재는 레이어드 구조를 기준으로 문서와 구현을 정리한다.
- 헥사고날 구조는 필요성이 검증된 뒤 후속 후보로 검토한다.
- 추상적인 구조 이상론보다 현재 채택한 구조와 이유를 명확히 쓴다.

후속 후보:

- 도메인 규칙이 복잡해질 경우 계층 분리 강화 검토
- 헥사고날 전환 필요성 검토

---

## 7. standards 적용 원칙

board는 필요 시 `docs/projects/standards/**`의 공통 기준을 참조한다.

예:

- naming
- java coding
- db
- api
- package structure
- git policy

board 문서에는 공통 기준 전체를 복사하지 않는다.  
board에 어떻게 적용할지, 예외가 있는지, 현재 어떤 판단을 채택했는지만 적는다.

---

## 8. 작업 시 주의

- board를 specdrive 내부 기능처럼 다루지 않는다.
- 현재 범위와 후속 후보를 구분한다.
- 검증용 프로젝트라는 이유로 문서 품질 기준을 낮추지 않는다.
- 구현 상세를 문서 확정 전에 과도하게 밀어넣지 않는다.
- 공통 standards와 충돌하는 board 고유 규칙을 근거 없이 만들지 않는다.

---

## 9. compact/read-minimal 원칙

기본은 이 compact 문서와 대상 board 문서만 읽는다.

다음은 필요할 때만 읽는다.

- 원본 `docs/projects/board/AGENTS.md`
- 관련 standards 문서
- 참조 문서
- bundle 문서
- `docs/history/**`

원본 규칙을 수정하거나 board 문서 역할 경계가 애매하면 full 원본을 읽는다.

---

## 10. 현재 결정

- board는 실제 애플리케이션 프로젝트 문서군이다.
- board 문서는 specdrive 운영 규칙이 아니라 board 개발 내용을 다룬다.
- 현재 구조는 Spring Boot 레이어드 구조 우선이다.
- standards는 참조하되 board 적용 판단만 기록한다.

---

## 11. 후속 후보

- board 문서 bundle에서 compact 문서를 우선 읽도록 조정한다.
- board 문서별 thin prompt/template 분리를 검토한다.
- 구현 단계 진입 전 standards 적용 체크를 더 짧게 자동화한다.
