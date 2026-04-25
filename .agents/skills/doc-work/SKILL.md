---
name: doc-work
description: Work on one specdrive target document at a time. Use when the user invokes $doc-work, wants a target document list, chooses draft or reinforce for a configured target, or asks Codex to prepare a single-document doc-stage prompt without loading reference or bundle documents by default.
---

# Doc Work

Use this skill as the basic single-document entry point for specdrive doc-stage work.

## Read First

Read this registry first:

```text
specdrive/config/target-registry.json
```

If the user did not provide a target key or document path, list the available target keys and stop.

If the user provided a target key, resolve it from `targets`.
If the user provided a document path, match it to a target by `document_path` when possible.

If the user provided only a target and no action, read only the target metadata and show the action choices.

Supported actions for now:

- `draft`
- `reinforce`
- `revise`

If the user provided a target and action, read only the resolved target document.

Do not read `specdrive/config/affected-docs-map.json` for this skill unless the user explicitly asks for reference or bundle checking.

Before generating an action prompt, check existing history filenames for the target under its project history directory.
For project documents, use `docs/history/projects/<project>/<document-base>/` where `<document-base>` is the target document filename without `.md`.

- For `draft`, if any file matching `*_dev-draft.md` exists for the target document base, report that a developer draft history already exists and stop.
- For `reinforce`, if any file matching `*_codex-reinforced.md` exists for the target document base, report that a Codex reinforced history already exists and stop.
- For `revise`, allow multiple runs. Do not stop when `*_dev-revised.md` already exists.
- Do not inspect the contents of existing `docs/history/**` files unless the user explicitly asks for history lookup.

## Output

For target selection, reply with:

1. available target keys
2. document paths
3. copy-ready examples such as `$doc-work board-design-summary`

For target-only selection, reply with:

1. target key and document path
2. current document role
3. action choices
4. stage status for `draft`, `reinforce`, and `revise`
5. copy-ready examples such as `$doc-work board-overview draft`, `$doc-work board-overview reinforce`, and `$doc-work board-overview revise`

For `draft`, output a copy-ready prompt that asks Codex to copy the current target document into history as a developer draft.
The draft prompt must:

- stop if a `_dev-draft.md` history snapshot already exists for the target
- read the target document directly
- treat the current document as a developer draft
- copy the current target document content as-is into a history snapshot
- create a simple note file with the fixed note shape below
- use `_dev-draft.md` and `_dev-draft.note.md` as the draft history suffix pattern
- prefix every proposed history filename with `yyyy-MM-dd_HHmmss_`, for example `2026-03-17_131703_`
- avoid editing files until the developer explicitly approves
- keep history saving separate from session-save

Draft note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: dev-draft
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Summary

개발자 초안 작성
~~~

For `reinforce`, output a copy-ready prompt that asks Codex to reinforce the target document, update the original target document, and save the reinforced result into history.
The reinforce prompt must:

- stop if a `_codex-reinforced.md` history snapshot already exists for the target
- read the target document directly
- respect the current document role and scope
- avoid reference or bundle documents unless the user asks for them
- separate current decisions from deferred ideas
- before updating the original target document, check whether a `_dev-draft.md` history snapshot already exists for the target
- if no `_dev-draft.md` snapshot exists, first copy the current target document content as-is into `_dev-draft.md` and create `_dev-draft.note.md`
- use `_codex-reinforced.md` and `_codex-reinforced.note.md` when proposing Codex reinforcement history files
- prefix every proposed history filename with `yyyy-MM-dd_HHmmss_`, for example `2026-03-17_131703_`
- update the original target document with the reinforced content only after developer approval
- copy the reinforced final content into the `_codex-reinforced.md` history snapshot
- create `_codex-reinforced.note.md` with a summary within 10 lines
- ask before editing files, creating documents, or changing document roles

The reinforce prompt should ask for this output before execution:

1. reinforced document preview
2. target document path to update
3. history snapshot path
4. history note path
5. summary note body within 10 lines
6. explicit approval question
7. copy-ready approval prompt
8. whether a missing dev-draft snapshot will be created first

Codex reinforced note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: codex-reinforced
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Summary

- <summary line 1>
- <summary line 2>
~~~

The summary should be 10 lines or fewer.

When outputting a copy-ready prompt, do not nest triple-backtick code fences inside it.
Use `~~~markdown` for embedded note templates so the copy area stays in one block.

The copy-ready approval prompt for reinforce should use this shape:

```text
위 reinforced document preview를 기준으로 `docs/projects/board/01-overview.md`를 업데이트하고,
같은 내용을 `docs/history/projects/board/01-overview/<timestamp>01-overview_codex-reinforced.md`에 저장한 뒤,
note를 `docs/history/projects/board/01-overview/<timestamp>01-overview_codex-reinforced.note.md`에 저장해줘.
단, 대상 문서의 `_dev-draft.md` history snapshot이 아직 없으면 원본 업데이트 전에 현재 원본을 먼저 `_dev-draft.md`와 `_dev-draft.note.md`로 저장해줘.
수정 전 최종 대상 파일 3개를 다시 확인하고 진행해줘.
```

For `revise`, output a copy-ready prompt that asks Codex to apply developer revision after initial Codex reinforcement.
The revise prompt must:

- require an existing `_codex-reinforced.md` history snapshot for the target
- read the target document directly
- treat the current document as developer revision input after Codex reinforcement
- include a common header that explains what Codex should do and must not do
- include a clearly marked blank section where the developer writes the requested revision
- update the original target document with the revised content only after developer approval
- output only the Preview Prompt when the user invokes `$doc-work <target> revise`
- have the Preview Prompt ask the next Codex response to provide follow-up and completion prompts after the preview
- separate the preview prompt from completion prompts because the conversation may not finish in one turn
- provide a document-only completion prompt for minor revisions that do not need history after the preview response
- provide a document-plus-history completion prompt for revisions worth preserving after the preview response
- for document-plus-history completion, copy the revised final content into `_dev-revised.md`
- for document-plus-history completion, create `_dev-revised.note.md` with a summary within 10 lines
- for document-plus-history completion, include the developer revision or review request in `_dev-revised.note.md`
- for document-plus-history completion, prefix every proposed history filename with `yyyy-MM-dd_HHmmss_`, for example `2026-03-17_131703_`
- allow multiple `_dev-revised.md` history snapshots for the same target
- ask before editing files, creating documents, or changing document roles

The revise copy-ready prompt should start with this common header:

```text
$doc-work <target-key> revise 기준으로 진행해줘.

## Target

- target key: <target-key>
- target document: <target-document>
- target kind: <target-kind>
- history directory: <history-directory>

## Developer Revision Request

아래 영역에는 확정된 수정 요청, 논의하고 싶은 방향, 질문, 메모 중 현재 준비된 내용을 적는다.
아직 범위가 분명하지 않으면 Codex와 대화하면서 수정 범위를 먼저 맞춰간다.

<수정 요청 또는 논의하고 싶은 방향을 작성>

## Codex Task

대상 문서를 저장소에서 직접 읽고, 위 Developer Revision Request 또는 이후 대화 내용을 현재 문서 역할과 범위 안에서 반영해줘.
수정 범위가 충분히 분명하면 revised document preview를 만들어줘.
수정 범위가 아직 불분명하면 파일 수정 없이 먼저 확인 질문, 범위 후보, 선택지를 제시해줘.

## Codex Must Do

- 대상 문서를 직접 읽는다.
- Developer Revision Request와 이후 대화 내용을 우선 기준으로 삼는다.
- 현재 문서의 역할과 범위를 유지한다.
- 현재 결정과 후속 후보를 구분한다.
- 범위가 충분히 정리되면 revised document preview를 먼저 제시한다.
- 범위가 불분명하면 preview를 서두르지 말고 먼저 질문하거나 범위 후보를 제시한다.
- 수정 중요도에 따라 history 저장이 필요한지 판단할 수 있도록 summary를 제공한다.
- 완료 실행은 개발자가 별도 completion prompt를 붙여 승인할 때만 진행한다.

## Codex Must Not Do

- 참조 문서나 bundle 문서를 읽지 않는다.
- docs/history/** 기존 파일 본문을 비교하거나 정리하지 않는다.
- 현재 문서의 역할을 바꾸지 않는다.
- 신규 문서를 만들지 않는다.
- 요구사항, 설계, 구현 계획으로 단계 전환하지 않는다.
- Developer Revision Request나 이후 대화에 없는 확장을 확정처럼 추가하지 않는다.
- 개발자 승인 전에는 어떤 파일도 수정하지 않는다.
```

When the user invokes `$doc-work <target> revise`, output only one copy-ready fenced code block: Preview Prompt.
Do not output Preview Follow-up Prompt, Completion Prompt A, or Completion Prompt B at this stage.

The Preview Prompt should ask the next Codex response for this output before execution:

1. revised document preview
2. target document path to update
3. summary note body within 10 lines
4. whether this revision is worth saving to history
5. explicit approval question
6. copy-ready preview follow-up prompt
7. copy-ready document-only completion prompt
8. copy-ready document-plus-history completion prompt

When the Preview Prompt is executed and the next Codex response provides the preview, split follow-up and completion copy-ready areas into separate fenced code blocks:

1. Preview Follow-up Prompt
2. Completion Prompt A: Document Only
3. Completion Prompt B: Document Plus History

Do not put follow-up and completion prompts in the same copy-ready block.

Dev revised note shape:

~~~markdown
# Note

- Document: <DOCUMENT-LABEL>
- Title: <target file name>
- Stage: dev-revised
- Saved At: <yyyy-MM-dd HH:mm:ss>

## Developer Revision Request

- <developer request or review note line 1>
- <developer request or review note line 2>

## Summary

- <summary line 1>
- <summary line 2>
~~~

The summary should be 10 lines or fewer.
The Developer Revision Request section should capture the developer's requested change, review question, or discussion direction that led to the revision.

The preview follow-up prompt for revise should use this shape:

```text
위 revised document preview를 기준으로 아래 추가 요청 또는 논의 내용을 반영해줘.
범위가 충분히 분명하면 revised document preview를 다시 제시해줘.
범위가 아직 불분명하면 파일 수정 없이 먼저 확인 질문, 범위 후보, 선택지를 제시해줘.

- <추가 요청, 질문, 논의 방향, 메모>
```

The document-only completion prompt for revise should use this shape:

```text
위 revised document preview를 기준으로 `docs/projects/board/01-overview.md`만 업데이트해줘.
이번 수정은 history snapshot을 생성하지 않는다.
수정 전 최종 대상 파일 1개를 다시 확인하고 진행해줘.
```

The document-plus-history completion prompt for revise should use this shape:

```text
위 revised document preview를 기준으로 `docs/projects/board/01-overview.md`를 업데이트하고,
같은 내용을 `docs/history/projects/board/01-overview/<timestamp>01-overview_dev-revised.md`에 저장한 뒤,
Developer Revision Request와 Summary를 포함한 note를 `docs/history/projects/board/01-overview/<timestamp>01-overview_dev-revised.note.md`에 저장해줘.
수정 전 최종 대상 파일 3개를 다시 확인하고 진행해줘.
```

When outputting revise completion prompts, keep history filename details and apply rules inside the completion prompts, not inside the initial preview prompt.

Use this output shape for action prompts:

```text
target: <target-key>
document: <document-path>
action: <draft|reinforce|revise>

아래 프롬프트를 사용해주세요.

<copy-ready prompt>
```

Keep the output concise.

## Stop Points

Ask for confirmation before:

- editing files
- creating a new document
- changing a document role
- moving from requirements to design
- moving from design to implementation planning
- changing active state or next entry point in status/index documents

## Boundaries

- Work on one target document only.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.
- Do not treat undecided ideas as confirmed decisions.
- Do not perform Git work.
- Use `$doc-work-ref` when parent/reference documents should be read.
- Use `$doc-work-bundle` when related documents should be cross-checked.
