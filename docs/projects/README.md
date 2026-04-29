# docs/projects/README.md

[English](README.md) | [한국어](README.ko.md)

## 1. Document Purpose

This document is the **main entry document** for the `docs/projects/**` area.

Its purposes are as follows.

- Explain the identity and role of the projects area.
- Distinguish the relationship between specdrive and projects.
- Organize what the documents under projects cover.
- Guide readers on the order in which individual application project documents should be read.
- Explain the relationship between shared standards documents and project documents.

This document explains the overall direction and overview of the projects area.  
Detailed work rules follow each project's `AGENTS.md`,  
current-state recovery follows `docs/AI_CONTEXT.md`,  
and each project's detailed structure follows its `README.md`, `index.md`, and individual documents.

---

## 2. How to View projects

`projects` is a **workspace for development specification documents of real applications**.

It covers the following.

- Requirements
- Design
- Implementation plans
- State
- History
- Application-specific decisions

In other words, `projects` is the area that deals with  
**what should be built**.

At the current stage, it is operated together in the same repository  
to apply the specdrive operating model to real projects.

However, in the long term, it assumes a structure  
where specdrive and projects can be separated.

---

## 3. Relationship Between projects and specdrive

In the current repository, specdrive and projects coexist,  
but their roles are clearly different.

### 3.1 specdrive
specdrive covers the following.

- Document-based AI collaboration flow
- Session start and context recovery
- Document reinforcement / confirmation / history-save procedures
- Task decomposition and state management flow
- Repo-local skill-first flow and future wizard-style guidance candidates
- Collaboration operating rules

In other words, specdrive covers  
**how collaboration should be executed**.

### 3.2 projects
projects covers the following.

- Requirements
- Design
- Implementation plans
- Current state
- Project-specific decision history

In other words, projects covers  
**what should be built**.

### 3.3 No Mixing
Do not make project documents primarily about specdrive's own operating rules.  
Conversely, do not put detailed design for a specific project inside specdrive documents.

---

## 4. Current Role of projects

projects is not just a collection of example documents.

projects currently has the following roles.

- Validate whether the specdrive approach is also effective for real projects.
- Apply document-based AI collaboration flow to real applications.
- Actually operate the structure of requirements / design / implementation plans / state / history.
- Validate a working structure that can later be applied repeatedly to multiple projects.

In other words, projects is  
**both the validation target of specdrive and its practical application space**.

---

## 5. Structure Under projects

At the current stage, `docs/projects/**` is divided into the following layers.

### 5.1 Shared Entry Documents for Projects
Example:
- `docs/projects/README.md`

Role:
- Explain the overall identity of projects
- Provide shared guidance before reading sub-project documents

### 5.2 Individual Application Project Documents
Example:
- `docs/projects/board/**`

Role:
- Manage the requirements, design, implementation plans, state, and history of a specific application

### 5.3 Shared Project Standard Documents
Location:
- `docs/projects/standards/**`

Role:
- Manage development standard documents shared across multiple projects

---

## 6. How to View board

The first real project example at the current stage is `board`.

board is not a sub-feature of specdrive.  
board is the **first real application project handled by specdrive**.

board currently has the following purposes.

- Apply the specdrive document flow to a real project.
- Validate the flow of requirements -> design -> implementation plans -> state -> history.
- Verify whether document-based AI collaboration is effective in an actual development project.
- For now, validate a Spring Boot-based layered structure example first.

In other words, board should be treated as a  
**real application project document set**.

---

## 7. Relationship with standards

`docs/projects/standards/**` is the set of development standard documents  
shared under projects.

Examples:

- naming
- java coding
- db
- api
- package structure
- git policy

The principles are as follows.

- standards are shared standards.
- Individual project documents apply them by reference.
- Do not duplicate the standards body into project documents.
- If there are project-specific exceptions or additional decisions, state them in the relevant project document.

In other words, standards handles  
**shared standards**, while projects handles **practical application decisions**.

---

## 8. What projects Documents Cover

projects documents cover the following.

- The requirements of the current project
- The design and structure of the current project
- The implementation plans of the current project
- The state of the current project
- The history of the current project
- The decisions of the current project
- Project-specific exception rules when needed

---

## 9. What projects Documents Do Not Cover Directly

projects documents do not directly cover the following.

- specdrive's own skill / automation / deferred CLI design
- specdrive's skill structure
- Detailed Codex exec design
- Repository-wide shared operating rules
- Collaboration procedures that apply commonly across other projects as well

These belong in root documents or under `docs/specdrive/**`.

---

## 10. Current Principles for Document Work

The projects area follows the principles below.

### 10.1 Document First
Documents are the standard, and implementation follows the documents.

### 10.2 Current Decisions First
Record the currently chosen design and scope before listing possibilities.

### 10.3 Separate Document Roles
Separate requirements, design, implementation plans, state, and history as much as possible.

### 10.4 Minimum Scope First
Document and implement the minimum scope required for the current validation stage first.

### 10.5 Keep a Structure That AI Can Read Easily
Keep title hierarchy, terminology, scope boundaries, and reference documents consistent.

---

## 11. Reading Order

When starting work in projects, the usual reading order is as follows.

1. Root `README.md`
2. Root `AGENTS.md`
3. `docs/AI_CONTEXT.md`
4. `docs/projects/README.md`
5. The target project's `AGENTS.md`
6. The target project's `README.md`
7. The target project's `index.md`
8. Related `docs/projects/standards/**` documents when needed
9. The actual target requirements / design / implementation plan documents

---

## 12. Current Priorities

The current priorities in the projects area are as follows.

### Priority 1
- Fix the role boundaries of projects / board / standards
- Secure expression consistency with README / AGENTS / AI_CONTEXT

### Priority 2
- Fix board clearly as the first real application project
- Prevent mixing between specdrive documents and board documents

### Priority 3
- Organize the minimum set of board requirements / design / implementation plan documents
- Prepare a real document base for repo-local skill and document-flow testing

---

## 13. Final Summary

`docs/projects/README.md` is the entry document for understanding the entire projects area.

When working with projects, always check the following first.

- Is this content an actual application decision?
- Should this belong in a project document rather than a specdrive tool rule?
- Should this be moved out into shared standards?
- Are the current scope and later candidates clearly separated?
- Is this strengthening the minimum document structure needed for the current validation stage?

Although specdrive and projects are currently operated together in one repository,  
projects is organized from the beginning as a  
**separable workspace for real application documents**.
