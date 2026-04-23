param(
    [switch]$DryRun,
    [switch]$Detailed,
    [int]$MaxChangedPaths = 10,
    [int]$MaxStatusItems = 5
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$branchName = Get-SpecdriveCurrentBranchName -RepoRoot $repoRoot
$changedPaths = Get-SpecdriveGitChangedPaths -RepoRoot $repoRoot
$branchLabel = if ([string]::IsNullOrWhiteSpace($branchName)) { "unknown" } else { $branchName }
$changeOverview = Get-SpecdriveGitChangeOverview -ChangedPaths $changedPaths -MaxChangedPaths $MaxChangedPaths
$samplePaths = @($changeOverview.SamplePaths)
$sampleBlock = if ($samplePaths.Count -gt 0) { $samplePaths | ForEach-Object { "- $_" } } else { @("- no changed paths detected") }
$detailBlock = if ($changedPaths.Count -gt 0) { $changedPaths | ForEach-Object { "- $_" } } else { @("- no changed paths detected") }

function Get-SectionLines {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$Lines = @(),
        [Parameter(Mandatory = $true)]
        [string]$Heading
    )

    if ($null -eq $Lines -or $Lines.Count -eq 0) {
        return @()
    }

    $startIndex = -1
    for ($i = 0; $i -lt $Lines.Count; $i++) {
        if ($Lines[$i].Trim() -eq $Heading) {
            $startIndex = $i + 1
            break
        }
    }

    if ($startIndex -lt 0) {
        return @()
    }

    $sectionLines = @()
    for ($i = $startIndex; $i -lt $Lines.Count; $i++) {
        $line = $Lines[$i]
        if ($line -match "^##\s+") {
            break
        }

        $sectionLines += $line
    }

    return $sectionLines
}

function Get-FirstBulletText {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$Lines = @()
    )

    if ($null -eq $Lines -or $Lines.Count -eq 0) {
        return ""
    }

    foreach ($line in $Lines) {
        $trimmed = $line.Trim()
        if ($trimmed.StartsWith("- ")) {
            return $trimmed.Substring(2).Trim()
        }
    }

    return ""
}

function Get-BulletTexts {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$Lines = @(),
        [int]$Limit = 5
    )

    $items = @()
    if ($null -eq $Lines -or $Lines.Count -eq 0) {
        return $items
    }

    foreach ($line in $Lines) {
        $trimmed = $line.Trim()
        if ($trimmed.StartsWith("- ")) {
            $items += $trimmed.Substring(2).Trim()
            if ($items.Count -ge $Limit) {
                break
            }
        }
    }

    return $items
}

$aiContextPath = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath "docs/AI_CONTEXT.md"
$aiContextLines = if (Test-Path $aiContextPath) { @(Get-Content -Path $aiContextPath) } else { @() }

$oneLineStatusLines = @(Get-SectionLines -Lines $aiContextLines -Heading "## 2. 현재 상태 한 줄 요약")
$workModeLines = @(Get-SectionLines -Lines $aiContextLines -Heading "## 3. 현재 작업 모드")
$focusLines = @(Get-SectionLines -Lines $aiContextLines -Heading "## 12. 현재 focus")
$entryLines = @(Get-SectionLines -Lines $aiContextLines -Heading "## 11. 다음 진입점")
$pendingLines = @(Get-SectionLines -Lines $aiContextLines -Heading "## 8. 현재 보류 사항")

$oneLineStatus = Get-FirstBulletText -Lines $oneLineStatusLines
$workModeItems = Get-BulletTexts -Lines $workModeLines -Limit $MaxStatusItems
$focusItems = Get-BulletTexts -Lines $focusLines -Limit $MaxStatusItems
$entryItems = Get-BulletTexts -Lines $entryLines -Limit $MaxStatusItems
$pendingItems = Get-BulletTexts -Lines $pendingLines -Limit $MaxStatusItems

Write-Host "[session status] current state:"
if ([string]::IsNullOrWhiteSpace($oneLineStatus)) {
    Write-Host "  docs/AI_CONTEXT.md에서 현재 상태 한 줄 요약을 찾지 못했습니다."
} else {
    Write-Host "  $oneLineStatus"
}

Write-Host "[session status] work mode:"
if ($workModeItems.Count -gt 0) {
    foreach ($item in $workModeItems) {
        Write-Host "  - $item"
    }
} else {
    Write-Host "  - no work mode items found"
}

Write-Host "[session status] current focus:"
if ($focusItems.Count -gt 0) {
    foreach ($item in $focusItems) {
        Write-Host "  - $item"
    }
} else {
    Write-Host "  - no focus items found"
}

Write-Host "[session status] next entry candidates:"
if ($entryItems.Count -gt 0) {
    foreach ($item in $entryItems) {
        Write-Host "  - $item"
    }
} else {
    Write-Host "  - no next entry items found"
}

Write-Host "[session status] pending candidates:"
if ($pendingItems.Count -gt 0) {
    foreach ($item in $pendingItems) {
        Write-Host "  - $item"
    }
} else {
    Write-Host "  - no pending items found"
}

Write-Host "[session status] workspace note:"
Write-Host "  branch: $branchLabel"
Write-Host "  git: $($changeOverview.Summary); areas: $($changeOverview.AreaSummary)"

if ($Detailed) {
    Write-Host "[session status] changed path sample:"
    foreach ($line in $sampleBlock) {
        Write-Host "  $line"
    }
    if ($changeOverview.HasMorePaths) {
        Write-Host "  - ... and $($changeOverview.RemainingPathCount) more path(s)."
    }

    Write-Host "[session status] changed paths detail:"
    foreach ($line in $detailBlock) {
        Write-Host "  $line"
    }
}

Write-Host ""
Write-Host "[session status] mode: read-only status check"
Write-Host "[session status] source: docs/AI_CONTEXT.md"
Write-Host "[session status] no prompt generated, no file updated, and no artifact saved."

if ($DryRun) {
    Write-Host "[session status] dry-run only."
}
