param(
    [string]$Target = "",
    [switch]$DryRun,
    [switch]$Execute
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

function Read-ReinforceLegacyConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/doc-reinforce-targets.json"
    return Read-SpecdriveJsonFile -Path $configPath
}

function Read-ReinforceRegistries {
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

function Resolve-TargetName {
    param(
        [string]$RequestedTarget,
        [Parameter(Mandatory = $true)]
        $TargetRegistry,
        [Parameter(Mandatory = $true)]
        $LegacyConfig
    )

    return Resolve-SpecdriveTargetName -RequestedTarget $RequestedTarget -TargetRegistry $TargetRegistry -LegacyConfig $LegacyConfig -ActionLabel "reinforce"
}

function Resolve-ReinforceRouting {
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

    $actionConfig = $Registries.Actions.actions.reinforce
    if ($null -eq $actionConfig) {
        throw "Missing reinforce action in doc-action-registry.json"
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

function Resolve-DocumentSet {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        $Routing
    )

    $resolvedContext = @()
    foreach ($doc in $Routing.ContextSet.required_documents) {
        $resolvedContext += [pscustomobject]@{
            Path = $doc
            AbsolutePath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $doc
            Required = $true
        }
    }

    $resolvedOptionalContext = @()
    foreach ($doc in $Routing.ContextSet.optional_documents) {
        $resolvedOptionalContext += [pscustomobject]@{
            Path = $doc
            AbsolutePath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $doc
            Required = $false
        }
    }

    return @{
        TargetDocument = [pscustomobject]@{
            Path = $Routing.Target.document_path
            AbsolutePath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $Routing.Target.document_path
        }
        Skill = [pscustomobject]@{
            Path = $Routing.Skill.path
            AbsolutePath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $Routing.Skill.path
        }
        ContextDocuments = $resolvedContext
        OptionalContextDocuments = $resolvedOptionalContext
    }
}

function Test-RequiredFiles {
    param(
        [Parameter(Mandatory = $true)]
        $DocumentSet
    )

    $requiredPaths = @(
        $DocumentSet.TargetDocument.AbsolutePath,
        $DocumentSet.Skill.AbsolutePath
    )

    foreach ($doc in $DocumentSet.ContextDocuments) {
        $requiredPaths += $doc.AbsolutePath
    }

    Test-SpecdriveRequiredPaths -Paths $requiredPaths
}

function Show-ReinforcePlan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetName,
        [Parameter(Mandatory = $true)]
        $Routing,
        [Parameter(Mandatory = $true)]
        $DocumentSet,
        [Parameter(Mandatory = $true)]
        $OutputPolicy
    )

    Write-Host "[doc reinforce] target: $TargetName"
    Write-Host "  document : $($DocumentSet.TargetDocument.Path)"
    Write-Host "  skill    : $($DocumentSet.Skill.Path)"
    Write-Host "  output   : $($Routing.Action.output_mode)"
    Write-Host "  review   : $($Routing.Action.human_review_required)"
    Write-Host "  policy   : $($OutputPolicy.Path)"
    Write-Host "  preview  : $($OutputPolicy.Config.store_preview_under)"
    Write-Host "  context  :"

    foreach ($doc in $DocumentSet.ContextDocuments) {
        Write-Host "    - $($doc.Path)"
    }

    if ($DocumentSet.OptionalContextDocuments.Count -gt 0) {
        Write-Host "  optional context :"
        foreach ($doc in $DocumentSet.OptionalContextDocuments) {
            $exists = Test-Path $doc.AbsolutePath
            $suffix = if ($exists) { "" } else { " (missing, optional)" }
            Write-Host "    - $($doc.Path)$suffix"
        }
    }
}

function Invoke-CodexExecPreview {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        $DocumentSet
    )

    $execScript = Join-Path $RepoRoot "specdrive\scripts\exec\codex-exec.ps1"
    if (-not (Test-Path $execScript)) {
        throw "Exec wrapper not found: specdrive/scripts/exec/codex-exec.ps1"
    }

    $contextPaths = @($DocumentSet.ContextDocuments | ForEach-Object { $_.Path })
    $optionalContextPaths = @($DocumentSet.OptionalContextDocuments | ForEach-Object { $_.Path })
    $execParams = @{
        TargetDocument = $DocumentSet.TargetDocument.Path
        SkillDocument = $DocumentSet.Skill.Path
        ContextDocuments = $contextPaths
    }

    if ($optionalContextPaths.Count -gt 0) {
        $execParams.OptionalContextDocuments = $optionalContextPaths
    }

    if ($Execute) {
        $execParams.Execute = $true
    }

    & $execScript @execParams
}

$repoRoot = Resolve-SpecdriveRepoRoot
$legacyConfig = Read-ReinforceLegacyConfig -RepoRoot $repoRoot
$registries = Read-ReinforceRegistries -RepoRoot $repoRoot
$targetName = Resolve-TargetName -RequestedTarget $Target -TargetRegistry $registries.Targets -LegacyConfig $legacyConfig
$routing = Resolve-ReinforceRouting -TargetName $targetName -Registries $registries
$documentSet = Resolve-DocumentSet -RepoRoot $repoRoot -Routing $routing
$outputPolicy = Get-SpecdriveOutputPolicy -RepoRoot $repoRoot -OutputMode $routing.Action.output_mode

Test-RequiredFiles -DocumentSet $documentSet
Show-ReinforcePlan -TargetName $routing.Name -Routing $routing -DocumentSet $documentSet -OutputPolicy $outputPolicy

if ($DryRun) {
    Write-Host ""
    Write-Host "[doc reinforce] dry-run only. No external execution performed."
    exit 0
}

Write-Host ""
Write-Host "[doc reinforce] hand off to exec wrapper."
Invoke-CodexExecPreview -RepoRoot $repoRoot -DocumentSet $documentSet
