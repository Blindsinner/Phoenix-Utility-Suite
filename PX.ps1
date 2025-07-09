# Phoenix Utility Suite - Robust Downloader
# Developed by MD Faysal Mahmud
# This version uses a more reliable waiting process to prevent crashes when launching graphical tools.

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# The direct URL to your raw batch file on GitHub.
$DownloadURL = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/main/PX.cmd'
$DownloadURL2 = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/main/PX.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\PX_$rand.cmd" } else { "$env:TEMP\PX_$rand.cmd" }

try {
    # Attempt to download the script content from the primary URL.
    try {
        $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
    }
    catch {
        # If the primary URL fails, try the fallback URL.
        $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
    }

    $ScriptArgs = "$args "
    $prefix = "@REM $rand `r`n"
    $content = $prefix + $response.Content
    Set-Content -Path $FilePath -Value $content

    # Start the process and get the process object itself. This is the key change.
    $process = Start-Process -FilePath $FilePath -ArgumentList $ScriptArgs -Verb RunAs -PassThru
    
    # Use the more reliable WaitForExit() method to ensure the script waits correctly.
    # This will not get confused by graphical sub-programs like Disk Cleanup.
    if ($process) {
        $process.WaitForExit()
    }

}
catch {
    # If any part of the 'try' block fails, display the error.
    Write-Error "A critical error occurred during download or execution: $_"
    pause
}
finally {
    # --- Cleanup ---
    # This block runs regardless of whether the script succeeded or failed.
    $FilePaths = @("$env:TEMP\PX_*.cmd", "$env:SystemRoot\Temp\PX_*.cmd")
    foreach ($Path in $FilePaths) { 
        $matchingFiles = Get-Item $Path -ErrorAction SilentlyContinue
        if ($null -ne $matchingFiles) {
            $matchingFiles | Remove-Item -Force
        }
    }
}
