@echo off
REM ================================================================
REM  Phoenix Plugin: Check Disk Health (SMART)
REM ================================================================

cls
echo ================================================================
echo            Phoenix Plugin: Check Disk Health (SMART)
echo ================================================================
echo.
echo [INFO] Retrieving the S.M.A.R.T. health status of all drives.
echo        'OK' status is good. Any other status may indicate a problem.
echo.

wmic diskdrive get model,status

echo.
echo ================================================================
echo      Disk health check complete.
echo ================================================================
echo.
pause