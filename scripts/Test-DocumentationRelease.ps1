[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$pendingJson = & (Join-Path $PSScriptRoot 'Get-PendingDocumentationRequests.ps1') -AsJson
if ($pendingJson -and $pendingJson -ne 'FSE_DOCS_NO_PENDING_READY_REQUESTS') {
    $pending = @($pendingJson | ConvertFrom-Json)
    if ($pending.Count -gt 0) { throw "Pending ready documentation requests remain: $($pending.id -join ', ')" }
}
& (Join-Path $PSScriptRoot 'check-docs.ps1')
if ($LASTEXITCODE -ne 0) { throw 'Documentation check failed.' }
Write-Output 'FSE_DOCUMENTATION_RELEASE_READY'
