import { SpecContext } from '../core/state/types';
import { AIEngine } from './AIEngine';

export class AntigravityAdapter implements AIEngine {
    private apiKey: string;
    // 기본 모델명 하드코딩 (차후 설정으로 뺄 수 있음)
    private modelName: string = 'gemini-2.5-flash-lite'; 

    constructor(apiKey: string) {
        this.apiKey = apiKey;
    }

    async generateCode(prompt: string, context: SpecContext): Promise<string> {
        if (!this.apiKey) {
            throw new Error('API Key가 설정되지 않았습니다.');
        }

        const url = `https://generativelanguage.googleapis.com/v1beta/models/${this.modelName}:generateContent?key=${this.apiKey}`;
        
        // 시스템 프롬프트 및 컨텍스트 구성
        let systemContext = "너는 SpecDrive 방식에 최적화된 시니어 풀스택 개발자다.\n";
        systemContext += "반드시 아래 제공된 모든 섹션의 지시사항과 [제약사항]을 엄격히 준수하여 코드를 생성하라.\n";
        systemContext += "제약사항을 어길 경우 프로그램이 오작동할 수 있으므로, 단 하나도 빠짐없이 반영해야 한다.\n\n";
        
        if (context.sections) {
            for (const [title, body] of Object.entries(context.sections)) {
                if (!/Task|개발\s*할\s*일|TODO/i.test(title)) {
                    systemContext += `### ${title}\n${body}\n\n`;
                }
            }
        }

        const fullPrompt = `${systemContext}\n---\n\n현재 구현해야 할 Task:\n${prompt}\n\n위의 모든 맥락과 특히 [제약사항]을 100% 반영하여 최적의 코드를 생성하라.`;

        // 디버깅을 위한 프롬프트 출력 (VSCode 디버그 콘솔에서 확인 가능)
        console.log("------- [SENT PROMPT TO AI] -------");
        console.log(fullPrompt);
        console.log("-----------------------------------");

        const payload = {
            contents: [
                {
                    parts: [{ text: fullPrompt }]
                }
            ],
            generationConfig: {
                temperature: 0.1, // 코드 생성이므로 일관성을 위해 낮은 온도로 설정
                topP: 0.95,
                topK: 40
            }
        };

        try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(payload)
            });

            if (!response.ok) {
                const errorData = await response.json().catch(() => ({}));
                throw new Error(`Gemini API Error (${response.status}): ${JSON.stringify(errorData)}`);
            }

            const data = await response.json() as any;
            
            if (data.candidates && data.candidates.length > 0 && data.candidates[0].content?.parts?.length > 0) {
                return data.candidates[0].content.parts[0].text;
            } else {
                throw new Error('Gemini API 응답에서 코드를 추출할 수 없습니다.');
            }
        } catch (error: any) {
            console.error('AntigravityAdapter generateCode error:', error);
            throw new Error(`AI 코드 생성 실패: ${error.message}`);
        }
    }
}
