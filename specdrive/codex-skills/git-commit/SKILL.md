---
name: git-commit
description: Run the simplest Git commit flow: git add ., policy-based commit message, commit, and simple push after approval.
---

# Git Commit

Use the simplest flow.

## Rule

- Excluded files are controlled only by `.gitignore`.
- Stage with `git add .`.
- Generate the commit message from `docs/projects/standards/git-policy.md`.
- Commit with the approved message.
- Push with a simple `git push`.

## Flow

1. Check current branch.
2. Check `git status --short`.
3. Propose one commit message.
4. After approval, run:

```powershell
git add .
git commit -m "<message>"
git push
```

## Output

Keep output minimal:

- branch
- proposed commit message
- approval prompt
- final result
