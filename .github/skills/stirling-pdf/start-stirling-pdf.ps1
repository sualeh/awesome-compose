param(
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yaml"

$pullCmd = "docker compose -f `"$composePath`" pull"
$upCmd = "docker compose -f `"$composePath`" up -d"

if ($DryRun) {
  Write-Host "Dry run: $pullCmd"
  Write-Host "Dry run: $upCmd"
  return
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

Push-Location $scriptDir
try {
  Write-Host "Pulling latest Stirling PDF image with Docker Compose..."
  & docker compose -f $composePath pull
  Write-Host "Starting Stirling PDF with Docker Compose..."
  & docker compose -f $composePath up -d
  Write-Host "Stirling PDF should be reachable at http://localhost:8080"
}
finally {
  Pop-Location
}
