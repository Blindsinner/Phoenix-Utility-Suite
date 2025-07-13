@echo off
setlocal ENABLEDELAYEDEXPANSION
REM ================================================================
REM  Phoenix Plugin: Live Network Connections
REM  Description: Shows which applications are connected to which
REM               IP addresses in real-time.
REM  v2.0 - Added robust error handling and safer output.
REM ================================================================

cls
echo ================================================================
echo               Phoenix Plugin: Live Network Connections
echo ================================================================
echo.
echo [INFO] This may take a moment to gather all connections...
echo.
echo   PROCESS NAME (PID)         FOREIGN ADDRESS
echo   --------------------         -------------------

rem The 'find /i' makes the search case-insensitive for better compatibility.
for /f "tokens=2,3,5" %%a in ('netstat -ano -p TCP ^| find /i "ESTABLISHED"') do (
    rem The '2^>nul' suppresses errors if tasklist can't find a process (e.g., system processes).
    for /f "tokens=1,2" %%x in ('tasklist /fi "pid eq %%c" /nh 2^>nul') do (
        set "proc=%%x"
        set "pid=%%y"
        set "foreign=%%b"
        
        set "proc_padded=!proc!                    "
        set "proc_padded=!proc_padded:~0,20!"
        
        rem Using "call echo" is a safer way to print variables that might contain special characters.
        set "output_line=  !proc_padded! (!pid!)   !foreign!"
        call echo %%output_line%%
    )
)

echo.
echo.
echo [SUCCESS] Live connection report complete.
echo.
