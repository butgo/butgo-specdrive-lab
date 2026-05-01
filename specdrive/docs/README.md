# specdrive/docs/README.md

[English](README.md) | [한국어](README.ko.md)

## 1. Document Purpose

This document is the **main entry document** for the `specdrive/docs/**` area.

Its purposes are as follows.

- Explain specdrive's current identity and goals.
- Organize the scope and role of specdrive documents.
- Distinguish the boundary between specdrive and projects.
- Guide readers on the order in which specdrive documents should be read.
- Fix how specdrive should be understood at the current stage.

This document explains the overall direction and overview of the entire specdrive area.  
Detailed work rules follow `specdrive/docs/AGENTS.md`,  
current-state recovery follows `docs/AI_CONTEXT.md`,  
and the detailed list follows `specdrive/docs/index.md` and the individual documents.

---

## 2. How to View specdrive

specdrive is a **tool that executes AI collaboration based on development specification documents**.

At the current stage, specdrive should be understood as follows.

- A document-based AI collaboration engine
- An operating system for repeatable work flows
- A **repo-local Codex skill-first** work orchestrator
- A future **wizard-style guided workflow** layer for repeated, stabilized flows
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

At the current stage, this means the operating order is explicit:

1. Validate the workflow with repo-local skills first.
2. Stabilize the repeated action shape and human confirmation points.
3. Only then promote the stable flow into a wizard-style guided experience.

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

At the current stage, specdrive divides the work flow into the core work stages `doc`, `plan`, and `dev`, the operating stage `session`, and the delivery stage `git`.

### 5.1 doc Stage
This is the stage of making documents implementation-ready.

Core flow:

- draft-save
- reinforce-prompt
- reinforce
- confirm-prompt
- apply-prompt
- apply-only-prompt

Basic meaning:

- AI reinforces the current documents.
- A human reviews the reinforcement result through a normalized prompt.
- Meaningful applied results are prepared together with history notes.

At the current stage, this is better understood more concretely as follows.

- `draft-save`: save the current developer draft into history before Codex reinforcement starts.
- `reinforce-prompt`: generate a normalized copy prompt for Codex so the conversation can start inside specdrive rules.
- `reinforce`: create reinforcement drafts and review artifacts, and keep a narrow path for actual Codex execution tests.
- `confirm-prompt`: generate a normalized review prompt before real document updates.
- `apply-prompt`: generate a normalized prompt for deliberate document apply + history save.
- `apply-only-prompt`: generate a normalized prompt for document-only apply when history save is intentionally skipped.

One more point matters at the current stage.

The preferred document loop is shifting away from a fully automatic “automation applies everything” idea.
Instead, specdrive is being shaped around the following rhythm.

1. The developer writes a draft.
2. `draft-save` records the draft as history.
3. `reinforce-prompt` starts a normalized Codex conversation.
4. The developer and Codex refine the document through direct or interactive dialogue.
5. `confirm-prompt` reviews whether the proposal is ready to apply.
6. `apply-prompt` explicitly prepares the meaningful applied state and history note.
7. Repeat as needed.

This means specdrive currently treats repo-local skills as a way to standardize prompts
and preserve a clean document-history loop before returning to heavier automation.

### 5.2 plan Stage
This is the stage of decomposing confirmed or near-confirmed development documents into executable work structure.

Core flow:

- extract-candidates
- wp-split
- phase-split
- cycle-split
- task-split

Basic meaning:

- Extract general work candidates from development documents.
- Split work candidates into Work Package candidates.
- Place Work Package candidates into Phase and Cycle structure.
- Split selected Work Packages into executable Tasks.
- Prepare `work-candidates.md` and `work-roadmap.md` before coding starts.

At the current stage, Work Package means a dev coding bundle.  
It should leave a meaningful behavior, structure, or verification result when completed.

### 5.3 dev Stage
This is the stage of performing actual coding and testing based on the approved plan.

Core flow:

- start
- run
- test
- sync

Basic meaning:

- Select the current Work Package from the approved roadmap.
- Set the current execution pointer in `work-index.md`.
- Code within the current Work Package.
- Test or verify the current Work Package.
- Summarize the result in `work-log.md` and propose follow-up sync.

### 5.4 session Stage
This is the operating stage for starting and closing sessions.

Current skill flow examples:

- `$session start-lite`
- `$session restore`
- `$session start`
- `$session status`
- `$session save`

Basic meaning:

- Recover the current state and next entry point through session skills.
- Save session notes and the next entry point at session end.

At the current stage, `$session start` is better understood not as an automatic work-start command,
but as an action that prints a copy prompt so Codex can read the relevant documents, recover the current state,
and summarize the focus and next entry point first.
Actual document edits or follow-up work begin only after the developer explicitly asks for them.

At the current stage, `$session save` is better understood not as an automatic save command,
but as an action that prints a copy prompt asking Codex for a `docs/AI_CONTEXT.md` update draft.
The draft is reviewed first, and the real `docs/AI_CONTEXT.md` edit happens only after the developer explicitly asks to save it.

At the current stage, `$session status` is better understood as a compact read-only status check.
It does not generate a copy prompt and does not start document edits or save flows by itself.

At the current stage, `$session restore` is better understood as a read-only recovery action after a VS Code or Codex restart.
It checks `docs/AI_CONTEXT.md` together with the current Git workspace state and summarizes where to resume.

### 5.5 git Stage
This is the stage for generating Git delivery artifacts.

Current skill flow examples:

- `git-commit`
- `github-pr`

Basic meaning:

- Read the current branch and changed files.
- Prepare a safe commit proposal.
- Commit and push only after explicit approval.
- Draft or create a GitHub PR only after explicit approval.

---

## 6. Work System

SpecDrive's Work System is an operating structure for collecting candidate work, decomposing it into Phase / Cycle / Work Package / Task units, and then allowing humans and AI to execute and synchronize work based on the current work pointer.

Detailed standards follow this document:

- `work-system.md`

Project-specific application documents are placed under each project's `work/` directory.

Examples:

- `docs/projects/board/work/work-candidates.md`
- `docs/projects/board/work/work-roadmap.md`
- `docs/projects/board/work/work-index.md`
- `docs/projects/board/work/work-log.md`

---

## 7. What specdrive Covers

At the current stage, specdrive covers the following.

- Document-based AI collaboration flow
- Session start and context recovery
- Session save and next-entry preservation
- Git commit and GitHub PR workflow support
- Document reinforcement / review / apply-history procedures
- Work Package extraction and plan decomposition procedures
- Phase / Cycle / Work Package / Task management direction
- Dev execution based on the current Work Package
- repo-local Codex skill structure
- Role separation among prompt / skill / state-management assets
- Validation of an operating model applicable to real projects

---

## 8. What specdrive Does Not Cover Directly

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

## 9. Relationship Between specdrive and projects

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

## 10. Current Technical Direction

The current technical direction of specdrive is as follows.

- AI engine: centered on Codex
- Execution interface: repo-local Codex skills
- Goal: validate the minimum work flow
- Current repository nature: alpha integrated validation repository
- Later candidates: possible reimplementation in Go or Python
- Multi-AI engine support is not a current priority

In other words, this is the stage of first building and validating a  
**minimum operating system that works**, rather than a general platform.

---

## 11. Relationship Between specdrive Documents and Assets

At the current stage, assets related to specdrive roughly have the following relationships.

### 11.1 `specdrive/docs/**`
- specdrive concepts
- rules
- structure
- flow explanations

### 11.2 `specdrive/scripts/**`
- specdrive execution scripts
- workflow-processing flow
- state / path / output helpers

### 11.3 `specdrive/skills/**`
- internal work assets for standardizing repeatable tasks
- for example: document reinforcement, history saving, task decomposition

### 11.4 `specdrive/config/**`
- document mapping
- path rules
- configuration assets connected to skills and state

In other words, documents provide explanation and standards,  
while skills, scripts, and config connect those standards to executable forms as needed.

---

## 12. Current Priorities

The current priorities of specdrive are as follows.

### Priority 1
- Secure consistency among README / AGENTS / AI_CONTEXT
- Fix specdrive identity and work rules

### Priority 2
- Fix the separation of `doc` / `plan` / `dev` stages at both the document and command levels
- Fix the role of `session` as a separate operating stage
- Fix the role of `git` as a separate delivery stage
- Make it possible for Codex to understand the project nature consistently

### Priority 3
- Validate the minimum repo-local skill flow
- `doc reinforce / confirm-prompt / apply-prompt`
- `plan extract-candidates / wp-split / phase-split / cycle-split / task-split`
- `dev start / run / test / sync`
- `$session start-lite / $session restore / $session start / $session status / $session save`
- `$git-commit / $github-pr`

### Priority 4
- Organize follow-up technical documents
- Detailed design for skill / deferred CLI / Codex integration

---

## 13. Recommended Reading Order

When starting specdrive work, the usual reading order is as follows.

1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `specdrive/docs/AGENTS.md`
5. `specdrive/docs/README.md`
6. `specdrive/docs/index.md`
7. The target specdrive document

---

## 14. Final Summary

`specdrive/docs/README.md` is the entry document for explaining specdrive itself.

When working with specdrive, always check the following first.

- Is the current topic about specdrive's own rules?
- Does it reflect that the current stage is engine / operating-system validation?
- Are the responsibilities of `doc`, `plan`, and `dev` kept separate?
- Is project-document content being pulled into specdrive documents by mistake?
- Is this moving in the direction of strengthening the minimum flow needed right now?

At the current stage, specdrive should be understood less as a finished product and more as a  
**tool for making document-based AI collaboration flows repeatable**.

