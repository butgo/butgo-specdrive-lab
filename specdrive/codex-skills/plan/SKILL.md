---
name: plan
description: Route specdrive plan actions by argument. Use when the user invokes $plan, $plan extract-candidates, $plan phase-split, $plan cycle-split, $plan task-split, or $plan wp.
---

# Plan

Use this skill as the argument-based entry point for specdrive plan work.

Common action inputs are defined in `specdrive/codex-skills/plan/inputs.md`.

Plan policy: `specdrive/rules/plan-policy.md`.
Read it only when the action file does not include enough policy detail or plan boundaries are unclear.

## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.

## Invocation Rule

If the user's message is exactly `$plan`, treat it as a no-action router call.
Do not wait for another message or ask a follow-up question.
Immediately print the no-action output below and stop.

Supported actions:

- `extract-candidates`
- `phase-split`
- `cycle-split`
- `task-split`
- `wp`

Aliases:

- `extract` -> `extract-candidates`
- `extract-candidates` -> `extract-candidates`
- `phase` -> `phase-split`
- `phase-split` -> `phase-split`
- `cycle` -> `cycle-split`
- `cycle-split` -> `cycle-split`
- `task` -> `task-split`
- `task-split` -> `task-split`
- `wp` -> `wp`

If the user provided `$plan` without an action, or provided no recognizable action, list the action choices and stop.

## Dispatch

Follow the matching repo-local plan action instructions:

- `extract-candidates`: `.agents/skills/plan/actions/extract-candidates.md`
- `phase-split`: `.agents/skills/plan/actions/phase-split.md`
- `cycle-split`: `.agents/skills/plan/actions/cycle-split.md`
- `task-split`: `.agents/skills/plan/actions/task-split.md`
- `wp`: `.agents/skills/plan/actions/wp.md`

Do not combine actions in one response unless the user explicitly asks.

## Output: No Action

Reply with:

1. available actions
2. short descriptions
3. copy-ready examples

Use this concrete shape:

```text
사용 가능한 $plan action:

- extract-candidates: 개발 문서에서 일반 작업 후보를 추출합니다.
- phase-split: 추출된 작업 후보를 Phase 범위로 배치하는 초안을 준비합니다.
- cycle-split: 선택된 Phase를 Cycle 완성도 단계로 배치하는 초안을 준비합니다.
- task-split: CAND 후보를 WP 구성을 위한 Task 후보로 나눕니다.
- wp: Task 후보를 AI 작업 단위인 Work Package로 패키징합니다.

예시:
$plan extract-candidates
$plan phase-split
$plan cycle-split
$plan task-split
$plan wp
```

Examples:

```text
$plan extract-candidates
$plan phase-split
$plan cycle-split
$plan task-split
$plan wp
```

## Boundaries

- Plan work is planning work between `doc` and `dev`.
- Do not perform `doc`, `dev`, `session`, or `git` work through this skill.
- Do not code or run tests through this skill.
- Do not set `work-index.md`; current execution pointer setup belongs to `dev`.
- Do not edit files unless the dispatched action explicitly allows it and the user approves.
- Treat generated phase/cycle/task structures as drafts until the developer confirms them.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
