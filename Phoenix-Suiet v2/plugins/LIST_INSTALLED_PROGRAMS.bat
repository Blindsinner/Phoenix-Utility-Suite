@echo off
REM ================================================================
REM  Phoenix Plugin: List All Installed Programs
REM ================================================================

cls
echo ================================================================
echo            Phoenix Plugin: List Installed Programs
echo ================================================================
echo.
echo [INFO] Generating a list of installed software.
echo [WARNING] This process can be very slow. Please be patient...
echo.

wmic product get name,version

echo.
echo ================================================================
echo      List generation complete.
echo ================================================================
echo.
pause