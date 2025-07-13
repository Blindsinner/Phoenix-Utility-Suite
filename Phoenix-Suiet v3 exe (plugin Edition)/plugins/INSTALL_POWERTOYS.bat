@echo off
REM ================================================================
REM  Phoenix Plugin: Microsoft PowerToys Installer
REM  Description: Uses the winget package manager to install the
REM               latest version of Microsoft PowerToys.
REM ================================================================

cls
echo ================================================================
echo           Phoenix Plugin: Microsoft PowerToys Installer
echo ================================================================
echo.
echo [INFO] This script will use the Windows Package Manager (winget)
echo        to download and install Microsoft PowerToys.
echo.
echo [INFO] A User Account Control (UAC) prompt may appear during
echo        installation. Please accept it to proceed.
echo.
echo        Executing command now...
echo.

rem This command uses winget to find and install the package.
winget install Microsoft.PowerToys --source winget --accept-package-agreements --accept-source-agreements

echo.
echo [SUCCESS] The PowerToys installation process has been completed.
echo.