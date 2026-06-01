# Pull latest images, generate .env if missing, then start the stack.
# Pass -DryRun to print commands without executing.
param([switch]$DryRun)
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

function Invoke-Step {
    param([string[]]$Cmd)
    Write-Host "+ $($Cmd -join ' ')"
    if (-not $DryRun) {
        & $Cmd[0] $Cmd[1..($Cmd.Length - 1)]
        if ($LASTEXITCODE -ne 0) { throw "Command failed (exit $LASTEXITCODE): $($Cmd -join ' ')" }
    }
}

if (-not (Test-Path .env)) {
    $bytes = New-Object byte[] 32
    [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    $jwt = [Convert]::ToBase64String($bytes)
    if ($DryRun) {
        Write-Host "+ write .env with generated JWT_SECRET"
    } else {
        "JWT_SECRET=$jwt" | Out-File -Encoding ascii -FilePath .env -Force
    }
}

Invoke-Step @("docker", "compose", "pull")
Invoke-Step @("docker", "compose", "up", "-d")

if (-not $DryRun) {
    Write-Host ""
    Write-Host "AnythingLLM UI: http://localhost:3001"
    Write-Host "Ollama API:     http://localhost:11434"
}
