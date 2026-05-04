/**
 * 마크다운 문서에서 ## 헤더를 기준으로 모든 섹션을 추출합니다. (줄 단위 분석으로 안정성 강화)
 */
export function parseSpecMarkdown(markdownContent: string): { [title: string]: string } {
    const sections: { [title: string]: string } = {};
    const lines = markdownContent.split(/\r?\n/);
    
    let currentTitle: string | null = null;
    let currentBody: string[] = [];

    for (const line of lines) {
        // ## 제목 형태의 라인인지 확인
        const headerMatch = line.match(/^##\s+(.+)$/);
        
        if (headerMatch) {
            // 이전에 읽던 섹션이 있다면 저장
            if (currentTitle) {
                sections[currentTitle] = currentBody.join('\n').trim();
            }
            // 새로운 섹션 시작
            currentTitle = headerMatch[1].trim();
            currentBody = [];
        } else if (currentTitle !== null) {
            // 현재 섹션의 본문으로 추가
            currentBody.push(line);
        }
    }

    // 마지막 섹션 저장
    if (currentTitle) {
        sections[currentTitle] = currentBody.join('\n').trim();
    }
    
    return sections;
}

/**
 * 기획서(Markdown)에서 실제 구현할 Task 내용을 추출합니다.
 */
export function parseTaskFromMarkdown(markdownContent: string): string | null {
    const sections = parseSpecMarkdown(markdownContent);
    
    // Task, 개발 할 일, TODO 등의 키워드가 포함된 섹션을 찾음
    for (const title of Object.keys(sections)) {
        if (/Task|개발\s*할\s*일|TODO/i.test(title)) {
            return sections[title];
        }
    }
    
    return null;
}
