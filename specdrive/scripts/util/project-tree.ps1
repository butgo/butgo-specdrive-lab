# 실행 예:
# .\specdrive\scripts\util\project-tree.ps1
# .\specdrive\scripts\util\project-tree.ps1 -Root "docs/projects" -MaxDepth 6
# .\specdrive\scripts\util\project-tree.ps1 -Root "docs/projects" -MaxDepth 6 -DryRun
param(
    [string]$Name = "project-tree",
    [string]$Root = ".",
    [int]$MaxDepth = 4,
    [switch]$DirectoriesOnly,
    [switch]$DryRun,
    [string[]]$Exclude = @(".git", ".speclab", "node_modules", "bin", "obj")
)

$ErrorActionPreference = "Stop"
$commonScript = Join-Path $PSScriptRoot "..\common\specdrive-common.ps1"
. $commonScript

$repoRoot = Resolve-SpecdriveRepoRoot
$normalizedRoot = $Root.Trim()
if ([string]::IsNullOrWhiteSpace($normalizedRoot) -or $normalizedRoot -eq ".") {
    $treeRoot = $repoRoot
    $displayRoot = "."
}
else {
    $displayRoot = $normalizedRoot.Replace("\", "/").TrimEnd("/")
    $treeRoot = Join-SpecdriveRepoPath -RepoRoot $repoRoot -RelativePath $displayRoot
}
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

if (-not (Test-Path -LiteralPath $treeRoot)) {
    throw "Tree root not found: $displayRoot"
}

$treeLines = [System.Collections.Generic.List[string]]::new()
$treeLines.Add("# Project Tree")
$treeLines.Add("")
$treeLines.Add("- generated_at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$treeLines.Add("- repo_root: $repoRoot")
$treeLines.Add("- tree_root: $displayRoot")
$treeLines.Add("- max_depth: $MaxDepth")
$treeLines.Add("- directories_only: $DirectoriesOnly")
$treeLines.Add("- excluded: $($Exclude -join ', ')")
$treeLines.Add("")
$treeLines.Add('```text')
$treeLines.Add("$displayRoot/")
Add-TreeLines -OutputLines $treeLines -Path $treeRoot -MaxDepth $MaxDepth -DirectoriesOnly:$DirectoriesOnly -ExcludedNames $Exclude
$treeLines.Add('```')

$treeContent = $treeLines -join [Environment]::NewLine

Write-Host "[project tree] root:"
Write-Host "  $displayRoot"
Write-Host "[project tree] output directory:"
Write-Host "  $outputDirectory"

if ($DryRun) {
    Write-Host ""
    Write-Host $treeContent
    Write-Host ""
    Write-Host "[project tree] dry-run only. No tree file generated."
    exit 0
}

$outputPath = Save-SpecdrivePreviewFile -RepoRoot $repoRoot -RelativeOutputDirectory $outputDirectory -BaseName $Name -Content $treeContent

Write-Host ""
Write-Host "[project tree] saved:"
Write-Host "  $outputPath"
