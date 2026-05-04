# 1번 모듈: VSCode Extension Controller 통합 완료

코어 로직(`stateMachine.ts`, `markdownParser.ts`)을 VSCode의 확장 프로그램(Extension) 환경에 연결하는 껍데기 작업이 완료되었습니다.

## 1. 구현 내역 요약

### 1) VSCode 플러그인 설정 완료
- `package.json`에 VSCode 엔진 지원 버전을 선언하고, `specdrive.run` 명령어를 등록했습니다.
- `@types/vscode` 의존성을 설치하여 TypeScript 환경에서 VSCode API를 호출할 수 있도록 세팅했습니다.

### 2) `extension.ts` (진입점) 작성 완료
- 사용자가 `Ctrl+Shift+P`에서 **`SpecDrive: Run Tasks`** 명령어를 실행하면 작동하는 로직을 만들었습니다.
- **동작 흐름**:
  1. 현재 활성화된(화면에 띄워진) 마크다운 문서의 전체 텍스트를 읽어옵니다.
  2. `MockAIEngine`과 `SpecDriveStateMachine`을 생성합니다.
  3. `stateMachine.start()`를 호출하여 파이프라인을 돌립니다.
  4. 상태가 `REVIEWING`에 도달하면 멈추고, VSCode 우측 하단 알림창에 **[승인] / [반려]** 버튼을 띄웁니다.
  5. 사용자가 '승인'을 누르면 코어 로직의 `.approve()`가 호출되며 워크플로우가 끝납니다.

## 2. 직접 테스트 해보는 방법 (로컬 환경)

현재 에디터에서 아래 방법으로 플러그인을 직접 실행해 보실 수 있습니다.

1. VSCode 에디터에서 `src/extension.ts` 파일을 엽니다.
2. 키보드의 **`F5`** 키를 눌러 "확장 프로그램 개발 호스트(Extension Development Host)"라는 새로운 VSCode 창을 띄웁니다.
3. 새로 뜬 창에서 임의의 `.md` 파일을 만들고 아래 내용을 적습니다.
   ```markdown
   ## 개발 할 일
   간단한 로그인 폼 작성
   ```
4. 해당 문서를 열어둔 상태에서 **`Ctrl+Shift+P`**를 누르고, **`SpecDrive: Run Tasks`**를 검색하여 실행합니다.
5. 우측 하단 알림창에서 단계별 메시지와 승인/반려 버튼이 뜨는지 확인해 보세요!
