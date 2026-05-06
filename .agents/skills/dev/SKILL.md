---
name: dev
description: Route specdrive dev actions by argument. Use when the user invokes $dev, $dev start, $dev impl-run, $dev run, $dev test, or $dev sync.
---

# Dev

Use this skill as the argument-based entry point for specdrive dev work.
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.

## Invocation Rule

If the user's message is exactly `$dev`, treat it as a no-action router call.
Do not wait for another message or ask a follow-up question.
Immediately print the no-action output below and stop.

Supported actions:

- `start`
- `impl-run`
- `run`
- `test`
- `sync`

Aliases:

- `start` -> `start`
- `impl-run` -> `run`
- `run` -> `run`
- `test` -> `test`
- `verify` -> `test`
- `sync` -> `sync`

If the user provided `$dev` without an action, or provided no recognizable action, list the action choices and stop.

## Dispatch

Follow the matching repo-local dev action instructions:

- `start`: `.agents/skills/dev/actions/start.md`
- `run`: `.agents/skills/dev/actions/run.md`
- `test`: `.agents/skills/dev/actions/test.md`
- `sync`: `.agents/skills/dev/actions/sync.md`

Do not combine actions in one response unless the user explicitly asks.

## Output: No Action

Reply with:

1. available actions
2. short descriptions
3. copy-ready examples

Use this concrete shape:

```text
사용 가능한 $dev action:

- start: 승인된 plan 결과에서 현재 Work Package를 선택하고 work-index.md 설정 초안을 준비합니다.
- impl-run: 현재 Work Package 기준으로 구현을 진행합니다.
- run: impl-run과 같은 구현 실행 action입니다.
- test: 현재 Work Package 기준으로 테스트/검증을 실행합니다.
- sync: 실행/테스트 결과를 work-log/status/manual 반영 후보로 정리합니다.

예시:
$dev start
$dev impl-run
$dev run
$dev test
$dev sync
```

Examples:

```text
$dev start
$dev impl-run
$dev run
$dev test
$dev sync
```

## Boundaries

- Dev work executes approved plan work.
- Do not perform `doc`, `plan`, `session`, or `git` work through this skill.
- Do not extract candidates or split phases/cycles/tasks through this skill.
- Do not commit, push, or create PRs.
- Do not move to the next Work Package without developer confirmation.
- Keep coding and testing inside the current Work Package and Cycle.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
