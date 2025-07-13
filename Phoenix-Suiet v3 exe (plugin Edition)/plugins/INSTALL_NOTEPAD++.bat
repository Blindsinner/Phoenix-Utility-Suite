@echo off
REM ================================================================
REM  Phoenix Plugin: Install Notepad++
REM ================================================================

cls
echo ================================================================
echo               Phoenix Plugin: Install Notepad++
echo ================================================================
echo.
echo [INFO] This will install the Notepad++ text editor using winget.
echo        Please accept any UAC prompts that appear.
echo.
echo        Executing now...
echo.

winget install Notepad++.Notepad++ -s winget

echo.
echo ================================================================
echo      Notepad++ installation process is complete.
echo ================================================================
echo.