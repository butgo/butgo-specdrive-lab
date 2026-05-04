# specdrive-vscode 영역 작업 규칙 (AGENTS.md)

## 1. 목적 및 현재 단계 (Study Phase)
이 `specdrive-vscode` 디렉터리는 현재 **"공부 혹은 로직 파악을 위한 중간 검증 단계"**입니다.
본격적인 제품 개발 전, 순수 비즈니스 로직(파서, 상태 제어기 등)을 실험하고 학습하는 목적으로 사용됩니다.

## 2. Artifact 자동 보존 예외 규칙 (Auto-Save Rule)
루트 `AGENTS.md`의 엄격한 "명시적 승인 전 파일 생성 금지" 원칙에도 불구하고, 현재 이 영역이 **학습 및 로직 파악 단계**임을 감안하여 다음의 예외 규칙을 적용합니다.

*   **규칙**: AI(Antigravity 등)가 Planning Mode에서 작성한 중요한 기획 산출물(`implementation_plan.md`)과 작업 결과 요약(`walkthrough.md`)은, 개발자의 별도 요청이 없더라도 작업 완료 시점에 **자동으로 아래의 히스토리 경로에 복사하여 보존**해야 합니다.

*   **저장 경로 (History Target)**:
    `docs/history/projects/specdrive-vscode/`

*   **파일명 규칙**:
    `yyyy-MM-dd_implementation_plan.md`
    `yyyy-MM-dd_walkthrough.md`

이 규칙은 학습 기록이 휘발되는 것을 막고, 추후 VSCode 플러그인 본 작업 시 이전의 설계 고민을 즉시 꺼내볼 수 있도록 하기 위함입니다. 본 단계가 끝나고 정식 제품화 단계로 넘어갈 경우 이 규칙은 재검토합니다.

## 3. Git 작업 원칙
*   **규칙**: 기본적으로 Git 작업(Commit, Push, Pull 등)은 **사용자가 직접 수행**합니다.
*   AI(Antigravity 등)는 개발자의 명시적인 요청("Git 커밋해 줘", "푸시해 줘")이 있을 때만 보조적으로 Git 명령어를 실행합니다.
