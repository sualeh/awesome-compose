param(
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yml"

$cmd = "docker compose -f `\"$composePath`\" down"

if ($DryRun) {
  Write-Host "Dry run: $cmd"
  return
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

Push-Location $scriptDir
try {
  Write-Host "Stopping code-analysis MCP server with Docker Compose..."
  & docker compose -f $composePath down
  Write-Host "Code-analysis MCP containers stopped and removed"
}
finally {
  Pop-Location
}
