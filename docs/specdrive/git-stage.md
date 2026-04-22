# docs/specdrive/git-stage.md

## 1. 문서 목적

이 문서는 specdrive의 `git` 단계를  
**브랜치명 생성, Git commit message 생성, PR 제목/설명 생성 같은 Git 전달 흐름을 다루는 별도 작업 단계**로 정리하는 문서다.

목적은 다음과 같다.

- `git` 이 왜 `session` 과 분리되어야 하는지 설명한다.
- `git branch-name`, `git git-message`, `git pr-message` 의 역할을 고정한다.
- `docs/projects/standards/git-policy.md` 의 브랜치/커밋/PR 메시지 규칙을 따른다.
- Git 전달 메시지 생성 시 변경 파일 목록이 길어져도 기본 출력과 프롬프트가 과도하게 커지지 않도록 한다.
- 현재 `phase / cycle` 과 문서 변경을 읽어 브랜치명을 만드는 흐름의 위치를 정한다.
- 단일 진입 CLI에서 `git` 을 어떤 상위 명령으로 둘지 기준을 만든다.

---

## 2. 왜 `git` 단계를 따로 두는가

`session start`, `session save` 는 세션 운영 보조 흐름이다.  
반면 다음 흐름은 Git 전달 단위와 직접 연결된다.

- 새 브랜치명 초안 생성
- Git commit message 초안 생성
- PR 제목/설명 초안 생성

특히 브랜치명 생성은 앞으로 `phase / cycle`, 관련 문서 제목, 변경 범위를 읽어 판단할 수 있어야 하므로  
세션 메모보다는 Git 전략 쪽에 더 가깝다.

따라서 현재 기준으로는:

- `session` = 세션 복구 / 세션 저장
- `git` = 브랜치 / 커밋 / PR 전달 단위 생성

으로 나누는 편이 자연스럽다.

---

## 3. 현재 기준 핵심 명령

```powershell
specdrive/specdrive.ps1 git branch-name
specdrive/specdrive.ps1 git git-message
specdrive/specdrive.ps1 git pr-message
```

### 3.1 `git branch-name`
- 현재 브랜치와 변경 요약을 읽는다.
- `git-policy.md` 의 작업 브랜치 접두사(`docs/`, `spec/`, `impl/`, `test/`, `refactor/`, `fix/`, `chore/`) 중 하나를 사용한다.
- 필요 시 앞으로는 phase / cycle, 관련 문서를 읽는다.
- 새 브랜치명 초안과 근거를 생성한다.

### 3.2 `git git-message`
- 현재 변경 요약 기준 commit message 초안을 생성한다.
- 커밋 제목은 `git-policy.md` 의 `type(scope): summary` 형식을 따른다.
- 출력 계약:
  - `change_summary`
  - `changed_area_summary`
  - `changed_path_sample`
  - `type`
  - `scope`
  - `subject`
  - `body`

### 3.3 `git pr-message`
- 현재 변경 요약 기준 PR 메시지 초안을 생성한다.
- PR 제목은 `git-policy.md` 의 `[type] short summary` 형식을 따른다.
- 출력 계약:
  - `change_summary`
  - `changed_area_summary`
  - `changed_path_sample`
  - `type`
  - `title_en`
  - `description_ko`

---

## 4. 현재 단계의 원칙

- `git` 단계는 실제 Git 명령 실행을 대신하지 않는다.
- 현재는 branch/commit/PR 산출물 초안 생성에 집중한다.
- 브랜치명, commit message, PR 제목의 형식 기준은 `docs/projects/standards/git-policy.md` 를 따른다.
- `git branch-name` 은 현재 브랜치명을 참고 정보로 출력해야 한다.
- `git git-message`, `git pr-message` 도 현재 브랜치명을 함께 보여주는 편이 좋다.
- 기본 출력은 변경 파일 전체 목록이 아니라 변경 수, 변경 영역, 변경 파일 샘플로 제한한다.
- 상세 변경 파일 목록은 `-Detailed` 옵션을 사용할 때만 콘솔에 출력한다.
- `git` 단계의 출력은 commit/PR 초안 생성을 돕는 것이며, 긴 변경 목록을 Codex 프롬프트에 그대로 넣기 위한 것이 아니다.

---

## 5. 토큰 절감 출력 원칙

Git 관련 명령은 변경 파일이 수십 개 이상일 수 있으므로 기본 출력에 전체 파일 목록을 넣지 않는다.

기본 출력은 다음 정도로 제한한다.

- 현재 브랜치
- 변경 파일 수
- 변경 영역 요약
- 변경 파일 샘플
- 생성된 브랜치명 / commit message / PR 메시지 초안

상세 목록이 필요할 때는 아래처럼 실행한다.

```powershell
specdrive/specdrive.ps1 git branch-name -Detailed
specdrive/specdrive.ps1 git git-message -Detailed
specdrive/specdrive.ps1 git pr-message -Detailed
```

---

## 6. 최종 정리

현재 specdrive에서 `git` 은  
세션 운영 단계와 분리된 **전달 단위 생성 단계**다.

즉 현재 기준 핵심 정리는 다음과 같다.

- `session` 은 세션 복구/저장을 다룬다.
- `git` 은 브랜치명, commit message, PR 메시지 생성을 다룬다.
- 브랜치명 생성은 앞으로 phase / cycle 및 문서 흐름과 연결될 수 있으므로 `git` 아래에 두는 편이 맞다.
