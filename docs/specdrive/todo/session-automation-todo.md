# docs/specdrive/todo/session-automation-todo.md

## 1. 문서 목적

이 문서는 `session start` 와 `session save` 이후에 검토할 수 있는
**Codex 자동 실행 / IDE 연동 후보를 정리한 후속 검토 메모**다.

이 문서는 현재 확정 규칙이 아니다.
현재 `session` 단계의 기준은 `docs/specdrive/session-stage.md` 를 따른다.

이 문서는 나중에 개발자가 다음을 판단할 때 참고하기 위해 남긴다.

- `session start` 의 copy prompt 출력만으로 충분한가
- `session start -Execute` 같은 자동 실행을 둘 것인가
- `codex exec` 기반 자동 실행과 IDE Extension 연동을 어떻게 구분할 것인가
- Codex SDK 같은 별도 자동화 계층이 필요한가

---

## 2. 현재 기준

현재 `session` CLI는 다음 역할을 가진다.

- `session start`
  - 세션 복구에 필요한 문서 목록을 출력한다.
  - 현재 브랜치와 Git 변경 상태를 출력한다.
  - Codex 프롬프트에 붙여넣을 copy prompt 블록을 출력한다.

- `session save`
  - 현재 브랜치와 변경 파일 목록을 출력한다.
  - 세션 저장 요약 초안을 요청하는 copy prompt 블록을 출력한다.

현재 기준에서 `session` CLI는 Codex 프롬프트에 문맥을 자동 주입하지 않는다.
또한 session 출력 파일을 별도로 누적하지 않는다.

추가로 현재 판단은 다음과 같다.

- `session` 과 `git` 단계는 먼저 내부 skill 자산을 사용하도록 정리한다.
- 여기서 말하는 내부 skill 사용은 `specdrive/skills/session/**`, `specdrive/skills/git/**` 같은 작업 규칙 자산을 CLI 프롬프트 구성에 반영하는 것을 뜻한다.
- `codex exec`, IDE Extension, SDK 등을 통한 자동 실행은 차기 버전 검토 대상으로 둔다.
- `git branch-name`, `git git-message`, `git pr-message` 3종은 다시 계획할 예정이므로, 현재 자동화 설계의 기준으로 확정하지 않는다.
- `git commit`, PR 생성 같은 실제 GitHub/Git 실행 자동화도 차기 버전 범위로 둔다.

---

## 3. 검토 후보 1: copy prompt 유지

가장 안전한 현재 방식이다.

방식:

```powershell
specdrive/specdrive.ps1 session start
```

이 명령이 출력한 copy prompt 블록을 사람이 Codex 프롬프트에 붙여넣는다.

장점:

- 현재 문서 우선 / 사람 확인 원칙과 잘 맞는다.
- Codex Extension, CLI, Web 어느 환경에서도 사용할 수 있다.
- 자동 실행 권한 문제를 피할 수 있다.
- `session` 이 `doc` 또는 `dev` 작업을 대신하지 않는다.

단점:

- 사람이 복사/붙여넣기 해야 한다.
- 반복 작업에서는 약간 번거롭다.

현재 판단:

- 지금 단계의 기본 경로로 유지한다.

---

## 4. 검토 후보 2: `codex exec` 기반 자동 실행

`session start` 가 만든 프롬프트를 `codex exec` 로 넘기는 방식이다.

예상 명령 후보:

```powershell
specdrive/specdrive.ps1 session start -Execute
```

또는 저수준 연결 예:

```powershell
specdrive/specdrive.ps1 session start | codex exec -
```

역할:

- 세션 복구 프롬프트를 Codex CLI에 넘긴다.
- Codex가 문서를 읽고 현재 상태를 요약하게 한다.
- 결과는 콘솔 또는 별도 output 파일로 받을 수 있다.

도입 전 확인할 점:

- `session start -Execute` 가 실제 문서 수정까지 허용하면 안 된다.
- 기본 sandbox / approval 정책을 어떻게 둘지 정해야 한다.
- 결과를 콘솔 출력으로만 둘지, `.speclab/session-output/**` 같은 파일로 남길지 결정해야 한다.
- `doc reinforce -Execute` 와 같은 exec wrapper를 재사용할지 별도 session exec wrapper를 둘지 정해야 한다.

현재 판단:

- copy prompt 출력이 몇 차례 검증된 뒤 후속 후보로 검토한다.
- 자동 실행을 넣더라도 "상태 복구 요청"까지만 담당하고 문서 수정은 하지 않는 방향이 안전하다.

---

## 4.1 역할 분리와 실행 모드 후보

후속 자동화 검토 시 역할은 다음처럼 분리해서 본다.

- Skill
  - Codex가 따르는 절차다.
  - 어떤 문서를 읽고, 어떤 순서로 요약하며, 어디서 사람 확인을 받아야 하는지 정의한다.
- `specflow.ps1`
  - 프롬프트를 만들거나 로컬 상태를 수집하는 도구다.
  - 현재 `specdrive.ps1` 단일 진입점과 이름/역할 관계는 별도 검토한다.
- VSCode Codex
  - 사람이 붙여넣은 프롬프트를 실행하는 IDE 연동 실행자다.
  - 현재 기준에서는 사람이 copy prompt를 붙여넣어 이어서 대화하는 인터페이스로 본다.
- `codex exec` / SDK
  - 사람이 붙여넣지 않아도 실행되게 하는 자동화 수단이다.
  - 자동 실행을 도입하더라도 문서 수정은 별도 승인 흐름으로 분리한다.

세션 저장 자동화 후보 명령 형태는 다음처럼 검토할 수 있다.

```powershell
.\specflow.ps1 session save --mode prompt
.\specflow.ps1 session save --mode file
.\specflow.ps1 session save --mode clipboard
.\specflow.ps1 session save --mode agent
```

각 mode의 의미 후보는 다음과 같다.

- `prompt`
  - 콘솔에 copy prompt를 출력한다.
  - 현재 기본 방식과 가장 가깝다.
- `file`
  - 세션 저장 초안이나 prompt를 파일로 남긴다.
  - `.speclab/session-output/**` 같은 출력 위치는 별도 검토한다.
- `clipboard`
  - 생성된 prompt를 클립보드에 복사한다.
  - IDE Extension 직접 주입이 없을 때 반복 복사 부담을 줄이는 중간 단계로 볼 수 있다.
- `agent`
  - `codex exec` 또는 SDK를 통해 자동 실행한다.
  - 차기 버전 자동화 후보로 두며, 현재 기본 경로로 확정하지 않는다.

현재 선호하는 검증 순서는 다음과 같다.

1. Skill만 만든다.
   - `session-start`
   - `session-save`
   - repo local 설치 위치:
     - `.agents/skills/session-start/SKILL.md`
     - `.agents/skills/session-save/SKILL.md`
   - 배포/패키징 후보 원본 위치:
     - `specdrive/codex-skills/session-start/SKILL.md`
     - `specdrive/codex-skills/session-save/SKILL.md`
   - 테스트 중에는 전역 `~/.agents/skills/**` 또는 `~/.codex/skills/**` 에 설치하지 않는다.
2. Codex에서 직접 호출한다.
   - `$session-start`
   - `$session-save`
3. 5~10번 실제 세션에서 사용하면서 절차를 다듬는다.
4. 정말 반복되는 부분만 `specflow.ps1` 로 뺄지 검토한다.

4단계는 현재 확정이 아니다.  
Skill 직접 사용만으로 충분한지, CLI로 빼야 할 반복 부분이 실제로 누적되는지 확인한 뒤 판단한다.

---

## 5. 검토 후보 3: Codex IDE Extension 직접 연동

Codex IDE Extension의 현재 공식 문서 기준으로는 다음 기능이 확인된다.

- IDE 사이드바에서 Codex 사용
- 현재 thread에 선택 영역 추가
- 현재 thread에 파일 추가
- 새 Codex panel 또는 새 chat 생성

다만 외부 CLI가 IDE Extension의 현재 입력창에 임의 프롬프트를 자동 주입하고 실행하는 공개 인터페이스는 현재 확인된 범위에서는 명확하지 않다.

따라서 이 후보는 다음처럼 본다.

- 지금 바로 구현하지 않는다.
- 공식 extension command 또는 API가 명확해질 때 다시 검토한다.
- 현재는 IDE Extension을 사람이 이어서 대화하는 인터페이스로 보고, 자동 실행은 CLI 쪽에서 다룬다.

현재 판단:

- 보류한다.

---

## 6. 검토 후보 4: Codex SDK 기반 자동화

Codex SDK를 사용하면 별도 프로그램에서 Codex thread를 만들고 prompt를 실행하는 구조를 만들 수 있다.

가능한 방향:

- specdrive 전용 session runner 작성
- session start/save prompt를 SDK로 실행
- 결과를 구조화해서 콘솔 또는 상태 문서 반영 후보로 출력

도입 전 확인할 점:

- Node.js 기반 SDK 의존성을 현재 PowerShell 중심 구조에 넣을 필요가 있는가
- specdrive가 아직 alpha 검증 단계인데 SDK 계층이 과하지 않은가
- `codex exec` 로 충분한 일을 SDK로 다시 만드는 것은 아닌가

현재 판단:

- 장기 후보로만 둔다.
- 먼저 `codex exec` 기반 자동 실행으로 충분한지 확인한다.

---

## 7. 추천 구현 순서 후보

후속으로 자동화를 검토한다면 다음 순서가 자연스럽다.

1. `session start` / `session save` copy prompt 품질을 몇 차례 실제 세션에서 검증한다.
2. `session start -Execute` 를 문서 수정 없는 read-only 실행으로 설계한다.
3. `codex exec` 호출 시 sandbox, approval, output 저장 여부를 정한다.
4. 필요하면 `session save -Execute` 는 상태 문서 수정이 아니라 요약 초안 생성까지만 담당하게 한다.
5. IDE Extension 직접 주입은 공식 지원 경로가 확인될 때 다시 검토한다.
6. Codex SDK는 CLI 기반 자동 실행이 부족할 때 별도 설계로 검토한다.

---

## 8. 현재 보류 결정

현재는 아래를 확정하지 않는다.

- `session start -Execute` 도입
- `session save -Execute` 도입
- `.speclab/session-output/**` 생성
- Codex IDE Extension 직접 주입
- Codex SDK 기반 session runner
- `git commit` 자동 실행
- GitHub PR 자동 생성
- 현재 `git` 3종 명령의 최종 구조

현재 확정된 것은 다음뿐이다.

- `session` 명령은 copy prompt를 출력한다.
- 사람이 필요한 경우 그 prompt를 Codex에 붙여넣는다.
- 영속 반영은 사람이 검토한 뒤 관련 문서에 직접 반영한다.
- 자동 실행보다 먼저 `session` / `git` 단계가 내부 skill 자산을 사용하도록 정리한다.

---

## 9. 최종 정리

현재 단계에서 가장 좋은 기준은
**copy prompt 출력은 현재 기능, 자동 실행은 후속 검토 후보**로 분리하는 것이다.

자동 실행은 가능성이 있지만, 지금 바로 `session` 단계의 기본 동작으로 넣기에는 이르다.
특히 `session` 이 `doc` 또는 `dev` 작업을 대신하지 않도록,
자동화는 세션 복구와 요약 초안 생성에만 제한하는 방향으로 검토한다.
