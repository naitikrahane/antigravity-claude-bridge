@echo off
setlocal
echo =============================================================
echo   Antigravity Claude Proxy (WITHOUT API KEY)
echo =============================================================
echo.
echo Checking account status...
call acc accounts list
echo.
echo 1. Link Google Account (Browser Sign-in, No Key needed)
echo 2. Start Proxy Background Service (with Multi-Account Rotation)
echo 3. Open Proxy Web Dashboard
echo 4. Launch Claude Code (Claude Sonnet 4.6)
echo 5. Launch Claude Code (Gemini 3.8 Flash)
echo 6. Stop Proxy
echo.
set /p CHOICE="Enter choice (1-6): "

if "%CHOICE%"=="1" (
    echo Opening browser to link Google account...
    acc accounts add
    pause
    goto end
)
if "%CHOICE%"=="2" (
    acc start --strategy=hybrid --fallback
    pause
    goto end
)
if "%CHOICE%"=="3" (
    acc ui
    goto end
)
if "%CHOICE%"=="4" (
    call claude-agy
    goto end
)
if "%CHOICE%"=="5" (
    call claude-gemini
    goto end
)
if "%CHOICE%"=="6" (
    acc stop
    pause
    goto end
)

:end
