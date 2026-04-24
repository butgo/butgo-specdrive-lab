---
name: git-commit
description: Review the current Git branch, status, diff, and changed files; classify changes; decide whether commits should be split; propose commit messages; and, only after explicit user approval, run git add, git commit, and git push. Use when the user invokes $git-commit or asks Codex to prepare or perform a safe Git commit workflow.
---

# Git Commit

Use this skill to prepare and optionally execute a safe Git commit workflow.

## Read First

Run read-only Git checks first:

1. current branch
2. `git status --short`
3. `git diff --stat`
4. `git diff` when needed to understand the change

If this is a specdrive repository, respect the repository document rules:

- Do not inspect `docs/history/**` unless the user explicitly asks.
- Do not change documents as part of this skill.
- Treat generated commit messages as drafts until approved.

## Analyze

Classify changed files by area, for example:

- repo-local Codex skills
- distribution skill sources
- specdrive documents
- specdrive scripts/config
- templates/examples
- project documents

Decide whether one commit is enough or whether the changes should be split.

## Output Before Execution

Reply with:

1. current branch
2. status summary
3. diff summary
4. changed file classification
5. commit split recommendation
6. commit message candidates
7. proposed files for `git add`
8. approval prompt
9. push prompt template

Keep the output concise and separate facts from recommendations.

For the approval prompt, include a copy-ready prompt that lets the user approve add + commit while explicitly excluding push. Use this shape:

```text
위 대상 전부 add하고 `<commit message>` 로 commit 해줘. push는 아직 하지 마.
```

For the push prompt template, include copy-ready prompts that can be used after commit succeeds. Use the current branch and final commit hash/message when known. Use this shape:

```text
현재 브랜치 `<branch>` 의 커밋 `<short-hash> <commit message>` 를 원격에 push 해줘.
push 전에 현재 브랜치와 git status를 확인하고, 문제가 없으면 `git push origin <branch>` 를 실행해줘.
------------------------------------------------
현재 브랜치 확인하고 clean 상태면 `git push origin <branch>` 실행해줘.
```

## Approval Gates

Do not run write operations until the user explicitly approves them.

Use these gates:

1. Ask before `git add`.
2. Ask before `git commit`.
3. Ask before `git push`.

If the user gives one explicit approval for a complete flow, still summarize the exact commands before running them.

## Execution

After approval:

1. Run `git add` only for the approved files.
2. Run `git status --short` again.
3. Run `git commit` with the approved message.
4. Run `git status --short` again.
5. If push was not approved, do not push. Report the commit result and include the copy-ready push prompt.
6. Ask before `git push` unless the user already approved push explicitly.
7. After push, report the result briefly.

## Boundaries

- Do not amend commits unless the user explicitly asks.
- Do not force push.
- Do not stage unrelated files.
- Do not create PRs; use `$github-pr` for PR work.
- Do not create or modify documents as part of this skill.
