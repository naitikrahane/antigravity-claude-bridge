@echo off
setlocal enabledelayedexpansion
title Antigravity Claude Bridge - 1-Click Setup

echo ====================================================================
echo      ANTIGRAVITY CLAUDE BRIDGE - AUTOMATED 1-CLICK INSTALLER
echo ====================================================================
echo.
echo This installer sets up Claude Code with Google Antigravity models,
echo supporting multiple Google accounts, automatic failover, and full
echo model discovery (Gemini 3.8 / 3.5 + Claude Sonnet/Opus).
echo.

:: 1. Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed!
    echo Please download and install Node.js (v20 or newer) from:
    echo https://nodejs.org/
    echo.
    pause
    exit /b 1
)
echo [1/5] Node.js is detected.

:: 2. Install Claude Code & Antigravity Proxy globally
echo [2/5] Installing Claude Code and Antigravity Proxy globally...
call npm install -g @anthropic-ai/claude-code antigravity-claude-proxy
if %errorlevel% neq 0 (
    echo [WARN] npm install encountered an issue, retrying with force...
    call npm install -g @anthropic-ai/claude-code antigravity-claude-proxy --force
)

:: 3. Configure Claude Code settings (~/.claude/settings.json)
echo [3/5] Configuring Claude Code settings with Model Gateway Discovery...
set "CLAUDE_DIR=%USERPROFILE%\.claude"
if not exist "%CLAUDE_DIR%" mkdir "%CLAUDE_DIR%"

set "SETTINGS_FILE=%CLAUDE_DIR%\settings.json"
(
echo {
echo   "autoUpdates": false,
echo   "env": {
echo     "ANTHROPIC_BASE_URL": "http://localhost:8080",
echo     "ANTHROPIC_AUTH_TOKEN": "test",
echo     "CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY": "1",
echo     "DISABLE_AUTOUPDATER": "1",
echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-6",
echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-6-thinking",
echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "gemini-3.8-flash-medium",
echo     "CLAUDE_CODE_SUBAGENT_MODEL": "gemini-3.5-flash-lite"
echo   }
echo }
) > "%SETTINGS_FILE%"

:: 4. Install Global Helper Launchers (claude-agy & claude-gemini)
echo [4/5] Setting up global CLI commands (claude-agy and claude-gemini)...
for /f "delims=" %%i in ('npm root -g') do set "NPM_GLOBAL_PATH=%%~dpi"
if not "%NPM_GLOBAL_PATH%"=="" (
    copy /y "%~dp0bin\claude-agy.cmd" "%NPM_GLOBAL_PATH%" >nul 2>nul
    copy /y "%~dp0bin\claude-agy.ps1" "%NPM_GLOBAL_PATH%" >nul 2>nul
    copy /y "%~dp0bin\claude-gemini.cmd" "%NPM_GLOBAL_PATH%" >nul 2>nul
    copy /y "%~dp0bin\claude-gemini.ps1" "%NPM_GLOBAL_PATH%" >nul 2>nul
)

:: 5. Account Authentication Check
echo [5/5] Checking Google account connection...
call acc accounts list 2>nul | findstr /i "@" >nul
if %errorlevel% neq 0 (
    echo.
    echo --------------------------------------------------------------------
    echo Action Required: Link your Google Account
    echo A browser window will now open for Google Sign-In.
    echo Please sign in with your Google Account used for Antigravity.
    echo (You can run 'acc accounts add' later to link multiple accounts)
    echo --------------------------------------------------------------------
    echo.
    call acc accounts add
) else (
    echo Google account is already linked!
)

:: 6. Start Proxy with Hybrid Strategy (Auto-rotation & fallback)
echo.
echo Starting Antigravity Proxy with multi-account failover...
call acc start --strategy=hybrid --fallback

echo.
echo ====================================================================
echo                    SETUP COMPLETED SUCCESSFULLY!
echo ====================================================================
echo.
echo You can now run Claude Code from ANY terminal:
echo.
echo   claude-agy      -^> Claude Sonnet 4.6 (Antigravity)
echo   claude-gemini   -^> Gemini 3.8 Flash (Antigravity)
echo   claude          -^> Claude Code CLI with full model discovery
echo.
echo Multi-Account Tips:
echo   Run 'acc accounts add' to add 2nd/3rd Google accounts for quota balancing.
echo   Proxy dashboard is available at: http://localhost:8080/
echo.
set /p LAUNCH_NOW="Would you like to start Claude Code right now? (Y/N): "
if /i "%LAUNCH_NOW%"=="Y" (
    call claude-agy
)
