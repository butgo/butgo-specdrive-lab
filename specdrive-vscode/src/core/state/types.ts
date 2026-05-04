export enum WorkflowState {
    IDLE = 'IDLE',
    PARSING = 'PARSING',
    GENERATING = 'GENERATING',
    REVIEWING = 'REVIEWING',
    APPLYING = 'APPLYING'
}

export interface SpecContext {
    markdownContent?: string;
    parsedTask?: string;
    generatedCode?: string;
    feedback?: string;
}
