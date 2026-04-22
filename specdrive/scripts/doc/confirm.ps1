param(
    [string]$Target = "",
    [switch]$DryRun,
    [switch]$Execute
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ConfirmLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-confirm-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-ConfirmRegistries {
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

function Resolve-ConfirmTargetName {
    param(
        [string]$RequestedTarget,
        [Parameter(Mandatory = $true)]
        $TargetRegistry,
        [Parameter(Mandatory = $true)]
        $LegacyConfig
    )

    return Resolve-SpecdriveTargetName -RequestedTarget $RequestedTarget -TargetRegistry $TargetRegistry -LegacyConfig $LegacyConfig -ActionLabel "confirm"
}

function Resolve-ConfirmRouting {
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

    $actionConfig = $Registries.Actions.actions.confirm
    if ($null -eq $actionConfig) {
        throw "Missing confirm action in doc-action-registry.json"
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

function Find-LatestReviewPreview {
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

function Find-LatestCodexOutput {
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
    $pattern = "*$Prefix-$baseName.md"
    return Get-ChildItem $dir -Filter $pattern | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

function Find-LatestCodexNote {
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
    $pattern = "*$Prefix-$baseName.note.md"
    return Get-ChildItem $dir -Filter $pattern | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

function Show-ConfirmPlan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetName,
        [Parameter(Mandatory = $true)]
        $Routing,
        [Parameter(Mandatory = $true)]
        $OutputPolicy,
        $LatestPreview
    )

    Write-Host "[doc confirm] target: $TargetName"
    Write-Host "  document : $($Routing.Target.document_path)"
    Write-Host "  skill    : $($Routing.Skill.path)"
    Write-Host "  output   : $($Routing.Action.output_mode)"
    Write-Host "  review   : $($Routing.Action.human_review_required)"
    Write-Host "  policy   : $($OutputPolicy.Path)"

    if ($null -ne $LatestPreview) {
        Write-Host "  latest reinforce preview : $($LatestPreview.FullName)"
    } else {
        Write-Host "  latest reinforce preview : none"
    }
}

$repoRoot = Resolve-SpecdriveRepoRoot
$legacyConfig = Read-ConfirmLegacyConfig -RepoRoot $repoRoot
$registries = Read-ConfirmRegistries -RepoRoot $repoRoot
$targetName = Resolve-ConfirmTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig
$routing = Resolve-ConfirmRouting -TargetName $targetName -Registries $registries
$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode $routing.Action.output_mode
$reviewPreviewDirectory = Get-SpecdriveActionPreviewDirectory -ActionConfig $routing.Action -OutputPolicy $outputPolicy
$confirmPreviewPrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "preview_base_name_prefix" -DefaultValue "doc-confirm"
$reinforcePreviewPrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "lookup_reinforce_preview_prefix" -DefaultValue "doc-reinforce"
$reinforceCodexOutputPrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "lookup_reinforce_codex_output_prefix" -DefaultValue "doc-reinforce-codex-output"
$reinforceCodexNotePrefix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "lookup_reinforce_codex_note_prefix" -DefaultValue "doc-reinforce-codex-output"
$historyCodexOutputSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_codex_output" -DefaultValue "confirm-source-codex-output"
$historyCodexNoteSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_codex_note" -DefaultValue "confirm-source-codex-output.note"
$historyAppliedSuffix = Get-SpecdriveActionSetting -ActionConfig $routing.Action -SettingName "history_suffix_applied" -DefaultValue "confirm-applied"

$requiredPaths = @(
    (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $routing.Target.document_path),
    (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $routing.Skill.path)
)
foreach ($doc in $routing.ContextSet.required_documents) {
    $requiredPaths += (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $doc)
}
Test-SpecdriveRequiredPaths -Paths $requiredPaths

$latestPreview = Find-LatestReviewPreview -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $routing.Target.document_path -Prefix $reinforcePreviewPrefix
$latestCodexOutput = Find-LatestCodexOutput -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $routing.Target.document_path -Prefix $reinforceCodexOutputPrefix
$latestCodexNote = Find-LatestCodexNote -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $routing.Target.document_path -Prefix $reinforceCodexNotePrefix
Show-ConfirmPlan -TargetName $routing.Name -Routing $routing -OutputPolicy $outputPolicy -LatestPreview $latestPreview

if ($DryRun) {
    Write-Host ""
    Write-Host "[doc confirm] dry-run only. No confirm review output generated."
    exit 0
}

$previewPathText = if ($null -ne $latestPreview) { $latestPreview.FullName } else { "none" }
$checklist = @(
    "# doc confirm preview",
    "",
    "## Target",
    "- document: $($routing.Target.document_path)",
    "- skill: $($routing.Skill.path)",
    "- latest reinforce preview: $previewPathText",
    "",
    "## Confirm Checklist",
    "- Is the document purpose clear enough?",
    "- Are in-scope and out-of-scope boundaries separated?",
    "- Does it still read as a board project document?",
    "- Can this document serve as a basis for follow-up requirement/design docs?",
    "- Does it need another reinforce cycle before confirmation?",
    "",
    "## Decision",
    "- human review required"
)

$confirmPreviewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ($confirmPreviewPrefix + "-" + [System.IO.Path]::GetFileNameWithoutExtension($routing.Target.document_path)) -Content ($checklist -join [Environment]::NewLine)

Write-Host ""
Write-Host "[doc confirm] preview file : $confirmPreviewPath"
Write-Host "[doc confirm] confirm checklist generated."

if (-not $Execute) {
    exit 0
}

Test-SpecdriveActionExecuteAllowed -ActionConfig $routing.Action -ActionLabel "confirm" -Execute:$Execute
Test-SpecdriveActionPreconditions -ActionConfig $routing.Action -ActionLabel "confirm" -AvailableInputs @{
    reinforce_codex_output = $latestCodexOutput
}

$codexOutputContent = Get-Content -Path $latestCodexOutput.FullName -Raw
$draftDocument = Get-SpecdriveFirstMarkdownCodeBlock -Content $codexOutputContent
if ([string]::IsNullOrWhiteSpace($draftDocument)) {
    throw "Unable to extract a markdown draft from the reinforce codex output."
}

$targetDocumentPath = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $routing.Target.document_path
Set-Content -Path $targetDocumentPath -Value $draftDocument -Encoding UTF8

$historyCodexOutputPath = Copy-SpecdriveFileToHistory -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -SourcePath $latestCodexOutput.FullName -Suffix $historyCodexOutputSuffix
$historyCodexNotePath = if ($null -ne $latestCodexNote) {
    Copy-SpecdriveFileToHistory -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -SourcePath $latestCodexNote.FullName -Suffix $historyCodexNoteSuffix
} else {
    $null
}
$historyAppliedPath = Save-SpecdriveHistoryFile -RepoRoot $repoRoot -Project $routing.Target.project -DocumentPath $routing.Target.document_path -Suffix $historyAppliedSuffix -Content $draftDocument

Write-Host "[doc confirm] execute mode applied the reinforce codex draft to the target document."
Write-Host "[doc confirm] applied document : $targetDocumentPath"
if ($null -ne $historyCodexOutputPath) {
    Write-Host "[doc confirm] history codex output : $historyCodexOutputPath"
}
if ($null -ne $historyCodexNotePath) {
    Write-Host "[doc confirm] history codex note   : $historyCodexNotePath"
}
Write-Host "[doc confirm] history applied file : $historyAppliedPath"
