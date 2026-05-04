# specdrive/AI_CONTEXT.compact.md

## Purpose

This is the compact context for SpecDrive engine and workflow development.

Use this file only when working on SpecDrive rules, repo-local skills, CLI, manuals, packaging, or internal workflow design.

---

## Current Focus

- Rule layer is under `specdrive/rules/**`.
- Repo-local skills are under `.agents/skills/**`.
- Session and plan flows are being reduced to compact context, policy-first read scope, and short outputs.
- Plan output contracts are centered on `Plan Update Candidate`.
- `$plan extract-candidates` now uses `generate` and guided `revise` as its core run modes.
- For existing `work-candidates.md`, `$plan extract-candidates` separates next choices into `overwrite`, `keep`, and `revise`.
- Git skill is currently excluded from repo-local skill scope.

---

## Current Rules

- Read the workspace router first when the target is unclear.
- For SpecDrive work, read this compact context and only the policy needed for the current skill.
- Do not read board project docs unless required by the user request.
- Do not inspect `docs/history/**` unless the user explicitly asks for history lookup.

---

## Next Entry Point

- Re-run `$plan extract-candidates` against board when needed to verify the `overwrite / keep / revise` next-step output.
- Continue SpecDrive context routing cleanup across `read-scope-policy.md`, `session-policy.md`, and session action docs.
- Keep `Spec-to-Anchor` in `core-collaboration-rules.md` until `dev-policy.md` is created.

---

## Open Questions

- `dev-policy.md` creation timing
- Whether `doc-work-policy.md` and `bundle-policy.md` should be created after more repeated validation
- Whether `Spec-to-Anchor` should later shrink into a traceability principle in core rules
