@echo off
REM ================================================================
REM  Phoenix Plugin: Install Sysinternals Suite
REM ================================================================

cls
echo ================================================================
echo           Phoenix Plugin: Install Sysinternals Suite
echo ================================================================
echo.
echo [INFO] This will install Microsoft's Sysinternals Suite using winget.
echo        Please accept any UAC prompts that appear.
echo.
echo        Executing now...
echo.

winget install Microsoft.Sysinternals -s winget

echo.
echo ================================================================
echo      Sysinternals Suite installation process is complete.
echo ================================================================
echo.