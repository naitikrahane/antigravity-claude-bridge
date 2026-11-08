# Antigravity (Gemini) -> Claude Code Bridge Launcher (PowerShell)
param (
    [string]$ApiKey = $env:GEMINI_API_KEY
)

if (-not $ApiKey) {
    $ApiKey = Read-Host "Enter your Google Gemini API Key (from https://aistudio.google.com/apikey)"
}

if (-not $ApiKey) {
    Write-Error "No GEMINI_API_KEY provided. Aborting."
    return
}

$env:GEMINI_API_KEY = $ApiKey
$configPath = Join-Path $PSScriptRoot "litellm_config.yaml"

Write-Host "Starting LiteLLM Bridge on port 4000..." -ForegroundColor Cyan
Write-Host "Bridge active! Open a new terminal and run: .\run-claude-with-bridge.bat (or ccr code)" -ForegroundColor Green

python -m litellm --config $configPath --port 4000
