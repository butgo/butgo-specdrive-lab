# 정규식 파서 및 상태 제어기 TypeScript 구현 및 테스트 계획

나중에 VSCode 플러그인으로 확장이 가능하면서도, 현재 순수 비즈니스 로직(파서, 상태 제어기)을 쉽게 테스트할 수 있는 폴더 구조와 환경 설정 계획입니다.

## User Review Required

> [!IMPORTANT]
> 아래 제안하는 폴더 구조와 기술 스택(TypeScript + Jest)이 마음에 드시는지 확인 부탁드립니다. 승인해 주시면 즉시 `package.json` 생성 및 기본 환경 설정을 시작하겠습니다.

## 1. 폴더 구조 추천

이 저장소가 문서(docs)와 스킬(.agents)을 포함하는 거대한 랩(Lab) 환경이므로, 실제 확장 프로그램 코드가 들어갈 독립된 디렉터리(`specdrive-vscode` 또는 `packages/core`)를 구성하는 것을 추천합니다. 여기서는 루트 아래에 `specdrive-vscode`라는 디렉터리를 만든다고 가정합니다.

```text
butgo-specdrive-lab_antigravity/
├── .agents/
├── docs/
├── specdrive-vscode/        <-- 🌟 신규 생성 (VSCode 플러그인 본체 및 테스트)
│   ├── package.json         <-- 의존성 관리 (TypeScript, Jest 등)
│   ├── tsconfig.json        <-- TS 컴파일 설정
│   ├── jest.config.js       <-- 테스트 프레임워크 설정
│   ├── src/                 <-- 🚀 실제 프로덕션 코드 (나중에 배포될 코드)
│   │   ├── core/            <-- VSCode API에 의존하지 않는 '순수 비즈니스 로직'
│   │   │   ├── parser/
│   │   │   │   └── markdownParser.ts  (정규식 파서)
│   │   │   └── state/
│   │   │       ├── stateMachine.ts    (상태 제어기)
│   │   │       └── types.ts           (상태 Enum, 인터페이스 정의)
│   │   ├── clients/         
│   │   │   └── antigravityClient.ts   (추후 구현할 API 클라이언트)
│   │   └── extension.ts     <-- 추후 VSCode 플러그인의 진입점이 될 파일
│   └── tests/               <-- 🧪 테스트 코드 전용 폴더 (배포 시 제외됨)
│       ├── fixtures/        <-- 테스트용 더미 파일 (예: dummy-spec.md)
│       ├── parser/
│       │   └── markdownParser.test.ts
│       └── state/
│           └── stateMachine.test.ts
```

### 이 구조의 장점
1. **관심사 분리**: `src/core/` 내부에 있는 코드는 VSCode의 특정 API(`vscode.*`)를 절대 import 하지 않도록 설계합니다. 이렇게 하면 터미널, 웹, VSCode 어디서든 재사용이 가능하고 테스트가 매우 쉽습니다.
2. **테스트 편의성**: `tests/` 폴더를 `src/` 밖으로 빼서 배포 패키지(`vsix`) 빌드 시 테스트 코드가 섞여 들어가는 것을 방지합니다. 또한 `fixtures/` 폴더를 통해 다양한 포맷의 마크다운 파일을 만들어두고 파서가 잘 동작하는지 쉽게 검증할 수 있습니다.

## 2. 기술 스택 및 환경 설정

*   **언어**: TypeScript
*   **테스트 프레임워크**: Jest + `ts-jest` (VSCode 플러그인 및 순수 TS 로직 테스트에 가장 범용적이고 설정이 직관적입니다.)
*   **린터/포매터**: ESLint + Prettier (추후 협업을 위해 기본 세팅)

## 3. Proposed Changes (구현 단계)

승인해 주시면 다음 작업을 순차적으로 실행하겠습니다.

### 단계 1: 프로젝트 초기화
#### [NEW] `specdrive-vscode/package.json`
- `npm init` 실행 및 `typescript`, `jest`, `@types/jest`, `ts-jest` 설치
- `npm run test` 스크립트 등록

#### [NEW] `specdrive-vscode/tsconfig.json` & `jest.config.js`
- TypeScript 및 Jest 환경 설정 파일 생성

### 단계 2: 코어 뼈대 작성
#### [NEW] `specdrive-vscode/src/core/state/types.ts`
- `WorkflowState` Enum 및 컨텍스트 인터페이스 작성
#### [NEW] `specdrive-vscode/src/core/state/stateMachine.ts`
- 5단계 상태 전이 로직 작성
#### [NEW] `specdrive-vscode/src/core/parser/markdownParser.ts`
- 정규식 기반 Task 추출 함수 뼈대 작성

### 단계 3: 테스트 뼈대 작성
#### [NEW] `specdrive-vscode/tests/state/stateMachine.test.ts`
- 상태 전이가 정상적으로 일어나는지 검증하는 단위 테스트 작성
#### [NEW] `specdrive-vscode/tests/parser/markdownParser.test.ts`
- 임시 문자열을 기반으로 파싱 결과를 확인하는 단위 테스트 작성

## 4. Verification Plan (검증 계획)

1. **자동화 테스트 실행**:
   - `cd specdrive-vscode && npm run test`를 실행하여 모든 Jest 테스트가 통과하는지 확인합니다.
2. **상태 로그 확인**:
   - State Machine이 `IDLE` -> `PARSING` -> `GENERATING` 등으로 전이될 때 올바른 트랜지션 로그가 찍히는지 테스트 결과를 통해 확인합니다.
