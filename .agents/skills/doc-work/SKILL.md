---
name: doc-work
description: Work on one specdrive target document at a time. Use when the user invokes $doc-work, wants a target document list, chooses draft or reinforce for a configured target, or asks Codex to prepare a single-document doc-stage prompt without loading reference or bundle documents by default.
---

# Doc Work

Use this skill as the basic single-document entry point for specdrive doc-stage work.
## Wizard Rule

This skill performs only the current action.
It prints one copy-ready prompt only when a clear next action exists.

Detailed rule: `specdrive/rules/skill-wizard-rule.md` when wizard behavior is unclear.

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

Before generating an action prompt, check existing history filenames for the target under its doc-work history directory.
For project documents, use `docs/history/projects/<project>/doc/<document-base>/work/` where `<document-base>` is the target document filename without `.md`.
Older history paths directly under `docs/history/projects/<project>/<document-base>/...` are preserved as past history and should not be moved unless the developer explicitly asks.

- For `draft`, if any file matching `*_dev-draft.md` exists for the target document base, report that a developer draft history already exists and stop.
- For `reinforce`, if any file matching `*_codex-reinforced.md` exists for the target document base, report that a Codex reinforced history already exists and stop.
- For `revise`, allow multiple runs. Do not stop when `*_dev-revised.md` already exists.
- Do not inspect the contents of existing `docs/history/**` files unless the user explicitly asks for history lookup.

## Output

## Output Fencing Rules

When showing a document preview, wrap the whole preview with `~~~markdown`, not triple backticks.
This prevents inner Markdown examples such as code blocks, JSON examples, or text snippets from closing the outer preview block.
Inside a document preview, prefer indented examples or inline code for short snippets.
If fenced examples are needed inside the preview, use triple backticks only because the outer preview uses tildes.

Copy-ready prompts may use triple backticks with `text`, but do not put a full document preview inside a copy-ready prompt block.

For target selection, reply with:

1. available target keys
2. document paths
3. copy-ready examples such as `$doc-work board-design`

For target-only selection, reply with:

1. target key and document path
2. current document role
3. action choices
4. stage status for `draft`, `reinforce`, and `revise`
5. a short guide line such as `아래 프롬프트를 사용해주세요.`
6. copy-ready examples such as `$doc-work board-overview draft`, `$doc-work board-overview reinforce`, and `$doc-work board-overview revise`

For `draft`, do not output a long execution prompt.
Draft is a lightweight history-copy operation, so handle the preflight directly in the current response:

- check whether a `_dev-draft.md` history snapshot already exists for the target
- read the target document directly
- propose the target document path, history snapshot path, and history note path
- ask one explicit approval question
- provide only a short copy-ready approval prompt

The draft preflight must:

- stop if a `_dev-draft.md` history snapshot already exists for the target
- read the target document directly
- treat the current document as a developer draft
- use `_dev-draft.md` and `_dev-draft.note.md` as the draft history suffix pattern
- prefix every proposed history filename with `yyyy-MM-dd_HHmmss_`, for example `2026-03-17_131703_`
- avoid editing files until the developer explicitly approves
- keep history saving separate from `$session save`

After the developer approves a draft snapshot, treat the completion as a simple copy operation.
Do not summarize, compare, or reinterpret the document.
Recheck the target snapshot and note paths, copy the current target document as-is, write the note, then verify the snapshot exists.

The draft preflight output should be compact and include only:

1. target document path to read
2. history snapshot path
3. history note path
4. explicit approval question
5. copy-ready approval prompt

The copy-ready approval prompt for draft should be short.
Prefer this shape when the paths were just shown in the same response:

```text
승인. 위 경로로 draft snapshot과 note를 저장해줘.
```

Use the longer shape only when the prompt must be portable across conversations:

```text
현재 `<target-document>` 내용을 그대로 복사해
`<history-snapshot-path>`에 draft snapshot을 저장하고,
note를 `<history-note-path>`에 저장해줘.
수정 전 최종 대상 파일 2개를 다시 확인하고 진행해줘.
```

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

For `reinforce`, output a compact copy-ready prompt that asks Codex to reinforce the target document, show a preview first, and wait for approval before editing files.
Keep the generated reinforce prompt short to reduce token usage.
Treat history saving after approval as a simple file operation, not as another document-reasoning step.
The reinforce prompt must include only:

1. target metadata
2. task: read the target directly and reinforce it within the current role/scope
3. guards: no reference/bundle docs, no history body inspection, no role/stage change, no file edit before approval
4. history checks: stop if `_codex-reinforced.md` exists; note whether `_dev-draft.md` exists
5. expected output: preview, target path, proposed reinforced snapshot/note paths, short summary, approval prompt

Do not include the full note template in the generated reinforce prompt.
Instead, say the note must use the standard `codex-reinforced` note shape with Document, Title, Stage, Saved At, and Summary within 10 lines.
The generated reinforce prompt should not repeat every detailed rule if the same meaning is already covered by the compact guards.
The reinforced preview may be concise when the document is large: show changed structure and important sections, then ask the developer to approve the full rewritten content only when needed.

After the developer approves a reinforced preview, do not regenerate or re-explain the document.
Apply the latest approved preview content, write the same content to the reinforced history snapshot, write the note, then verify target/snapshot hashes match.
Do not read reference documents, bundle documents, or existing history file bodies during this completion step.

When outputting a copy-ready prompt, do not nest triple-backtick code fences inside it.
Use `~~~markdown` for embedded note templates so the copy area stays in one block.

The copy-ready approval prompt for reinforce should use this shape:

```text
승인된 reinforced document preview를 기준으로 `docs/projects/board/01-overview.md`를 업데이트하고,
같은 내용을 `docs/history/projects/board/doc/01-overview/work/<timestamp>01-overview_codex-reinforced.md`에 저장한 뒤,
note를 `docs/history/projects/board/doc/01-overview/work/<timestamp>01-overview_codex-reinforced.note.md`에 저장해줘.
대상 문서의 `_dev-draft.md` history snapshot은 이미 있으므로 새로 만들지 않아도 돼.
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

Keep the generated revise prompt compact.
Use the preview step for document reasoning.
After the developer approves a revised preview, treat completion as a simple apply-and-save operation: apply the latest approved preview content, optionally write the same content to `_dev-revised.md`, write the note if history is requested, and verify target/snapshot hashes when a snapshot is created.
Do not regenerate, re-explain, or re-compare the revised document during completion.

The revise copy-ready prompt should start with this common header:

```text
Doc-work <target-key> revise 실행 기준으로 진행해줘.

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
승인된 revised document preview를 기준으로 `docs/projects/board/01-overview.md`만 업데이트해줘.
이번 수정은 history snapshot을 생성하지 않는다.
수정 전 최종 대상 파일 1개를 다시 확인하고 진행해줘.
```

The document-plus-history completion prompt for revise should use this shape:

```text
승인된 revised document preview를 기준으로 `docs/projects/board/01-overview.md`를 업데이트하고,
같은 내용을 `docs/history/projects/board/doc/01-overview/work/<timestamp>01-overview_dev-revised.md`에 저장한 뒤,
Developer Revision Request와 Summary를 포함한 note를 `docs/history/projects/board/doc/01-overview/work/<timestamp>01-overview_dev-revised.note.md`에 저장해줘.
수정 전 최종 대상 파일 3개를 다시 확인하고 진행해줘.
```

When outputting revise completion prompts, keep history filename details and apply rules inside the completion prompts, not inside the initial preview prompt.

For `reinforce` and `revise`, output only one copy-ready fenced code block containing the prompt.
Do not add separate target/document/action metadata outside the prompt.
Before the fenced block, add only one short guide line: `아래 프롬프트를 사용해주세요.`
Do not add explanatory prose after the fenced block.
Generated copy-ready execution prompts must not start with `$doc-work`.
Use a plain execution header such as `Doc-work <target-key> <action> 실행 기준으로 진행해줘.` instead.
Reserve `$doc-work ...` only for user-facing command examples, not for prompts that should be pasted back for execution.

When an executed prompt reaches a stop point and another developer action is expected, provide the next action as a copy-ready fenced prompt.
This includes approval prompts for saving draft history, applying reinforced content, and completing revised content.
When the work is fully complete or there is no useful follow-up action, finish with a concise result summary and do not include a copy-ready prompt.

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
