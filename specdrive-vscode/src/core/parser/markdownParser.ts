/**
 * 기획서(Markdown)에서 실제 구현할 Task 내용을 정규식으로 추출합니다.
 * 현재 가정: `## Task` 또는 `## 개발 할 일` 이라는 헤딩 아래의 텍스트를 추출.
 */
export function parseTaskFromMarkdown(markdownContent: string): string | null {
    // ## Task (또는 유사한 헤더) 이후부터 다음 ## 헤더 또는 파일 끝까지 추출하는 정규식
    const taskRegex = /##\s*(?:Task|개발\s*할\s*일)\s*\n([\s\S]*?)(?=\n##|$)/i;
    
    const match = markdownContent.match(taskRegex);
    if (match && match[1]) {
        return match[1].trim();
    }
    
    return null;
}
