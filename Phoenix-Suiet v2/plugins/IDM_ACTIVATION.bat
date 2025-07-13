@echo off
REM ================================================================
REM  Phoenix Plugin: IDM Activation Script Launcher
REM  Description: Launches a popular third-party IDM activation
REM               script from the internet.
REM ================================================================

cls
echo ================================================================
echo             Phoenix Plugin: IDM Activation Launcher
echo ================================================================
echo.
echo [WARNING] This tool will download and execute a script from the
echo           internet (is.gd/IDMFIX). Please ensure you trust
echo           this source before proceeding.
echo.
echo [INFO] The activation script will open in a NEW window.
echo        Please follow the instructions in that new window.
echo.
echo        Launching now...
echo.

rem This command uses PowerShell to download and execute the script.
powershell -ExecutionPolicy Bypass -Command "iex (irm is.gd/IDMFIX)"

echo.
echo [SUCCESS] The IDM activation script has been launched in a new window.
echo.
