export enum WorkflowState {
    IDLE = 'IDLE',
    PARSING = 'PARSING',
    GENERATING = 'GENERATING',
    REVIEWING = 'REVIEWING',
    APPLYING = 'APPLYING'
}

export interface SpecContext {
    markdownContent?: string;
    // 파싱된 섹션들 (예: { "요구사항": "...", "Task": "..." })
    sections?: { [title: string]: string };
    parsedTask?: string;
    generatedCode?: string;
    feedback?: string;
}
