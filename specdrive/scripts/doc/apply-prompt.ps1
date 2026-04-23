param(
    [string]$Target = "",
    [string]$Source = "codex-reinforce",
    [string]$Note = ""
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ApplyPromptLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-history-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-ApplyPromptRegistries {
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

function Find-LatestApplyPreview {
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

$repoRoot = Resolve-SpecdriveRepoRoot
$legacyConfig = Read-ApplyPromptLegacyConfig -RepoRoot $repoRoot
$registries = Read-ApplyPromptRegistries -RepoRoot $repoRoot
$targetName = Resolve-SpecdriveTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig -ActionLabel "apply-prompt"
$targetConfig = $registries.Targets.targets.$targetName
if ($null -eq $targetConfig) {
    throw "Unknown target in target-registry.json: $targetName"
}

$actionConfig = $registries.Actions.actions.'history-save'
$skillConfig = $registries.Skills.skills.PSObject.Properties[$actionConfig.skill_key].Value
$contextSetConfig = $registries.ContextSets.context_sets.PSObject.Properties[$targetConfig.context_set_key].Value

if ($null -eq $skillConfig) {
    throw "Unknown skill key in skill-registry.json: $($actionConfig.skill_key)"
}
if ($null -eq $contextSetConfig) {
    throw "Unknown context set key in context-set-registry.json: $($targetConfig.context_set_key)"
}

$requiredPaths = @(
    (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $targetConfig.document_path),
    (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $skillConfig.path)
)
foreach ($doc in $contextSetConfig.required_documents) {
    $requiredPaths += (Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $doc)
}
Test-SpecdriveRequiredPaths -Paths $requiredPaths

$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode $actionConfig.output_mode
$reviewPreviewDirectory = Get-SpecdriveActionPreviewDirectory -ActionConfig $actionConfig -OutputPolicy $outputPolicy
$latestReinforcePreview = Find-LatestApplyPreview -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $targetConfig.document_path -Prefix "doc-reinforce"
$latestConfirmPreview = Find-LatestApplyPreview -RepoRoot $repoRoot -RelativeReviewDirectory $reviewPreviewDirectory -DocumentPath $targetConfig.document_path -Prefix "doc-confirm"
$documentBaseName = Get-SpecdriveDocumentBaseName -DocumentPath $targetConfig.document_path

$promptLines = @(
    "# specdrive doc apply prompt",
    "",
    "아래 규칙을 따르며 이 저장소의 문서 반영 및 history 저장 작업을 지원해라.",
    "",
    "## Target",
    "- target key: $targetName",
    "- target document: $($targetConfig.document_path)",
    "- target kind: $($targetConfig.document_kind)",
    "- source: $Source",
    $(if (-not [string]::IsNullOrWhiteSpace($Note)) { "- iteration note: $Note" } else { $null }),
    "",
    "## Read These Files Directly",
    "- $($targetConfig.document_path)"
)

foreach ($doc in $contextSetConfig.required_documents) {
    $promptLines += "- $doc"
}

$promptLines += @(
    "",
    "## Related Previews",
    "- latest reinforce preview: $(if ($latestReinforcePreview) { $latestReinforcePreview.FullName } else { 'none' })",
    "- latest confirm preview: $(if ($latestConfirmPreview) { $latestConfirmPreview.FullName } else { 'none' })",
    "",
    "## Core Rules",
    "- 문서 본문을 새로 붙여넣으라고 요구하지 말고, 위 파일들을 직접 읽어라.",
    "- 현재 문서의 역할과 범위를 먼저 존중하라.",
    "- 실제 문서 반영과 history 저장을 함께 준비하되, 개발자 승인 전에는 파일 반영을 확정하지 말라.",
    "- specdrive 문서 내용과 project 문서 내용을 섞지 말라.",
    "- history note 는 diff 자체보다 Codex가 실제로 어떤 보강과 정리를 했는지 요약하는 방향을 우선하라.",
    "",
    "## Apply Guidance",
    "- 대상 문서와 관련 문서를 직접 읽은 뒤, 실제 반영 본문과 history 저장 초안을 함께 제안하라.",
    "- 출력은 반드시 아래 순서를 따른다.",
    "- 1. Applied Document",
    "- 2. History Snapshot File",
    "- 3. History Note File",
    "- 4. Change Summary",
    "- 5. Note Body",
    "- 6. Next Entry",
    "- Applied Document 는 하나의 markdown 코드블록으로 제시하라.",
    "- Note Body 는 별도의 markdown 코드블록으로 제시하라.",
    "",
    "## Suggested File Names",
    "- history snapshot: <timestamp>-$documentBaseName-reinforce-applied.md",
    "- history note: <timestamp>-$documentBaseName-reinforce-applied.note.md",
    "",
    "## Final Reminder",
    "- 이 단계의 목적은 실제 문서 반영 + history 저장 초안을 함께 준비하는 것이다.",
    "- 개발자 승인 전에는 실제 파일을 직접 수정하지 말라."
)

$promptContent = ($promptLines | Where-Object { $null -ne $_ }) -join [Environment]::NewLine
$promptPreviewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ("doc-apply-prompt-" + $documentBaseName) -Content $promptContent

Write-Host "[doc apply-prompt] target: $targetName"
Write-Host "  document : $($targetConfig.document_path)"
Write-Host "  source   : $Source"
if (-not [string]::IsNullOrWhiteSpace($Note)) {
    Write-Host "  note     : $Note"
}
Write-Host "  preview  : $promptPreviewPath"
Write-Host ""
Write-Host "----- COPY PROMPT START -----"
Write-Output $promptContent
Write-Host "----- COPY PROMPT END -----"
