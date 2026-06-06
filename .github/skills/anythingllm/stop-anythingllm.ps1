# Stop the stack. Preserves data in named volumes.
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

Invoke-Step @("docker", "compose", "stop")

if (-not $DryRun) {
    Write-Host "Stopped. Data preserved; run start-anythingllm.ps1 to bring it back up."
}
