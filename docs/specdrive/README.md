# docs/specdrive/README.md

[English](README.md) | [한국어](README.ko.md)

## 1. Document Purpose

This document is the **main entry document** for the `docs/specdrive/**` area.

Its purposes are as follows.

- Explain specdrive's current identity and goals.
- Organize the scope and role of specdrive documents.
- Distinguish the boundary between specdrive and projects.
- Guide readers on the order in which specdrive documents should be read.
- Fix how specdrive should be understood at the current stage.

This document explains the overall direction and overview of the entire specdrive area.  
Detailed work rules follow `docs/specdrive/AGENTS.md`,  
current-state recovery follows `docs/AI_CONTEXT.md`,  
and the detailed list follows `docs/specdrive/index.md` and the individual documents.

---

## 2. How to View specdrive

specdrive is a **tool that executes AI collaboration based on development specification documents**.

At the current stage, specdrive should be understood as follows.

- A document-based AI collaboration engine
- An operating system for repeatable work flows
- A CLI-centered work orchestrator
- A tool that reads real project documents and executes collaboration flows

In other words, specdrive is currently closer to an  
**engine / operating system for validating the core workflow of AI-assisted development**  
than to a **finished SaaS product**.

At the current stage, one more distinction matters.

- `.speclab/**` is for intermediate execution artifacts.
- What must remain is the real project document and its history.
- Meaningful document work should be preserved under `docs/history/projects/**` like a document ledger.

In other words, specdrive is not primarily about storing previews.  
Its core is **executing document-based AI collaboration flows and settling the results into real documents and document history**.

---

## 3. Why specdrive Documents Are Needed

AI collaboration can produce results quickly,  
but when context and structure are unclear, the results easily become unstable.

For example, the following problems are easy to run into.

- Expansion beyond the current scope
- Collapse of structural boundaries
- Loss of context when sessions change
- Misalignment between documents and implementation
- Quality variance when repeating the same kind of work

specdrive documents exist to reduce these problems.

In other words, specdrive documents define in a repeatable form:

- what standards AI should work from,
- how documents should be reinforced,
- how the flow should move into development,
- and what state and traces should be left behind.

---

## 4. Core Perspective of specdrive at the Current Stage

The most important perspectives in specdrive right now are as follows.

### 4.1 Document First
Documents are the standard.  
Implementation follows the documents.

### 4.2 Human Confirmation First
Documents reinforced by AI are only drafts or reinforcement proposals.  
Before a human confirms them, they are not standard documents.

### 4.3 Stage Separation
Separate the stage of refining documents  
from the stage of doing actual development based on documents.

### 4.4 Minimum Flow First
At the current stage, rather than defining a huge product structure,  
fix the minimum repeatable work flow first.

### 4.5 Codex-Centered Validation
For now, collaboration flows are organized and validated around Codex.

---

## 5. Work Stages of specdrive

At the current stage, specdrive divides the work flow into the core work stages `doc` and `dev`, the operating stage `session`, and the delivery stage `git`.

### 5.1 doc Stage
This is the stage of making documents implementation-ready.

Core flow:

- draft-save
- reinforce-prompt
- reinforce
- confirm
- history-save

Basic meaning:

- AI reinforces the current documents.
- A human reviews and confirms them.
- Important decisions and results are recorded in history.

At the current stage, this is better understood more concretely as follows.

- `draft-save`: save the current developer draft into history before Codex reinforcement starts.
- `reinforce-prompt`: generate a normalized copy prompt for Codex so the conversation can start inside specdrive rules.
- `reinforce`: create reinforcement drafts and review artifacts, and keep a narrow path for actual Codex execution tests.
- `confirm`: decide whether to apply the reinforced draft to the real project document and leave the evidence in history.
- `history-save`: fix the current applied document state and human judgment into history.

One more point matters at the current stage.

The preferred document loop is shifting away from a fully automatic “CLI applies everything” idea.
Instead, specdrive is being shaped around the following rhythm.

1. The developer writes a draft.
2. `draft-save` records the draft as history.
3. `reinforce-prompt` starts a normalized Codex conversation.
4. The developer and Codex refine the document through direct or interactive dialogue.
5. `history-save` explicitly records the meaningful applied state.
6. Repeat until the document is ready for confirm.

This means specdrive currently treats the CLI not only as an execution wrapper,
but also as a way to standardize prompts and preserve a clean document-history loop.

### 5.2 dev Stage
This is the stage of performing actual development work based on confirmed documents.

Core flow:

- task-split
- phase
- cycle
- status

Basic meaning:

- Decompose work based on confirmed documents.
- Manage the current development stage through phase / cycle.
- Keep the current work state recoverable.

### 5.3 session Stage
This is the operating stage for starting and closing sessions.

Core flow examples:

- start
- save

Basic meaning:

- Recover the current state and next entry point at session start.
- Save session notes and the next entry point at session end.

At the current stage, `session start` is better understood not as an automatic work-start command,
but as a command that prints a copy prompt so Codex can read the relevant documents, recover the current state,
and summarize the focus and next entry point first.
Actual document edits or follow-up work begin only after the developer explicitly asks for them.

At the current stage, `session save` is better understood not as an automatic save command,
but as a command that prints a copy prompt asking Codex for a `docs/AI_CONTEXT.md` update draft.
The draft is reviewed first, and the real `docs/AI_CONTEXT.md` edit happens only after the developer explicitly asks to save it.

At the current stage, `session status` is better understood as a read-only status check based on `docs/AI_CONTEXT.md`.
It does not generate a copy prompt and does not start document edits or save flows by itself.

### 5.4 git Stage
This is the stage for generating Git delivery artifacts.

Core flow examples:

- branch-name
- git-message
- pr-message

Basic meaning:

- Read the current branch and changed files.
- Generate a new branch-name draft.
- Generate a Git commit message draft.
- Generate a PR title/body draft.

---

## 6. What specdrive Covers

At the current stage, specdrive covers the following.

- Document-based AI collaboration flow
- Session start and context recovery
- Session save and next-entry preservation
- Branch naming and Git / PR message generation support
- Document reinforcement / confirmation / history-save procedures
- Task decomposition procedures
- The management direction of phase / cycle / status
- CLI command structure
- Role separation among prompt / skill / state-management assets
- Validation of an operating model applicable to real projects

---

## 7. What specdrive Does Not Cover Directly

At the current stage, specdrive documents do not directly cover the following.

- Detailed requirements of a specific application
- API / DB / package design of a specific project
- Domain policies of an individual project
- Finished SaaS UI design
- Organization / user / billing features
- Generalized multi-AI engine support
- Operations / deployment automation

These are handled in project documents or in later stages.

---

## 8. Relationship Between specdrive and projects

specdrive and projects are currently in the same repository, but their roles are different.

### specdrive
- Covers collaboration methods
- Covers context, procedures, commands, and state flow
- Covers how work should be done

### projects
- Covers the actual application content
- Covers requirements, design, implementation plans, and state
- Covers what should be built

At the current stage, they are validated together,  
but the long-term assumption is a structure in which they can be separated.

---

## 9. Current Technical Direction

The current technical direction of specdrive is as follows.

- AI engine: centered on Codex
- Execution interface: PowerShell CLI
- Goal: validate the minimum work flow
- Current repository nature: alpha integrated validation repository
- Later candidates: possible reimplementation in Go or Python
- Multi-AI engine support is not a current priority

In other words, this is the stage of first building and validating a  
**minimum operating system that works**, rather than a general platform.

---

## 10. Relationship Between specdrive Documents and Assets

At the current stage, assets related to specdrive roughly have the following relationships.

### 10.1 `docs/specdrive/**`
- specdrive concepts
- rules
- structure
- flow explanations

### 10.2 `specdrive/scripts/**`
- specdrive execution scripts
- command-processing flow
- state / path / output helpers

### 10.3 `specdrive/skills/**`
- internal work assets for standardizing repeatable tasks
- for example: document reinforcement, history saving, task decomposition

### 10.4 `specdrive/config/**`
- document mapping
- path rules
- configuration assets connected to commands and state

In other words, documents provide explanation and standards,  
while `specdrive/scripts`, `specdrive/skills`, and `specdrive/config` connect those standards to executable forms.

---

## 11. Current Priorities

The current priorities of specdrive are as follows.

### Priority 1
- Secure consistency among README / AGENTS / AI_CONTEXT
- Fix specdrive identity and work rules

### Priority 2
- Fix the separation of `doc` / `dev` stages at both the document and command levels
- Fix the role of `session` as a separate operating stage
- Fix the role of `git` as a separate delivery stage
- Make it possible for Codex to understand the project nature consistently

### Priority 3
- Validate the minimum CLI flow
- `doc reinforce / confirm / history-save`
- `dev phase / cycle / status / task-split`
- `session start / save`
- `git branch-name / git-message / pr-message`

### Priority 4
- Organize follow-up technical documents
- Detailed design for skill / CLI / Codex integration

---

## 12. Recommended Reading Order

When starting specdrive work, the usual reading order is as follows.

1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/specdrive/AGENTS.md`
5. `docs/specdrive/README.md`
6. `docs/specdrive/index.md`
7. The target specdrive document

---

## 13. Final Summary

`docs/specdrive/README.md` is the entry document for explaining specdrive itself.

When working with specdrive, always check the following first.

- Is the current topic about specdrive's own rules?
- Does it reflect that the current stage is engine / operating-system validation?
- Are the responsibilities of `doc` and `dev` kept separate?
- Is project-document content being pulled into specdrive documents by mistake?
- Is this moving in the direction of strengthening the minimum flow needed right now?

At the current stage, specdrive should be understood less as a finished product and more as a  
**tool for making document-based AI collaboration flows repeatable**.

