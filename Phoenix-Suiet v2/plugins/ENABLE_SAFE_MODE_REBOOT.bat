@echo off
REM ================================================================
REM  Phoenix Plugin: Enable Safe Mode (Next Reboot)
REM ================================================================

cls
echo ================================================================
echo           Phoenix Plugin: Enable Safe Mode (Next Reboot)
echo ================================================================
echo.
echo [EXTREME WARNING] This will configure your PC to automatically
echo                   boot into Safe Mode with Networking after the
echo                   next restart.
echo.
echo [IMPORTANT] To boot normally again, you MUST run the
echo             'Disable Safe Mode' plugin before you restart.
echo.
set /p "confirm=Are you sure you want to enable Safe Mode on next boot? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo.
    echo Operation cancelled by user.
    goto :eof
)

echo.
echo [*] Setting Safe Boot option...
bcdedit /set {default} safeboot network
echo.
echo [SUCCESS] Your PC will boot into Safe Mode with Networking
echo           the next time it restarts.
echo.