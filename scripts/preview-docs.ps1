[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$checkScript = Join-Path $PSScriptRoot 'check-docs.ps1'
$venvPython = Join-Path $repositoryRoot '.venv-docs\Scripts\python.exe'
$previewAddress = '127.0.0.1'
$previewPort = 8000

if (-not (Test-Path -LiteralPath $checkScript -PathType Leaf)) {
    throw "The documentation environment script was not found: $checkScript"
}

& $checkScript -EnvironmentOnly

$listener = [System.Net.Sockets.TcpListener]::new(
    [System.Net.IPAddress]::Parse($previewAddress),
    $previewPort
)
try {
    $listener.Start()
}
catch {
    throw "The local preview cannot start because http://${previewAddress}:${previewPort}/ is already in use. Stop the existing process and try again."
}
finally {
    $listener.Stop()
}

Write-Host "Starting the local documentation preview at http://${previewAddress}:${previewPort}/"
Write-Host 'Press Ctrl+C in this terminal to stop the preview server.'

Push-Location $repositoryRoot
try {
    & $venvPython -m mkdocs serve --strict --clean --open --dev-addr "${previewAddress}:${previewPort}"
    if ($LASTEXITCODE -ne 0) { throw "MkDocs preview failed with exit code $LASTEXITCODE." }
}
finally { Pop-Location }
