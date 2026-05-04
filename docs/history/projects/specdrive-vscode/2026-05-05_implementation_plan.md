# 구현 계획서: VSCode 확장 프로그램 관측성 및 제어 기능 강화

본 계획은 `specdrive-vscode` 랩 환경에서 Antigravity 상태 머신 로직과 VSCode 연동성을 더 정밀하게 검증하기 위해, 상태 표시 및 로깅 기능을 강화하는 것을 목표로 합니다.

## 사용자 검토 필요 사항

> [!IMPORTANT]
> VSCode 하단 바에 새로운 상태바(Status Bar) 항목이 추가됩니다.
> 로깅을 위해 "SpecDrive"라는 이름의 새로운 출력 채널(Output Channel)이 생성됩니다.

## 제안된 변경 사항

### [Component] VSCode 확장 프로그램 UI 및 로깅

#### [MODIFY] [extension.ts](file:///d:/dev/workspace/butgo-specdrive-workspace/butgo-specdrive-lab_antigravity/specdrive-vscode/src/extension.ts)
- `vscode.StatusBarItem`을 초기화하고 하단바에 배치합니다.
- `vscode.OutputChannel`을 초기화하여 "SpecDrive" 채널을 생성합니다.
- `specdrive.toggleMode` 명령어를 추가하여 Mock AI와 실재 AI(Antigravity) 모드를 전환할 수 있게 합니다.
- 상태 머신의 상태가 변할 때마다 상태바를 갱신하고 출력 채널에 로그를 남깁니다.

#### [MODIFY] [stateMachine.ts](file:///d:/dev/workspace/butgo-specdrive-workspace/butgo-specdrive-lab_antigravity/specdrive-vscode/src/core/state/stateMachine.ts)
- 상태 전이가 발생했을 때 확장 프로그램 측에 알림을 보낼 수 있도록 콜백 또는 이벤트 이미터를 추가합니다.

### [Component] AI 엔진 어댑터

#### [MODIFY] [AntigravityAdapter.ts](file:///d:/dev/workspace/butgo-specdrive-workspace/butgo-specdrive-lab_antigravity/specdrive-vscode/src/clients/AntigravityAdapter.ts)
- 디버깅을 위해 AI에 전송되는 원본 프롬프트와 수신된 응답을 출력 채널(Output Channel)에 로깅하는 로직을 추가합니다.

---

## 검증 계획

### 수동 검증
1. 확장 프로그램 개발 호스트(`F5`)를 실행합니다.
2. 하단 상태바에 "SpecDrive: IDLE"이 표시되는지 확인합니다.
3. `SpecDrive: Run Tasks` 명령을 실행하고 상태바가 PARSING -> GENERATING -> REVIEWING 순으로 변하는지 관찰합니다.
4. "출력(Output)" 패널을 열고 "SpecDrive" 채널을 선택하여 상세 로그가 출력되는지 확인합니다.
5. `SpecDrive: Toggle AI Mode` 명령을 실행하여 모드가 정상적으로 전환되는지 확인합니다.
