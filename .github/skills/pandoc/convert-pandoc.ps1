param(
  [Parameter(Mandatory = $true)][string]$InputPath,
  [Parameter(Mandatory = $true)][string]$OutputFormat,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$composePath = Join-Path $scriptDir "compose.yaml"
$repoRoot = (Resolve-Path (Join-Path $scriptDir "..\..\..")).Path
$outputDir = Join-Path $repoRoot "output"

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
$outputContainer = "/workspace/output/$stem.$OutputFormat"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Error "docker is required but was not found in PATH"
}

Push-Location $scriptDir
try {
  $running = & docker compose -f $composePath ps -q pandoc
  if (-not $running) {
    Write-Error "Pandoc container is not running. Start it with ./start-pandoc.ps1"
    exit 1
  }

  $cmd = "docker compose -f `"$composePath`" exec -e INPUT=`"$inputContainer`" -e OUTPUT=`"$outputContainer`" pandoc sh -lc 'pandoc `"`$INPUT`" -o `"`$OUTPUT`"'"

  if ($DryRun) {
    Write-Host "Dry run: $cmd"
    return
  }

  Write-Host "Converting '$inputFull' to format '$OutputFormat'..."
  & docker compose -f $composePath exec -e INPUT=$inputContainer -e OUTPUT=$outputContainer pandoc sh -lc 'pandoc "$INPUT" -o "$OUTPUT"'
  Write-Host "Conversion complete. Output written to: $outputHost"
}
finally {
  Pop-Location
}
