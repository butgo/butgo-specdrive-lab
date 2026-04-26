---
name: doc-work-bundle
description: Work on one specdrive target document with its configured include_for_bundle documents from affected-docs-map.json. Supports reference and revise actions with bundle-prefixed history snapshots.
---

# Doc Work Bundle

Use this skill when a target document should be checked or revised against its configured mutual-impact document bundle.

This skill sits above `$doc-work-ref`:

- `$doc-work` reads one target document only.
- `$doc-work-ref` reads the target document plus `reference_docs` only.
- `$doc-work-bundle` reads the target document plus `include_for_bundle`.
- `$doc-work-bundle` may use `check_targets` only as conditional impact validation.

## Read First

Read these registries first:

```text
specdrive/config/target-registry.json
specdrive/config/affected-docs-map.json
```

If the user did not provide a target key or document path, list target keys that have entries in `affected-docs-map.json` and stop.

Resolve the target key or path from `target-registry.json`, then find the matching entry in `affected-docs-map.json` by key or `path`.

If the user provided only a target and no action, read only the target metadata and affected-docs entry metadata. Show the action choices.

Supported actions for now:

- `reference`
- `revise`

For `reference` or `revise`, read first:

1. the resolved target document
2. documents listed in that entry's `include_for_bundle`

Do not read all `check_targets[*].path` by default.

Use `check_targets` only as a second-pass impact map:

- Read `check_targets[*].path` only when the first pass finds a likely inconsistency or impact.
- Use `check_targets[*].reason` to explain why that second-pass check is needed.
- If the user explicitly asks for full impact validation, read all configured `check_targets[*].path`.

Do not inspect `docs/history/**` file contents unless the user explicitly asks for history lookup.

Missing optional or future documents should be reported, not invented.

## History Rules

If a bundle action updates one document, save one history snapshot and one note for that document.

If a bundle action updates multiple documents, save separate history snapshots and separate notes for each changed document.

Use the same timestamp for all history files created by one approved bundle operation.

Bundle history filenames must add `bundle` after the timestamp:

```text
yyyy-MM-dd_HHmmss_bundle_<document-base>_codex-reinforced.md
yyyy-MM-dd_HHmmss_bundle_<document-base>_codex-reinforced.note.md
yyyy-MM-dd_HHmmss_bundle_<document-base>_dev-revised.md
yyyy-MM-dd_HHmmss_bundle_<document-base>_dev-revised.note.md
```

For project documents, use:

```text
docs/history/projects/<project>/<document-base>/
```

The `<document-base>` is the changed document filename without `.md`, such as `02-requirements`.

## Output: Target Only

For target-only selection, reply with:

1. target key and document path
2. target document role
3. bundle documents from `include_for_bundle`
4. conditional impact targets from `check_targets`, with reasons summarized briefly
5. action choices
6. copy-ready examples such as `$doc-work-bundle board-requirements reference` and `$doc-work-bundle board-requirements revise`

## Output: Reference

For `reference`, output a copy-ready prompt that asks Codex to read the target and `include_for_bundle`, then prepare a bundle-based reinforcement preview.

The reference prompt must ask Codex to:

- read the target document and `include_for_bundle` documents first
- use `check_targets` only when impact validation is needed
- keep every document's role and scope
- separate current decisions from deferred ideas
- avoid editing files before approval
- produce previews for every document it proposes to update
- propose per-document history snapshot paths and note paths for every changed document
- use `bundle` in every proposed history filename
- use the same timestamp across all history files in one approved bundle operation
- ask for explicit approval before editing files or creating history files

The reference prompt should ask for this output before execution:

1. target document preview, if the target document should change
2. bundle document previews, only for bundle documents that should change
3. impact target previews, only if `check_targets` were used and those documents should change
4. target document path to update
5. changed bundle or impact document paths to update, if any
6. whether `check_targets` were used, and why
7. per-document history snapshot paths
8. per-document history note paths
9. per-document summary note bodies within 10 lines each
10. explicit approval question
11. copy-ready approval prompt

If no file change is needed, the response should say so and should not propose history files.

Bundle reference note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: bundle-codex-reinforced
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Bundle Context

- Target: <target-key>
- Bundle Docs:
  - <bundle-doc-1>
  - <bundle-doc-2>
- Impact Targets Used:
  - <impact-target-or-none>

## Summary

- <summary line 1>
- <summary line 2>
~~~

The summary should be 10 lines or fewer.

The copy-ready approval prompt for reference should use this shape:

```text
위 bundle reference preview를 기준으로 아래 문서들을 업데이트하고,
각 변경 문서의 내용을 해당 bundle history snapshot과 note로 저장해줘.

Changed documents:
- <document-path-1>
- <document-path-2>

History files:
- <history-snapshot-path-1>
- <history-note-path-1>
- <history-snapshot-path-2>
- <history-note-path-2>

모든 history 파일은 같은 timestamp를 사용하고, 파일명에는 timestamp 뒤에 `bundle`을 포함해줘.
각 note에는 Bundle Context와 Summary를 포함해줘.
수정 전 최종 대상 파일과 history 파일 존재 여부를 다시 확인하고 진행해줘.
```

## Output: Revise

For `revise`, output a copy-ready prompt that asks Codex to apply developer revision after a previous bundle reinforcement or bundle review.

The revise prompt must:

- read the target document and `include_for_bundle` documents first
- use `check_targets` only when impact validation is needed
- include a clearly marked blank section for the developer's revision request
- keep every document's role and scope unchanged
- produce revised previews for every document it proposes to update
- ask whether each changed document should be saved to history
- for history-worthy changes, use `_bundle_<document-base>_dev-revised.md` and `_bundle_<document-base>_dev-revised.note.md`
- use the same timestamp across all history files in one approved bundle revise operation
- ask before editing files, creating documents, or changing document roles

When the user invokes `$doc-work-bundle <target> revise`, output only one copy-ready fenced code block: Preview Prompt.

The revise Preview Prompt should ask the next Codex response for this output before execution:

1. revised target document preview, if the target document should change
2. revised bundle document previews, only for bundle documents that should change
3. revised impact target previews, only if `check_targets` were used and those documents should change
4. target document path to update
5. changed bundle or impact document paths to update, if any
6. whether `check_targets` were used, and why
7. per-document summary note bodies within 10 lines each
8. whether each changed document is worth saving to history
9. explicit approval question
10. copy-ready preview follow-up prompt
11. copy-ready document-only completion prompt
12. copy-ready document-plus-history completion prompt

When the Preview Prompt is executed and the next Codex response provides the preview, split follow-up and completion copy-ready areas into separate fenced code blocks.

Bundle revise note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: bundle-dev-revised
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Bundle Context

- Target: <target-key>
- Bundle Docs:
  - <bundle-doc-1>
  - <bundle-doc-2>
- Impact Targets Used:
  - <impact-target-or-none>

## Developer Revision Request

- <developer request or review note line 1>

## Summary

- <summary line 1>
- <summary line 2>
~~~

The summary should be 10 lines or fewer.

The preview follow-up prompt for revise should use this shape:

```text
위 bundle revised preview를 기준으로 아래 추가 요청 또는 논의 내용을 반영해줘.
범위가 충분히 분명하면 bundle revised preview를 다시 제시해줘.
범위가 아직 불분명하면 파일 수정 없이 먼저 확인 질문, 범위 후보, 선택지를 제시해줘.

- <추가 요청, 질문, 논의 방향, 메모>
```

The document-only completion prompt for revise should use this shape:

```text
위 bundle revised preview를 기준으로 아래 문서들만 업데이트해줘.
이번 수정은 history snapshot을 생성하지 않는다.

Changed documents:
- <document-path-1>
- <document-path-2>

수정 전 최종 대상 파일을 다시 확인하고 진행해줘.
```

The document-plus-history completion prompt for revise should use this shape:

```text
위 bundle revised preview를 기준으로 아래 문서들을 업데이트하고,
각 변경 문서의 내용을 해당 bundle dev-revised history snapshot과 note로 저장해줘.

Changed documents:
- <document-path-1>
- <document-path-2>

History files:
- <history-snapshot-path-1>
- <history-note-path-1>
- <history-snapshot-path-2>
- <history-note-path-2>

모든 history 파일은 같은 timestamp를 사용하고, 파일명에는 timestamp 뒤에 `bundle`을 포함해줘.
각 note에는 Bundle Context, Developer Revision Request, Summary를 포함해줘.
수정 전 최종 대상 파일과 history 파일 존재 여부를 다시 확인하고 진행해줘.
```

## Stop Points

Ask for confirmation before:

- editing files
- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

## Boundaries

- Start from `include_for_bundle`; treat `check_targets` as conditional impact validation.
- Do not read `reference_docs` unless explicitly requested.
- Do not inspect `docs/history/**` contents unless explicitly requested.
- Do not turn bundle review into a full rewrite.
- Do not perform Git work.
- Keep current decisions separate from deferred or candidate ideas.
