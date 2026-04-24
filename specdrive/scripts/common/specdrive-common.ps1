function Resolve-SpecdriveRepoRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")).Path
}

function Read-SpecdriveJsonFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "Config file not found: $Path"
    }

    return Get-Content $Path -Raw | ConvertFrom-Json
}

function Test-SpecdriveRequiredPaths {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Paths
    )

    $missing = @()
    foreach ($path in $Paths) {
        if (-not (Test-Path $path)) {
            $missing += $path
        }
    }

    if ($missing.Count -gt 0) {
        throw "Required paths are missing:`n- " + ($missing -join "`n- ")
    }
}

function Get-SpecdriveOutputPolicy {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$OutputMode
    )

    $policyPath = Join-Path $RepoRoot "specdrive\config\output-policy.json"
    $policy = Read-SpecdriveJsonFile -Path $policyPath

    $selectedPolicy = $policy.modes.$OutputMode
    if ($null -eq $selectedPolicy) {
        throw "Unknown output mode in output-policy.json: $OutputMode"
    }

    return [pscustomobject]@{
        Path = $policyPath
        Mode = $OutputMode
        Config = $selectedPolicy
    }
}

function Get-SpecdriveActionPreviewDirectory {
    param(
        [Parameter(Mandatory = $true)]
        $ActionConfig,
        [Parameter(Mandatory = $true)]
        $OutputPolicy
    )

    if ($null -ne $ActionConfig -and -not [string]::IsNullOrWhiteSpace($ActionConfig.review_output_directory)) {
        return $ActionConfig.review_output_directory
    }

    return $OutputPolicy.Config.store_preview_under
}

function Resolve-SpecdriveTargetName {
    param(
        [string]$RequestedTarget,
        $TargetRegistry,
        $LegacyConfig,
        [string]$ActionLabel = "action"
    )

    if (-not [string]::IsNullOrWhiteSpace($RequestedTarget)) {
        return $RequestedTarget
    }

    if ($null -ne $TargetRegistry -and -not [string]::IsNullOrWhiteSpace($TargetRegistry.default_target)) {
        return $TargetRegistry.default_target
    }

    if ($null -ne $LegacyConfig -and -not [string]::IsNullOrWhiteSpace($LegacyConfig.default_target)) {
        return $LegacyConfig.default_target
    }

    throw "No $ActionLabel target specified and no default_target configured."
}

function Test-SpecdriveActionExecuteAllowed {
    param(
        [Parameter(Mandatory = $true)]
        $ActionConfig,
        [Parameter(Mandatory = $true)]
        [string]$ActionLabel,
        [switch]$Execute
    )

    if (-not $Execute) {
        return
    }

    if ($null -eq $ActionConfig -or $ActionConfig.execute_allowed -ne $true) {
        throw "Execute mode is not allowed for action: $ActionLabel"
    }
}

function Test-SpecdriveActionPreconditions {
    param(
        [Parameter(Mandatory = $true)]
        $ActionConfig,
        [Parameter(Mandatory = $true)]
        [string]$ActionLabel,
        [hashtable]$AvailableInputs
    )

    if ($null -eq $ActionConfig -or $null -eq $ActionConfig.execute_requires) {
        return
    }

    foreach ($requirement in $ActionConfig.execute_requires) {
        $isAvailable = $false
        if ($null -ne $AvailableInputs -and $AvailableInputs.ContainsKey($requirement)) {
            $value = $AvailableInputs[$requirement]
            if ($null -ne $value) {
                if ($value -is [string]) {
                    $isAvailable = -not [string]::IsNullOrWhiteSpace($value)
                } else {
                    $isAvailable = $true
                }
            }
        }

        if (-not $isAvailable) {
            throw "Missing execute precondition for action '$ActionLabel': $requirement"
        }
    }
}

function Get-SpecdriveActionSetting {
    param(
        [Parameter(Mandatory = $true)]
        $ActionConfig,
        [Parameter(Mandatory = $true)]
        [string]$SettingName,
        [string]$DefaultValue = ""
    )

    if ($null -ne $ActionConfig) {
        $value = $ActionConfig.$SettingName
        if ($null -ne $value -and -not [string]::IsNullOrWhiteSpace([string]$value)) {
            return [string]$value
        }
    }

    return $DefaultValue
}

function Join-SpecdriveRepoPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$RelativePath
    )

    return Join-Path $RepoRoot $RelativePath
}

function New-SpecdriveTimestamp {
    return (Get-Date).ToString("yyyyMMdd-HHmmss")
}

function Get-SpecdriveSafeName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    return (($Value -replace "[\\/:\s]+", "-") -replace "[^A-Za-z0-9._-]", "").Trim("-")
}

function Save-SpecdrivePreviewFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$RelativeOutputDirectory,
        [Parameter(Mandatory = $true)]
        [string]$BaseName,
        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $outputDirectory = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $RelativeOutputDirectory
    if (-not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $timestamp = New-SpecdriveTimestamp
    $safeBaseName = Get-SpecdriveSafeName -Value $BaseName
    $fileName = "$timestamp-$safeBaseName.md"
    $outputPath = Join-Path $outputDirectory $fileName

    Set-Content -Path $outputPath -Value $Content -Encoding UTF8
    return $outputPath
}

function Get-SpecdriveDocumentBaseName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$DocumentPath
    )

    return [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileName($DocumentPath))
}

function Get-SpecdriveProjectHistoryDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$DocumentPath
    )

    $documentBaseName = Get-SpecdriveDocumentBaseName -DocumentPath $DocumentPath
    return Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath ("docs/history/projects/{0}/{1}" -f $Project, $documentBaseName)
}

function New-SpecdriveHistoryArtifactPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$DocumentPath,
        [Parameter(Mandatory = $true)]
        [string]$Suffix
    )

    $historyDirectory = Get-SpecdriveProjectHistoryDirectory -RepoRoot $RepoRoot -Project $Project -DocumentPath $DocumentPath
    if (-not (Test-Path $historyDirectory)) {
        New-Item -ItemType Directory -Path $historyDirectory -Force | Out-Null
    }

    $timestamp = New-SpecdriveTimestamp
    $documentBaseName = Get-SpecdriveSafeName -Value (Get-SpecdriveDocumentBaseName -DocumentPath $DocumentPath)
    $safeSuffix = Get-SpecdriveSafeName -Value $Suffix
    return Join-Path $historyDirectory ("{0}-{1}-{2}.md" -f $timestamp, $documentBaseName, $safeSuffix)
}

function Save-SpecdriveHistoryFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$DocumentPath,
        [Parameter(Mandatory = $true)]
        [string]$Suffix,
        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $outputPath = New-SpecdriveHistoryArtifactPath -RepoRoot $RepoRoot -Project $Project -DocumentPath $DocumentPath -Suffix $Suffix
    Set-Content -Path $outputPath -Value $Content -Encoding UTF8
    return $outputPath
}

function Copy-SpecdriveFileToHistory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$DocumentPath,
        [Parameter(Mandatory = $true)]
        [string]$SourcePath,
        [Parameter(Mandatory = $true)]
        [string]$Suffix
    )

    if (-not (Test-Path $SourcePath)) {
        return $null
    }

    $content = Get-Content -Path $SourcePath -Raw
    return Save-SpecdriveHistoryFile -RepoRoot $RepoRoot -Project $Project -DocumentPath $DocumentPath -Suffix $Suffix -Content $content
}

function Get-SpecdriveFirstMarkdownCodeBlock {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $match = [regex]::Match($Content, '```(?:md|markdown)?\r?\n(?<body>[\s\S]*?)\r?\n```')
    if (-not $match.Success) {
        return ""
    }

    return $match.Groups['body'].Value.Trim()
}

function Invoke-SpecdriveGitCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    $safeDirectory = $RepoRoot -replace "\\", "/"
    $output = & git -c "safe.directory=$safeDirectory" -C $RepoRoot @Arguments 2>$null
    if ($LASTEXITCODE -ne 0) {
        return @()
    }

    return @($output)
}

function Get-SpecdriveGitStatusLines {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    return Invoke-SpecdriveGitCommand -RepoRoot $RepoRoot -Arguments @("status", "--short")
}

function Get-SpecdriveCurrentBranchName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $branchLines = Invoke-SpecdriveGitCommand -RepoRoot $RepoRoot -Arguments @("branch", "--show-current")
    if ($branchLines.Count -eq 0) {
        return ""
    }

    return ((@($branchLines) -join "").Trim())
}

function Get-SpecdriveGitChangedPaths {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $statusLines = Get-SpecdriveGitStatusLines -RepoRoot $RepoRoot
    $paths = @()

    foreach ($line in $statusLines) {
        if ([string]::IsNullOrWhiteSpace($line)) {
            continue
        }

        if ($line.Length -le 3) {
            continue
        }

        $path = $line.Substring(3).Trim()
        if ($path.Contains(" -> ")) {
            $path = $path.Split(" -> ")[-1].Trim()
        }

        if (-not [string]::IsNullOrWhiteSpace($path)) {
            $paths += $path
        }
    }

    return $paths
}

function Get-SpecdriveChangedAreas {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$ChangedPaths
    )

    if ($null -eq $ChangedPaths) {
        $ChangedPaths = @()
    } else {
        $ChangedPaths = @($ChangedPaths)
    }
    $areas = @()
    foreach ($path in $ChangedPaths) {
        $normalizedPath = $path -replace "\\", "/"
        $parts = $normalizedPath.Split("/")
        if ($parts.Count -ge 2) {
            $areas += ($parts[0..1] -join "/")
            continue
        }

        if ($parts.Count -eq 1 -and -not [string]::IsNullOrWhiteSpace($parts[0])) {
            $areas += $parts[0]
        }
    }

    return @($areas | Select-Object -Unique)
}

function Get-SpecdriveGitChangeOverview {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$ChangedPaths,
        [int]$MaxChangedPaths = 10
    )

    if ($null -eq $ChangedPaths) {
        $ChangedPaths = @()
    } else {
        $ChangedPaths = @($ChangedPaths)
    }
    if ($MaxChangedPaths -lt 1) {
        $MaxChangedPaths = 10
    }

    $areas = Get-SpecdriveChangedAreas -ChangedPaths $ChangedPaths
    $samplePaths = @($ChangedPaths | Select-Object -First $MaxChangedPaths)

    return [pscustomobject]@{
        Count = $ChangedPaths.Count
        Summary = if ($ChangedPaths.Count -gt 0) { "changed paths: $($ChangedPaths.Count)" } else { "clean worktree" }
        Areas = $areas
        AreaSummary = if ($areas.Count -gt 0) { $areas -join ", " } else { "none" }
        SamplePaths = $samplePaths
        HasMorePaths = ($ChangedPaths.Count -gt $samplePaths.Count)
        RemainingPathCount = ($ChangedPaths.Count - $samplePaths.Count)
        MaxChangedPaths = $MaxChangedPaths
    }
}

function Get-SpecdriveSessionOutputDirectory {
    return ".speclab/session-output"
}

function Get-SpecdriveChangeSummary {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$ChangedPaths
    )

    if ($null -eq $ChangedPaths) {
        $ChangedPaths = @()
    } else {
        $ChangedPaths = @($ChangedPaths)
    }
    $summary = [ordered]@{
        HasOnlyDocs = ($ChangedPaths.Count -gt 0)
        HasSpecdriveScripts = $false
        HasSpecdriveConfig = $false
        HasSpecdriveDocs = $false
        HasBoardDocs = $false
        HasProjectHistory = $false
        HasSessionScripts = $false
        HasGitScripts = $false
        HasDocScripts = $false
        HasCommonScript = $false
    }

    foreach ($path in $ChangedPaths) {
        if ($path -notlike "docs/*" -and $path -notlike "README*" -and $path -notlike "AGENTS.md") {
            $summary.HasOnlyDocs = $false
        }

        if ($path -like "specdrive/scripts/*") {
            $summary.HasSpecdriveScripts = $true
        }
        if ($path -like "specdrive/config/*") {
            $summary.HasSpecdriveConfig = $true
        }
        if ($path -like "docs/specdrive/*") {
            $summary.HasSpecdriveDocs = $true
        }
        if ($path -like "docs/projects/board/*") {
            $summary.HasBoardDocs = $true
        }
        if ($path -like "docs/history/projects/*") {
            $summary.HasProjectHistory = $true
        }
        if ($path -like "specdrive/scripts/session/*") {
            $summary.HasSessionScripts = $true
        }
        if ($path -like "specdrive/scripts/git/*") {
            $summary.HasGitScripts = $true
        }
        if ($path -like "specdrive/scripts/doc/*") {
            $summary.HasDocScripts = $true
        }
        if ($path -eq "specdrive/scripts/common/specdrive-common.ps1") {
            $summary.HasCommonScript = $true
        }
    }

    return [pscustomobject]$summary
}

function Get-SpecdriveCommitMessageDraft {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$ChangedPaths
    )

    if ($null -eq $ChangedPaths) {
        $ChangedPaths = @()
    } else {
        $ChangedPaths = @($ChangedPaths)
    }
    $summary = Get-SpecdriveChangeSummary -ChangedPaths $ChangedPaths
    $type = "spec"
    $scope = "specdrive"
    if ($summary.HasOnlyDocs) {
        $type = "docs"
        $scope = "docs"
    }

    if ($summary.HasSpecdriveConfig -or $summary.HasDocScripts -or $summary.HasCommonScript -or $summary.HasSessionScripts -or $summary.HasGitScripts) {
        $type = "spec"
        $scope = "specdrive"
    }

    if ($summary.HasBoardDocs -or $summary.HasProjectHistory) {
        $type = "spec"
        $scope = "board"
    }

    $subject = "${type}(${scope}): reduce session and git cli context output"
    $body = @()

    if ($summary.HasSessionScripts -or $summary.HasGitScripts -or $summary.HasCommonScript) {
        $body += "- summarize changed paths and areas before printing detailed file lists"
    }
    if ($summary.HasSpecdriveDocs) {
        $body += "- document token-aware output rules for session and git commands"
    }
    if ($summary.HasBoardDocs -or $summary.HasProjectHistory) {
        $body += "- keep project document and history changes visible in the generated draft"
    }
    if ($body.Count -eq 0) {
        $body += "- update current changed files and align the git draft with the latest workspace state"
    }

    return [pscustomobject]@{
        Type = $type
        Scope = $scope
        Subject = $subject
        Body = $body
    }
}

function Get-SpecdrivePrMessageDraft {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$ChangedPaths
    )

    if ($null -eq $ChangedPaths) {
        $ChangedPaths = @()
    } else {
        $ChangedPaths = @($ChangedPaths)
    }
    $summary = Get-SpecdriveChangeSummary -ChangedPaths $ChangedPaths
    $type = "spec"
    if ($summary.HasOnlyDocs) {
        $type = "docs"
    }
    if ($summary.HasSpecdriveConfig -or $summary.HasDocScripts -or $summary.HasCommonScript -or $summary.HasSessionScripts -or $summary.HasGitScripts -or $summary.HasBoardDocs -or $summary.HasProjectHistory) {
        $type = "spec"
    }

    $title = "[$type] reduce session and git CLI context output"
    $description = @()

    if ($summary.HasSessionScripts -or $summary.HasGitScripts -or $summary.HasCommonScript) {
        $description += "- session/git CLI 기본 출력을 변경 파일 전체 목록에서 변경 수, 변경 영역, 샘플 중심으로 정리"
    }
    if ($summary.HasSpecdriveDocs) {
        $description += "- session-stage, git-stage, cli-manual에 토큰 사용량 절감용 출력 원칙 반영"
    }
    if ($summary.HasBoardDocs -or $summary.HasProjectHistory) {
        $description += "- 프로젝트 문서 또는 history 변경 포함 시 전달 메시지 생성에서 변경 범위 참고 유지"
    }

    if ($ChangedPaths.Count -eq 0) {
        $description += "- 현재 Git 변경 파일 없음, 기본 초안만 출력"
    }

    return [pscustomobject]@{
        Type = $type
        TitleEn = $title
        DescriptionKo = $description
    }
}

function Get-SpecdriveBranchNameDraft {
    param(
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]]$ChangedPaths,
        [string]$CurrentBranch
    )

    if ($null -eq $ChangedPaths) {
        $ChangedPaths = @()
    } else {
        $ChangedPaths = @($ChangedPaths)
    }
    $summary = Get-SpecdriveChangeSummary -ChangedPaths $ChangedPaths
    $prefix = "spec"
    $topic = "specdrive-cli-output"

    if (($summary.HasBoardDocs -or $summary.HasProjectHistory) -and -not ($summary.HasSpecdriveScripts -or $summary.HasSpecdriveConfig -or $summary.HasSpecdriveDocs)) {
        $topic = "board-history"
    }

    if ($summary.HasOnlyDocs -and $ChangedPaths.Count -gt 0) {
        $prefix = "docs"
        $topic = "specdrive-docs"
    }
    if ($summary.HasSpecdriveConfig -or $summary.HasDocScripts -or $summary.HasCommonScript) {
        $prefix = "spec"
        $topic = "specdrive-rules"
    }
    if ($summary.HasSessionScripts -or $summary.HasGitScripts) {
        $prefix = "spec"
        $topic = "session-git-cli-output"
    }
    if ($summary.HasProjectHistory -and -not ($summary.HasSpecdriveConfig -or $summary.HasDocScripts -or $summary.HasCommonScript)) {
        $prefix = "spec"
        $topic = "board-history"
    }

    $branchName = "$prefix/$topic"
    $reasons = @(
        "- policy prefix: $prefix",
        "- topic: $topic",
        "- current branch: $(if ([string]::IsNullOrWhiteSpace($CurrentBranch)) { 'unknown' } else { $CurrentBranch })"
    )

    return [pscustomobject]@{
        BranchName = $branchName
        Reasons = $reasons
    }
}

