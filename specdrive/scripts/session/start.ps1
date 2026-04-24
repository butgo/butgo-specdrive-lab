param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$skillRegistry = Read-SpecdriveJsonFile -Path (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath "specdrive/config/skill-registry.json")
$skillConfig = $skillRegistry.skills."session-start"
if ($null -eq $skillConfig) {
    throw "Unknown skill key in skill-registry.json: session-start"
}
$skillPath = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $skillConfig.path
Test-SpecdriveRequiredPaths -Paths @($skillPath)
$skillContent = Get-Content -Path $skillPath -Raw
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
    "아래 내부 skill 규칙을 따라 session start를 수행해줘.",
    "",
    "## Internal Skill",
    "",
    $skillContent.Trim(),
    "",
    "## Current Local State",
    "",
    "현재 브랜치는 '$branchLabel' 이야.",
    "현재 Git 상태 요약은 '$statusSummary' 이고, 변경 영역 요약은 '$areaSummary' 이야.",
    "상세 변경 파일 목록은 필요할 때만 git status로 확인해줘.",
    "위 문맥을 기준으로 현재 focus, 다음 진입점, 주의해야 할 변경 범위를 짧게 정리해줘."
)

Write-Host "[session start] repo root : $repoRoot"
Write-Host "[session start] current branch : $branchLabel"
Write-Host "[session start] skill : $($skillConfig.path)"
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
