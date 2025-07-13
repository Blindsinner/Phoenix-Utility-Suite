@echo off
REM ================================================================
REM  Phoenix Plugin: Update All Apps (via Winget)
REM  Description: Finds and installs updates for all supported apps.
REM ================================================================

cls
echo ================================================================
echo             Phoenix Plugin: Update All Apps
echo ================================================================
echo.
echo [INFO] This will attempt to update all possible applications
echo        using the Windows Package Manager (winget).
echo.
echo [WARNING] This process can take a very long time depending on
echo           how many applications need updates.
echo.
echo        Executing command now... Please be patient.
echo.

winget upgrade --all --accept-package-agreements --accept-source-agreements

echo.
echo ================================================================
echo      Update process complete.
echo ================================================================
echo.
pause