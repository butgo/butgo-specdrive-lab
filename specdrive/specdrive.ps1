param(
    [Parameter(Position = 0)]
    [string]$Stage = "",
    [Parameter(Position = 1)]
    [string]$Action = "",
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "scripts\common\specdrive-common.ps1"
. $commonScript

function Show-SpecdriveUsage {
    Write-Host "specdrive/specdrive.ps1 usage:"
    Write-Host "  specdrive/specdrive.ps1 doc reinforce -Target board-overview [-DryRun] [-Execute]"
    Write-Host "  specdrive/specdrive.ps1 doc confirm -Target board-overview [-DryRun] [-Execute]"
    Write-Host "  specdrive/specdrive.ps1 doc history-save -Target board-overview [-DryRun] [-Execute]"
    Write-Host "  specdrive/specdrive.ps1 session start [-DryRun]"
    Write-Host "  specdrive/specdrive.ps1 session status [-DryRun] [-Detailed] [-MaxChangedPaths 10]"
    Write-Host "  specdrive/specdrive.ps1 session save [-DryRun] [-Detailed] [-MaxChangedPaths 10]"
    Write-Host "  specdrive/specdrive.ps1 git branch-name [-DryRun] [-Detailed] [-MaxChangedPaths 10]"
    Write-Host "  specdrive/specdrive.ps1 git git-message [-DryRun] [-Detailed] [-MaxChangedPaths 10]"
    Write-Host "  specdrive/specdrive.ps1 git pr-message [-DryRun] [-Detailed] [-MaxChangedPaths 10]"
}

function ConvertTo-SpecdriveNamedArgs {
    param(
        [string[]]$ArgsToConvert
    )

    $namedArgs = @{}
    $i = 0
    while ($i -lt $ArgsToConvert.Count) {
        $token = $ArgsToConvert[$i]
        if (-not $token.StartsWith("-")) {
            throw "Unexpected positional argument: $token"
        }

        $name = $token.TrimStart("-")
        $nextIndex = $i + 1
        $hasValue = $nextIndex -lt $ArgsToConvert.Count -and -not $ArgsToConvert[$nextIndex].StartsWith("-")
        if ($hasValue) {
            $namedArgs[$name] = $ArgsToConvert[$nextIndex]
            $i += 2
            continue
        }

        $namedArgs[$name] = $true
        $i += 1
    }

    return $namedArgs
}

function Invoke-SpecdriveScript {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ScriptRelativePath,
        [Parameter(Mandatory = $true)]
        [hashtable]$NamedArgs
    )

    $repoRoot = Split-Path -Parent $PSScriptRoot
    $scriptPath = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $ScriptRelativePath
    if (-not (Test-Path $scriptPath)) {
        throw "Script not found: $ScriptRelativePath"
    }

    & $scriptPath @NamedArgs
}

if ([string]::IsNullOrWhiteSpace($Stage) -or [string]::IsNullOrWhiteSpace($Action)) {
    Show-SpecdriveUsage
    exit 1
}

$namedArgs = ConvertTo-SpecdriveNamedArgs -ArgsToConvert $RemainingArgs

switch ($Stage) {
    "doc" {
        switch ($Action) {
            "reinforce" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/doc/reinforce.ps1" -NamedArgs $namedArgs; exit 0 }
            "confirm" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/doc/confirm.ps1" -NamedArgs $namedArgs; exit 0 }
            "history-save" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/doc/history-save.ps1" -NamedArgs $namedArgs; exit 0 }
            default { throw "Unknown doc action: $Action" }
        }
    }
    "session" {
        switch ($Action) {
            "start" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/session/start.ps1" -NamedArgs $namedArgs; exit 0 }
            "status" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/session/status.ps1" -NamedArgs $namedArgs; exit 0 }
            "save" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/session/save.ps1" -NamedArgs $namedArgs; exit 0 }
            default { throw "Unknown session action: $Action" }
        }
    }
    "git" {
        switch ($Action) {
            "branch-name" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/git/branch-name.ps1" -NamedArgs $namedArgs; exit 0 }
            "git-message" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/git/git-message.ps1" -NamedArgs $namedArgs; exit 0 }
            "pr-message" { Invoke-SpecdriveScript -ScriptRelativePath "specdrive/scripts/git/pr-message.ps1" -NamedArgs $namedArgs; exit 0 }
            default { throw "Unknown git action: $Action" }
        }
    }
    default {
        throw "Unknown stage: $Stage"
    }
}
