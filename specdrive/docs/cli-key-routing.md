# specdrive/docs/cli-key-routing.md

## 1. 문서 목적

이 문서는 specdrive CLI를  
**경로 직접 입력 방식에서 키 기반 연결 방식으로 정리하기 위한 설계 초안**이다.

목적은 다음과 같다.

- `target document`, `skill document`, `context documents` 를 각각 경로로 직접 입력하는 부담을 줄인다.
- 문서/skill/context 문서 묶음을 재사용 가능한 키 구조로 바꾼다.
- 향후 선택형 CLI 입력과 비대화식 실행을 함께 지원할 수 있는 기준을 만든다.

이 문서는 originally 설계 초안으로 시작했지만,  
현재는 그 방향을 따라 registry 초안과 key 기반 해석이 실제 스크립트에 일부 반영된 상태를 설명한다.

---

## 2. 현재 구조와 한계

이전 기준 legacy 구조는 다음과 같았다.

- `doc-reinforce-targets.json`
- `doc-confirm-targets.json`
- `doc-history-targets.json`

각 target 설정 안에 현재는 다음 정보가 직접 들어 있다.

- `document_path`
- `skill_path`
- `context_documents`
- `optional_context_documents`

이 구조는 최소 검증에는 충분했지만, 다음 한계가 있었다.

- 같은 context 문서 묶음이 여러 config 파일에 반복된다.
- skill 경로가 action마다 직접 박혀 있다.
- `codex-exec.ps1`를 단독 테스트할 때 경로를 직접 넣으면 실수하기 쉽다.
- 이후 target 이 늘어나면 중복 수정이 빠르게 늘어난다.

그래서 현재는 registry 기반 구조로 이동 중이며,  
legacy config 는 주로 `default_target` fallback 용으로 남아 있다.

---

## 3. 목표 방향

다음 방향을 목표로 한다.

1. target 은 `문서 대상 키` 로 식별한다.
2. skill 은 `작업 규칙 키` 로 식별한다.
3. context 는 `문서 묶음 키` 로 식별한다.
4. CLI 는 기본적으로 키만 받는다.
5. 경로 해석은 config registry 가 담당한다.

즉 장기적으로는 사용자가 다음을 직접 입력하지 않게 한다.

- 긴 문서 경로
- skill 파일 경로
- context 문서 배열

대신 다음처럼 키 중심으로 사용한다.

- `board-overview`
- `doc-reinforce`
- `board-doc-base`

현재 `session`, `git` 단계 명령은 이 구조와 직접 동일하지 않을 수 있다.  
예를 들어 `session start`, `session save`, `git branch-name`, `git git-message`, `git pr-message` 는  
문서 대상 key 보다 세션 상태, 현재 브랜치, 현재 변경 집합을 기준으로 동작할 가능성이 높다.

---

## 4. 추천 키 구조

### 4.1 target key

target key 는  
**무슨 문서를 대상으로 작업할 것인가**를 나타낸다.

예:

- `board-overview`
- `board-requirements`
- `board-design`

target registry 에는 다음 정보가 들어간다.

- `document_path`
- `document_kind`
- `project`
- `default_context_set_key`
- `notes`

### 4.2 skill key

skill key 는  
**어떤 작업 규칙 자산을 사용할 것인가**를 나타낸다.

예:

- `doc-reinforce`
- `doc-confirm-prompt`
- `doc-apply-prompt`
- `doc-apply-only-prompt`

skill registry 에는 다음 정보가 들어간다.

- `path`
- `stage`
- `action`
- `description`

### 4.3 context-set key

context-set key 는  
**대상 문서를 읽을 때 함께 읽어야 하는 문서 묶음**을 나타낸다.

예:

- `board-doc-base`
- `board-doc-with-standards`

context-set registry 에는 다음 정보가 들어간다.

- `required_documents`
- `optional_documents`
- `description`

---

## 5. 추천 config 분리 방식

현재 액션별 target config 구조를 유지하되,  
내부 값을 다음처럼 키 중심으로 바꾸는 방식을 추천한다.

현재 저장소에는 이 방향을 반영한 registry 파일을 다음 위치에 둔다.

- `specdrive/config/target-registry.json`
- `specdrive/config/skill-registry.json`
- `specdrive/config/context-set-registry.json`
- `specdrive/config/doc-action-registry.json`

### 5.1 target registry

예:

```json
{
  "version": 1,
  "default_target": "board-overview",
  "targets": {
    "board-overview": {
      "document_path": "docs/projects/board/01-overview.md",
      "document_kind": "project-overview",
      "project": "board",
      "context_set_key": "board-doc-base"
    }
  }
}
```

현재는 기본 target 도 registry 에서 함께 관리하는 방향을 사용한다.
즉 `doc` 스크립트는 먼저 `target-registry.json` 의 `default_target` 을 보고,
legacy action별 target config 는 호환 fallback 으로만 남긴다.

### 5.2 skill registry

예:

```json
{
  "version": 1,
  "skills": {
    "doc-reinforce": {
      "path": "specdrive/skills/doc/reinforce.md",
      "stage": "doc",
      "action": "reinforce"
    },
    "doc-confirm-prompt": {
      "path": "specdrive/skills/doc/confirm.md",
      "stage": "doc",
      "action": "confirm-prompt"
    },
    "doc-apply-prompt": {
      "path": "specdrive/skills/doc/history-save.md",
      "stage": "doc",
      "action": "apply-prompt"
    }
  }
}
```

### 5.3 context-set registry

예:

```json
{
  "version": 1,
  "context_sets": {
    "board-doc-base": {
      "required_documents": [
        "README.md",
        "AGENTS.md",
        "docs/AI_CONTEXT.md",
        "docs/projects/board/README.md",
        "docs/projects/board/AGENTS.md"
      ],
      "optional_documents": [
        "docs/projects/standards/index.md"
      ]
    }
  }
}
```

### 5.4 action routing config

예:

```json
{
  "version": 1,
  "default_target": "board-overview",
  "actions": {
    "reinforce": {
      "skill_key": "doc-reinforce",
      "output_mode": "review_patch",
      "human_review_required": true
    },
    "confirm-prompt": {
      "skill_key": "doc-confirm-prompt",
      "output_mode": "review_patch",
      "human_review_required": true
    },
    "apply-prompt": {
      "skill_key": "doc-apply-prompt",
      "output_mode": "history_entry",
      "human_review_required": true
    }
  }
}
```

이렇게 나누면  
같은 target 을 여러 action 에서 재사용할 수 있다.

---

## 6. 권장 해석 흐름

키 기반 구조의 해석 순서는 다음과 같다.

1. 사용자가 `target key` 를 입력한다.
2. 스크립트가 target registry 에서 `document_path` 와 `context_set_key` 를 읽는다.
3. action routing config 에서 `skill_key` 와 `output_mode` 를 읽는다.
4. skill registry 에서 실제 skill 파일 경로를 읽는다.
5. context-set registry 에서 required / optional 문서 배열을 읽는다.
6. 해석된 결과를 `codex-exec.ps1` 에 넘긴다.

즉 실행기에는 최종 해석 결과만 넘기고,  
해석 책임은 상위 `doc` 스크립트와 config layer 가 가진다.

---

## 7. CLI 입력 방식 권장안

입력 방식은 두 층으로 나누는 것을 추천한다.

### 7.1 기본: 비대화식 입력

예: `doc reinforce` 계열의 후속 보조 도구가 생기더라도 대상 문서는 `board-overview` 같은 key 로 지정한다.

장점:

- 반복 실행이 쉽다.
- 자동화와 기록에 유리하다.
- 명령이 짧고 명확하다.

### 7.2 보조: 선택형 입력

예:

- target 을 비우고 실행
- 엔터 입력 시 현재 target 목록 표시
- 번호 선택 또는 방향키 선택

이 방식은 수동 테스트에서 유용하지만,  
기본 실행 방식은 여전히 비대화식 입력이어야 한다.

즉 추천은 다음과 같다.

- 기본: `-Target board-overview`
- 보조: 선택 UI

---

## 8. `codex-exec.ps1` 의 위치

이 구조에서 `codex-exec.ps1` 는  
직접 target/skill/context 를 설계하는 계층이 아니다.

`codex-exec.ps1` 의 책임은 다음에 가깝다.

- 해석된 target document 받기
- 해석된 skill document 받기
- 해석된 context 문서 목록 받기
- preview 생성
- 이후 실제 `codex exec` 호출

즉 `codex-exec.ps1` 는  
**routing resolver 가 아니라 execution wrapper** 로 유지하는 편이 좋다.

---

## 9. 현재 단계의 추천 적용 순서

현재는 한 번에 전부 바꾸기보다 다음 순서를 추천한다.

1. 이 문서로 키 구조를 먼저 확정
2. `target / skill / context-set` registry 초안 추가
3. `reinforce.ps1` 만 먼저 키 기반 해석 구조로 전환
4. 이후 `confirm-prompt.ps1`, `apply-prompt.ps1`, `apply-only-prompt.ps1` 확장
5. 마지막에 선택형 입력 도입 여부 판단

`session`, `git` 단계는 이와 별도로 설계하는 편이 좋다.  
왜냐하면 이 단계들은 `doc` / `dev` 처럼 target document 중심 라우팅보다  
세션 복구/저장, 현재 브랜치, 메시지 생성 같은 운영 목적 중심 라우팅에 더 가깝기 때문이다.

즉 지금 바로 필요한 것은  
선택 UI보다 먼저 **키 구조와 registry 분리**다.

---

## 10. 최종 정리

현재 specdrive의 문서 작업 스크립트는 이미 최소 preview 흐름을 검증했다.

다음 단계에서 더 중요한 것은  
경로 직접 입력을 늘리는 것이 아니라,  
**문서 / skill / context 를 키 기반으로 연결해 재사용성과 안정성을 높이는 것**이다.

따라서 현재 추천 방향은 다음 한 줄로 요약된다.

- `path direct input` 보다 `target key + skill key + context-set key` 중심 구조로 간다.
