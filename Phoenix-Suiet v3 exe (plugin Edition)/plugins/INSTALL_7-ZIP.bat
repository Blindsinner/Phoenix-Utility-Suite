@echo off
REM ================================================================
REM  Phoenix Plugin: Install 7-Zip
REM ================================================================

cls
echo ================================================================
echo                Phoenix Plugin: Install 7-Zip
echo ================================================================
echo.
echo [INFO] This will install the 7-Zip file archiver using winget.
echo        Please accept any UAC prompts that appear.
echo.
echo        Executing now...
echo.

winget install 7zip.7zip -s winget

echo.
echo ================================================================
echo      7-Zip installation process is complete.
echo ================================================================
echo.