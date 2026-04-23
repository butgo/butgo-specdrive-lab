param(
    [string]$Target = "",
    [ValidateSet("direct", "interactive")]
    [string]$Mode = "interactive",
    [string]$Focus = "",
    [string]$Note = ""
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ReinforcePromptLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-reinforce-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-ReinforcePromptRegistries {
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
$legacyConfig = Read-ReinforcePromptLegacyConfig -RepoRoot $repoRoot
$registries = Read-ReinforcePromptRegistries -RepoRoot $repoRoot
$targetName = Resolve-SpecdriveTargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig -ActionLabel "reinforce-prompt"
$targetConfig = $registries.Targets.targets.$targetName
if ($null -eq $targetConfig) {
    throw "Unknown target in target-registry.json: $targetName"
}

$actionConfig = $registries.Actions.actions.reinforce
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

$modeGuidance = switch ($Mode) {
    "direct" {
        @(
            "이 작업은 direct reinforce 모드다.",
            "대상 문서와 관련 문서를 직접 읽은 뒤, 현재 문서를 전면 재설계하지 말고 현재 범위 안에서 바로 보강안을 제시하라.",
            "출력은 다음 순서를 따른다.",
            "1. 보강 포인트 요약",
            "2. 수정 이유 요약",
            "3. 보강된 문서 초안을 하나의 markdown 코드블록으로 제시"
        )
    }
    "interactive" {
        @(
            "이 작업은 interactive reinforce 모드다.",
            "대상 문서와 관련 문서를 직접 읽은 뒤, 바로 문서 전체를 다시 쓰지 말고 먼저 보강이 필요한 지점을 좁혀라.",
            "출력은 다음 순서를 따른다.",
            "1. 현재 문서에서 애매하거나 누락된 지점을 짧게 정리",
            "2. 개발자와 맞춰가야 할 선택지나 질문을 짧게 제시",
            "3. 개발자 합의 전에는 문서 전체 재작성 대신 필요한 일부 수정안이나 방향 제안만 제시"
        )
    }
}

$targetNotes = @()
if ($null -ne $targetConfig.notes) {
    $targetNotes = @($targetConfig.notes)
}

$promptLines = @(
    "# specdrive doc reinforce prompt",
    "",
    "아래 규칙을 따르며 이 저장소의 문서 보강 작업을 지원해라.",
    "",
    "## Target",
    "- target key: $targetName",
    "- target document: $($targetConfig.document_path)",
    "- target kind: $($targetConfig.document_kind)",
    "- mode: $Mode",
    $(if (-not [string]::IsNullOrWhiteSpace($Focus)) { "- focus: $Focus" } else { $null }),
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
    "- 기존 문서를 전면 재설계하지 말고, 현재 문서를 더 명확하고 더 작업 가능하게 만드는 보강을 우선하라.",
    "- 현재 확정 범위와 후속 후보를 섞지 말라.",
    "- specdrive 문서 내용과 project 문서 내용을 섞지 말라.",
    "- 신규 문서 생성, 문서 역할 변경, 요구사항에서 설계 또는 설계에서 구현 계획으로 넘어가는 전환은 확정처럼 다루지 말고 먼저 개발자 확인이 필요하다고 유지하라.",
    "- 직접 프롬프트를 다시 설계하지 말고, 현재 규칙 안에서만 대화하라."
)

if ($targetNotes.Count -gt 0) {
    $promptLines += ""
    $promptLines += "## Target Notes"
    foreach ($item in $targetNotes) {
        $promptLines += "- $item"
    }
}

$promptLines += ""
$promptLines += "## Mode Guidance"
$promptLines += $modeGuidance | ForEach-Object { "- $_" }

$promptLines += @(
    "",
    "## Final Reminder",
    "- 개발자와 맞춰가는 대화형 작업이어도 위 규칙을 벗어나지 말라.",
    "- direct 모드가 아니면 먼저 문제점과 선택지를 좁히고, 합의 후 수정안을 제시하라."
)

$promptContent = ($promptLines | Where-Object { $null -ne $_ }) -join [Environment]::NewLine
$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode $actionConfig.output_mode
$promptPreviewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ("doc-reinforce-prompt-" + (Get-SpecdriveDocumentBaseName -DocumentPath $targetConfig.document_path)) -Content $promptContent

Write-Host "[doc reinforce-prompt] target: $targetName"
Write-Host "  document : $($targetConfig.document_path)"
Write-Host "  mode     : $Mode"
if (-not [string]::IsNullOrWhiteSpace($Focus)) {
    Write-Host "  focus    : $Focus"
}
if (-not [string]::IsNullOrWhiteSpace($Note)) {
    Write-Host "  note     : $Note"
}
Write-Host "  preview  : $promptPreviewPath"
Write-Host ""
Write-Host "----- COPY PROMPT START -----"
Write-Output $promptContent
Write-Host "----- COPY PROMPT END -----"
