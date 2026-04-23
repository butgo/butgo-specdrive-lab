param(
    [string]$Target = "",
    [string]$Source = "codex-reinforce",
    [string]$Note = ""
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ApplyOnlyPromptLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-confirm-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-ApplyOnlyPromptRegistries {
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

$repoRoot = Resolve-SpecdriveRepoRoot
$legacyConfig = Read-ApplyOnlyPromptLegacyConfig -RepoRoot $repoRoot
$registries = Read-ApplyOnlyPromptRegistries -RepoRoot $repoRoot
$targetName = Resolve-SpecdriveTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig -ActionLabel "apply-only-prompt"
$targetConfig = $registries.Targets.targets.$targetName
if ($null -eq $targetConfig) {
    throw "Unknown target in target-registry.json: $targetName"
}

$actionConfig = $registries.Actions.actions.confirm
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
$documentBaseName = Get-SpecdriveDocumentBaseName -DocumentPath $targetConfig.document_path

$promptLines = @(
    "# specdrive doc apply-only prompt",
    "",
    "아래 규칙을 따르며 이 저장소의 문서 반영 작업을 지원해라.",
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
    "## Core Rules",
    "- 문서 본문을 새로 붙여넣으라고 요구하지 말고, 위 파일들을 직접 읽어라.",
    "- 현재 문서의 역할과 범위를 먼저 존중하라.",
    "- 실제 문서만 반영하고, history 파일 저장은 포함하지 말라.",
    "- specdrive 문서 내용과 project 문서 내용을 섞지 말라.",
    "",
    "## Apply-Only Guidance",
    "- 대상 문서와 관련 문서를 직접 읽은 뒤, 실제 반영 본문만 제안하라.",
    "- 출력은 반드시 아래 순서를 따른다.",
    "- 1. Applied Document",
    "- 2. Change Summary",
    "- 3. Next Entry",
    "- Applied Document 는 하나의 markdown 코드블록으로 제시하라.",
    "",
    "## Final Reminder",
    "- 이 단계는 예외적으로 history 저장 없이 실제 문서 반영안만 준비하는 경로다.",
    "- 개발자 승인 전에는 실제 파일을 직접 수정하지 말라."
)

$promptContent = ($promptLines | Where-Object { $null -ne $_ }) -join [Environment]::NewLine
$promptPreviewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ("doc-apply-only-prompt-" + $documentBaseName) -Content $promptContent

Write-Host "[doc apply-only-prompt] target: $targetName"
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
