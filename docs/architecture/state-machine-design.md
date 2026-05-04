# SpecDrive 핵심 아키텍처 및 상태 제어기(State Machine) 설계서

## 1. 문서 목적
본 문서는 SpecDrive(VSCode 플러그인)의 핵심 제어 흐름을 담당하는 `stateMachine.ts`의 생명주기와 구성 요소 간의 역할 분담을 정의한다. 본 설계는 Spring StateMachine 및 상태(State) 패턴의 철학을 차용하여 AI 코딩 파이프라인을 통제한다.

---

## 2. 전체 아키텍처 조감도 (역할 분담)

VSCode 플러그인 내부의 핵심 모듈은 다음과 같이 역할을 분담하여 '단일 책임 원칙(SRP)'을 준수한다.

1. **`extension.ts` (Controller)**
   - VSCode 명령어(`Ctrl+Shift+P`)를 수신하는 플러그인의 메인 진입점.
2. **`stateMachine.ts` (Orchestrator / Service)**
   - 시스템의 현재 '상태'를 관리하며, 각 Worker들을 조율하여 전체 워크플로우를 통제한다.
3. **`markdownParser.ts` (Worker 1 - 통제/보호)**
   - 정규식(Regex)을 이용해 기획서(Markdown)에서 현재 실행할 Task(Work Package) 내용만 정확히 추출한다.
4. **`antigravityClient.ts` (Worker 2 - AI 엔진)**
   - 파싱된 텍스트와 프롬프트를 Antigravity (또는 타 LLM) API로 전송하고 결과를 수신한다.

---

## 3. State Machine 생명주기 (Life Cycle)

워크플로우는 다음 5가지 주요 상태(State)와 전이(Transition) 규칙을 가진다.

* **[상태 1] `IDLE` (대기 중)**
  - 초기 상태. 사용자가 명령어를 입력하기 전.
  - *Trigger:* 플러그인 실행 명령어 수신 ➡️ `PARSING` 상태로 전이.

* **[상태 2] `PARSING` (기획서 분석 중)**
  - `markdownParser.ts`를 호출하여 기획서에서 필요한 Task를 추출한다.
  - *Trigger (성공):* 텍스트 추출 완료 ➡️ `GENERATING` 상태로 전이.
  - *Trigger (실패):* 파싱 에러 또는 대상 없음 ➡️ 에러 알림 후 `IDLE`로 복귀.

* **[상태 3] `GENERATING` (AI 코드 생성 중)**
  - 파싱된 컨텍스트를 `antigravityClient.ts`에 전달하여 코드를 생성한다. (로딩 UI 표시)
  - *Trigger (성공):* Valid한 JSON 응답 수신 ➡️ `REVIEWING` 상태로 전이.
  - *Trigger (실패):* API 타임아웃 또는 JSON 파싱 에러 ➡️ `IDLE` 복귀 또는 재시도.

* **[상태 4] `REVIEWING` (인간 승인 대기 중) ★ 핵심 통제 구간**
  - 생성된 코드를 파일에 즉시 쓰지 않고 VSCode Webview에 Diff로 표시한 뒤, 워크플로우를 일시 정지(Pause)한다.
  - *Trigger (Approve):* 사용자가 '승인' 버튼 클릭 ➡️ `APPLYING` 상태로 전이.
  - *Trigger (Reject):* 사용자가 '반려' 및 피드백 입력 ➡️ 피드백 컨텍스트를 추가하여 `GENERATING` 상태로 롤백.

* **[상태 5] `APPLYING` (파일 적용 및 완료)**
  - 승인된 코드를 실제 로컬 파일 시스템(`.java` 등)에 기록한다.
  - *Trigger:* 파일 I/O 완료 ➡️ `IDLE` 상태로 복귀하여 다음 작업 대기.

---

## 4. TypeScript 코어 뼈대 (Reference)
```typescript
// 1. 상태 정의
export enum WorkflowState {
    IDLE = 'IDLE',
    PARSING = 'PARSING',
    GENERATING = 'GENERATING',
    REVIEWING = 'REVIEWING',
    APPLYING = 'APPLYING'
}

// 2. 상태 제어기 클래스
export class SpecDriveStateMachine {
    private currentState: WorkflowState = WorkflowState.IDLE;
    private currentContext: any = {}; // 공용 DTO (파싱 텍스트, 생성 코드 보관)

    // 전이 및 라우팅 로직
    public async transitionTo(nextState: WorkflowState, payload?: any) {
        console.log(`[Transition] ${this.currentState} -> ${nextState}`);
        this.currentState = nextState;

        switch (this.currentState) {
            case WorkflowState.PARSING:
                await this.handleParsing(payload);
                break;
            case WorkflowState.GENERATING:
                await this.handleGenerating();
                break;
            case WorkflowState.REVIEWING:
                this.handleReviewing(payload); // Webview 연동 및 이벤트 대기
                break;
            case WorkflowState.APPLYING:
                await this.handleApplying();
                break;
            case WorkflowState.IDLE:
                this.currentContext = {}; // 컨텍스트 초기화
                break;
        }
    }

    private async handleParsing(taskId: string) {
        // ... 정규식 파서 로직 연동 ...
    }
    
    // ... 기타 핸들러 메서드 구현 ...
}