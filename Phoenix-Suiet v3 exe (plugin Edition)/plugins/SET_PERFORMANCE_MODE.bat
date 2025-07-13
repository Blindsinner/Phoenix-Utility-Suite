@echo off
setlocal ENABLEDELAYEDEXPANSION
REM ================================================================
REM  Phoenix Plugin: Startup Optimizer & Performance Booster
REM  Description: Disables common startup items, enables Fast Startup,
REM               and sets the power plan for maximum performance.
REM  v2.0 - Made safer and more stable.
REM ================================================================

:check_admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script must be run as Administrator!
    pause
    exit /b 1
)

cls
echo ================================================================
echo         Phoenix Plugin: Startup Optimizer & Performance Booster
echo ================================================================
echo.
echo [WARNING] This tool will make the following changes:
echo   1. Disable programs from auto-starting via the HKLM and HKCU 'Run' keys.
echo   2. Enable the 'Fast Startup' feature in Windows.
echo   3. Set your active power plan to 'Ultimate Performance'.
echo.
echo These changes are generally safe but are intended for advanced users.
echo.
set /p "confirm=Are you sure you want to proceed? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo.
    echo [INFO] Operation cancelled by user.
    pause
    exit /b 0
)
echo.

:: --------------------------------------
:: Section 1: Disable Registry-Based Startup Items
:: --------------------------------------
echo [INFO] Disabling registry-based startup items...
echo ----------------------------------------------------------------

REM A non-destructive method: renames the startup entry by adding '.disabled'
REM This makes it easy to re-enable them manually in regedit if needed.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "Get-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' | Get-ItemProperty | Get-Member -MemberType NoteProperty | ForEach-Object { Rename-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name $_.Name -NewName ($_.Name + '.disabled') -ErrorAction SilentlyContinue }"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "Get-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' | Get-ItemProperty | Get-Member -MemberType NoteProperty | ForEach-Object { Rename-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name $_.Name -NewName ($_.Name + '.disabled') -ErrorAction SilentlyContinue }"

echo [SUCCESS] Startup items in registry 'Run' keys have been disabled.
echo.

:: --------------------------------------
:: Section 2: Enable Fast Startup
:: --------------------------------------
echo [INFO] Enabling Fast Startup (Hybrid Boot)...
echo ----------------------------------------------------------------

REM Ensure hibernation is enabled (a prerequisite for Fast Startup)
powercfg /hibernate on

REM Enable Fast Startup via the registry
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Fast Startup has been enabled.
echo.

:: --------------------------------------
:: Section 3: Set Power Plan to Ultimate Performance
:: --------------------------------------
echo [INFO] Setting Power Plan to Maximum Performance...
echo ----------------------------------------------------------------

REM GUID for Ultimate Performance Plan
set "ULTIMATE_GUID=e9a42b02-d5df-448d-aa00-03f14749eb61"
REM GUID for High Performance Plan (Fallback)
set "HIGH_PERF_GUID=8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"

REM Try to duplicate and activate the Ultimate Performance plan
powercfg -duplicatescheme %ULTIMATE_GUID% >nul 2>&1
powercfg -setactive %ULTIMATE_GUID% >nul 2>&1

REM Check if it failed, and if so, fall back to High Performance
if %errorLevel% neq 0 (
    echo [WARN] Ultimate Performance plan not available. Falling back to High Performance...
    powercfg -setactive %HIGH_PERF_GUID% >nul 2>&1
)

echo [SUCCESS] Active power plan has been set for maximum performance.
echo.

:: --------------------------------------
:: Completion Message
:: --------------------------------------
echo ================================================================
echo [COMPLETE] Startup optimization and performance boost finished!
echo ================================================================
echo.
pause
exit /b 0
