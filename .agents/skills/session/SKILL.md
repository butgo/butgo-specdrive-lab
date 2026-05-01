---
name: session
description: Route specdrive session actions by argument. Use when the user invokes $session, $session restore, $session start-lite, $session start, $session status, or $session save.
---

# Session

Use this skill as the argument-based entry point for specdrive session work.
Follow the common Skill output UX rules in `specdrive/docs/skill-wizard-manual.md`.

## Invocation Rule

If the user's message is exactly `$session`, treat it as a no-action router call.
Do not wait for another message or ask a follow-up question.
Immediately print the no-action output below and stop.

Supported actions:

- `start-lite`
- `restore`
- `start`
- `status`
- `save`

Aliases:

- `lite` -> `start-lite`
- `start-lite` -> `start-lite`
- `restore` -> `restore`
- `start` -> `start`
- `status` -> `status`
- `save` -> `save`

If the user provided `$session` without an action, or provided no recognizable action, list the action choices and stop.

## Dispatch

Follow the matching repo-local session action instructions:

- `start-lite`: `.agents/skills/session/actions/start-lite.md`
- `restore`: `.agents/skills/session/actions/restore.md`
- `start`: `.agents/skills/session/actions/start.md`
- `status`: `.agents/skills/session/actions/status.md`
- `save`: `.agents/skills/session/actions/save.md`

Do not combine actions in one response unless the user explicitly asks.

## Output: No Action

Reply with:

1. available actions
2. short descriptions
3. copy-ready examples

Use this concrete shape:

```text
사용 가능한 $session action:

- start-lite: docs/AI_CONTEXT.md 기준으로 최소 세션 복구를 합니다.
- restore: VSCode/Codex 재시작 후 현재 맥락을 복구합니다.
- start: 전체 세션 복구용 copy prompt를 준비합니다.
- status: 현재 세션 상태를 짧게 확인합니다.
- save: 세션 저장용 AI_CONTEXT 반영 초안을 준비합니다.

예시:
$session restore
$session start-lite
$session start
$session status
$session save
```

Examples:

```text
$session restore
$session start-lite
$session start
$session status
$session save
```

## Boundaries

- Session work is meta operation work.
- Do not perform `doc`, `dev`, or `git` work through this skill.
- Git is handled directly by the developer during the initial version. Do not require Git status or invoke Git skills unless the developer explicitly asks.
- Do not edit files unless the dispatched action explicitly allows it and the user approves.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
