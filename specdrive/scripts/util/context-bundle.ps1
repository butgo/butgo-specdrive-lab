param(
    [string]$BundleKey = "",
    [string[]]$Documents = @(),
    [string]$Name = "context-bundle",
    [switch]$IncludeDefault,
    [switch]$IncludeReadmeKo,
    [switch]$IncludeAgents,
    [switch]$IncludeRepoSkills,
    [switch]$IncludeCodexSkills,
    [switch]$IncludeLegacySkills,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$outputDirectory = ".speclab/context-bundle-output"

$defaultDocuments = @(
    "README.md",
    "AGENTS.compact.md",
    "docs/AI_CONTEXT.md"
)

function Get-ContextBundleConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot
    )

    $configPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath "specdrive/config/context-bundle-map.json"
    if (-not (Test-Path -LiteralPath $configPath)) {
        throw "Context bundle config not found: specdrive/config/context-bundle-map.json"
    }

    return Read-SpecdriveJsonFile -Path $configPath
}

function Select-ContextBundleKey {
    param(
        [Parameter(Mandatory = $true)]
        $Config
    )

    $orderedKeys = @(
        "default",
        "readme-ko-all",
        "readme-en-all",
        "readme-all",
        "agents-compact",
        "agents-all",
        "repo-skills",
        "codex-skills",
        "legacy-skills",
        "onboarding-all",
        "codex-base-review",
        "standards-all"
    )

    Write-Host "[context bundle] select bundle:"
    for ($i = 0; $i -lt $orderedKeys.Count; $i++) {
        $key = $orderedKeys[$i]
        if ($null -ne $Config.bundles.$key) {
            Write-Host ("  {0}: {1}" -f ($i + 1), $key)
        }
    }

    $selection = Read-Host "Select bundle number"
    if ([string]::IsNullOrWhiteSpace($selection)) {
        throw "No bundle selected."
    }

    $selectionNumber = 0
    if (-not [int]::TryParse($selection, [ref]$selectionNumber)) {
        throw "Invalid bundle selection: $selection"
    }

    if ($selectionNumber -lt 1 -or $selectionNumber -gt $orderedKeys.Count) {
        throw "Bundle selection out of range: $selection"
    }

    $selectedKey = $orderedKeys[$selectionNumber - 1]
    if ($null -eq $Config.bundles.$selectedKey) {
        throw "Selected bundle key is not configured: $selectedKey"
    }

    return $selectedKey
}

function Get-ContextBundleFilesByName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$FileName
    )

    $excludedDirectories = @(".git", ".speclab")
    $rootLength = $RepoRoot.TrimEnd("\").Length
    $items = Get-ChildItem -LiteralPath $RepoRoot -Recurse -Force -File -Filter $FileName |
        Where-Object {
            $relativePath = $_.FullName.Substring($rootLength).TrimStart("\")
            $parts = $relativePath -split "\\"
            $isExcluded = $false
            foreach ($part in $parts) {
                if ($excludedDirectories -contains $part) {
                    $isExcluded = $true
                    break
                }
            }

            -not $isExcluded
        } |
        Sort-Object FullName

    return @($items | ForEach-Object {
        $_.FullName.Substring($rootLength).TrimStart("\") -replace "\\", "/"
    })
}

function Get-ContextBundleFilesByDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$RelativeDirectory
    )

    $directoryPath = Join-SpecdriveRepoPath -RepoRoot $RepoRoot -RelativePath $RelativeDirectory
    if (-not (Test-Path -LiteralPath $directoryPath)) {
        return @()
    }

    $rootLength = $RepoRoot.TrimEnd("\").Length
    $items = Get-ChildItem -LiteralPath $directoryPath -Recurse -Force -File |
        Where-Object { $_.Name -ne ".gitkeep" } |
        Sort-Object FullName

    return @($items | ForEach-Object {
        $_.FullName.Substring($rootLength).TrimStart("\") -replace "\\", "/"
    })
}

$selectedDocuments = @()
$bundleConfig = $null
$hasSelectionOption = -not [string]::IsNullOrWhiteSpace($BundleKey) -or $Documents.Count -gt 0 -or $IncludeDefault -or $IncludeReadmeKo -or $IncludeAgents -or $IncludeRepoSkills -or $IncludeCodexSkills -or $IncludeLegacySkills
if (-not $hasSelectionOption) {
    $contextBundleConfig = Get-ContextBundleConfig -RepoRoot $repoRoot
    $BundleKey = Select-ContextBundleKey -Config $contextBundleConfig
}

if (-not [string]::IsNullOrWhiteSpace($BundleKey)) {
    if ($null -eq $contextBundleConfig) {
        $contextBundleConfig = Get-ContextBundleConfig -RepoRoot $repoRoot
    }
    $bundleConfig = $contextBundleConfig.bundles.$BundleKey
    if ($null -eq $bundleConfig) {
        throw "Unknown context bundle key: $BundleKey"
    }

    if (-not [string]::IsNullOrWhiteSpace($bundleConfig.name) -and $Name -eq "context-bundle") {
        $Name = $bundleConfig.name
    }

    foreach ($document in @($bundleConfig.documents)) {
        if (-not [string]::IsNullOrWhiteSpace($document)) {
            $selectedDocuments += $document
        }
    }

    foreach ($fileName in @($bundleConfig.file_names)) {
        if (-not [string]::IsNullOrWhiteSpace($fileName)) {
            $selectedDocuments += Get-ContextBundleFilesByName -RepoRoot $repoRoot -FileName $fileName
        }
    }

    foreach ($directory in @($bundleConfig.directories)) {
        if (-not [string]::IsNullOrWhiteSpace($directory)) {
            $selectedDocuments += Get-ContextBundleFilesByDirectory -RepoRoot $repoRoot -RelativeDirectory $directory
        }
    }
}

$hasExplicitSelection = $Documents.Count -gt 0 -or $IncludeReadmeKo -or $IncludeAgents -or $IncludeRepoSkills -or $IncludeCodexSkills -or $IncludeLegacySkills -or -not [string]::IsNullOrWhiteSpace($BundleKey)
if ($IncludeDefault -or -not $hasExplicitSelection) {
    $selectedDocuments += $defaultDocuments
}

if ($IncludeReadmeKo) {
    $selectedDocuments += Get-ContextBundleFilesByName -RepoRoot $repoRoot -FileName "README.ko.md"
}

if ($IncludeAgents) {
    $selectedDocuments += Get-ContextBundleFilesByName -RepoRoot $repoRoot -FileName "AGENTS.md"
}

if ($IncludeRepoSkills) {
    if ($Name -eq "context-bundle") {
        $Name = "repo-skills"
    }

    $selectedDocuments += Get-ContextBundleFilesByDirectory -RepoRoot $repoRoot -RelativeDirectory ".agents/skills"
}

if ($IncludeCodexSkills) {
    if ($Name -eq "context-bundle") {
        $Name = "codex-skills"
    }

    $selectedDocuments += Get-ContextBundleFilesByDirectory -RepoRoot $repoRoot -RelativeDirectory "specdrive/codex-skills"
}

if ($IncludeLegacySkills) {
    if ($Name -eq "context-bundle") {
        $Name = "legacy-skills"
    }

    $selectedDocuments += Get-ContextBundleFilesByDirectory -RepoRoot $repoRoot -RelativeDirectory "specdrive/skills"
}

$normalizedDocuments = @()
foreach ($document in $Documents) {
    if ([string]::IsNullOrWhiteSpace($document)) {
        continue
    }

    $normalizedDocuments += ($document -split "," | ForEach-Object { $_.Trim() } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}
$selectedDocuments += $normalizedDocuments
$selectedDocuments = @($selectedDocuments | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)

if ($selectedDocuments.Count -eq 0) {
    throw "No documents selected for context bundle."
}

$missingDocuments = @()
foreach ($document in $selectedDocuments) {
    $path = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $document
    if (-not (Test-Path -LiteralPath $path)) {
        $missingDocuments += $document
    }
}

if ($missingDocuments.Count -gt 0) {
    throw "Context bundle source documents are missing:`n- " + ($missingDocuments -join "`n- ")
}

$lines = @()
$lines += "# Context Bundle"
$lines += ""
$lines += "- generated_at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$lines += "- name: $Name"
$lines += "- repo_root: $repoRoot"
$lines += ""
$lines += "## Included Documents"
$lines += ""
foreach ($document in $selectedDocuments) {
    $lines += ('- `{0}`' -f $document)
}
$lines += ""

foreach ($document in $selectedDocuments) {
    $path = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $document
    $content = Get-Content -Path $path -Raw
    $lines += "---"
    $lines += ""
    $lines += "## $document"
    $lines += ""
    $lines += '```markdown'
    $lines += $content.TrimEnd()
    $lines += '```'
    $lines += ""
}

$bundleContent = $lines -join [Environment]::NewLine

if (-not [string]::IsNullOrWhiteSpace($BundleKey)) {
    Write-Host "[context bundle] bundle key:"
    Write-Host "  $BundleKey"
}
Write-Host "[context bundle] documents:"
foreach ($document in $selectedDocuments) {
    Write-Host "  - $document"
}
Write-Host "[context bundle] output directory:"
Write-Host "  $outputDirectory"

if ($DryRun) {
    Write-Host ""
    Write-Host "[context bundle] dry-run only. No bundle file generated."
    exit 0
}

$outputPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputDirectory -BaseName $Name -Content $bundleContent

Write-Host ""
Write-Host "[context bundle] saved:"
Write-Host "  $outputPath"
