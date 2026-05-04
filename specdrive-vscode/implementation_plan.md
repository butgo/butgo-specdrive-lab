# Implementation Plan: Enhancing VSCode Extension Observability and Control

This plan aims to improve the `specdrive-vscode` lab environment for better logic verification of the Antigravity state machine and VSCode integration.

## User Review Required

> [!IMPORTANT]
> A new Status Bar item will be added to the VSCode bottom bar.
> A new Output Channel named "SpecDrive" will be created for logging.

## Proposed Changes

### [Component] VSCode Extension UI & Logging

#### [MODIFY] [extension.ts](file:///d:/dev/workspace/butgo-specdrive-workspace/butgo-specdrive-lab_antigravity/specdrive-vscode/src/extension.ts)
- Initialize a `vscode.StatusBarItem`.
- Initialize a `vscode.OutputChannel`.
- Add a command `specdrive.toggleMode` to switch between Mock and Real AI.
- Update the status bar and log to the output channel whenever the state changes.

#### [MODIFY] [stateMachine.ts](file:///d:/dev/workspace/butgo-specdrive-workspace/butgo-specdrive-lab_antigravity/specdrive-vscode/src/core/state/stateMachine.ts)
- Add a callback or event emitter to notify the extension when a state transition occurs.

### [Component] AI Engine Adapters

#### [MODIFY] [AntigravityAdapter.ts](file:///d:/dev/workspace/butgo-specdrive-workspace/butgo-specdrive-lab_antigravity/specdrive-vscode/src/clients/AntigravityAdapter.ts)
- Add logging of the raw prompt and response to the Output Channel for debugging.

---

## Verification Plan

### Manual Verification
1. Open the Extension Development Host (`F5`).
2. Verify the Status Bar shows "SpecDrive: IDLE".
3. Run `SpecDrive: Run Tasks` and observe the Status Bar transitioning through PARSING -> GENERATING -> REVIEWING.
4. Open the "Output" panel and select "SpecDrive" to see the logs.
5. Run `SpecDrive: Toggle AI Mode` and verify the mode changes (via notification or status bar).
