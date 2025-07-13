@echo off
REM ================================================================
REM  Phoenix Plugin: List System Restore Points
REM ================================================================

cls
echo ================================================================
echo          Phoenix Plugin: List System Restore Points
echo ================================================================
echo.
echo [INFO] Listing all available shadow copies (System Restore points)...
echo.

vssadmin list shadows

echo.
echo ================================================================
echo      Finished listing restore points.
echo ================================================================
echo.
pause