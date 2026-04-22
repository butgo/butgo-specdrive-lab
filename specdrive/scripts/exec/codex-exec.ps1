param(
    [string]$TargetKey = "",
    [string]$Action = "reinforce",
    [string]$TargetDocument = "",
    [string]$SkillDocument = "",
    [string[]]$ContextDocuments = @(),
    [string[]]$OptionalContextDocuments = @(),
    [switch]$Execute
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ExecRegistries {
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

function Resolve-ExecInputFromKey {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetKey,
        [Parameter(Mandatory = $true)]
        [string]$Action,
        [Parameter(Mandatory = $true)]
        $Registries
    )

    $targetConfig = $Registries.Targets.targets.$TargetKey
    if ($null -eq $targetConfig) {
        throw "Unknown target key in target-registry.json: $TargetKey"
    }

    $actionConfig = $Registries.Actions.actions.$Action
    if ($null -eq $actionConfig) {
        throw "Unknown action in doc-action-registry.json: $Action"
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
        TargetDocument = $targetConfig.document_path
        SkillDocument = $skillConfig.path
        ContextDocuments = @($contextSetConfig.required_documents)
        OptionalContextDocuments = @($contextSetConfig.optional_documents)
    }
}

function Resolve-EffectiveExecInput {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [string]$TargetKey,
        [string]$Action,
        [string]$TargetDocument,
        [string]$SkillDocument,
        [string[]]$ContextDocuments,
        [string[]]$OptionalContextDocuments
    )

    if (-not [string]::IsNullOrWhiteSpace($TargetKey)) {
        $registries = Read-ExecRegistries -RepoRoot $RepoRoot
        $resolved = Resolve-ExecInputFromKey -TargetKey $TargetKey -Action $Action -Registries $registries
        return @{
            TargetDocument = $resolved.TargetDocument
            SkillDocument = $resolved.SkillDocument
            ContextDocuments = $resolved.ContextDocuments
            OptionalContextDocuments = $resolved.OptionalContextDocuments
        }
    }

    if ([string]::IsNullOrWhiteSpace($TargetDocument)) {
        throw "TargetDocument is required when TargetKey is not provided."
    }

    if ([string]::IsNullOrWhiteSpace($SkillDocument)) {
        throw "SkillDocument is required when TargetKey is not provided."
    }

    return @{
        TargetDocument = $TargetDocument
        SkillDocument = $SkillDocument
        ContextDocuments = @($ContextDocuments)
        OptionalContextDocuments = @($OptionalContextDocuments)
    }
}

function Test-CommandExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Show-ExecutionPlan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetDocument,
        [Parameter(Mandatory = $true)]
        [string]$SkillDocument,
        [string[]]$ContextDocuments,
        [string[]]$OptionalContextDocuments,
        [Parameter(Mandatory = $true)]
        $OutputPolicy
    )

    Write-Host "[exec/codex] target document : $TargetDocument"
    Write-Host "[exec/codex] skill document  : $SkillDocument"
    Write-Host "[exec/codex] output mode     : $($OutputPolicy.Mode)"
    Write-Host "[exec/codex] preview store   : $($OutputPolicy.Config.store_preview_under)"
    Write-Host "[exec/codex] required context:"
    foreach ($doc in $ContextDocuments) {
        Write-Host "  - $doc"
    }

    if ($OptionalContextDocuments.Count -gt 0) {
        Write-Host "[exec/codex] optional context:"
        foreach ($doc in $OptionalContextDocuments) {
            Write-Host "  - $doc"
        }
    }
}

function Build-CodexPrompt {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetDocument,
        [Parameter(Mandatory = $true)]
        [string]$SkillDocument,
        [string[]]$ContextDocuments,
        [string[]]$OptionalContextDocuments
    )

    $contextList = $ContextDocuments | ForEach-Object { "- $_" }
    $optionalContextList = @($OptionalContextDocuments | ForEach-Object { "- $_" })
    $optionalContextBlock = if ($optionalContextList.Count -gt 0) {
        ($optionalContextList -join [Environment]::NewLine)
    } else {
        "- none"
    }

    return (
        "Use the document reinforcement rules from:" + [Environment]::NewLine +
        "$SkillDocument" + [Environment]::NewLine + [Environment]::NewLine +
        "Reinforce this target document:" + [Environment]::NewLine +
        "$TargetDocument" + [Environment]::NewLine + [Environment]::NewLine +
        "Read these required context documents first:" + [Environment]::NewLine +
        ($contextList -join [Environment]::NewLine) + [Environment]::NewLine + [Environment]::NewLine +
        "Optional context documents (read when useful):" + [Environment]::NewLine +
        $optionalContextBlock + [Environment]::NewLine + [Environment]::NewLine +
        "Goal:" + [Environment]::NewLine +
        "- reinforce the existing document instead of rewriting it from scratch" + [Environment]::NewLine +
        "- keep the scope minimal" + [Environment]::NewLine +
        "- avoid prematurely expanding into detailed API, DB, UI, or implementation design" + [Environment]::NewLine +
        "- produce a reviewable improvement draft" + [Environment]::NewLine +
        "- do not edit files directly; return the reinforcement draft in your final response"
    )
}

function Build-PreviewContent {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetDocument,
        [Parameter(Mandatory = $true)]
        [string]$SkillDocument,
        [string[]]$ContextDocuments,
        [string[]]$OptionalContextDocuments,
        [Parameter(Mandatory = $true)]
        [string]$Prompt
    )

    $requiredContextBlock = ($ContextDocuments | ForEach-Object { "- $_" }) -join [Environment]::NewLine
    $optionalContextBlock = ($OptionalContextDocuments | ForEach-Object { "- $_" }) -join [Environment]::NewLine

    if ([string]::IsNullOrWhiteSpace($optionalContextBlock)) {
        $optionalContextBlock = "- none"
    }

    $lines = @(
        '# doc reinforce preview',
        '',
        '## Target',
        "- document: $TargetDocument",
        "- skill: $SkillDocument",
        '',
        '## Required Context',
        $requiredContextBlock,
        '',
        '## Optional Context',
        $optionalContextBlock,
        '',
        '## Prompt Preview',
        '',
        '```text',
        $Prompt,
        '```'
    )

    return ($lines -join [Environment]::NewLine)
}

function Invoke-CodexExecCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$Prompt,
        [Parameter(Mandatory = $true)]
        [string]$OutputFilePath
    )

    $outputDirectory = Split-Path -Parent $OutputFilePath
    if (-not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $Prompt | codex exec -C $RepoRoot --sandbox read-only --output-last-message $OutputFilePath - | Out-Null
    return [int]$LASTEXITCODE
}

function Get-CodexPendingOutputContent {
    return "# codex exec output`n`nPending execution output..."
}

function Get-CodexOutputSummary {
    param(
        [Parameter(Mandatory = $true)]
        [string]$OutputFilePath
    )

    if (-not (Test-Path $OutputFilePath)) {
        return @{
            Exists = $false
            HasUsableOutput = $false
            Content = ""
        }
    }

    $content = (Get-Content -Path $OutputFilePath -Raw).Trim()
    $pendingContent = (Get-CodexPendingOutputContent).Trim()
    $hasUsableOutput = -not [string]::IsNullOrWhiteSpace($content) -and $content -ne $pendingContent

    return @{
        Exists = $true
        HasUsableOutput = $hasUsableOutput
        Content = $content
    }
}

function Get-CodexNoteOutputPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$OutputFilePath
    )

    $directory = Split-Path -Parent $OutputFilePath
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($OutputFilePath)
    return Join-Path $directory ($baseName + ".note.md")
}

function Get-CodexNoteContent {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CodexOutputContent
    )

    $startMarkers = @(
        "변경 의도만 짧게 정리하면",
        "핵심 보강점은",
        "원하시면 다음 단계로는"
    )

    $startIndex = -1
    foreach ($marker in $startMarkers) {
        $index = $CodexOutputContent.IndexOf($marker)
        if ($index -ge 0 -and ($startIndex -lt 0 -or $index -lt $startIndex)) {
            $startIndex = $index
        }
    }

    if ($startIndex -ge 0) {
        $noteContent = $CodexOutputContent.Substring($startIndex).Trim()
        return "# reinforce note`n`n$noteContent"
    }

    $fallbackPatterns = @(
        "## 8. 최종 정리",
        "## 최종 정리",
        "## 7. 다음 문서로 이어지는 기준",
        "## 7. 다음 문서로 이어지는 방향"
    )

    $fallbackStartIndex = -1
    foreach ($pattern in $fallbackPatterns) {
        $index = $CodexOutputContent.IndexOf($pattern)
        if ($index -ge 0 -and ($fallbackStartIndex -lt 0 -or $index -lt $fallbackStartIndex)) {
            $fallbackStartIndex = $index
        }
    }

    if ($fallbackStartIndex -lt 0) {
        return ""
    }

    $fallbackContent = $CodexOutputContent.Substring($fallbackStartIndex).Trim()
    if ($fallbackContent.EndsWith('```')) {
        $fallbackContent = $fallbackContent.Substring(0, $fallbackContent.Length - 3).TrimEnd()
    }

    return "# reinforce note`n`n자동 추출 요약입니다.`n`n$fallbackContent"
}

function Save-CodexNoteFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$OutputFilePath,
        [Parameter(Mandatory = $true)]
        [string]$CodexOutputContent
    )

    $noteContent = Get-CodexNoteContent -CodexOutputContent $CodexOutputContent
    if ([string]::IsNullOrWhiteSpace($noteContent)) {
        return $null
    }

    $notePath = Get-CodexNoteOutputPath -OutputFilePath $OutputFilePath
    Set-Content -Path $notePath -Value $noteContent -Encoding UTF8
    return $notePath
}

function Show-CodexExecutionGuidance {
    param(
        [Parameter(Mandatory = $true)]
        [string]$OutputFilePath,
        [Parameter(Mandatory = $true)]
        [bool]$HasUsableOutput
    )

    Write-Host "[exec/codex] guidance:"
    Write-Host "  - If you see 'InvalidOperation: Cannot set property...' in PowerShell,"
    Write-Host "    it usually comes from a constrained PowerShell language mode in a plugin/helper path."

    if ($HasUsableOutput) {
        Write-Host "  - A usable codex output file was captured, so review that file first."
        Write-Host "  - Treat terminal warnings as secondary unless the output file is missing or empty."
    } else {
        Write-Host "  - No usable codex output file was captured yet."
        Write-Host "  - In this case, treat terminal errors as actionable and retry after checking the environment."
    }

    Write-Host "  - codex output file      : $OutputFilePath"
}

$repoRoot = Resolve-SpecdriveRepoRoot
$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode "review_patch"
$effectiveInput = Resolve-EffectiveExecInput -RepoRoot $repoRoot -TargetKey $TargetKey -Action $Action -TargetDocument $TargetDocument -SkillDocument $SkillDocument -ContextDocuments $ContextDocuments -OptionalContextDocuments $OptionalContextDocuments
$targetBaseName = [System.IO.Path]::GetFileNameWithoutExtension($effectiveInput.TargetDocument)

Show-ExecutionPlan -TargetDocument $effectiveInput.TargetDocument -SkillDocument $effectiveInput.SkillDocument -ContextDocuments $effectiveInput.ContextDocuments -OptionalContextDocuments $effectiveInput.OptionalContextDocuments -OutputPolicy $outputPolicy

$prompt = Build-CodexPrompt -TargetDocument $effectiveInput.TargetDocument -SkillDocument $effectiveInput.SkillDocument -ContextDocuments $effectiveInput.ContextDocuments -OptionalContextDocuments $effectiveInput.OptionalContextDocuments
$previewContent = Build-PreviewContent -TargetDocument $effectiveInput.TargetDocument -SkillDocument $effectiveInput.SkillDocument -ContextDocuments $effectiveInput.ContextDocuments -OptionalContextDocuments $effectiveInput.OptionalContextDocuments -Prompt $prompt
$previewPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ("doc-reinforce-" + $targetBaseName) -Content $previewContent

Write-Host ""
Write-Host "[exec/codex] preview file      : $previewPath"
Write-Host ""
Write-Host "[exec/codex] generated prompt preview:"
Write-Host $prompt

if (-not $Execute) {
    Write-Host ""
    Write-Host "[exec/codex] preview only. No codex command executed."
    exit 0
}

if (-not (Test-CommandExists -Name "codex")) {
    throw "The 'codex' command is not available in PATH."
}

$codexOutputPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputPolicy.Config.store_preview_under -BaseName ("doc-reinforce-codex-output-" + $targetBaseName) -Content (Get-CodexPendingOutputContent)

Write-Host ""
Write-Host "[exec/codex] execution mode requested."
$exitCode = Invoke-CodexExecCommand -RepoRoot $repoRoot -Prompt $prompt -OutputFilePath $codexOutputPath
$outputSummary = Get-CodexOutputSummary -OutputFilePath $codexOutputPath

if ($exitCode -ne 0 -and $outputSummary.HasUsableOutput) {
    $notePath = Save-CodexNoteFile -OutputFilePath $codexOutputPath -CodexOutputContent $outputSummary.Content
    Write-Host "[exec/codex] codex returned a non-zero exit code, but a usable output file was captured."
    Write-Host "[exec/codex] exit code          : $exitCode"
    Write-Host "[exec/codex] codex output file  : $codexOutputPath"
    if ($null -ne $notePath) {
        Write-Host "[exec/codex] codex note file    : $notePath"
    }
    Write-Host "[exec/codex] review the output file before applying any changes."
    Show-CodexExecutionGuidance -OutputFilePath $codexOutputPath -HasUsableOutput $outputSummary.HasUsableOutput
    exit 0
}

if ($exitCode -ne 0) {
    throw "codex exec failed with exit code $exitCode. Preview: $previewPath Output: $codexOutputPath"
}

if (-not $outputSummary.HasUsableOutput) {
    Show-CodexExecutionGuidance -OutputFilePath $codexOutputPath -HasUsableOutput $outputSummary.HasUsableOutput
    throw "codex exec completed without a usable output message. Preview: $previewPath Output: $codexOutputPath"
}

Write-Host "[exec/codex] codex output file   : $codexOutputPath"
$notePath = Save-CodexNoteFile -OutputFilePath $codexOutputPath -CodexOutputContent $outputSummary.Content
if ($null -ne $notePath) {
    Write-Host "[exec/codex] codex note file     : $notePath"
}
Show-CodexExecutionGuidance -OutputFilePath $codexOutputPath -HasUsableOutput $outputSummary.HasUsableOutput
