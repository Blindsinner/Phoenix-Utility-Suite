<#
.SYNOPSIS
    Downloads and executes the Phoenix Utility Suite batch script from GitHub.

.DESCRIPTION
    This PowerShell script securely downloads the latest version of the
    Phoenix Utility Suite (PX.cmd) from the official GitHub repository.
    It handles temporary file placement based on administrative rights,
    executes the batch script, and cleans up automatically upon completion.

.NOTES
    Author: MD FAYSAL MAHMUD
    For best results with the underlying Phoenix Utility Suite,
    run this PowerShell script with administrative privileges
    (Right-click -> "Run with PowerShell").
#>

# Stop the script immediately if any command fails.
$ErrorActionPreference = "Stop"

# Ensure modern security protocols (TLS 1.2) are enabled for the web request.
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# The direct URL to your raw batch file on GitHub.
$DownloadURL = 'https://raw.githubusercontent.com/Blindsinner/Phoenix-Utility-Suite/refs/heads/main/PX.cmd'

Write-Host "Preparing to download the Phoenix Utility Suite..."

# --- Temporary File Setup ---
# Generate a random number to ensure the temporary filename is unique.
$rand = Get-Random -Maximum 99999999

# Check if the script is running with Administrator privileges.
$isAdmin = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups.Exists({$_.Value -eq 'S-1-5-32-544'})

# Define the temporary file path. Use the system's Temp folder if admin, otherwise use the user's.
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\PX_$rand.cmd" } else { "$env:TEMP\PX_$rand.cmd" }
Write-Host "Temporary file will be created at: $FilePath"

# --- Download and Execution ---
try {
    # Download the script content from the URL.
    Write-Host "Downloading from: $DownloadURL"
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
    
    # Add a unique REM line at the beginning of the script content.
    $prefix = "@REM $rand `r`n"
    $content = $prefix + $response.Content
    
    # Save the downloaded content to the temporary file.
    Set-Content -Path $FilePath -Value $content -Encoding Ascii
    Write-Host "Download complete. Executing the suite..."
    
    # Start the downloaded batch file and pass any arguments to it.
    # The -Wait parameter ensures this script pauses until the batch file is closed.
    Start-Process -FilePath $FilePath -ArgumentList $args -Wait -Verb RunAs

}
catch {
    # If any part of the 'try' block fails, display the error.
    Write-Error "An error occurred during download or execution: $_"
    pause
}
finally {
    # --- Cleanup ---
    # This block runs regardless of whether the script succeeded or failed.
    Write-Host "Execution finished. Cleaning up temporary files..."
    if (Test-Path -Path $FilePath) {
        Remove-Item -Path $FilePath -Force -ErrorAction SilentlyContinue
        Write-Host "Temporary file removed."
    }
}

Write-Host "Process complete."
