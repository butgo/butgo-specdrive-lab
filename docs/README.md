# docs/README.md

[English](README.md) | [한국어](README.ko.md)

## 1. Document Purpose

This document is the **top-level entry point** for the entire `docs/**` document structure.

Its purposes are as follows.

- Help readers quickly understand the big picture of the document tree.
- Distinguish the boundary between specdrive documents and project documents.
- Clarify the roles of shared operating documents, tool documents, application documents, and shared standard documents.
- Guide readers on which documents to read first in a new session or new task.
- Explain why the current repository has an integrated validation structure.

This document does not directly define the detailed policies of individual documents.  
For detailed standards, follow each area's `AGENTS.md`, `README.md`, `index.md`, and individual documents.

---

## 2. How to View the docs Area

Within the current repository, `docs/**` is  
an **integrated document area for validating specdrive and projects together**.

At the current stage, specdrive documents and project documents are operated together in one repository  
in order to validate both the product and its real-world application.

However, this is the operating model for the current stage.  
In the long term, the direction is as follows.

- `specdrive` documents = documents for an independent tool / engine / operating system
- `projects` documents = documents for individual applications handled by specdrive

In other words, `docs/**` is currently an integrated validation document space,  
but it is organized on the assumption that tool documents and application documents can be separated in the long term.

---

## 3. Key Perspective for the Current Stage

When looking at `docs/**`, the following perspective should be fixed first.

### 3.1 specdrive
specdrive is currently viewed not as a **finished SaaS product**,  
but as an **engine / operating system / repo-local Codex skill-centered tool**  
that executes AI collaboration based on development specification documents.

### 3.2 projects
projects is viewed as a  
**workspace for real application development specification documents**.

### 3.3 board
board is not a sub-feature of specdrive.  
It is viewed as the **first real application project**  
used to validate whether the specdrive approach is effective for actual projects.

### 3.4 standards
`docs/projects/standards/**` is viewed as the  
**shared project development standards document set**  
referenced commonly under projects.

---

## 4. Overall Document Structure

At the moment, `docs/**` is divided into the following layers.

### 4.1 Shared Operating Documents
Documents responsible for the repository-wide entry point, state recovery, and layer guidance

Examples:
- `docs/README.md`
- `docs/AI_CONTEXT.md`

### 4.2 specdrive Documents
The document set that covers specdrive's own operating structure, AI collaboration method, and tool perspective

Location:
- `specdrive/docs/**`

Entry document examples:
- `specdrive/docs/README.md`
- `specdrive/docs/AGENTS.md`
- `specdrive/docs/index.md`

### 4.3 projects Documents
The document set that covers development specification documents for real applications

Location:
- `docs/projects/**`

Entry document examples:
- `docs/projects/README.md`
- `docs/projects/board/README.md`
- `docs/projects/board/AGENTS.md`
- `docs/projects/board/index.md`

### 4.4 Shared Project Standard Documents
The document set for shared standards referenced in real application development

Location:
- `docs/projects/standards/**`

Entry document examples:
- `docs/projects/standards/index.md`

At the current stage, `docs/projects/standards/**` is treated as  
a supporting shared document area under `projects`.

---

## 5. What Each Area Covers

### 5.1 Shared Operating Documents
They cover shared concerns such as the following.

- Recovery of the current state
- Document reading order
- Guidance on document layers
- Shared entry standards in the overall workflow

### 5.2 `specdrive/docs/**`
This area covers specdrive's own tool perspective, such as the following.

- The identity and goals of specdrive
- Document-based AI collaboration flow
- Separation of `doc` / `dev` stages
- Session start method
- Context recovery method
- Document review and synchronization flow
- The direction of skill-centered execution structure
- The operating structure as a tool

In other words, `specdrive/docs/**` covers  
**how AI collaboration should be executed**.

### 5.3 `docs/projects/**`
This area covers real application documents such as the following.

- Requirements
- Design
- Implementation plan
- State
- History
- Application-specific decisions

In other words, `docs/projects/**` covers  
**what should be built**.

### 5.4 `docs/projects/standards/**`
This area covers shared project development standards such as the following.

- naming
- coding style
- db
- api
- package structure
- git policy

In other words, `docs/projects/standards/**` covers  
**which shared standards should be followed in application development**.

---

## 6. Document Layers to Understand First

When reading the documents, it is helpful to understand the following layers first.

### 6.1 Root Rules
- `AGENTS.md`
- Shared work rules and collaboration principles for the entire repository

### 6.2 State Recovery
- `docs/AI_CONTEXT.md`
- Current focus, next entry point, and recent decisions

### 6.3 Entry Document for the Entire docs Area
- `docs/README.md`

### 6.4 Entry Documents by Area
- `specdrive/docs/README.md`
- `docs/projects/README.md`
- `docs/projects/board/README.md`

### 6.5 Area-Specific Rules
- `specdrive/docs/AGENTS.md`
- `docs/projects/board/AGENTS.md`

### 6.6 Individual Working Documents
- Requirements documents
- Design documents
- Implementation plan documents
- State documents
- Review documents
- History documents

---

## 7. Recommended Reading Order

### 7.1 When Understanding the Repository for the First Time
1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `specdrive/docs/README.md`
5. `docs/projects/board/README.md`

### 7.2 When Entering Through the docs Structure
1. Root `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. `docs/README.md`

### 7.3 When Starting specdrive Work
1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `specdrive/docs/AGENTS.md`
5. `specdrive/docs/README.md`
6. `specdrive/docs/index.md`
7. The target specdrive document

### 7.4 When Starting project Work
1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. The target project's `AGENTS.md`
6. The target project's `README.md`
7. The target project's `index.md`
8. Related `docs/projects/standards/**` documents when needed

---

## 8. Standards for Deciding Document Boundaries

If you are unsure where something belongs, decide by asking the following questions.

### Question 1
Is this content about repository-wide shared rules or shared entry standards?

- If yes -> root documents or shared operating documents

### Question 2
Is this content about specdrive's own tool behavior, collaboration flow, or operating structure?

- If yes -> `specdrive/docs/**`

### Question 3
Is this content about the requirements, design, or implementation decisions of a specific application?

- If yes -> `docs/projects/**`

### Question 4
Is this content a shared standard referenced in real application development?

- If yes -> `docs/projects/standards/**`

### Question 5
Is this content for recovering the current state, current focus, or next entry point?

- If yes -> `docs/AI_CONTEXT.md`

---

## 9. Meaning of the Current Structure

The current document structure is meant to separate the following.

- Shared operating standards
- specdrive tool documents
- Application development specification documents
- Shared project development standards
- Current state recovery documents

In other words, although they are currently being validated together in one repository,  
the goal is to keep their roles separated from the beginning.

The clearer this separation is, the easier the following becomes.

- Reducing document duplication
- Maintaining responsibility boundaries
- Improving AI collaboration quality
- Speeding up entry into new sessions
- Transitioning to a long-term separated structure

---

## 10. Current Operating Direction

At the current stage, instead of separating specdrive itself as a finished product,  
it is being operated together with real application projects  
to validate its effectiveness as a tool.

In other words, `docs/**` is currently used to do the following together.

- Organize specdrive tool documents
- Write real project documents
- Validate the AI collaboration model
- Validate the document entry structure and state recovery method
- Prepare skill workflow testing based on README / AGENTS / AI_CONTEXT

However, the long-term assumption is that  
specdrive documents and project documents can be separated.

---

## 11. Current Priorities from the docs Perspective

The current priorities in the docs area are as follows.

### Priority 1
- Secure consistency among README / AGENTS / AI_CONTEXT
- Fix the definitions of specdrive / projects / board / standards

### Priority 2
- Keep the `doc` / `dev` work-stage distinction clear at the document level
- Prevent the boundary between specdrive and board from becoming blurred in the documents

### Priority 3
- Make these documents stable enough for Codex to understand the project correctly
- Use them later as entry documents for minimum skill workflow testing

---

## 12. Final Summary

`docs/README.md` is the entry document for quickly understanding the overall `docs/**` structure.

Whenever starting new work or adding a new document, always check the following first.

- Should this belong in a shared operating document?
- Should this belong in a specdrive tool document?
- Should this belong in a project development specification document?
- Should this belong in a shared project development standard document?
- Should this belong in a current-state recovery document?

At the current stage, everything is being validated together in one repository,  
but the document structure is organized from the beginning on the assumption  
that `specdrive` and `projects` can be separated in the long term.
