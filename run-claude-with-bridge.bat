@echo off
setlocal
echo Starting Claude Code connected to Antigravity/Gemini Bridge...

set ANTHROPIC_BASE_URL=http://localhost:4000
set ANTHROPIC_API_KEY=dummy-antigravity-key

claude %*
