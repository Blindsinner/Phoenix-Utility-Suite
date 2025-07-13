@echo off
REM ================================================================
REM  Phoenix Plugin: Generate Battery Health Report
REM ================================================================

cls
echo ================================================================
echo         Phoenix Plugin: Generate Battery Health Report
echo ================================================================
echo.
echo [INFO] Generating a detailed battery health report...
echo.

powercfg /batteryreport /output "%USERPROFILE%\Desktop\battery_report.html"

echo [SUCCESS] Report saved to your Desktop as 'battery_report.html'.
echo.