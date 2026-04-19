param(
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yaml"
$envPath = Join-Path $scriptDir ".env"

if (-not (Test-Path -Path $envPath -PathType Leaf)) {
  Write-Error ".env file is required at: $envPath"
}

$projectPathFromEnv = $null
foreach ($line in Get-Content -Path $envPath) {
  $trimmed = $line.Trim()
  if ($trimmed.Length -eq 0 -or $trimmed.StartsWith("#")) {
    continue
  }

  if ($trimmed -match '^SERENA_PROJECT_PATH\s*=\s*(.*)$') {
    $projectPathFromEnv = $Matches[1].Trim()
    break
  }
}

if ([string]::IsNullOrWhiteSpace($projectPathFromEnv)) {
  Write-Error "SERENA_PROJECT_PATH must be set in $envPath"
}

if (
  ($projectPathFromEnv.StartsWith('"') -and $projectPathFromEnv.EndsWith('"')) -or
  ($projectPathFromEnv.StartsWith("'") -and $projectPathFromEnv.EndsWith("'"))
) {
  $projectPathFromEnv = $projectPathFromEnv.Substring(1, $projectPathFromEnv.Length - 2)
}

if (-not (Test-Path -Path $projectPathFromEnv -PathType Container)) {
  Write-Error "Project path from .env does not exist or is not a directory: $projectPathFromEnv"
}

$resolvedProjectPath = (Resolve-Path -Path $projectPathFromEnv).Path

$pullCmd = "docker compose -f `"$composePath`" pull"
$upCmd = "docker compose -f `"$composePath`" up -d"

if ($DryRun) {
  Write-Host "Dry run with SERENA_PROJECT_PATH=`"$resolvedProjectPath`""
  Write-Host "Dry run: $pullCmd"
  Write-Host "Dry run: $upCmd"
  return
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

Push-Location $scriptDir
try {
  Write-Host "Pulling latest Serena image with Docker Compose..."
  & docker compose -f $composePath pull
  Write-Host "Starting Serena MCP server with Docker Compose..."
  & docker compose -f $composePath up -d
  Write-Host "Activated project path: $resolvedProjectPath"
  Write-Host "Serena MCP should be reachable at http://localhost:9121"
}
finally {
  Pop-Location
}
