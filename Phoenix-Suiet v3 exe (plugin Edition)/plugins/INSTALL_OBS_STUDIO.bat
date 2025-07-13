@echo off
REM ================================================================
REM  Phoenix Plugin: Install OBS Studio
REM ================================================================

cls
echo ================================================================
echo               Phoenix Plugin: Install OBS Studio
echo ================================================================
echo.
echo [INFO] This will install OBS Studio using winget.
echo        Please accept any UAC prompts that appear.
echo.
echo        Executing now...
echo.

winget install OBSProject.OBSStudio -s winget

echo.
echo ================================================================
echo      OBS Studio installation process is complete.
echo ================================================================
echo.