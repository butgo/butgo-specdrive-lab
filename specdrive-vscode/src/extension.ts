import * as vscode from 'vscode';
import { SpecDriveStateMachine } from './core/state/stateMachine';
import { MockAIEngine } from './clients/AIEngine';
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
        
        // 1. 코어 엔진 생성 (추후 AntigravityAdapter 로 교체 가능)
        const aiEngine = new MockAIEngine();
        const stateMachine = new SpecDriveStateMachine(aiEngine);

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
                    
                    // VSCode 알림창으로 리뷰 요청
                    const action = await vscode.window.showInformationMessage(
                        `[코드 생성 완료] 승인하시겠습니까?\nTask: ${parsedTask}`,
                        '승인', '반려'
                    );

                    if (action === '승인') {
                        await stateMachine.approve();
                        vscode.window.showInformationMessage('코드가 적용되었습니다!');
                    } else if (action === '반려') {
                        // 반려 시 임의의 피드백 전송 (실제로는 Webview에서 텍스트 입력)
                        vscode.window.showInformationMessage('코드를 반려하고 다시 생성합니다.');
                        await stateMachine.reject('사용자가 수동으로 반려함');
                        // 여기서 다시 GENERATING 상태로 넘어가지만 예제 단순화를 위해 여기까지 구현
                    } else {
                        vscode.window.showWarningMessage('리뷰가 취소되었습니다.');
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
