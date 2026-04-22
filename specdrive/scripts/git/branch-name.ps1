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
$changedPaths = @(Get-SpecdriveGitChangedPaths -RepoRoot $repoRoot)
$changeOverview = Get-SpecdriveGitChangeOverview -ChangedPaths $changedPaths -MaxChangedPaths $MaxChangedPaths
$draft = Get-SpecdriveBranchNameDraft -ChangedPaths $changedPaths -CurrentBranch $branchName

Write-Host "[git branch-name] current branch:"
Write-Host "  $(if ([string]::IsNullOrWhiteSpace($branchName)) { 'unknown' } else { $branchName })"
Write-Host "[git branch-name] change summary:"
Write-Host "  - $($changeOverview.Summary)"
Write-Host "  - changed areas: $($changeOverview.AreaSummary)"
Write-Host "[git branch-name] changed path sample:"
if ($changeOverview.SamplePaths.Count -gt 0) {
    foreach ($path in $changeOverview.SamplePaths) {
        Write-Host "  - $path"
    }
} else {
    Write-Host "  - no changed paths detected"
}
if ($changeOverview.HasMorePaths) {
    Write-Host "  - ... and $($changeOverview.RemainingPathCount) more path(s). Use -Detailed to print all changed paths."
}
if ($Detailed) {
    Write-Host "[git branch-name] changed paths detail:"
    if ($changedPaths.Count -gt 0) {
        foreach ($path in $changedPaths) {
            Write-Host "  - $path"
        }
    } else {
        Write-Host "  - no changed paths detected"
    }
}
Write-Host "[git branch-name] suggestion:"
Write-Host "  $($draft.BranchName)"
Write-Host "[git branch-name] reasons:"
foreach ($line in $draft.Reasons) {
    Write-Host "  $line"
}

if ($DryRun) {
    Write-Host ""
    Write-Host "[git branch-name] dry-run only. No one-time artifact generated."
    exit 0
}
Write-Host ""
Write-Host "[git branch-name] no one-time artifact saved."
