# Dev Test

Use this action to run or prepare verification for the current Work Package.

Preferred argument-based invocation:

```text
$dev test
```

## Purpose

Verify the current Work Package after or during implementation.

## Read First

Read only what is needed:

1. project `work/work-index.md`
2. project `work/work-roadmap.md`
3. relevant specs for the current Work Package
4. relevant test files or test configuration

## Output

Run focused tests when appropriate, or provide a verification plan if tests cannot be run.

When summarizing, include:

```text
Dev action: test
Current Work Package:
Tests run:
Result:
Failures / gaps:
Suggested next action: $dev run or $dev sync
```

## Boundaries

- Verify the current Work Package only.
- Do not expand implementation scope while testing.
- Do not move to the next Work Package.
- If tests fail, summarize the failure and propose whether `$dev run` should fix it.
- Do not commit changes.

