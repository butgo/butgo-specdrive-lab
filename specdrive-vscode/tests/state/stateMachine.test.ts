import { SpecDriveStateMachine } from '../../src/core/state/stateMachine';
import { WorkflowState } from '../../src/core/state/types';
import { MockAIEngine } from '../../src/clients/AIEngine';

describe('SpecDriveStateMachine', () => {
    let stateMachine: SpecDriveStateMachine;
    let mockEngine: MockAIEngine;

    beforeEach(() => {
        mockEngine = new MockAIEngine();
        stateMachine = new SpecDriveStateMachine(mockEngine);
    });

    test('should initialize in IDLE state', () => {
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.IDLE);
    });

    test('should progress through states and pause at REVIEWING on valid markdown', async () => {
        const dummyMarkdown = `
# Project Document
## Task
- Create a simple express server.
        `;

        await stateMachine.start(dummyMarkdown);

        // After parsing and generating, it should pause at REVIEWING
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.REVIEWING);
        expect(stateMachine.getContext().parsedTask).toContain('Create a simple express server.');
        expect(stateMachine.getContext().generatedCode).toContain('Mocked Code');

        // Human approves
        await stateMachine.approve();

        // After applying, it returns to IDLE
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.IDLE);
    });

    test('should rollback to GENERATING on reject with feedback', async () => {
        const dummyMarkdown = `
## Task
test task
        `;

        await stateMachine.start(dummyMarkdown);
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.REVIEWING);

        // Human rejects with feedback
        await stateMachine.reject("Make it faster");

        // The state machine goes back to REVIEWING after generating again
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.REVIEWING);
        
        // Approve finally
        await stateMachine.approve();
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.IDLE);
    });

    test('should fallback to IDLE if parsing fails', async () => {
        const invalidMarkdown = `
# Project Document
No task header here.
        `;

        await stateMachine.start(invalidMarkdown);

        // Transitioned to IDLE because no task could be parsed
        expect(stateMachine.getCurrentState()).toBe(WorkflowState.IDLE);
        expect(stateMachine.getContext().parsedTask).toBeUndefined();
    });
});
