# Session Start Full

Use this action to prepare a full recovery read prompt after the lightweight start step.

Preferred argument-based invocation:

```text
$session start-full
$session start-full specdrive
$session start-full board
```

Compatibility alias:

```text
$session full
```

This action should avoid loading the full recovery document set immediately. It first performs a light recovery, then prints a copy prompt that the user can paste back when they want the full recovery pass.

## Read First

Read only the minimum needed first:

1. `.agents/skills/session/actions/start.md`
2. `docs/AI_CONTEXT.compact.md`
3. selected target compact context
4. `specdrive/rules/session-policy.md`

`docs/AI_CONTEXT.compact.md` is the workspace router. Use it to choose one target context.

Target mapping:

- `specdrive` -> `specdrive/AI_CONTEXT.compact.md`
- `board` -> `docs/projects/board/AI_CONTEXT.compact.md`

From the selected target context, focus on:

1. current focus
2. next entry point
3. read scope hint
4. open questions

Do not read `README.md`, root `AGENTS.md`, `specdrive/docs/AGENTS.md`, or `specdrive/docs/stages/session-stage.md` during this first step unless the user already gave a specific target that requires it.
When full recovery is needed, prefer compact AGENTS documents first and read full AGENTS documents only for rule edits, conflicts, or unclear approval boundaries.

## Output

Reply with two parts:

1. a short recovery summary:
   - active target
   - current focus
   - next entry point
   - caution areas for changes
2. a copy prompt for the next full recovery step

Use this shape for the copy prompt:

```text
아래 기준으로 specdrive session start-full 전체 복구를 진행해줘.

## Full Recovery Read Set

먼저 다음 문서를 저장소에서 직접 읽어줘.

1. AGENTS.compact.md
2. docs/AI_CONTEXT.compact.md
3. target AI_CONTEXT.compact.md 하나
4. specdrive/rules/core-collaboration-rules.md
5. specdrive/rules/read-scope-policy.md
6. specdrive/rules/session-policy.md

작업 대상 영역이 정해져 있으면 다음 문서도 추가로 읽어줘.

1. 대상 영역의 AGENTS.compact.md, 있으면 compact를 우선 읽어줘.
2. 대상 영역의 index.md
3. 현재 수정 또는 작성할 대상 문서

SpecDrive context와 project context를 둘 다 읽는 것은 내가 cross-context consistency review를 명시적으로 요청한 경우로 제한해줘.

full AGENTS.md, README, full AI_CONTEXT 원본은 규칙 수정, compact와의 충돌, 승인 필요 여부가 애매한 경우에만 추가로 읽어줘.

## Output

현재 focus, 다음 진입점, 주의해야 할 변경 범위를 짧게 정리해줘.

## Boundaries

- 파일은 수정하지 마.
- docs/history/** 는 내가 명시적으로 요청하지 않으면 보지 마.
- 신규 문서 생성, 문서 역할 변경, 요구사항->설계, 설계->구현 계획 전환, 상태/index의 활성 진입점 변경은 먼저 확인을 받아줘.
```

After printing the copy prompt, stop. Do not continue into the full recovery step in the same response.

## Stop Points

Ask for confirmation before:

- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

Do not edit files until the user explicitly asks you to do so.

## Boundaries

- Do not perform `doc`, `dev`, or `git` work as part of session recovery.
- Do not load the full recovery read set until the user pastes or explicitly asks to run the copy prompt.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not treat undecided ideas as confirmed decisions.
- Keep the response brief; this action is for staged re-entry, not full review.
