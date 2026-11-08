@echo off
setlocal
set ANTHROPIC_API_KEY=
set ANTHROPIC_BASE_URL=http://localhost:8080
set ANTHROPIC_AUTH_TOKEN=test
set ANTHROPIC_MODEL=gemini-3.8-flash-medium
set ANTHROPIC_DEFAULT_SONNET_MODEL=gemini-3.8-flash-medium
set ANTHROPIC_DEFAULT_OPUS_MODEL=gemini-3.8-flash-high
set ANTHROPIC_DEFAULT_HAIKU_MODEL=gemini-3.5-flash-lite
set CLAUDE_CODE_SUBAGENT_MODEL=gemini-3.5-flash-lite
claude %*
