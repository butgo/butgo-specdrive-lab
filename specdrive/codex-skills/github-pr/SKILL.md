---
name: github-pr
description: Prepare a GitHub pull request by checking the remote repository, current branch, status, base branch, pushed commits, GitHub CLI authentication, existing PRs, recent commits, and diff; then draft a PR title and body, and only after explicit user approval run gh pr create. Use when the user invokes $github-pr or asks Codex to prepare or create a GitHub PR.
---

# GitHub PR

Use this skill to prepare and optionally create a GitHub pull request safely.

## Read First

Run read-only checks first:

1. GitHub remote repository
2. current branch
3. `git status --short`
4. whether the current branch is the base branch
5. whether commits are pushed
6. GitHub CLI authentication status
7. existing PR for the current branch
8. likely base branch
9. recent commits and relevant diff

Prefer `gh` for GitHub state when available.

## Stop Conditions

Stop and ask the user what to do if:

- the current branch appears to be the base branch
- there are uncommitted changes that should be committed first
- commits are not pushed
- `gh auth status` fails
- an existing PR already exists for the branch
- the base branch is ambiguous

## Output Before Execution

Reply with:

1. remote repository
2. head branch
3. base branch recommendation
4. local status summary
5. push / commit readiness
6. existing PR status
7. PR title candidates
8. PR body draft
9. approval prompt

Keep the output concise. Draft the PR title in English unless the repository convention says otherwise. Draft the PR body in Korean when the current project workflow is Korean.

## Approval Gate

Do not run `gh pr create` until the user explicitly approves the PR title, body, base branch, and head branch.

Before execution, show the exact `gh pr create` command or an equivalent summary.

## Execution

After approval:

1. Run `gh pr create` with the approved base/head/title/body.
2. Confirm the generated PR URL.
3. Report the result briefly.

## Boundaries

- Do not commit or push changes; use `$git-commit` first.
- Do not force push.
- Do not create duplicate PRs.
- Do not change documents as part of this skill.
- Do not infer a risky base branch without asking.
