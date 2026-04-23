param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$branchName = Get-SpecdriveCurrentBranchName -RepoRoot $repoRoot
$statusLines = Get-SpecdriveGitStatusLines -RepoRoot $repoRoot
$changedPaths = Get-SpecdriveGitChangedPaths -RepoRoot $repoRoot
$changeOverview = Get-SpecdriveGitChangeOverview -ChangedPaths $changedPaths
$statusSummary = $changeOverview.Summary
$areaSummary = $changeOverview.AreaSummary
$readFirst = @(
    "README.md",
    "AGENTS.md",
    "docs/AI_CONTEXT.md",
    "docs/specdrive/AGENTS.md",
    "docs/specdrive/session-stage.md"
)
$readWhenTargetKnown = @(
    "작업 대상 영역의 AGENTS.md",
    "작업 대상 영역의 README.md",
    "작업 대상 영역의 index.md",
    "현재 수정 또는 작성할 대상 문서"
)
$branchLabel = if ([string]::IsNullOrWhiteSpace($branchName)) { "unknown" } else { $branchName }
$copyPromptLines = @(
    "README.md, AGENTS.md, docs/AI_CONTEXT.md부터 읽고 현재 상태를 복구해줘.",
    "그 다음 docs/specdrive/AGENTS.md, docs/specdrive/session-stage.md를 확인해서 session 단계의 현재 기준도 함께 반영해줘.",
    "작업 대상 영역이 정해져 있으면 해당 영역의 AGENTS.md, README.md, index.md, 대상 문서를 추가로 읽어줘.",
    "신규 문서 생성, 문서 역할 변경, 요구사항에서 설계 또는 설계에서 구현 계획으로 넘어가는 전환점에서는 먼저 개발자에게 확인해줘.",
    "문서 본문을 새로 붙여넣는 대신, 위 파일들을 직접 읽어서 필요한 최소 문맥만 사용해줘.",
    "먼저 현재 focus, 다음 진입점, 주의해야 할 변경 범위를 짧게 정리해주고, 내가 요청하기 전에는 파일을 직접 수정하지 말아줘.",
    "현재 브랜치는 '$branchLabel' 이야.",
    "현재 Git 상태 요약은 '$statusSummary' 이고, 변경 영역 요약은 '$areaSummary' 이야.",
    "상세 변경 파일 목록은 필요할 때만 git status로 확인해줘.",
    "위 문맥을 기준으로 현재 focus, 다음 진입점, 주의해야 할 변경 범위를 짧게 정리해줘."
)

Write-Host "[session start] repo root : $repoRoot"
Write-Host "[session start] current branch : $branchLabel"
Write-Host "[session start] read first:"
foreach ($path in $readFirst) {
    Write-Host "  - $path"
}
Write-Host "[session start] read when target area is known:"
foreach ($path in $readWhenTargetKnown) {
    Write-Host "  - $path"
}
Write-Host "[session start] git status summary:"
Write-Host "  - $statusSummary"
Write-Host "  - changed areas: $areaSummary"

Write-Host ""
Write-Host "[session start] codex prompt:"
Write-Host "----- BEGIN COPY PROMPT -----"
foreach ($line in $copyPromptLines) {
    Write-Host $line
}
Write-Host "----- END COPY PROMPT -----"

if ($DryRun) {
    Write-Host ""
    Write-Host "[session start] dry-run only. No session artifact generated."
    exit 0
}
Write-Host ""
Write-Host "[session start] no session artifact saved."
