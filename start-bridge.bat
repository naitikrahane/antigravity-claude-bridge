@echo off
setlocal
echo ========================================================
echo   Antigravity (Gemini) - Claude Code Bridge Launcher
echo ========================================================
echo.

if "%GEMINI_API_KEY%"=="" (
    echo [!] GEMINI_API_KEY environment variable is not set.
    set /p USER_KEY="Please enter your Google Gemini API Key (or press enter if set in .env): "
    if not "%USER_KEY%"=="" set GEMINI_API_KEY=%USER_KEY%
)

if "%GEMINI_API_KEY%"=="" (
    echo [ERROR] No GEMINI_API_KEY provided. Please set your key from https://aistudio.google.com/apikey
    pause
    exit /b 1
)

echo Starting LiteLLM Bridge on port 4000...
echo Routing Claude requests to Google Gemini 2.5 Pro / Flash.
echo Press Ctrl+C in this window to stop the bridge.
echo.

python -m litellm --config "%~dp0litellm_config.yaml" --port 4000
