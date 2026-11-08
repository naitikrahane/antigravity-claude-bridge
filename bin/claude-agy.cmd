@echo off
setlocal
set ANTHROPIC_API_KEY=
set ANTHROPIC_BASE_URL=http://localhost:8080
set ANTHROPIC_AUTH_TOKEN=test
set ANTHROPIC_MODEL=claude-sonnet-4-6
set ANTHROPIC_DEFAULT_SONNET_MODEL=claude-sonnet-4-6
set ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-6-thinking
set ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-sonnet-4-6
set CLAUDE_CODE_SUBAGENT_MODEL=claude-sonnet-4-6
claude %*
