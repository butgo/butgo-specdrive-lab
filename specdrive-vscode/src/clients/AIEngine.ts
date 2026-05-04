import { SpecContext } from '../core/state/types';

export interface AIEngine {
    generateCode(prompt: string, context: SpecContext): Promise<string>;
}

// 더미 어댑터 (테스트용)
export class MockAIEngine implements AIEngine {
    async generateCode(prompt: string, context: SpecContext): Promise<string> {
        // 네트워크 지연 흉내
        await new Promise(resolve => setTimeout(resolve, 500));
        return `// Mocked Code generated from: ${prompt}\nconsole.log("Hello World");`;
    }
}
