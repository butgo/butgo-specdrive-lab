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
$branchLabel = if ([string]::IsNullOrWhiteSpace($branchName)) { "unknown" } else { $branchName }

Write-Host "[session start] repo root : $repoRoot"
Write-Host "[session start] current branch : $branchLabel"
Write-Host "[session start] read first:"
foreach ($path in $readFirst) {
    Write-Host "  - $path"
}
Write-Host "[session start] git status summary:"
Write-Host "  - $statusSummary"
Write-Host "  - changed areas: $areaSummary"

Write-Host ""
Write-Host "[session start] codex prompt:"
Write-Host "----- BEGIN COPY PROMPT -----"
Write-Host "README.md, AGENTS.md, docs/AI_CONTEXT.md부터 읽고 현재 상태를 복구해줘."
Write-Host "그 다음 docs/specdrive/AGENTS.md, docs/specdrive/session-stage.md를 확인해서 session 단계의 현재 기준도 함께 반영해줘."
Write-Host "문서 본문을 새로 붙여넣는 대신, 위 파일들을 직접 읽어서 필요한 최소 문맥만 사용해줘."
Write-Host "현재 브랜치는 '$branchLabel' 이야."
Write-Host "현재 Git 상태 요약은 '$statusSummary' 이고, 변경 영역 요약은 '$areaSummary' 이야."
Write-Host "상세 변경 파일 목록은 필요할 때만 git status로 확인해줘."
Write-Host "위 문맥을 기준으로 현재 focus, 다음 진입점, 주의해야 할 변경 범위를 짧게 정리해줘."
Write-Host "----- END COPY PROMPT -----"

if ($DryRun) {
    Write-Host ""
    Write-Host "[session start] dry-run only. No session artifact generated."
    exit 0
}
Write-Host ""
Write-Host "[session start] no session artifact saved."
