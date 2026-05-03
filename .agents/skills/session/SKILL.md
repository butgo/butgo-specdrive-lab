---
name: session
description: Route specdrive session actions by argument. Use when the user invokes $session, $session restore, $session start, $session start-full, $session status, or $session save.
---

# Session

Use this skill as the argument-based entry point for specdrive session work.
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.

## Invocation Rule

If the user's message is exactly `$session`, treat it as a no-action router call.
Do not wait for another message or ask a follow-up question.
Immediately print the no-action output below and stop.

Supported actions:

- `restore`
- `start`
- `start-full`
- `status`
- `save`

Aliases:

- `restore` -> `restore`
- `start` -> `start`
- `start-full` -> `start-full`
- `full` -> `start-full`
- `status` -> `status`
- `save` -> `save`

If the user provided `$session` without an action, or provided no recognizable action, list the action choices and stop.

## Dispatch

Follow the matching repo-local session action instructions:

- `restore`: `.agents/skills/session/actions/restore.md`
- `start`: `.agents/skills/session/actions/start.md`
- `start-full`: `.agents/skills/session/actions/start-full.md`
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

- start: workspace router와 target compact context 기준으로 최소 세션 복구를 합니다.
- restore: VSCode/Codex 재시작 후 현재 맥락을 복구합니다.
- start-full: 전체 세션 복구용 copy prompt를 준비합니다.
- status: workspace router 또는 target context 기준으로 현재 세션 상태를 짧게 확인합니다.
- save: target compact context 상태 반영 초안을 준비합니다.

예시:
$session restore
$session start
$session start-full
$session status
$session status specdrive
$session status board
$session save
$session save specdrive
$session save board
```

Examples:

```text
$session restore
$session start
$session start-full
$session status
$session save
```

## Boundaries

- Session work is meta operation work.
- Do not perform `doc`, `dev`, or `git` work through this skill.
- Git is handled directly by the developer. Session work does not request Git information.
- Do not edit files unless the dispatched action explicitly allows it and the user approves.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
