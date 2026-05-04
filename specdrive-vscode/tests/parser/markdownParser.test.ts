import { parseTaskFromMarkdown } from '../../src/core/parser/markdownParser';

describe('Markdown Parser', () => {
    test('extracts task under "## Task"', () => {
        const md = `
# Overview
This is a test.

## Task
- Step 1
- Step 2

## Next Section
Other stuff
        `;
        const task = parseTaskFromMarkdown(md);
        expect(task).toBe('- Step 1\n- Step 2');
    });

    test('extracts task under "## 개발 할 일" (Korean)', () => {
        const md = `
## 개발 할 일
1. 로그인 API 작성

## 주의사항
보안 철저
        `;
        const task = parseTaskFromMarkdown(md);
        expect(task).toBe('1. 로그인 API 작성');
    });

    test('returns null if no task header exists', () => {
        const md = `
# Intro
Just normal text.
        `;
        expect(parseTaskFromMarkdown(md)).toBeNull();
    });

    test('extracts task until the end of file if no next header', () => {
        const md = `
## Task
Only this task remains.
        `;
        const task = parseTaskFromMarkdown(md);
        expect(task).toBe('Only this task remains.');
    });
});
