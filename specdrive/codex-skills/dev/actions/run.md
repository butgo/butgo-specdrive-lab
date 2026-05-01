# Dev Run

Use this action to code within the current Work Package.

Preferred argument-based invocation:

```text
$dev run
```

## Purpose

Perform implementation work inside the current Work Package from `work-index.md`.

## Read First

Read only what is needed:

1. root `AGENTS.md`
2. project `AGENTS.md`
3. project `work/work-index.md`
4. project `work/work-roadmap.md`
5. relevant specs for the current Work Package
6. relevant source files

## Output

Perform the requested coding work when the user asks for implementation.

When summarizing, include:

```text
Dev action: run
Current Work Package:
Changed files:
Implementation summary:
Known gaps:
Suggested next action: $dev test
```

## Boundaries

- Stay inside the current Work Package and Cycle.
- Do not perform broad refactors unless required by the current Work Package.
- Do not set the next Work Package.
- Do not commit changes.
- If the current work pointer is missing or unclear, stop and ask to run `$dev start` or clarify the target.

