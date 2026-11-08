@echo off
setlocal
set ANTHROPIC_API_KEY=
set ANTHROPIC_BASE_URL=http://localhost:8080
set ANTHROPIC_AUTH_TOKEN=test
claude --continue %*
