---
name: github-pr
description: Prepare a GitHub pull request safely. Prefer $git pr; $github-pr remains a compatibility command.
---

# GitHub PR

Use this skill to prepare and optionally create a GitHub pull request safely.

Preferred argument-based invocation:

```text
$git pr
```

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

Include a copyable approval sentence in the approval prompt. Use this shape and fill in the recommended base, head, and title:

```text
승인. base <base-branch>, head <head-branch>, title은 "<pr-title>" 로 PR 생성해줘.
```

## Approval Gate

Do not run `gh pr create` until the user explicitly approves the PR title, body, base branch, and head branch.

Before execution, show the exact `gh pr create` command or an equivalent summary.

## Execution

After approval:

1. Run `gh pr create` with the approved base/head/title/body.
2. Confirm the generated PR URL.
3. Report the result briefly.
4. Include a merge guidance note for the user.

Use this shape for the merge guidance:

```text
머지는 GitHub PR 화면에서 직접 확인 후 진행해줘.

1. PR 페이지를 연다: <pr-url>
2. 변경 파일과 설명을 확인한다.
3. 문제가 없으면 GitHub에서 Merge pull request 를 누른다.
4. 필요하면 merge 후 원격 브랜치를 삭제한다.
```

## Boundaries

- Do not commit or push changes; use `$git-commit` first.
- Do not force push.
- Do not create duplicate PRs.
- Do not merge PRs.
- Do not change documents as part of this skill.
- Do not infer a risky base branch without asking.
