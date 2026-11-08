# Run Claude Code connected to Antigravity / Gemini Bridge
$env:ANTHROPIC_BASE_URL = "http://localhost:4000"
$env:ANTHROPIC_API_KEY = "dummy-antigravity-key"

Write-Host "Connecting Claude Code to Antigravity Bridge at http://localhost:4000..." -ForegroundColor Green
claude $args
