# docs/projects/board/README.md

[English](README.md) | [한국어](README.ko.md)

## 1. Document Purpose

This document is the **main entry document** for the `docs/projects/board/**` area.

Its purposes are as follows.

- Explain the current identity and goals of the board project.
- Organize the scope and role of the board document set.
- Distinguish the boundary between specdrive documents and board documents.
- Guide readers on the order in which board documents should be read.
- Fix how board should be understood at the current stage.

This document explains the overall direction and overview of the board area.  
Detailed work rules follow `docs/projects/board/AGENTS.md`,  
current-state recovery follows `docs/AI_CONTEXT.md`,  
and the detailed document list follows `docs/projects/board/index.md` and the individual documents.

---

## 2. How to View board

board is not a sub-feature of specdrive.  
board is the **first real application project handled by specdrive**.

At the current stage, board should be understood as follows.

- A development specification document set for a real application
- A target project for validating document-based AI collaboration flow
- A project for actually operating the structure of requirements / design / implementation plan / state / history
- A project for validating whether specdrive's document-based development model is effective for real projects

In other words, board is not just an example document set.  
It is a **workspace for real development project documents**.

---

## 3. Why We Have a board Project

specdrive is a tool that deals with collaboration methods,  
but whether that method is effective for real projects requires separate validation.

The reasons for having a board project are as follows.

- Check whether a document-first development flow works in a real project.
- Actually operate the flow of requirements -> design -> implementation plan -> state -> history.
- Check what problems arise when AI collaborates based on real project documents.
- Validate whether specdrive's `doc` / `dev` flow can be applied to real projects.
- Review document structures and work flows that can later be reused in other projects.

In other words, board is  
not an **example for explaining specdrive**,  
but a **project for validating real development with the specdrive approach**.

---

## 4. Current Direction of board

board is currently guided by the following direction.

- Treat a Spring Boot-based layered architecture as the first validation target.
- Do not introduce excessive abstraction or unnecessary complexity from the start.
- Document and implement only the minimum scope needed for the current validation stage first.
- Separate requirements, design, implementation plan, state, and history as much as possible.
- Refer to shared standards documents, but clearly write in board documents how they are actually applied to board.

At the current stage,  
it is more important to view board as a  
**project for validating a document-based development flow** than as a “finished product.”

---

## 5. Relationship Between board and specdrive

board and specdrive are currently in the same repository, but their roles are different.

### 5.1 specdrive
specdrive covers the following.

- Document-based AI collaboration flow
- Session start and context recovery
- Document reinforcement / confirmation / history-save procedures
- Task decomposition and state management flow
- Repo-local skill-first flow and future wizard-style guidance candidates
- Collaboration operating rules

In other words, specdrive covers  
**how collaboration should be executed**.

### 5.2 board
board covers the following.

- board requirements
- board design
- board implementation plan
- board current state
- board history
- board-specific judgments and decisions

In other words, board covers  
**what should be built**.

### 5.3 No Mixing
Do not make board documents primarily about specdrive's own operating rules.  
Conversely, do not place detailed board design inside specdrive documents.

---

## 6. What the board Document Set Covers

The board document set covers the following.

- Requirements of the board project
- board structure and design
- board implementation plan
- board progress state
- board history and important decisions
- board-specific exception rules or additional decisions

In other words, the board document set should be a  
**real application project document set**.

---

## 7. What the board Document Set Does Not Cover Directly

The board document set does not directly cover the following.

- specdrive's own skill / automation / deferred CLI design
- specdrive's skill structure
- Detailed Codex exec design
- Repository-wide shared operating rules
- Collaboration procedures that apply commonly to other projects as well
- Explanation of the specdrive-specific document structure

These belong in root documents or under `docs/specdrive/**`.

---

## 8. Basic Perspective on the board Document Structure

The current board document structure prioritizes separating the following roles.

- Requirements
- Design
- Implementation plan
- State
- History

The principles are as follows.

### 8.1 Documents Are the Standard
Documents are the standard, and implementation follows the documents.

### 8.2 Current Decisions First
Record the currently chosen design and scope before listing possibilities.

### 8.3 Separate Document Roles
Separate requirements, design, implementation plan, state, and history as much as possible.

### 8.4 Minimum Scope First
Document and implement the minimum scope needed for the current validation stage first.

### 8.5 Keep a Structure That AI Can Read Easily
Keep title structure, terminology, scope boundaries, and reference documents consistent.

---

## 9. Work Flow of board

Within the overall flow, board also follows the `doc` stage and the `dev` stage.

At the current stage, the board document set is organized around the following structure.

- `01-overview.md`
- `specs/**`
- `impl/**`
- `status/**`

The intent is to keep the current-standard documents separated by role.

- `01-overview.md`: project entry and overview
- `specs/**`: requirements and design documents
- `impl/**`: implementation planning documents
- `status/**`: current state and next entry point documents

History documents are not managed under `docs/projects/board/**`.
They are kept under `docs/history/**` according to the repository-wide history policy.

### 9.1 doc Stage
This is the stage of making board documents implementation-ready.

Core flow:

- reinforce
- confirm
- history-save

Basic meaning:

- AI reinforces the current board documents.
- A human reviews and confirms them.
- Important judgments and results are left in history.

### 9.2 dev Stage
This is the stage of doing actual development work based on confirmed board documents.

Core flow:

- task-split
- phase
- cycle
- status

Basic meaning:

- Decompose work based on confirmed board documents.
- Manage the current implementation stage through phase / cycle.
- Keep the current work state recoverable.

---

## 10. Relationship with standards

`docs/projects/standards/**` is the set of shared development standards documents  
commonly referenced by projects under `projects`, including board.

Examples:

- naming
- java coding
- db
- api
- package structure
- git policy

The principles are as follows.

- standards are shared standards.
- board documents deal with how those standards are applied to board.
- Do not duplicate the standards body into board documents.
- If board needs exceptions or additional decisions, write them in board documents.

In other words, standards handle **shared standards**,  
while board handles **practical application decisions**.

---

## 11. Current Priorities

The current priorities in the board area are as follows.

### Priority 1
- Fix board's identity as a real application project rather than a sub-feature of specdrive
- Fix the boundary between board documents and specdrive documents

### Priority 2
- Organize the minimum set of board requirements / design / implementation plan documents
- Organize the roles of README / AGENTS / index / individual documents

### Priority 3
- Actually apply specdrive's `doc` / `dev` flow to board project documents
- Prepare a real document base for repo-local skill and document-flow testing

---

## 12. Recommended Reading Order

When starting board work, the usual reading order is as follows.

1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. `docs/projects/board/AGENTS.md`
6. `docs/projects/board/README.md`
7. `docs/projects/board/index.md`
8. Related `docs/projects/standards/**` documents when needed
9. `docs/projects/board/01-overview.md`
10. Related `docs/projects/board/specs/**`, `docs/projects/board/impl/**`, `docs/projects/board/status/**` documents

---

## 13. Final Summary

`docs/projects/board/README.md` is the entry document for understanding the board project document set.

When working with board, always check the following first.

- Is this content a board-specific decision?
- Should this belong in board documents rather than specdrive tool rules?
- Should this be extracted into shared standards?
- Are the current scope and later candidates clearly separated?
- Is this strengthening the minimum document structure needed for the current validation stage?

board is currently operated together with specdrive in the same repository,  
but from the beginning it is organized as a  
**separable real application project document set**.
