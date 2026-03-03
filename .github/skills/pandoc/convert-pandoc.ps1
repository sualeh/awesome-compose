param(
  [Parameter(Mandatory = $true)][string]$InputPath,
  [Parameter(Mandatory = $true)][string]$OutputFormat,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yaml"
$repoRoot = (Resolve-Path (Join-Path $scriptDir "..\..\..")).Path
$outputDir = Join-Path $repoRoot "_working"

if (-not (Test-Path $outputDir)) {
  New-Item -ItemType Directory -Path $outputDir | Out-Null
}

try {
  $inputFull = (Resolve-Path $InputPath -ErrorAction Stop).Path
}
catch {
  Write-Error "Input file not found: $InputPath"
  exit 1
}

# For Windows we currently support inputs that live under the repo root
if (-not $inputFull.StartsWith($repoRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
  Write-Error "Input path '$inputFull' must be under repository root '$repoRoot' for this script."
  exit 1
}

$relative = $inputFull.Substring($repoRoot.Length).TrimStart([char[]]"\\/")
$inputContainer = "/workspace/$relative" -replace '\\','/'

$stem = [System.IO.Path]::GetFileNameWithoutExtension($inputFull)
$outputHost = Join-Path $outputDir ("$stem.$OutputFormat")
$outputContainer = "/workspace/_working/$stem.$OutputFormat"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

Push-Location $scriptDir
try {
  $cmd = "docker compose -f `"$composePath`" run --rm pandoc `"$inputContainer`" -o `"$outputContainer`""

  if ($DryRun) {
    Write-Host "Dry run: $cmd"
    return
  }

  Write-Host "Converting '$inputFull' to format '$OutputFormat'..."
  & docker compose -f $composePath run --rm pandoc $inputContainer -o $outputContainer
  Write-Host "Conversion complete. Output written to: $outputHost"
}
finally {
  Pop-Location
}
