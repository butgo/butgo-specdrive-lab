---
name: doc-work-ref
description: Work on one specdrive target document with only its configured upper/reference documents from affected-docs-map.json. Supports reference and revise actions with ref-prefixed history snapshots.
---

# Doc Work Ref

Use this skill when a target document should be checked or revised against only its configured upper/reference documents.
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.

This skill sits between `$doc-work` and `$doc-work-bundle`:

- `$doc-work` reads one target document only.
- `$doc-work-ref` reads the target document plus `reference_docs` only.
- `$doc-work-bundle` reads the target document plus `bundle_refs` from `doc-work-bundle-map.json`.

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

For `reference` or `revise`, read:

1. the resolved target document
2. only documents listed in that entry's `reference_docs`

Do not read `include_for_bundle` or `check_targets` unless the user explicitly asks to do bundle or impact validation.

Do not inspect `docs/history/**` file contents unless the user explicitly asks for history lookup.

## History Rules

If a ref action updates one document, save one history snapshot and one note for that document.

If a ref action updates multiple documents, save separate history snapshots and separate notes for each changed document.

Use the same timestamp for all history files created by one approved ref operation.

Ref history filenames must add `ref` after the timestamp:

```text
yyyy-MM-dd_HHmmss_ref_<document-base>_codex-reinforced.md
yyyy-MM-dd_HHmmss_ref_<document-base>_codex-reinforced.note.md
yyyy-MM-dd_HHmmss_ref_<document-base>_dev-revised.md
yyyy-MM-dd_HHmmss_ref_<document-base>_dev-revised.note.md
```

For project documents, use:

```text
docs/history/projects/<project>/doc/<document-base>/ref/
```

The `<document-base>` is the target document filename without `.md`, such as `02-requirements`.
Older history paths directly under `docs/history/projects/<project>/<document-base>/...` are preserved as past history and should not be moved unless the developer explicitly asks.

If a reference document is also changed, use that changed document's own ref history directory and document base.

History completion is intentionally lightweight.
Use preview steps for document reasoning and consistency judgment.
After the developer approves a reference or revise preview, do not regenerate, re-explain, or re-compare the documents.
Apply the latest approved preview content, write the matching history snapshots and notes only when requested, then verify each changed document and its snapshot hash match.
Do not inspect existing history file bodies during completion.

## Output Fencing Rules

When showing any target, reference, or revised document preview, wrap the whole preview with `~~~markdown`, not triple backticks.
This prevents inner Markdown examples such as code blocks, JSON examples, or text snippets from closing the outer preview block.
Inside a document preview, prefer indented examples or inline code for short snippets.
If fenced examples are needed inside the preview, use triple backticks only because the outer preview uses tildes.

Copy-ready prompts may use triple backticks with `text`, but do not put full document previews inside copy-ready prompt blocks.

## Output: Target Only

For target-only selection, reply with:

1. target key and document path
2. target document role
3. reference documents from `reference_docs`
4. action choices
5. copy-ready examples such as `$doc-work-ref board-requirements reference` and `$doc-work-ref board-requirements revise`

## Output: Reference

For `reference`, output a copy-ready prompt that asks Codex to read the target and `reference_docs`, then prepare a reference-based reinforcement preview.

The reference prompt must ask Codex to:

- read only the target document and `reference_docs`
- keep the target document's role and scope
- separate current decisions from deferred ideas
- avoid downstream, sibling, bundle, or impact checks unless explicitly requested
- avoid editing files before approval
- produce previews for every document it proposes to update
- propose per-document history snapshot paths and note paths for every changed document
- use `ref` in every proposed history filename
- use the same timestamp across all history files in one approved ref operation
- ask for explicit approval before editing files or creating history files
- keep the approval/completion step as simple apply, copy, note, and hash verification

The reference prompt should ask for this output before execution:

1. target document preview, if the target document should change
2. reference document previews, only for reference documents that should change
3. target document path to update
4. changed reference document paths to update, if any
5. per-document history snapshot paths
6. per-document history note paths
7. per-document summary note bodies within 10 lines each
8. explicit approval question
9. copy-ready approval prompt

If no file change is needed, the response should say so and should not propose history files.

Reference note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: ref-codex-reinforced
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Ref Context

- Target: <target-key>
- Reference Docs:
  - <reference-doc-1>
  - <reference-doc-2>

## Summary

- <summary line 1>
- <summary line 2>
~~~

The summary should be 10 lines or fewer.

The copy-ready approval prompt for reference should use this shape:

```text
승인된 reference preview를 기준으로 아래 문서들을 업데이트하고,
각 변경 문서의 내용을 해당 ref history snapshot과 note로 저장해줘.

Changed documents:
- <document-path-1>
- <document-path-2>

History files:
- <history-snapshot-path-1>
- <history-note-path-1>
- <history-snapshot-path-2>
- <history-note-path-2>

모든 history 파일은 같은 timestamp를 사용하고, 파일명에는 timestamp 뒤에 `ref`를 포함해줘.
수정 전 최종 대상 파일과 history 파일 존재 여부를 다시 확인하고 진행해줘.
```

## Output: Revise

For `revise`, output a copy-ready prompt that asks Codex to apply developer revision after a previous reference reinforcement or reference review.

The revise prompt must:

- read only the target document and `reference_docs`
- include a clearly marked blank section for the developer's revision request
- keep the target and reference document roles unchanged
- produce revised previews for every document it proposes to update
- ask whether each changed document should be saved to history
- for history-worthy changes, use `_ref_<document-base>_dev-revised.md` and `_ref_<document-base>_dev-revised.note.md`
- use the same timestamp across all history files in one approved ref revise operation
- ask before editing files, creating documents, or changing document roles
- keep the approval/completion step as simple apply, optional history copy, note, and hash verification

When the user invokes `$doc-work-ref <target> revise`, output only one copy-ready fenced code block: Preview Prompt.
Generated copy-ready execution prompts must not start with `$doc-work-ref`.
Use a plain execution header such as `Doc-work-ref <target-key> <action> 실행 기준으로 진행해줘.` instead.
Reserve `$doc-work-ref ...` only for user-facing command examples, not for prompts that should be pasted back for execution.

The revise Preview Prompt should ask the next Codex response for this output before execution:

1. revised target document preview, if the target document should change
2. revised reference document previews, only for reference documents that should change
3. target document path to update
4. changed reference document paths to update, if any
5. per-document summary note bodies within 10 lines each
6. whether each changed document is worth saving to history
7. explicit approval question
8. copy-ready preview follow-up prompt
9. copy-ready document-only completion prompt
10. copy-ready document-plus-history completion prompt

When the Preview Prompt is executed and the next Codex response provides the preview, split follow-up and completion copy-ready areas into separate fenced code blocks.

Revise note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: ref-dev-revised
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Ref Context

- Target: <target-key>
- Reference Docs:
  - <reference-doc-1>
  - <reference-doc-2>

## Developer Revision Request

- <developer request or review note line 1>

## Summary

- <summary line 1>
- <summary line 2>
~~~

The summary should be 10 lines or fewer.

The preview follow-up prompt for revise should use this shape:

```text
위 ref revised preview를 기준으로 아래 추가 요청 또는 논의 내용을 반영해줘.
범위가 충분히 분명하면 ref revised preview를 다시 제시해줘.
범위가 아직 불분명하면 파일 수정 없이 먼저 확인 질문, 범위 후보, 선택지를 제시해줘.

- <추가 요청, 질문, 논의 방향, 메모>
```

The document-only completion prompt for revise should use this shape:

```text
승인된 ref revised preview를 기준으로 아래 문서들만 업데이트해줘.
이번 수정은 history snapshot을 생성하지 않는다.

Changed documents:
- <document-path-1>
- <document-path-2>

수정 전 최종 대상 파일을 다시 확인하고 진행해줘.
```

The document-plus-history completion prompt for revise should use this shape:

```text
승인된 ref revised preview를 기준으로 아래 문서들을 업데이트하고,
각 변경 문서의 내용을 해당 ref dev-revised history snapshot과 note로 저장해줘.

Changed documents:
- <document-path-1>
- <document-path-2>

History files:
- <history-snapshot-path-1>
- <history-note-path-1>
- <history-snapshot-path-2>
- <history-note-path-2>

모든 history 파일은 같은 timestamp를 사용하고, 파일명에는 timestamp 뒤에 `ref`를 포함해줘.
각 note에는 Ref Context, Developer Revision Request, Summary를 포함해줘.
승인된 preview를 다시 생성하거나 설명하지 말고, 단순 적용/저장/검증으로 처리해줘.
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

- Use only `reference_docs` as the reference set.
- Do not read `include_for_bundle` or `check_targets` unless explicitly requested.
- Do not inspect `docs/history/**` contents unless explicitly requested.
- Do not expand into downstream or sibling document checks.
- Do not perform Git work.
- Use `$doc-work-bundle` for mutual consistency checks across related documents.
