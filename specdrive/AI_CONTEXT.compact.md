# specdrive/AI_CONTEXT.compact.md

## Purpose

This is the compact context for SpecDrive engine and workflow development.

---

## Current Focus

- **SpecDrive-VSCode Lab Enhancement**: 메인 SKILL-first 프로젝트와 분리하여 확장 프로그램의 관측성(상태바, 로그) 및 제어 로직을 독립적으로 검증 중.
- **Korean Language Principle**: 모든 기획 및 구현 계획 문서는 한글로 작성하도록 규칙 고정.

---

## Current Rules

- **Wizard Rule First**: All v2 UI/Prompt designs must strictly follow `specdrive/rules/skill-wizard-rule.md`.
- **Schema-Driven**: Prioritize schema definition (Phase 1) before UI implementation.
- **Upstream Control**: Maintain "Schema -> Parser -> UI" data flow direction.

---

## Next Entry Point

- **Observability Implementation**: 상태바 연동, 출력 채널 로깅, Mock/Real 모드 토글 명령어 구현.

---

## Open Questions

- Integration depth between existing repo-local skills and the new VSCode Wizard UI.
- Choice of JSON-Schema to UI library for VSCode Webview.
