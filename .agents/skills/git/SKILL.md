---
name: git
description: Route specdrive Git actions by argument. Use when the user invokes $git, $git commit, or $git pr.
---

# Git

Use this skill as the argument-based entry point for specdrive Git delivery work.

Supported actions:

- `commit`
- `pr`

Aliases:

- `commit` -> `commit`
- `github-pr` -> `pr`
- `pr` -> `pr`

If the user did not provide an action, list the action choices and stop.

## Dispatch

Follow the matching repo-local skill instructions:

- `commit`: `.agents/skills/git-commit/SKILL.md`
- `pr`: `.agents/skills/github-pr/SKILL.md`

Do not combine actions in one response unless the user explicitly asks.

## Output: No Action

Reply with:

1. available actions
2. short descriptions
3. copy-ready examples

Examples:

```text
$git commit
$git pr
```

## Boundaries

- Git work is delivery work.
- Do not perform `doc`, `dev`, or `session` work through this skill.
- Do not commit, push, or create PRs without the approval gates in the dispatched skill.
- Do not force push.
- Do not merge PRs.
