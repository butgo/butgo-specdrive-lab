---
name: doc-work-ref
description: Work on one specdrive target document with only its configured reference documents from affected-docs-map.json. Use when the user invokes $doc-work-ref or asks to check a document against parent/upstream/reference documents without cross-checking downstream related documents.
---

# Doc Work Ref

Use this skill when a target document should be checked with its configured parent or reference documents.

## Read First

Read these registries first:

```text
specdrive/config/target-registry.json
specdrive/config/affected-docs-map.json
```

If the user did not provide a target key or document path, list the available target keys from `target-registry.json` and stop.

Resolve the target key or path, then find the matching entry in `affected-docs-map.json` by key or `path`.

Read:

1. the resolved target document
2. only documents listed in that entry's `include_for_bundle`

Do not read `check_targets` for this skill unless the user explicitly asks to do cross-document validation.

## Output

Reply with:

1. target key and document path
2. reference documents read
3. whether the target document stays consistent with those reference documents
4. must-fix points
5. recommended refinements
6. approval prompt if file edits are needed

Separate confirmed inconsistencies from optional improvements.

## Stop Points

Ask for confirmation before:

- editing files
- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

## Boundaries

- Use only `include_for_bundle` as the reference set.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not expand into downstream or sibling document checks.
- Do not perform Git work.
- Use `$doc-work-bundle` for mutual consistency checks across related documents.
