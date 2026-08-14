[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$UnityProjectRoot
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$resolved = (Resolve-Path -LiteralPath $UnityProjectRoot).Path
$requestRoot = Join-Path $resolved 'coordination\requests\documentation'
if (-not (Test-Path -LiteralPath $requestRoot)) {
    throw "The selected Unity project has no documentation request root: $requestRoot"
}
@{
    schema_version = 1
    unity_project_root = $resolved
} | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $repoRoot '.fse-docs-local.json') -Encoding utf8NoBOM
Write-Output "FSE_DOCS_PROJECT_ROOT_SET $resolved"
