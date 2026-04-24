# doc reinforce preview

## Target
- document: docs/projects/board/01-overview.md
- skill: specdrive/skills/doc/reinforce.md

## Required Context
- README.md
- AGENTS.md
- docs/AI_CONTEXT.md
- docs/projects/board/README.md
- docs/projects/board/AGENTS.md

## Optional Context
- docs/projects/standards/index.md

## Prompt Preview

```text
Use the document reinforcement rules from:
specdrive/skills/doc/reinforce.md

Reinforce this target document:
docs/projects/board/01-overview.md

Read these required context documents first:
- README.md
- AGENTS.md
- docs/AI_CONTEXT.md
- docs/projects/board/README.md
- docs/projects/board/AGENTS.md

Optional context documents (read when useful):
- docs/projects/standards/index.md

Goal:
- reinforce the existing document instead of rewriting it from scratch
- keep the scope minimal
- avoid prematurely expanding into detailed API, DB, UI, or implementation design
- produce a reviewable improvement draft
- do not edit files directly; return the reinforcement draft in your final response
```

