param(
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yaml"

$cmd = "docker compose -f `"$composePath`" up -d"

if ($DryRun) {
  Write-Host "Dry run: $cmd"
  return
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

Push-Location $scriptDir
try {
  Write-Host "Starting Vert with Docker Compose..."
  & docker compose -f $composePath up -d
  Write-Host "Vert should be reachable at http://localhost:8080"
}
finally {
  Pop-Location
}
