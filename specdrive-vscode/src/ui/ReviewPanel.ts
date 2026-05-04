import * as vscode from 'vscode';

export class ReviewPanel {
    public static async show(task: string, code: string): Promise<{ action: 'approve' | 'reject', feedback?: string }> {
        return new Promise((resolve) => {
            const panel = vscode.window.createWebviewPanel(
                'specDriveReview',
                'SpecDrive: 코드 리뷰',
                vscode.ViewColumn.Beside,
                {
                    enableScripts: true,
                    retainContextWhenHidden: true
                }
            );

            panel.webview.html = this.getHtmlForWebview(task, code);

            panel.webview.onDidReceiveMessage(
                message => {
                    switch (message.action) {
                        case 'approve':
                            resolve({ action: 'approve' });
                            panel.dispose();
                            return;
                        case 'reject':
                            resolve({ action: 'reject', feedback: message.feedback });
                            panel.dispose();
                            return;
                    }
                },
                undefined
            );
            
            panel.onDidDispose(() => {
                // 사용자가 패널을 그냥 닫았을 때
                resolve({ action: 'reject', feedback: '사용자가 리뷰 패널을 닫았습니다.' });
            });
        });
    }

    private static getHtmlForWebview(task: string, code: string): string {
        // 코드를 HTML에서 안전하게 보여주기 위한 이스케이프 처리
        const escapedCode = code.replace(/</g, '&lt;').replace(/>/g, '&gt;');
        
        return `
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Code Review</title>
    <!-- Highlight.js CSS (VSCode Dark 테마와 어울리는 vs2015 테마 적용) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/vs2015.min.css">
    <style>
        body {
            font-family: var(--vscode-font-family);
            padding: 20px;
            color: var(--vscode-editor-foreground);
            background-color: var(--vscode-editor-background);
        }
        h2 { margin-top: 0; }
        .task-box {
            background-color: var(--vscode-textBlockQuote-background);
            border-left: 4px solid var(--vscode-textBlockQuote-border);
            padding: 10px;
            margin-bottom: 20px;
        }
        .code-container {
            margin-bottom: 20px;
            border: 1px solid var(--vscode-panel-border);
            border-radius: 4px;
            overflow: hidden;
            background-color: #1e1e1e;
            position: relative; /* 카피 버튼 배치를 위해 추가 */
        }
        .copy-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            padding: 4px 8px;
            font-size: 11px;
            background-color: var(--vscode-button-secondaryBackground);
            color: var(--vscode-button-secondaryForeground);
            border: none;
            border-radius: 2px;
            cursor: pointer;
            opacity: 0.7;
        }
        .copy-btn:hover {
            opacity: 1;
            background-color: var(--vscode-button-secondaryHoverBackground);
        }
        pre {
            margin: 0;
            padding: 15px;
            overflow-x: auto;
            font-size: 14px;
            user-select: text; /* 텍스트 선택 가능하도록 명시 */
        }
        .feedback-area {
            margin-bottom: 20px;
        }
        textarea {
            width: 100%;
            height: 100px;
            background-color: var(--vscode-input-background);
            color: var(--vscode-input-foreground);
            border: 1px solid var(--vscode-input-border);
            padding: 8px;
            box-sizing: border-box;
            resize: vertical;
            margin-top: 5px;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        button {
            padding: 8px 16px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }
        .btn-approve {
            background-color: var(--vscode-button-background);
            color: var(--vscode-button-foreground);
        }
        .btn-approve:hover {
            background-color: var(--vscode-button-hoverBackground);
        }
        .btn-reject {
            background-color: var(--vscode-errorForeground);
            color: var(--vscode-button-foreground);
        }
        .btn-reject:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <h2>생성된 코드 리뷰</h2>
    
    <div class="task-box">
        <strong>Task:</strong><br/>
        ${task}
    </div>

    <div class="code-container">
        <button class="copy-btn" onclick="copyCode()">Copy</button>
        <pre><code id="generated-code" class="language-typescript">${escapedCode}</code></pre>
    </div>

    <div class="feedback-area">
        <label for="feedback">반려 시 피드백 입력:</label>
        <br/>
        <textarea id="feedback" placeholder="수정이 필요한 부분을 구체적으로 적어주세요. (승인 시 무시됨)"></textarea>
    </div>

    <div class="actions">
        <button class="btn-approve" onclick="approve()">승인 (Approve)</button>
        <button class="btn-reject" onclick="reject()">반려 (Reject)</button>
    </div>

    <!-- Highlight.js Script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/typescript.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/javascript.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/cpp.min.js"></script>
    <script>
        // 코드 하이라이팅 적용
        hljs.highlightAll();

        const vscode = acquireVsCodeApi();

        function copyCode() {
            const codeText = document.getElementById('generated-code').innerText;
            navigator.clipboard.writeText(codeText).then(() => {
                const btn = document.querySelector('.copy-btn');
                const originalText = btn.innerText;
                btn.innerText = 'Copied!';
                setTimeout(() => btn.innerText = originalText, 2000);
            });
        }

        function approve() {
            vscode.postMessage({ action: 'approve' });
        }

        function reject() {
            const feedback = document.getElementById('feedback').value;
            vscode.postMessage({ 
                action: 'reject', 
                feedback: feedback 
            });
        }
    </script>
</body>
</html>`;
    }
}
