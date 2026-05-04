import * as vscode from 'vscode';
import { SpecDriveStateMachine } from './core/state/stateMachine';
import { MockAIEngine } from './clients/AIEngine';
import { AntigravityAdapter } from './clients/AntigravityAdapter';
import { ReviewPanel } from './ui/ReviewPanel';
import { WorkflowState } from './core/state/types';

export function activate(context: vscode.ExtensionContext) {
    console.log('SpecDrive extension is now active!');

    // 명령어 등록
    let disposable = vscode.commands.registerCommand('specdrive.run', async () => {
        const editor = vscode.window.activeTextEditor;
        
        if (!editor) {
            vscode.window.showErrorMessage('활성화된 마크다운 문서가 없습니다.');
            return;
        }

        const document = editor.document;
        if (document.languageId !== 'markdown') {
            vscode.window.showWarningMessage('마크다운 파일에서만 SpecDrive를 실행할 수 있습니다.');
            return;
        }

        const markdownContent = document.getText();
        
        // 1. 코어 엔진 생성 (설정에서 API Key를 읽어옴)
        const config = vscode.workspace.getConfiguration('specdrive.ai');
        const apiKey = config.get<string>('apiKey');

        let aiEngine;
        if (apiKey && apiKey.trim() !== '') {
            aiEngine = new AntigravityAdapter(apiKey);
        } else {
            vscode.window.showWarningMessage('API Key가 설정되어 있지 않아 Mock 모드로 동작합니다. (설정에서 specdrive.ai.apiKey를 등록해 주세요)');
            aiEngine = new MockAIEngine();
        }
        
        const stateMachine = new SpecDriveStateMachine(aiEngine);

        // 2. APPLYING 상태일 때 실행될 저장 로직 등록
        stateMachine.onApply = async (code: string) => {
            const extractedCode = extractCodeBlock(code);
            const fileName = 'specdrive_output.py';
            
            try {
                // 현재 마크다운 파일이 저장된 위치를 기준으로 경로 생성
                const currentDocUri = editor.document.uri;
                const folderUri = vscode.Uri.joinPath(currentDocUri, '..');
                const fileUri = vscode.Uri.joinPath(folderUri, fileName);
                
                const data = Buffer.from(extractedCode, 'utf8');
                await vscode.workspace.fs.writeFile(fileUri, data);
                vscode.window.showInformationMessage(`[SpecDrive] ${fileName} 파일로 저장되었습니다! (위치: ${folderUri.fsPath})`);
            } catch (error: any) {
                vscode.window.showErrorMessage(`파일 저장 실패: ${error.message}`);
            }
        };

        vscode.window.showInformationMessage('SpecDrive: Task 파싱을 시작합니다...');

        // 2. 파이프라인 시작
        try {
            await stateMachine.start(markdownContent);
            
            // 상태를 계속 관찰하며 진행 상황 알림 (간단한 폴링 예시)
            const checkInterval = setInterval(async () => {
                const currentState = stateMachine.getCurrentState();
                
                if (currentState === WorkflowState.REVIEWING) {
                    clearInterval(checkInterval);
                    const parsedTask = stateMachine.getContext().parsedTask;
                    const code = stateMachine.getContext().generatedCode;
                    
                    // Webview 기반 리뷰 패널 띄우기
                    const result = await ReviewPanel.show(parsedTask || '작업 내용 없음', code || '');

                    if (result.action === 'approve') {
                        await stateMachine.approve();
                        vscode.window.showInformationMessage('코드가 성공적으로 적용되었습니다!');
                    } else {
                        vscode.window.showInformationMessage(`코드가 반려되었습니다. 사유: ${result.feedback}`);
                        await stateMachine.reject(result.feedback || '반려됨');
                        // 차후 여기서 다시 GENERATING 상태로 루프백 처리 가능
                    }
                } else if (currentState === WorkflowState.IDLE) {
                    clearInterval(checkInterval);
                }
            }, 500);

        } catch (error: any) {
            vscode.window.showErrorMessage(`SpecDrive 실행 중 오류 발생: ${error.message}`);
        }
    });

    context.subscriptions.push(disposable);
}

export function deactivate() {}

/**
 * 마크다운 텍스트에서 ```...``` 코드 블록 내부의 내용만 추출합니다.
 */
function extractCodeBlock(text: string): string {
    // 가장 먼저 등장하는 코드 블록을 추출
    const regex = /```(?:\w+)?\r?\n([\s\S]*?)```/;
    const match = text.match(regex);
    if (match && match[1]) {
        return match[1].trim();
    }
    return text; // 코드 블록이 없으면 전체 텍스트 반환
}
