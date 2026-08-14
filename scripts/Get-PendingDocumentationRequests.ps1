[CmdletBinding()]
param(
    [string]$UnityProjectRoot,
    [switch]$AsJson
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
if (-not $UnityProjectRoot) { $UnityProjectRoot = $env:FSE_UNITY_PROJECT_ROOT }
if (-not $UnityProjectRoot) {
    $settingsPath = Join-Path $repoRoot '.fse-docs-local.json'
    if (Test-Path -LiteralPath $settingsPath) {
        $UnityProjectRoot = (Get-Content -LiteralPath $settingsPath -Raw | ConvertFrom-Json).unity_project_root
    }
}
if (-not $UnityProjectRoot) {
    throw 'Set the Unity project with Set-DocsProjectRoot.ps1 or FSE_UNITY_PROJECT_ROOT.'
}
$UnityProjectRoot = (Resolve-Path -LiteralPath $UnityProjectRoot).Path
$requestRoot = Join-Path $UnityProjectRoot 'coordination\requests\documentation'
if (-not (Test-Path -LiteralPath $requestRoot)) { throw "Request root not found: $requestRoot" }

$ledgerPath = Join-Path $repoRoot 'coordination\applied-requests.yml'
$ledger = if (Test-Path -LiteralPath $ledgerPath) { Get-Content -LiteralPath $ledgerPath -Raw } else { '' }
$appliedIds = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
[regex]::Matches($ledger, '(?m)^\s{2}([A-Za-z0-9._-]+):\s*$') | ForEach-Object {
    [void]$appliedIds.Add($_.Groups[1].Value)
}

$pending = @()
Get-ChildItem -LiteralPath $requestRoot -Recurse -Filter '*.json' -File | Sort-Object FullName | ForEach-Object {
    $request = Get-Content -LiteralPath $_.FullName -Raw | ConvertFrom-Json
    foreach ($required in @('schema_version', 'id', 'product', 'task_id', 'status', 'summary', 'evidence')) {
        if ($null -eq $request.$required) { throw "Invalid request '$($_.FullName)': missing '$required'." }
    }
    if ($request.status -eq 'ready' -and -not $appliedIds.Contains([string]$request.id)) {
        $sourceCommit = (& git -C $UnityProjectRoot log -1 --format=%H -- $_.FullName).Trim()
        $pending += [pscustomobject]@{
            id = [string]$request.id
            product = [string]$request.product
            task_id = [string]$request.task_id
            source_commit = $sourceCommit
            path = $_.FullName
            summary = [string]$request.summary
        }
    }
}
if ($AsJson) { $pending | ConvertTo-Json -Depth 5 } else { $pending | Format-Table -AutoSize }
if ($pending.Count -eq 0) { Write-Output 'FSE_DOCS_NO_PENDING_READY_REQUESTS' }
