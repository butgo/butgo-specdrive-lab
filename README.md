# butgo-specdrive

[English](README.md) | [한국어](README.ko.md)

> A tool for running AI collaboration based on development specification documents  
> In the long term, it aims for a repeatable development operating system and platform

> **Current Status: Alpha**  
> This repository is not yet a finished general-purpose product. It is currently in the stage of validating the specdrive operating model through real application projects.

> **Current Repository Nature**  
> This repository is the **alpha validation repository** for butgo-specdrive.  
> At the moment, it operates both the specdrive core and validation projects together,  
> while aiming for a structure where the specdrive core and individual projects can be separated in the long term.

> **Current Operating Model: Skill-First + Wizard-Oriented**  
> The current baseline is **repo-local Codex skill-first**.  
> Repeated flows should be shaped into a **wizard-style guided workflow** only after the skill flow has become stable.

If you are reading this for the first time:
1. `AGENTS.md`
2. `docs/AI_CONTEXT.md`
3. `docs/README.md`

---

## 1. Introduction

butgo-specdrive is a **tool for structurally operating AI-assisted development based on development specification documents**.

The core of this repository is not simply writing a lot of documents.  
Its core is making AI collaboration flows repeatable, based on real application development specification documents, including session recovery, context assembly, prompt execution, document review, change reflection, and task decomposition.

In other words, specdrive is not a system that directly owns project content.  
Instead, it aims to be a tool that reads and uses project documents to operate AI-assisted development through a controllable workflow.

At this stage, `specdrive` and `projects` are operated together in a single repository in order to validate both the product and the operating model.

However, this is not the final structure.  
It is the operating model for the current stage of real application and validation.  
In the long term, `specdrive` is intended to become an independent tool/platform, and `projects` are intended to become separate application workspaces managed by specdrive.

---

## 2. Why We Are Building butgo-specdrive

Traditional development usually centered on the following flow:

- Database design
- Interface definition
- Implementation on top of a framework created by an architect
- Final structure determined through code and developer judgment

This approach was effective up to a certain scale, but it has limitations when AI is used seriously in development.

AI can generate code quickly, but the results become unstable when the following are unclear:

- The purpose of the project
- The current scope
- Structural principles
- The relationship between documents and code
- The order of work
- The points where human review is required
- The current state and the next entry point

In the AI era, this means that what matters more than simply “writing code faster” is  
**what standards and inputs AI should work from**.

butgo-specdrive started to reduce this problem.

- Keep design and implementation flows anchored to development specification documents.
- Separate policy documents from state documents.
- Make it possible to quickly recover the current state and next entry point.
- Use AI not as an autonomous developer, but as a controllable execution assistant.
- Organize a repeatable development operating model in the form of a tool.

---

## 3. The Development Style butgo-specdrive Aims For

butgo-specdrive does not see AI as a simple code generation tool.

Instead, it sees AI as follows:

- AI reads documents
- AI reinforces documents
- AI decomposes work based on documents
- AI works through human confirmation
- AI repeatedly participates in implementation and review as a collaborator

In other words, the key is not “making AI implement immediately,”  
but **standardizing AI collaboration flows around documents**.

---

## 4. The SDD Direction We Are Pursuing

In butgo-specdrive, SDD is not simply a way of producing a lot of documents.

Here, SDD means the following:

### 4.1 Document First
Documents are the standard.  
Implementation follows the documents.

Documents are not reporting artifacts.  
They are the standard used to define intent and scope before implementation.

### 4.2 Documents Are Input Assets for AI Collaboration
Documents are both guides for people  
and execution inputs for AI.

### 4.3 State Separation
Policy documents and state documents are separated.  
The current state and the next entry point are managed in separate state documents.

### 4.4 Structure First
Structural boundaries and responsibility separation are fixed before adding more features.

### 4.5 Controlled AI Collaboration
AI works based on documents and the current active scope.  
Developers retain responsibility for final judgment and stage transitions.

### 4.6 Human Confirmation Is Mandatory
Documents reinforced by AI are only drafts or reinforcement proposals.  
Until a human confirms them, they are not treated as standard documents.

### 4.7 Minimum Scope First
Start with the minimum scope required for the current stage.  
Do not lock in future expansion that has not yet been validated.

### 4.8 Repeatability First
Prefer an operating model that can be applied repeatedly across projects  
rather than one that works only once.

---

## 5. The SDD Execution Flow in specdrive

butgo-specdrive divides the workflow into the core work stages `doc`, `dev`, the operating stage `session`, and the delivery-oriented stage `git`.

### 5.1 Document Stage (`doc`)
This is the stage that makes documents ready for implementation.

Core flow:

- draft-save
- reinforce-prompt
- reinforce
- confirm-prompt
- apply-prompt
- apply-only-prompt

Basic flow:

1. A developer writes an initial document draft
2. The developer saves the current draft into history
3. A normalized reinforce prompt is generated for Codex
4. The developer and Codex refine the document through direct or interactive reinforcement
5. The reinforcement result is reviewed before any real document update
6. Meaningful document changes and history are applied deliberately when needed

At the current stage, an important point is that the repository is leaning toward
an explicit history-first document loop rather than a fully automatic apply flow.

- `draft-save`: save the current developer draft into history before reinforcement
- `reinforce-prompt`: print a normalized prompt that can be copied into Codex
- `reinforce`: keep a narrow path for actual Codex execution tests when needed
- `confirm-prompt`: print a normalized review/confirmation prompt before real document updates
- `apply-prompt`: print a normalized prompt for deliberate document apply + history save
- `apply-only-prompt`: print a normalized prompt for document-only apply when history save is intentionally skipped

In other words, the preferred loop is not “run one command and let automation decide everything.”
It is closer to the following.

1. Write a draft
2. Save the draft history
3. Start a normalized Codex reinforcement conversation
4. Review the proposed changes deliberately
5. Apply meaningful changes with human approval
6. Save the changed state into history
7. Repeat as needed

### 5.2 Development Stage (`dev`)
This is the stage that executes actual development work units based on confirmed documents.

Core flow:

- task-split
- phase
- cycle
- status

Basic flow:

1. Split tasks based on confirmed documents
2. Set the current phase
3. Set the current cycle
4. Proceed with the task
5. Update and review the status

### 5.3 Session Stage (`session`)
This is the operating stage for session recovery, compact status checks, and session save.

Current skill flow examples:

- `$session start-lite`
- `$session start`
- `$session status`
- `$session save`

Basic flow:

1. Recover the current state and entry point with a light or staged session skill
2. Run `doc` or `dev` work as needed
3. Save session notes and the next entry point at session end
4. Hand off to `git` stage when delivery messages are needed

### 5.4 Git Stage (`git`)
This is the stage for preparing delivery-oriented Git artifacts and PR handoff.

Current skill flow examples:

- `git-commit`
- `github-pr`

Basic flow:

1. Read the current branch and changed files
2. Prepare a safe commit proposal when needed
3. Commit and push only after explicit approval
4. Draft or create a GitHub PR only after explicit approval

In other words, specdrive separates  
the **flow of refining documents**  
from the **flow of developing based on documents**,  
while also keeping session-operation flows separate.

---

## 6. How to View This Repository

This repository can be understood through two main axes.

### 6.1 specdrive
specdrive is the tool area that executes AI collaboration  
based on development specification documents.

It includes the following:

- Session start rules
- Session save rules
- Branch naming support
- Context recovery
- Document bundle standards
- Prompt execution flow
- Document review and synchronization methods
- Structural inspection methods
- AI collaboration operating rules
- Repo-local Codex skill structure
- Git commit / PR workflow support
- history / phase / cycle management methods

In other words, specdrive covers **how collaboration should be executed**.

### 6.2 projects
projects is the workspace for  
development specification documents of real applications.

It includes the following:

- Requirements
- Design
- Implementation plans
- State
- History
- Application-specific decisions
- Real validation programs or real project documents

In other words, projects covers **what should be built**.

At the moment, specdrive and projects are operated together in one repository  
to validate whether document-based AI collaboration is effective for real projects.

In the long term, the goal is a structure where specdrive and projects can be separated.

### 6.3 standards
`standards` is the set of shared development standard documents used under `projects`.

Examples:

- naming
- java coding
- db
- api
- package structure
- git policy

These documents are used as shared standards above individual projects.

---

## 7. Current Project Definition

specdrive is a tool for the following:

- Execute AI collaboration based on development specification documents.
- Separate the document stage from the actual development stage.
- Keep session recovery/save and Git/PR message generation as a separate operating stage.
- Standardize repeatable work procedures as repo-local Codex skills.
- Use collaboration with Codex as the primary initial reference.

At the moment, specdrive is closer to the following than to a SaaS product:

- An internal engine
- A work operating system
- A repo-local skill workflow
- A bundle of AI collaboration execution rules

An important point is that specdrive should not be viewed as a tool for merely producing many preview files.

At the current stage, its core concept is closer to the following:

- Read project documents and execute AI collaboration flows from them.
- Separate AI reinforcement proposals from human judgment.
- Apply meaningful document changes to the real project documents.
- Leave the applied evidence and result documents under `docs/history/projects/**` like a document ledger.

In other words, specdrive is better understood not as a  
**draft generator**,  
but as a **document-based AI collaboration operating system with document-history flow**.

---

## 8. Current Direction

specdrive is currently guided by the following direction:

- Validate the core workflow before focusing on SaaS form.
- Separate the development-document stage from the actual development stage.
- Organize the flow around Codex for now.
- **Validate the minimum workflow first with repo-local Codex skills.**
- **Use a wizard-style guided workflow as the UX direction for repeated, stabilized flows.**
- Keep PowerShell CLI work as a later technical option, not as the current execution center.
- The previous single-entry PowerShell CLI router has been removed from the current baseline.
- Do not prioritize multi-AI engine support at this stage.

---

## 9. Current Priorities

The current first-priority items are as follows.

### Document Stage
- `doc draft-save`
- `doc reinforce-prompt`
- `doc reinforce`
- `doc confirm-prompt`
- `doc apply-prompt`
- `doc apply-only-prompt`
- current interpretation direction: prompt-first reinforce / review / apply flow

### Development Stage
- `dev task-split`
- `dev phase set`
- `dev cycle set`
- `dev status`

### Session Stage
- `$session start-lite`
- `$session start`
- `$session status`
- `$session save`

### Git Stage
- `$git-commit`
- `$github-pr`

At this stage, stabilizing the **document-based AI collaboration flow itself**  
is more important than web UI, multi-tenancy, or organization/user management.

---

## 10. Current Development Environment

The current minimum validation environment for this repository is based on the following:

- Editor: VS Code
- AI collaboration tool: Codex extension
- Execution interface: repo-local Codex skills under `.agents/skills/**`
- Shell: PowerShell for local Git and file checks when needed

In other words, the current stage assumes  
**VS Code + Codex extension + repo-local Codex skills**  
as the default development environment.

Direct `codex exec` integration and broader CLI automation are deferred follow-up topics.
The current baseline does not include a single-entry `specdrive` CLI.

---

## 11. What specdrive Handles

butgo-specdrive handles the following flows:

- Collaboration based on development specification documents
- Recovery of the current state
- Session start and entry-point organization
- Session save and next-entry preservation
- Branch / commit / PR workflow support
- AI input context assembly
- Document review and reinforcement
- Synchronization after document changes
- Structural inspection and boundary maintenance
- Task decomposition and state management
- Git / PR message generation support
- Organization of repeatable collaboration flows

---

## 12. What specdrive Does Not Directly Own

butgo-specdrive is not a system that directly owns the following:

- The domain content of individual applications itself
- The body of requirements for a specific project itself
- Detailed design decisions for a specific project itself
- An autonomous AI that makes every implementation decision for you
- A fully automatic transition system with no human review
- A SaaS web UI at the current stage
- Organization / user / billing features
- Generalized multi-AI engine support
- Operations / deployment automation

In other words, specdrive is not a platform that writes project content on behalf of the team.  
It is a **tool that executes and operates AI collaboration based on project documents**.

---

## 13. Included Scope

The current scope includes the following:

- Document reinforcement / review / apply-history flow
- Task decomposition flow
- phase / cycle state management
- Separation of project documents and shared standards
- Validation of the repo-local Codex skill workflow
- Verification of the operating model through a real validation project

---

## 14. What This Repository Means

This repository is not only for specdrive itself.

At the moment, it is a workspace for validating the following together:

- specdrive’s own documents and skill workflow
- The structure of shared standard documents
- The structure of real project document workspaces
- Whether AI collaboration is effective in real development projects

In other words, the current repository is viewed as a  
**working repository that validates both the specdrive engine and its application to real projects**.

---

## 15. Where to Start Reading

When first entering this repository, or returning to it later, it is best to read in this order.

1. `AGENTS.md`  
   Shared work rules and collaboration principles for the entire repository

2. `docs/AI_CONTEXT.md`  
   The current state, current focus, and next entry point

3. `docs/README.md`  
   The overall docs structure and entry document guide

4. `docs/specdrive/README.md`  
   The identity of specdrive itself and its document structure

5. `docs/projects/README.md`  
   The role and structure of the projects area

After that, follow each area’s `AGENTS.md`, `README.md`, `index.md`,  
and the actual target documents as needed.

---

## 16. Current Document Structure

The current document structure is operated around the following axes.

### 16.1 Shared Operating Standards
- `AGENTS.md`
  - Shared work rules for the entire repository
- `docs/AI_CONTEXT.md`
  - Current state / next entry point / session recovery summary
- `docs/README.md`
  - Entry document for the entire docs area

### 16.2 specdrive Documents
- `docs/specdrive/**`
  - The document set for specdrive’s own operating structure and collaboration tooling

Examples:
- `docs/specdrive/AGENTS.md`
- `docs/specdrive/README.md`
- `docs/specdrive/index.md`

### 16.3 projects Documents
- `docs/projects/**`
  - The development specification document set for real applications

Examples:
- `docs/projects/README.md`
- `docs/projects/board/**`

### 16.4 Shared Project Standard Documents
- `docs/projects/standards/**`
  - Shared standard documents referenced when developing real applications
  - At the moment, these are treated as supporting shared documents under projects

Examples:
- `docs/projects/standards/index.md`

---

## 17. Current Application Direction

butgo-specdrive is currently being organized as a tool that executes  
AI collaboration flows based on development specification documents for real application projects.

In other words, the current direction is as follows:

- Write real application specification documents under projects.
- Let projects reference shared development standards when needed.
- Let specdrive support collaboration flows such as session recovery, context assembly, review, synchronization, and task decomposition based on those documents.

As the first real application example,  
the current direction is to validate the structure with a board-style project.

Here, board is not a sub-feature of specdrive.  
It is viewed as a **real application project handled by specdrive**.

At the moment, they are kept together in one repository for validation,  
but in the long term the goal is a structure where specdrive and individual projects can be separated.

---

## 18. Future Direction

For now, the focus is on validating the **core skill-first operating model** first.
The preferred product direction after repeated validation is **wizard-style guidance**:
each workflow should expose the next action, required context, human confirmation point, and expected output without requiring users to remember raw command details.

After that, the following can be reviewed step by step:

- Wizard-style UX for stable `doc`, `session`, and `git` flows
- Structural cleanup and folder reorganization
- Reimplementation in Go or Python
- Stronger Git integration
- Stronger team collaboration features
- Review of collaboration tools that can connect with mobile apps
- Long-term promotion to a SaaS form

However, at the current stage, making a **repeatable flow that works in practice now**  
is more important than future expansion.

---

## 19. One-Sentence Summary

butgo-specdrive is an **engine / operating system that executes AI collaboration based on development specification documents in projects. It is currently operated together in one repository for validation, while aiming in the long term for a development operating system and platform in which specdrive and projects can be separated.**

