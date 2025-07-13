@echo off
REM ================================================================
REM  Phoenix Plugin: Chris Titus Tech Windows Utility Launcher
REM  Description: Launches the popular CTT Windows Utility script
REM               from christitus.com.
REM ================================================================

cls
echo ================================================================
echo      Phoenix Plugin: Chris Titus Tech Windows Utility
echo ================================================================
echo.
echo [WARNING] This tool will download and execute a script from the
echo           internet (christitus.com). Please ensure you trust
echo           this source before proceeding.
echo.
echo [INFO] The utility will open in a NEW window.
echo        Please follow the instructions in that new window.
echo.
echo        Launching now...
echo.

rem This command uses PowerShell to download and execute the script.
powershell -ExecutionPolicy Bypass -Command "irm 'https://christitus.com/win' | iex"

echo.
echo [SUCCESS] The Chris Titus Tech utility script has been launched.
echo.