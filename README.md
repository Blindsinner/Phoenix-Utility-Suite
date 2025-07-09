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
    * [**Click here to download PX.cmd**](https://raw.githubusercontent.com/Blindsinner/Phoenix-Utility-Suite/refs/heads/main/PX.cmd)
2.  Save the `PX.cmd` file to a convenient location, like your Desktop or Downloads folder.
3.  Right-click the `PX.cmd` file and select **"Run as administrator"**.
4.  The Phoenix Utility Suite menu will appear.

---

## Features Explained

The suite is organized into several key functions:

-   **[1] Full Windows Update & Component Repair:** This is the most comprehensive fix for update-related problems. It stops update services, clears all caches, re-registers essential files, fixes component corruption with SFC and DISM, and restarts the process.
-   **[2] System Performance & Health Optimization:** This option cleans temporary files from all user profiles, runs SFC and DISM to ensure system integrity, and defragments your primary drive to improve performance.
-   **[3] Driver & Hardware Reset:** This function backs up your current drivers and rescans your system's hardware, which can help resolve conflicts or issues with malfunctioning devices.
-   **[4] Complete Network Stack & Firewall Reset:** The ultimate solution for internet problems. It flushes your DNS, resets your computer's IP configuration, and restores both the Winsock catalog and the Windows Firewall to their default states.
-   **[5] Run Security Scan (Microsoft Defender):** Updates your antivirus definitions and initiates a quick scan to check for malware.

---

### **Disclaimer**

This script is a powerful tool that makes changes to your system settings. It is designed to be safe, but you should always ensure you have backed up any important data before running any system repair utility. Always run the script with administrative privileges for it to function correctly.
