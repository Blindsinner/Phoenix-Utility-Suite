@echo off
REM ================================================================
REM  Phoenix Plugin: Network Connectivity Test
REM  Description: Pings common servers and shows your public IP.
REM ================================================================

cls
echo ================================================================
echo              Phoenix Plugin: Network Connectivity Test
echo ================================================================
echo.

echo [INFO] Pinging Google DNS (8.8.8.8)...
echo ----------------------------------------------------------------
ping 8.8.8.8 -n 2
echo.

echo [INFO] Pinging Cloudflare DNS (1.1.1.1)...
echo ----------------------------------------------------------------
ping 1.1.1.1 -n 2
echo.

echo [INFO] Fetching your Public IP Address...
echo ----------------------------------------------------------------
powershell -NoProfile -Command "(Invoke-WebRequest -Uri 'https://ifconfig.me/ip').Content"
echo.

echo.
echo [SUCCESS] Network connectivity test complete.
echo.
