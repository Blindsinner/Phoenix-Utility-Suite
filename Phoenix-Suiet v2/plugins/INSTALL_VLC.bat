@echo off
REM ================================================================
REM  Phoenix Plugin: Install VLC Media Player
REM ================================================================

cls
echo ================================================================
echo            Phoenix Plugin: Install VLC Media Player
echo ================================================================
echo.
echo [INFO] This will install VLC Media Player using winget.
echo        Please accept any UAC prompts that appear.
echo.
echo        Executing now...
echo.

winget install VideoLAN.VLC -s winget

echo.
echo ================================================================
echo      VLC installation process is complete.
echo ================================================================
echo.