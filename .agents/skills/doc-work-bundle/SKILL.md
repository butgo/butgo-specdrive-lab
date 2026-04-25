---
name: doc-work-bundle
description: Cross-check related specdrive documents as a bundle using affected-docs-map.json. Use when the user invokes $doc-work-bundle or asks to validate consistency across mutually related documents, including reference documents and configured check targets.
---

# Doc Work Bundle

Use this skill to validate consistency across a configured document bundle.

## Read First

Read these registries first:

```text
specdrive/config/target-registry.json
specdrive/config/affected-docs-map.json
```

If the user did not provide a target key or document path, list target keys that have entries in `affected-docs-map.json` and stop.

Resolve the target key or path, then find the matching entry in `affected-docs-map.json` by key or `path`.

Read:

1. the resolved target document
2. documents listed in `include_for_bundle`
3. documents listed in `check_targets[*].path`

Missing optional or future documents should be reported, not invented.

## Output

Reply with:

1. target key and document path
2. documents read
3. missing configured documents, if any
4. cross-document consistency findings
5. role-boundary issues
6. terminology or scope conflicts
7. recommended next edits
8. approval prompt if file edits are needed

Order findings by importance.

## Stop Points

Ask for confirmation before:

- editing files
- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

## Boundaries

- This skill is for review and consistency checking first.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not turn bundle review into a full rewrite.
- Do not perform Git work.
- Keep current decisions separate from deferred or candidate ideas.
