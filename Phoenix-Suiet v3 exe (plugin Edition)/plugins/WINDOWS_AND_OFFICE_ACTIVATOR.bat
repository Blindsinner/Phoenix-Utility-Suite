@echo off
REM ================================================================
REM  Phoenix Plugin: Windows Activator Launcher
REM  Description: Launches a popular third-party activation script
REM               from the internet.
REM ================================================================

cls
echo ================================================================
echo             Phoenix Plugin: Windows Activator Launcher
echo ================================================================
echo.
echo [WARNING] This tool will download and execute a script from the
echo           internet (get.activated.win). Please ensure you trust
echo           this source before proceeding.
echo.
echo [INFO] The activation script will open in a NEW window.
echo        Please follow the instructions in that new window.
echo.
echo        Launching now...
echo.

rem This command uses PowerShell to download and execute the script.
powershell -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"

echo.
echo [SUCCESS] The activation script has been launched in a new window.
echo.
