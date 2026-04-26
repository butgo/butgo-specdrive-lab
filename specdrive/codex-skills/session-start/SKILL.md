---
name: session-start
description: Prepare a staged specdrive session recovery prompt. Prefer $session start; $session-start remains a compatibility command.
---

# Session Start

Use this skill to start session recovery in two steps.

Preferred argument-based invocation:

```text
$session start
```

This skill should avoid loading the full recovery document set immediately. It first performs a light recovery, then prints a copy prompt that the user can paste back when they want the full recovery pass.

## Read First

Read only the minimum needed first:

1. `.agents/skills/session-start-lite/SKILL.md`
2. `docs/AI_CONTEXT.md`

From `docs/AI_CONTEXT.md`, focus on:

1. current one-line summary
2. next session start checklist
3. next entry point
4. current focus
5. work caution principles

Do not read `README.md`, root `AGENTS.md`, `docs/specdrive/AGENTS.md`, or `docs/specdrive/session-stage.md` during this first step unless the user already gave a specific target that requires it.

## Output

Reply with two parts:

1. a short recovery summary:
   - current focus
   - next entry point
   - caution areas for changes
2. a copy prompt for the next full recovery step

Use this shape for the copy prompt:

```text
아래 기준으로 specdrive session start 전체 복구를 진행해줘.

## Full Recovery Read Set

먼저 다음 문서를 저장소에서 직접 읽어줘.

1. README.md
2. AGENTS.md
3. docs/AI_CONTEXT.md
4. docs/specdrive/AGENTS.md
5. docs/specdrive/session-stage.md

작업 대상 영역이 정해져 있으면 다음 문서도 추가로 읽어줘.

1. 대상 영역의 AGENTS.md
2. 대상 영역의 README.md
3. 대상 영역의 index.md
4. 현재 수정 또는 작성할 대상 문서

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
- Keep the response brief; this skill is for staged re-entry, not full review.
