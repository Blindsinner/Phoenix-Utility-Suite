@echo off
REM ================================================================
REM  Phoenix Plugin: AutoHotkey v2 Installer
REM  Description: Downloads and runs the latest AHK v2 installer
REM               from the official website.
REM ================================================================

cls
echo ================================================================
echo             Phoenix Plugin: AutoHotkey v2 Installer
echo ================================================================
echo.
echo [INFO] This script will download the official installer to your
echo        Downloads folder, run it, and then delete the file.
echo.
echo [INFO] You will need to click through the installer's prompts
echo        and accept any UAC confirmation that appears.
echo.

echo [*] Downloading AutoHotkey installer...
powershell -Command "Invoke-WebRequest -Uri 'https://www.autohotkey.com/download/ahk-v2.exe' -OutFile '%USERPROFILE%\Downloads\ahk-v2-setup.exe'"

IF EXIST "%USERPROFILE%\Downloads\ahk-v2-setup.exe" (
    echo [SUCCESS] Download complete.
    echo.
    echo [*] Launching the installer... Please follow the setup prompts.
    start "" /wait "%USERPROFILE%\Downloads\ahk-v2-setup.exe"
    echo [SUCCESS] Installer has been closed.
    echo.
    echo [*] Cleaning up downloaded file...
    del "%USERPROFILE%\Downloads\ahk-v2-setup.exe"
    echo [SUCCESS] Cleanup complete.
) ELSE (
    echo [ERROR] Download failed. Could not find the installer file.
)

echo.
echo ================================================================
echo      The AutoHotkey installation process is complete.
echo ================================================================
echo.