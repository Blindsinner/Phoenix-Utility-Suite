@echo off
REM ================================================================
REM  Phoenix Plugin: Disable Safe Mode (Normal Boot)
REM ================================================================

cls
echo ================================================================
echo           Phoenix Plugin: Disable Safe Mode
echo ================================================================
echo.
echo [INFO] This will remove the Safe Mode flag, causing your PC
echo        to boot normally on the next restart.
echo.
echo [*] Removing Safe Boot option...
bcdedit /deletevalue {default} safeboot
echo.
echo [SUCCESS] Your PC will now boot normally.
echo.