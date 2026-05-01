---
name: git-commit
description: Run the simplest Git commit flow. Prefer $git commit; $git-commit remains a compatibility command.
---

# Git Commit

Use the simplest flow.
Follow the common Skill output UX rules in `specdrive/docs/skill-wizard-manual.md`.

Preferred argument-based invocation:

```text
$git commit
```

## Rule

- Excluded files are controlled only by `.gitignore`.
- Stage with `git add .`.
- Generate the commit message from `docs/projects/standards/git-policy.md`.
- Commit with the approved message.
- Before push, check whether the current branch exists on `origin`.
- If the remote branch exists, push with `git push`.
- If the remote branch does not exist, report that and use `git push -u origin <current-branch>` only after approval.

## Flow

1. Check current branch.
2. Check `git status --short`.
3. Propose one commit message.
4. After approval, run:

```powershell
git add .
git commit -m "<message>"
```

5. Before push, check remote branch existence:

```powershell
git ls-remote --heads origin <current-branch>
```

6. If the branch exists on `origin`, run:

```powershell
git push
```

7. If the branch does not exist on `origin`, ask approval for the upstream push, then run:

```powershell
git push -u origin <current-branch>
```

## Output

Keep output minimal:

- branch
- remote branch existence before push
- proposed commit message
- approval prompt
- final result
