import { WorkflowState, SpecContext } from './types';
import { AIEngine } from '../../clients/AIEngine';
import { parseTaskFromMarkdown, parseSpecMarkdown } from '../parser/markdownParser';

export class SpecDriveStateMachine {
    private currentState: WorkflowState = WorkflowState.IDLE;
    private context: SpecContext = {};
    private aiEngine: AIEngine;
    public onApply?: (code: string) => Promise<void>;

    constructor(aiEngine: AIEngine) {
        this.aiEngine = aiEngine;
    }

    public getCurrentState(): WorkflowState {
        return this.currentState;
    }

    public getContext(): SpecContext {
        return this.context;
    }

    public async start(markdownContent: string): Promise<void> {
        if (this.currentState !== WorkflowState.IDLE) {
            throw new Error(`Cannot start from state: ${this.currentState}`);
        }
        this.context = { markdownContent };
        await this.transitionTo(WorkflowState.PARSING);
    }

    private async transitionTo(nextState: WorkflowState, payload?: any): Promise<void> {
        console.log(`[Transition] ${this.currentState} -> ${nextState}`);
        this.currentState = nextState;

        switch (this.currentState) {
            case WorkflowState.PARSING:
                await this.handleParsing();
                break;
            case WorkflowState.GENERATING:
                await this.handleGenerating();
                break;
            case WorkflowState.REVIEWING:
                this.handleReviewing();
                break;
            case WorkflowState.APPLYING:
                await this.handleApplying();
                break;
            case WorkflowState.IDLE:
                // Context is NOT fully cleared if we want to keep the final result, 
                // but conceptually IDLE means ready for next command.
                break;
        }
    }

    private async handleParsing(): Promise<void> {
        try {
            if (!this.context.markdownContent) {
                throw new Error("No markdown content to parse.");
            }
            // 전체 섹션 파싱 및 저장
            const sections = parseSpecMarkdown(this.context.markdownContent);
            this.context.sections = sections;

            // 핵심 Task 추출
            const task = parseTaskFromMarkdown(this.context.markdownContent);
            if (!task) {
                throw new Error("Failed to extract task from markdown.");
            }
            this.context.parsedTask = task;
            await this.transitionTo(WorkflowState.GENERATING);
        } catch (error) {
            console.error("[Error in PARSING]", error);
            await this.transitionTo(WorkflowState.IDLE);
        }
    }

    private async handleGenerating(): Promise<void> {
        try {
            const prompt = this.context.feedback 
                ? `Revise this task based on feedback: ${this.context.feedback}\nTask: ${this.context.parsedTask}`
                : `Generate code for task: ${this.context.parsedTask}`;

            this.context.generatedCode = await this.aiEngine.generateCode(prompt, this.context);
            
            // Clear feedback after generating
            this.context.feedback = undefined; 
            
            await this.transitionTo(WorkflowState.REVIEWING);
        } catch (error) {
            console.error("[Error in GENERATING]", error);
            await this.transitionTo(WorkflowState.IDLE);
        }
    }

    private handleReviewing(): void {
        // VSCode 환경에서는 여기서 Webview 이벤트를 대기해야 함.
        // 현재는 단위 테스트를 위해 상태만 REVIEWING에 머물게 하고 반환함.
        // 사용자가 approve() 나 reject() 를 명시적으로 호출할 때까지 대기.
        console.log("[Waiting for Human Review]");
    }

    public async approve(): Promise<void> {
        if (this.currentState !== WorkflowState.REVIEWING) {
            throw new Error(`Cannot approve from state: ${this.currentState}`);
        }
        await this.transitionTo(WorkflowState.APPLYING);
    }

    public async reject(feedback: string): Promise<void> {
        if (this.currentState !== WorkflowState.REVIEWING) {
            throw new Error(`Cannot reject from state: ${this.currentState}`);
        }
        this.context.feedback = feedback;
        await this.transitionTo(WorkflowState.GENERATING);
    }

    private async handleApplying(): Promise<void> {
        console.log("[Apply] Triggering onApply callback...");
        
        if (this.onApply && this.context.generatedCode) {
            await this.onApply(this.context.generatedCode);
        }
        
        // 작업 완료 후 IDLE 복귀
        await this.transitionTo(WorkflowState.IDLE);
    }
}
