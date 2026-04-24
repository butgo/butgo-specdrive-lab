param(
    [string]$Target = "",
    [string]$Source = "developer-draft",
    [string]$Note = "",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-DraftSaveLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-history-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-DraftSaveRegistries {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    return @{
        Targets = Read-SpecdriveJsonFile -Path (Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/target-registry.json")
    }
}

function Resolve-DraftSaveTargetName {
    param(
        [string]$RequestedTarget,
        [Parameter(Mandatory = $true)]
        $TargetRegistry,
        [Parameter(Mandatory = $true)]
        $LegacyConfig
    )

    return Resolve-SpecdriveTargetName -RequestedTarget $RequestedTarget -TargetRegistry $TargetRegistry -LegacyConfig $LegacyConfig -ActionLabel "draft-save"
}

$repoRoot = Resolve-SpecdriveRepoRoot
$legacyConfig = Read-DraftSaveLegacyConfig -RepoRoot $repoRoot
$registries = Read-DraftSaveRegistries -RepoRoot $repoRoot
$targetName = Resolve-DraftSaveTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig
$targetConfig = $registries.Targets.targets.$targetName
if ($null -eq $targetConfig) {
    throw "Unknown target in target-registry.json: $targetName"
}

$targetDocumentPath = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $targetConfig.document_path
Test-SpecdriveRequiredPaths -Paths @($targetDocumentPath)

Write-Host "[doc draft-save] target: $targetName"
Write-Host "  document : $($targetConfig.document_path)"
Write-Host "  source   : $Source"
if (-not [string]::IsNullOrWhiteSpace($Note)) {
    Write-Host "  note     : $Note"
}

if ($DryRun) {
    Write-Host ""
    Write-Host "[doc draft-save] dry-run only. No history saved."
    exit 0
}

$targetDocumentContent = Get-Content -Path $targetDocumentPath -Raw
$draftSnapshotPath = Save-SpecdriveHistoryFile -RepoRoot $repoRoot -Project $targetConfig.project -DocumentPath $targetConfig.document_path -Suffix "draft-applied" -Content $targetDocumentContent
$draftNoteContent = @(
    "# draft note",
    "",
    "- document: $($targetConfig.document_path)",
    "- source: $Source",
    "- saved current document as draft snapshot before reinforce work",
    $(if (-not [string]::IsNullOrWhiteSpace($Note)) { "- note: $Note" } else { $null }),
    "",
    "## Summary",
    "- this snapshot records the developer-side draft before codex reinforce work continues.",
    "- use this path to distinguish the initial draft from later codex reinforce snapshots."
) | Where-Object { $null -ne $_ }
$draftNotePath = Save-SpecdriveHistoryFile -RepoRoot $repoRoot -Project $targetConfig.project -DocumentPath $targetConfig.document_path -Suffix "draft-applied.note" -Content ($draftNoteContent -join [Environment]::NewLine)

Write-Host ""
Write-Host "[doc draft-save] history snapshot : $draftSnapshotPath"
Write-Host "[doc draft-save] history note     : $draftNotePath"
Write-Host "[doc draft-save] draft history saved."
