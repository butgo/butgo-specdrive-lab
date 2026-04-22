param(
    [string]$Name = "doc-tree",
    [int]$MaxDepth = 8,
    [switch]$DirectoriesOnly,
    [switch]$DryRun,
    [string[]]$Exclude = @()
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$docsRoot = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath "docs"
$outputDirectory = ".speclab/tree-output"

function Test-ExcludedTreeItem {
    param(
        [Parameter(Mandatory = $true)]
        [System.IO.FileSystemInfo]$Item,
        [string[]]$ExcludedNames
    )

    return $ExcludedNames -contains $Item.Name
}

function Get-TreeChildItems {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [switch]$DirectoriesOnly,
        [string[]]$ExcludedNames
    )

    $items = Get-ChildItem -LiteralPath $Path -Force |
        Where-Object { -not (Test-ExcludedTreeItem -Item $_ -ExcludedNames $ExcludedNames) }

    if ($DirectoriesOnly) {
        $items = $items | Where-Object { $_.PSIsContainer }
    }

    return @($items | Sort-Object @{ Expression = { -not $_.PSIsContainer } }, Name)
}

function Add-TreeLines {
    param(
        [Parameter(Mandatory = $true)]
        [object]$OutputLines,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [string]$Prefix = "",
        [int]$Depth = 0,
        [int]$MaxDepth,
        [switch]$DirectoriesOnly,
        [string[]]$ExcludedNames
    )

    if ($Depth -ge $MaxDepth) {
        return
    }

    $children = Get-TreeChildItems -Path $Path -DirectoriesOnly:$DirectoriesOnly -ExcludedNames $ExcludedNames
    for ($i = 0; $i -lt $children.Count; $i++) {
        $child = $children[$i]
        $isLast = $i -eq ($children.Count - 1)
        $connector = if ($isLast) { "+-- " } else { "|-- " }
        $suffix = if ($child.PSIsContainer) { "/" } else { "" }
        $OutputLines.Add("$Prefix$connector$($child.Name)$suffix")

        if ($child.PSIsContainer) {
            $nextPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix|   " }
            Add-TreeLines -OutputLines $OutputLines -Path $child.FullName -Prefix $nextPrefix -Depth ($Depth + 1) -MaxDepth $MaxDepth -DirectoriesOnly:$DirectoriesOnly -ExcludedNames $ExcludedNames
        }
    }
}

if ($MaxDepth -lt 1) {
    throw "MaxDepth must be greater than 0."
}

if (-not (Test-Path -LiteralPath $docsRoot)) {
    throw "Docs root not found: docs"
}

$treeLines = [System.Collections.Generic.List[string]]::new()
$treeLines.Add("# Document Tree")
$treeLines.Add("")
$treeLines.Add("- generated_at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$treeLines.Add("- docs_root: docs")
$treeLines.Add("- max_depth: $MaxDepth")
$treeLines.Add("- directories_only: $DirectoriesOnly")
$treeLines.Add("- excluded: $($Exclude -join ', ')")
$treeLines.Add("")
$treeLines.Add('```text')
$treeLines.Add("docs/")
Add-TreeLines -OutputLines $treeLines -Path $docsRoot -MaxDepth $MaxDepth -DirectoriesOnly:$DirectoriesOnly -ExcludedNames $Exclude
$treeLines.Add('```')

$treeContent = $treeLines -join [Environment]::NewLine

Write-Host "[doc tree] root:"
Write-Host "  docs"
Write-Host "[doc tree] output directory:"
Write-Host "  $outputDirectory"

if ($DryRun) {
    Write-Host ""
    Write-Host $treeContent
    Write-Host ""
    Write-Host "[doc tree] dry-run only. No tree file generated."
    exit 0
}

$outputPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputDirectory -BaseName $Name -Content $treeContent

Write-Host ""
Write-Host "[doc tree] saved:"
Write-Host "  $outputPath"
