param(
    [string]$Target = "",
    [switch]$DryRun,
    [switch]$Execute
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-HistoryLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-history-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-HistoryRegistries {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    return @{
        Targets = Read-SpecdriveJsonFile -Path (Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/target-registry.json")
        Skills = Read-SpecdriveJsonFile -Path (Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/skill-registry.json")
        ContextSets = Read-SpecdriveJsonFile -Path (Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/context-set-registry.json")
        Actions = Read-SpecdriveJsonFile -Path (Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-action-registry.json")
    }
}

function Resolve-HistoryTargetName {
    param(
        [string]$RequestedTarget,
        [Parameter(Mandatory = $true)]
        $TargetRegistry,
        [Parameter(Mandatory = $true)]
        $LegacyConfig
    )

    return Resolve-SpecdriveTargetName -RequestedTarget $RequestedTarget -TargetRegistry $TargetRegistry -LegacyConfig $LegacyConfig -ActionLabel "history-save"
}

function Resolve-HistoryRouting {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetName,
        [Parameter(Mandatory = $true)]
        $Registries
    )

    $targetConfig = $Registries.Targets.targets.$TargetName
    if ($null -eq $targetConfig) {
        throw "Unknown target in target-registry.json: $TargetName"
    }

    $actionConfig = $Registries.Actions.actions.'history-save'
    if ($null -eq $actionConfig) {
        throw "Missing history-save action in doc-action-registry.json"
    }

    $skillKey = $actionConfig.skill_key
    $skillConfig = $Registries.Skills.skills.$skillKey
    if ($null -eq $skillConfig) {
        throw "Unknown skill key in skill-registry.json: $skillKey"
    }

    $contextSetKey = $targetConfig.context_set_key
    $contextSetConfig = $Registries.ContextSets.context_sets.$contextSetKey
    if ($null -eq $contextSetConfig) {
        throw "Unknown context set key in context-set-registry.json: $contextSetKey"
    }

    return @{
        Name = $targetName
        Target = $targetConfig
        Action = $actionConfig
        Skill = $skillConfig
        ContextSet = $contextSetConfig
    }
}

function Find-LatestPreview {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$RelativeReviewDirectory,
        [Parameter(Mandatory = $true)]
        [string]$DocumentPath,
        [Parameter(Mandatory = $true)]
        [string]$Prefix
    )

    $dir = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $RelativeReviewDirectory
    if (-not (Test-Path $dir)) {
        return $null
    }

    $baseName = [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileName($DocumentPath))
    $pattern = "*$Prefix-$baseName*.md"
    return Get-ChildItem $dir -Filter $pattern | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

function Show-HistoryPlan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetName,
        [Parameter(Mandatory = $true)]
        $Routing,
        [Parameter(Mandatory = $true)]
        $OutputPolicy,
        $LatestReinforcePreview,
        $LatestConfirmPreview
    )

    Write-Host "[doc history-save] target: $TargetName"
    Write-Host "  document : $($Routing.Target.document_path)"
    Write-Host "  skill    : $($Routing.Skill.path)"
    Write-Host "  output   : $($Routing.Action.output_mode)"
    Write-Host "  review   : $($Routing.Action.human_review_required)"
    Write-Host "  policy   : $($OutputPolicy.Path)"
    Write-Host "  latest reinforce preview : $(if ($LatestReinforcePreview) { $LatestReinforcePreview.FullName } else { 'none' })"
    Write-Host "  latest confirm preview   : $(if ($LatestConfirmPreview) { $LatestConfirmPreview.FullName } else { 'none' })"
}

$repoRoot = Resolve-SpecdriveRepoRoot
$legacyConfig = Read-HistoryLegacyConfig -RepoRoot $repoRoot
$registries = Read-HistoryRegistries -RepoRoot $repoRoot
$targetName = Resolve-HistoryTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig
$routing = Resolve-HistoryRouting -TargetName $targetName -Registries $registries
$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode $routing.Action.output_mode
$reviewPreviewDirectory = Get-SpecdriveActionPreviewDirectory -ActionConfig $routing.Action -OutputPolicy $outputPolicy
$historyPreviewPrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "preview_base_name_prefix" -DefaultValue "doc-history-save"
$reinforcePreviewPrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "lookup_reinforce_preview_prefix" -DefaultValue "doc-reinforce"
$confirmPreviewPrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "lookup_confirm_preview_prefix" -DefaultValue "doc-confirm"
$historyAppliedSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_applied" -DefaultValue "history-applied"
$historyAppliedNoteSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_applied_note" -DefaultValue "history-applied.note"
$historyReinforceSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_reinforce_preview" -DefaultValue "history-source-reinforce-preview"
$historyConfirmSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_confirm_preview" -DefaultValue "history-source-confirm-preview"

$requiredPaths = @(
    (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $routing.Target.document_path),
    (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $routing.Skill.path)
)
foreach ($doc in $routing.ContextSet.required_documents) {
    $requiredPaths += (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $doc)
}
Test-SpecdriveRequiredPaths -Paths $requiredPaths

$latestReinforcePreview = Find-LatestPreview -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $routing.Target.document_path -Prefix $reinforcePreviewPrefix
$latestConfirmPreview = Find-LatestPreview -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $routing.Target.document_path -Prefix $confirmPreviewPrefix

Show-HistoryPlan -TargetName $routing.Name -Routing $routing -OutputPolicy $outputPolicy -LatestReinforcePreview $latestReinforcePreview -LatestConfirmPreview $latestConfirmPreview

if ($DryRun) {
    Write-Host ""
    Write-Host "[doc history-save] dry-run only. No history preview generated."
    exit 0
}

$historyLines = @(
    "# doc history preview",
    "",
    "## Target",
    "- document: $($routing.Target.document_path)",
    "- skill: $($routing.Skill.path)",
    "",
    "## Related Previews",
    "- reinforce: $(if ($latestReinforcePreview) { $latestReinforcePreview.FullName } else { 'none' })",
    "- confirm: $(if ($latestConfirmPreview) { $latestConfirmPreview.FullName } else { 'none' })",
    "",
    "## Suggested History Points",
    "- clarified the board overview as the first project overview document",
    "- preserved minimal scope and avoided premature detailed design",
    "- established the starting point for follow-up requirement and design documents",
    "",
    "## Next Entry",
    "- review whether 02-requirements.md should be started next"
)

$historyPreviewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ($historyPreviewPrefix + "-" + [System.IO.Path]::GetFileNameWithoutExtension($routing.Target.document_path)) -Content ($historyLines -join [Environment]::NewLine)

Write-Host ""
Write-Host "[doc history-save] preview file : $historyPreviewPath"
Write-Host "[doc history-save] history preview generated."

if (-not $Execute) {
    exit 0
}

Test-SpecdriveActionExecuteAllowed -ActionConfig $routing.Action -ActionLabel "history-save" -Execute:$Execute

$targetDocumentPath = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $routing.Target.document_path
$targetDocumentContent = Get-Content -Path $targetDocumentPath -Raw
$historySnapshotPath = Save-SpecdriveHistoryFile -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -Suffix $historyAppliedSuffix -Content $targetDocumentContent
$historyNoteContent = @(
    "# history note",
    "",
    "- document: $($routing.Target.document_path)",
    "- saved current applied document snapshot",
    "- latest reinforce preview: $(if ($latestReinforcePreview) { $latestReinforcePreview.FullName } else { 'none' })",
    "- latest confirm preview: $(if ($latestConfirmPreview) { $latestConfirmPreview.FullName } else { 'none' })",
    "",
    "## Summary",
    "- history-save was used to keep the currently applied document state.",
    "- this path is intended for manual updates or prompt-driven updates after the document is already applied.",
    "",
    "## Next Entry",
    "- continue from the saved document snapshot when needed."
) -join [Environment]::NewLine
$historyNotePath = Save-SpecdriveHistoryFile -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -Suffix $historyAppliedNoteSuffix -Content $historyNoteContent
$historyReinforcePath = if ($null -ne $latestReinforcePreview) {
    Copy-SpecdriveFileToHistory -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -SourcePath $latestReinforcePreview.FullName -Suffix $historyReinforceSuffix
} else {
    $null
}
$historyConfirmPath = if ($null -ne $latestConfirmPreview) {
    Copy-SpecdriveFileToHistory -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -SourcePath $latestConfirmPreview.FullName -Suffix $historyConfirmSuffix
} else {
    $null
}

Write-Host "[doc history-save] execute mode saved the current applied document into history."
Write-Host "[doc history-save] history snapshot : $historySnapshotPath"
Write-Host "[doc history-save] history note     : $historyNotePath"
if ($null -ne $historyReinforcePath) {
    Write-Host "[doc history-save] history reinforce: $historyReinforcePath"
}
if ($null -ne $historyConfirmPath) {
    Write-Host "[doc history-save] history confirm  : $historyConfirmPath"
}
