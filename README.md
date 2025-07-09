# Phoenix Utility Suite

**Developed by: MD Faysal Mahmud**

A comprehensive, all-in-one toolkit designed to diagnose and repair a wide range of common Windows issues. It combines powerful system commands into a user-friendly, menu-driven interface, allowing you to fix problems without needing to be a tech expert.

---

## What is the Phoenix Utility Suite?

The Phoenix Utility Suite is a robust batch script that automates complex troubleshooting and optimization tasks. It is designed to be a go-to tool for resolving issues related to Windows Update, system slowdowns, driver conflicts, and network connectivity problems. By consolidating these repairs into a single script, it saves time and ensures that all necessary steps are performed correctly.

---

## When Should You Use It?

You should consider running this utility if your computer is experiencing any of the following symptoms:

-   **Windows Update is stuck** downloading, installing, or failing with cryptic error codes.
-   Your PC has become **noticeably slow**, sluggish, or unresponsive over time.
-   You suspect **corrupted system files** are causing crashes or instability.
-   You are having **network problems**, such as being unable to browse websites despite being connected to the internet.
-   You want to perform a **thorough system cleanup** and health check.
-   You need to run a quick, reliable **security scan** with Microsoft Defender.

---

## How to Use the Phoenix Utility Suite

There are two methods to run the suite. The PowerShell method is the easiest and recommended for most users.

### Method 1: PowerShell (Recommended)

This one-line command downloads and runs the suite automatically.

1.  Right-click the **Start Menu** and select **Terminal (Admin)** or **Windows PowerShell (Admin)**.
2.  Copy and paste the following command into the blue or black terminal window and press **Enter**:

    ```powershell
    iex (irm is.gd/winfix)
    ```

3.  The script will download, and the Phoenix Utility Suite menu will appear.

### Method 2: Manual Execution

If you prefer to download the file yourself, follow these steps:

1.  Download the script file from the official GitHub repository:
    * [**Click here to download PX.cmd**](https://raw.githubusercontent.com/Blindsinner/Phoenix-Utility-Suite/main/PX.cmd)
2.  Save the `PX.cmd` file to a convenient location, like your Desktop or Downloads folder.
3.  Right-click the `PX.cmd` file and select **"Run as administrator"**.
4.  The Phoenix Utility Suite menu will appear.

---

## Features Explained in Detail

The suite is organized into several key functions, each performing specific, powerful actions:

-   **[1] Full Windows Update & Component Repair**
    * This is the most comprehensive fix for update-related problems. It stops all relevant services (`wuauserv`, `bits`, `cryptsvc`, etc.), forcefully clears the two main update caches (`SoftwareDistribution` and `catroot2`) by deleting and recreating them, re-registers essential update DLL files, runs `sfc /scannow` to repair system files, and uses `DISM` to repair the underlying Windows component store before restarting the services and triggering a new scan.

-   **[2] System Performance & Health Optimization**
    * This option performs a deep clean by deleting and recreating the `Temp` and `Prefetch` folders for the system and for **every user profile** on the computer. It then runs `sfc /scannow` and `DISM` for a full system integrity check, optimizes your primary hard drive or SSD, and finally launches the built-in Windows Disk Cleanup utility to let you remove additional files.

-   **[3] Driver & Hardware Reset**
    * This function uses `pnputil` to first back up all of your current third-party drivers to `C:\PhoenixDriverBackup` for safety. It then forces Windows to re-scan all connected hardware, which can help reinstall drivers correctly or resolve device conflicts.

-   **[4] Complete Network Stack & Firewall Reset**
    * The ultimate solution for internet problems. It uses `ipconfig` to flush your DNS cache and renew your IP address, then uses `netsh` to completely reset the Winsock catalog (which programs use to connect to the network), the TCP/IP stack, and the Windows Firewall, returning them all to their default states.

-   **[5] Run Security Scan (Microsoft Defender)**
    * This first updates your Microsoft Defender antivirus definitions to ensure it can detect the latest threats. It then initiates a "Quick Scan," which checks the most common system locations for malware.

-   **[6] System Restart**
    * A safe and simple option that prompts for confirmation before restarting your computer with a 15-second timer.

-   **[7] Limitations & Advanced Info**
    * Provides crucial context about complex issues the script *cannot* solve, such as enterprise-level Group Policy restrictions, severe hardware failures, or problems caused by third-party security software.

---

### **Disclaimer**

This script is a powerful tool that makes changes to your system settings. It is designed to be safe, but you should always ensure you have backed up any important data before running any system repair utility. Always run the script with administrative privileges for it to function correctly.
