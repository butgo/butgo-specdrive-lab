---
name: specdrive-skills
description: List the repo-local specdrive Codex skills available in this repository with short descriptions. Use when the user invokes $specdrive-skills or asks what specdrive local skills are available.
---

# Specdrive Skills

Use this skill to show the repo-local specdrive Codex skills available in this repository.
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.

## Read First

Read this registry first:

```text
.agents/skills/specdrive-skills/skills.json
```

Use the registry `command` and `description` values for the displayed list.

If the registry is missing or invalid, fall back to reading the `SKILL.md` files under:

```text
.agents/skills/*/SKILL.md
```

In the fallback path, use each skill's frontmatter `name` and `description`.

## Output

Reply with a concise list using this shape:

```text
$skill-name - short description
```

Keep the descriptions short and user-facing.

## Boundaries

- Do not edit files.
- Do not install global skills.
- Do not include system skills unless the user explicitly asks for them.
- Do not perform the listed skills; only list them.
- Treat `skills.json` as display metadata; each `SKILL.md` remains the execution source.
