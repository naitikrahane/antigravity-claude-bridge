$env:ANTHROPIC_API_KEY = $null
$env:ANTHROPIC_BASE_URL = "http://localhost:8080"
$env:ANTHROPIC_AUTH_TOKEN = "test"
& claude.ps1 --continue $args
