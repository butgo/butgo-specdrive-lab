# Dev Start

Use this action to select the current Work Package from an approved plan and prepare the current execution pointer.

Preferred argument-based invocation:

```text
$dev start
```

## Purpose

Set up the dev entry point before coding starts.

This action prepares or updates `work-index.md` based on an approved `work-roadmap.md`.

## Read First

Read only what is needed:

1. root `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. project `AGENTS.md`
4. project `work/work-policy.md` if it exists
5. project `work/work-roadmap.md`
6. project `work/work-index.md` if it exists
7. relevant project specs for the selected Work Package

## Output

Provide a draft current execution pointer.

Use this shape:

```text
Dev action: start
Target project: <project>

Current Pointer Draft:
- Current Phase:
- Current Cycle:
- Current Work Package:
- Current Focus Task:
- Next Task:
- Entry Notes:

Apply Target:
- docs/projects/<project>/work/work-index.md
```

## Boundaries

- Do not code.
- Do not run tests.
- Do not change `work-index.md` unless the developer explicitly asks to apply the draft.
- Do not select work that is not present in the approved roadmap.

