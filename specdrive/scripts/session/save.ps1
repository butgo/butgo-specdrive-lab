param(
    [switch]$DryRun,
    [switch]$Detailed,
    [int]$MaxChangedPaths = 10
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$branchName = Get-SpecdriveCurrentBranchName -RepoRoot $repoRoot
$changedPaths = Get-SpecdriveGitChangedPaths -RepoRoot $repoRoot
$branchLabel = if ([string]::IsNullOrWhiteSpace($branchName)) { "unknown" } else { $branchName }
$changeOverview = Get-SpecdriveGitChangeOverview -ChangedPaths $changedPaths -MaxChangedPaths $MaxChangedPaths
$statusSummary = $changeOverview.Summary
$areaSummary = $changeOverview.AreaSummary
$samplePaths = @($changeOverview.SamplePaths)
$sampleBlock = if ($samplePaths.Count -gt 0) { $samplePaths | ForEach-Object { "- $_" } } else { @("- no changed paths detected") }
$hasMorePaths = $changeOverview.HasMorePaths
$remainingPathCount = $changeOverview.RemainingPathCount
$detailBlock = if ($changedPaths.Count -gt 0) { $changedPaths | ForEach-Object { "- $_" } } else { @("- no changed paths detected") }
$copyPromptLines = @(
    "이번 세션을 저장하려고 해.",
    "현재 브랜치는 '$branchLabel' 이야.",
    "현재 Git 상태 요약은 '$statusSummary' 이고, 변경 영역 요약은 '$areaSummary' 이야.",
    "변경 파일 샘플은 아래와 같아."
)
foreach ($line in $sampleBlock) {
    $copyPromptLines += $line
}
if ($hasMorePaths) {
    $copyPromptLines += "- ... and $remainingPathCount more path(s). 필요하면 git status로 상세 목록을 확인해줘."
}
$copyPromptLines += @(
    "이 변경 요약과 샘플을 기준으로 docs/AI_CONTEXT.md 반영용 세션 저장 초안을 작성해줘.",
    "긴 대화 전체를 다시 요약하려 하지 말고, 변경 파일과 현재 상태 문서 기준으로 필요한 최소 문맥만 사용해줘.",
    "반드시 이번 세션에서 한 일, 검증한 것, docs/AI_CONTEXT.md 반영 후보, 다음 진입점, 보류 사항을 구분해줘.",
    "직접 파일을 수정하지 말고, 사람이 검토해서 docs/AI_CONTEXT.md 등에 반영할 수 있는 초안으로만 제안해줘.",
    "반영 초안을 먼저 보여주고, 내가 저장하라고 하기 전에는 docs/AI_CONTEXT.md 를 직접 수정하지 말아줘."
)
Write-Host "[session save] current branch : $branchLabel"
Write-Host "[session save] git status summary:"
Write-Host "  - $statusSummary"
Write-Host "  - changed areas: $areaSummary"
Write-Host "[session save] changed path sample:"
foreach ($line in $sampleBlock) {
    Write-Host "  $line"
}
if ($hasMorePaths) {
    Write-Host "  - ... and $remainingPathCount more path(s). Use -Detailed to print all changed paths."
}
if ($Detailed) {
    Write-Host "[session save] changed paths detail:"
    foreach ($line in $detailBlock) {
        Write-Host "  $line"
    }
}

Write-Host ""
Write-Host "[session save] codex prompt:"
Write-Host "----- BEGIN COPY PROMPT -----"
foreach ($line in $copyPromptLines) {
    Write-Host $line
}
Write-Host "----- END COPY PROMPT -----"

if ($DryRun) {
    Write-Host ""
    Write-Host "[session save] dry-run only. No session artifact generated."
    exit 0
}

Write-Host ""
Write-Host "[session save] suggested next entry:"
Write-Host "  - review docs/AI_CONTEXT.md and the most recently edited specdrive docs"
Write-Host "[session save] no session artifact saved."
