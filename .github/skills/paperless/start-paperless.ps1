param(
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yaml"
$envPath = Join-Path $scriptDir "paperless.env"
$dataRoot = Join-Path $scriptDir ".paperless"

$pullCmd = "docker compose -f `"$composePath`" pull"
$upCmd = "docker compose -f `"$composePath`" up -d"

if ($DryRun) {
  Write-Host "Dry run: $pullCmd"
  Write-Host "Dry run: $upCmd"
  return
}

if (-not (Test-Path $envPath)) {
  Write-Error "paperless.env not found. Copy paperless.env.example to paperless.env and set PAPERLESS_SECRET_KEY."
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

$null = New-Item -ItemType Directory -Path $dataRoot -Force -ErrorAction SilentlyContinue
$directories = @("data", "media", "export", "consume", "paperless-ai-data") | ForEach-Object { Join-Path $dataRoot $_ }
foreach ($dir in $directories) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

Push-Location $scriptDir
try {
  Write-Host "Pulling latest Paperless-ngx images with Docker Compose..."
  & docker compose -f $composePath pull
  Write-Host "Starting Paperless-ngx stack with Docker Compose..."
  & docker compose -f $composePath up -d
  Write-Host "Paperless-ngx should be reachable at http://localhost:8000"
  Write-Host "Paperless AI should be reachable at http://localhost:3000"
}
finally {
  Pop-Location
}
