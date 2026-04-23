param(
    [string]$Target = "",
    [string]$Note = ""
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ConfirmPromptLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-confirm-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-ConfirmPromptRegistries {
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
$legacyConfig = Read-ConfirmPromptLegacyConfig -RepoRoot $repoRoot
$registries = Read-ConfirmPromptRegistries -RepoRoot $repoRoot
$targetName = Resolve-SpecdriveTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig -ActionLabel "confirm-prompt"
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

$promptLines = @(
    "# specdrive doc confirm prompt",
    "",
    "아래 규칙을 따르며 이 저장소의 문서 검토 작업을 지원해라.",
    "",
    "## Target",
    "- target key: $targetName",
    "- target document: $($targetConfig.document_path)",
    "- target kind: $($targetConfig.document_kind)",
    $(if (-not [string]::IsNullOrWhiteSpace($Note)) { "- iteration note: $Note" } else { $null }),
    "",
    "## Read These Files Directly",
    "- $($targetConfig.document_path)"
)

foreach ($doc in $contextSetConfig.required_documents) {
    $promptLines += "- $doc"
}

if ($contextSetConfig.optional_documents.Count -gt 0) {
    $promptLines += ""
    $promptLines += "## Optional Files"
    foreach ($doc in $contextSetConfig.optional_documents) {
        $promptLines += "- $doc"
    }
}

$promptLines += @(
    "",
    "## Core Rules",
    "- 문서 본문을 새로 붙여넣으라고 요구하지 말고, 위 파일들을 직접 읽어라.",
    "- 현재 문서의 역할과 범위를 먼저 존중하라.",
    "- 기존 문서를 전면 재설계하지 말고, 현재 보강안이 실제 반영 가능한지 검토하는 데 집중하라.",
    "- 현재 확정 범위와 후속 후보를 섞지 말라.",
    "- specdrive 문서 내용과 project 문서 내용을 섞지 말라.",
    "- 신규 문서 생성, 문서 역할 변경, 요구사항에서 설계 또는 설계에서 구현 계획으로 넘어가는 전환은 확정처럼 다루지 말고 먼저 개발자 확인이 필요하다고 유지하라.",
    "",
    "## Confirm Guidance",
    "- 대상 문서와 관련 문서를 직접 읽은 뒤, 보강안이 현재 문서 역할과 범위에 맞는지 먼저 검토하라.",
    "- 아직 합의되지 않은 설계 확장, 문서 역할 혼합, 과도한 미래 범위 선반영이 없는지 확인하라.",
    "- 출력은 다음 순서를 따른다.",
    "- 1. 반영 가능 여부 판단",
    "- 2. 보류하거나 다시 맞춰야 할 지점",
    "- 3. 반영 전 수정이 필요한 일부 포인트",
    "- 문서 전체 재작성 대신 검토 결과와 반영 가능 조건을 먼저 제시하라.",
    "",
    "## Final Reminder",
    "- 이 단계의 목적은 보강 자체가 아니라 반영 가능 여부 검토다.",
    "- 개발자 승인 전에는 실제 문서 반영을 확정하지 말라."
)

$promptContent = ($promptLines | Where-Object { $null -ne $_ }) -join [Environment]::NewLine
$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode $actionConfig.output_mode
$promptPreviewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ("doc-confirm-prompt-" + (Get-SpecdriveDocumentBaseName -DocumentPath $targetConfig.document_path)) -Content $promptContent

Write-Host "[doc confirm-prompt] target: $targetName"
Write-Host "  document : $($targetConfig.document_path)"
if (-not [string]::IsNullOrWhiteSpace($Note)) {
    Write-Host "  note     : $Note"
}
Write-Host "  preview  : $promptPreviewPath"
Write-Host ""
Write-Host "----- COPY PROMPT START -----"
Write-Output $promptContent
Write-Host "----- COPY PROMPT END -----"
