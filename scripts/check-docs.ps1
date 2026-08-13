[CmdletBinding()]
param(
    [switch]$EnvironmentOnly
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$requirementsPath = Join-Path $repositoryRoot 'requirements-docs.txt'
$venvPath = Join-Path $repositoryRoot '.venv-docs'
$venvPython = Join-Path $venvPath 'Scripts\python.exe'
$requiredMaterialVersion = '9.7.7'

function Resolve-Python312 {
    $candidates = @(
        [pscustomobject]@{ Command = 'py'; Arguments = @('-3.12') },
        [pscustomobject]@{ Command = 'python'; Arguments = @() }
    )

    foreach ($candidate in $candidates) {
        $command = Get-Command $candidate.Command -ErrorAction SilentlyContinue
        if (-not $command) { continue }
        $version = & $command.Source @($candidate.Arguments) -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")' 2>$null
        if ($LASTEXITCODE -eq 0 -and $version -eq '3.12') {
            return [pscustomobject]@{ Path = $command.Source; Arguments = @($candidate.Arguments) }
        }
    }
    throw 'Python 3.12 was not found. Install Python 3.12 and run this script again.'
}

function Ensure-DocumentationEnvironment {
    if (-not (Test-Path -LiteralPath $requirementsPath -PathType Leaf)) {
        throw "Documentation requirements file was not found: $requirementsPath"
    }
    if (-not (Test-Path -LiteralPath $venvPython -PathType Leaf)) {
        $python = Resolve-Python312
        Write-Host "Creating the documentation virtual environment at $venvPath"
        & $python.Path @($python.Arguments) -m venv $venvPath
        if ($LASTEXITCODE -ne 0) { throw 'Failed to create the documentation virtual environment.' }
    }
    $venvVersion = & $venvPython -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")'
    if ($LASTEXITCODE -ne 0 -or $venvVersion -ne '3.12') {
        throw "The existing .venv-docs environment uses Python $venvVersion. Remove it and rerun this script with Python 3.12 available."
    }
    $installedMaterialVersion = & $venvPython -c "import importlib.metadata as m; print(m.version('mkdocs-material'))" 2>$null
    if ($LASTEXITCODE -ne 0 -or $installedMaterialVersion -ne $requiredMaterialVersion) {
        Write-Host 'Installing the pinned documentation dependencies.'
        & $venvPython -m pip install --requirement $requirementsPath
        if ($LASTEXITCODE -ne 0) { throw 'Failed to install the documentation dependencies.' }
    }
    return $venvPython
}

$pythonPath = Ensure-DocumentationEnvironment
if ($EnvironmentOnly) { return }

Push-Location $repositoryRoot
try {
    & $pythonPath -m mkdocs build --strict --clean
    if ($LASTEXITCODE -ne 0) { throw "MkDocs strict build failed with exit code $LASTEXITCODE." }
}
finally { Pop-Location }
