# Phoenix Windows Utility Suite
---
<div align="center">
  <img src="https://github.com/Blindsinner/Phoenix-Windows-Utility-Suite/blob/main/PX.png" alt="Phoenix Utility Suite Logo" width="250">
</div>

**Developed by: MD Faysal Mahmud**

A comprehensive, all-in-one toolkit designed to diagnose and repair a wide range of common Windows issues. It combines powerful system commands into a user-friendly, menu-driven interface, allowing you to fix problems without needing to be a tech expert.

---

## What is the Phoenix Windows Utility Suite?

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

    A command prompt window will open displaying the PX menu:

   
    ```

    ================================================================
                         PHOENIX WINDOWS UTILITY SUITE
                       (Developed by MD Faysal Mahmud)
    ================================================================

    [1] Full Windows Update & Component Repair
    [2] System Performance & Health Optimization
    [3] Driver & Hardware Reset
    [4] Complete Network Stack & Firewall Reset
    [5] Run Security Scan (Microsoft Defender)
    [6] System Restart
    [7] Limitations & Advanced Info
    [0] Exit

    ================================================================
    Enter your choice [0-7]:
    ```

### Method 2: Manual Execution

If you prefer to download the file yourself, follow these steps:

1.  Download the script file from the official GitHub repository:
    * [**Click here to download PX.cmd**](https://raw.githubusercontent.com/Blindsinner/Phoenix-Utility-Suite/main/PX.cmd)
2.  Save the `PX.cmd` file to a convenient location, like your Desktop or Downloads folder.
3.  Right-click the `PX.cmd` file and select **"Run as administrator"**.
4.  The Phoenix Utility Suite menu will appear.

---

## Features Explained in Detail

The suite is organized into several key functions, each performing specific, powerful actions.

### [1] Full Windows Update & Component Repair

This is the most powerful and thorough option for fixing all types of Windows Update problems. It’s a multi-stage process designed to reset the entire update mechanism from the ground up.

#### What it Does

1.  **Stops Services:** It begins by immediately stopping critical services related to Windows Update, including the **Windows Update Service** (`wuauserv`), **Background Intelligent Transfer Service** (`bits`), **Cryptographic Services** (`cryptsvc`), and the **Windows Installer** (`msiserver`). This releases any "locked" files and allows them to be deleted.
2.  **Clears Caches:** The script forcefully deletes and then recreates two key folders:
    * `C:\Windows\SoftwareDistribution`: This folder is where Windows stores temporary files for updates before and during installation.
    * `C:\Windows\System32\catroot2`: This folder stores the signatures of update packages to confirm they are authentic and untampered with.
3.  **Re-registers DLLs:** It re-registers several essential `.dll` files that are crucial for the Windows Update agent to function correctly.
4.  **Repairs System & Component Store:** It runs three of the most important system repair commands in sequence:
    * `sfc /scannow`: Scans and repairs any corrupted or missing core Windows system files.
    * `DISM /Online /Cleanup-Image /RestoreHealth`: Repairs the underlying Windows Component Store, which `sfc` uses as a source for its repairs. A healthy component store is vital for successful updates.
    * `DISM /Online /Cleanup-Image /StartComponentCleanup`: Removes old and superseded versions of updated components, freeing up significant disk space.
5.  **Performs Deep Cleanup:** It deletes the **Delivery Optimization cache** (files shared between PCs to speed up updates) and runs `cleanmgr /verylowdisk` to perform a deep, automated cleanup of other system junk files.
6.  **Restarts and Rescans:** Finally, it restarts all the services it initially stopped and forces Windows to check for updates again with a clean slate.

#### What Issues it Solves

* **Stuck Updates:** Fixes updates that are stuck at 0% or 100% and never finish downloading or installing.
* **Update Errors:** Resolves common error codes (e.g., `0x80070002`, `0x800f0922`, `0x80240034`) that appear when an update fails.
* **Corrupted Downloads:** By clearing the caches, it deletes any partially downloaded or corrupted update files, forcing a fresh download.
* **Component Store Corruption:** Directly addresses errors indicating that the update manifest or component store is damaged.
* **"We couldn't complete the updates" message:** Often solves the issue where Windows tries to install an update on restart but fails and has to roll back the changes.

---

### [2] System Performance & Health Optimization

This option is a comprehensive tune-up designed to clean out system-wide junk, ensure system file integrity, and improve disk performance, making your computer feel more responsive.

#### What it Does

1.  **Cleans Temporary Files:** It performs a safe but thorough cleaning of temporary file locations for both the system and **every user account** on the PC, including the `Temp` and `Prefetch` folders.
2.  **Runs Health Checks:** It executes both `sfc /scannow` and `DISM /RestoreHealth` to find and fix any corruption in the operating system's core files and component store, which can be a hidden cause of slowdowns.
3.  **Optimizes Primary Drive:** It runs the `defrag C: /O` command, which performs the appropriate optimization for your drive. For traditional Hard Disk Drives (HDDs), it defragments files. For Solid-State Drives (SSDs), it sends a `TRIM` command to help the drive maintain its speed.
4.  **Launches Interactive Cleanup:** It opens the Windows **Disk Cleanup** utility, allowing you to choose and delete additional items like old Windows installation files, recycle bin contents, and more.

#### What Issues it Solves

* **General Sluggishness:** Removes junk files that can slow down your system over time.
* **Slow Boot/Login Times:** Cleaning user-specific temporary files and optimizing the drive can lead to faster startup and login processes.
* **Low Disk Space:** Can free up gigabytes of storage by removing unnecessary files.
* **Application Crashes:** Corrupted temp files can cause programs to crash; cleaning them out can improve stability.
* **Slow File Access:** Defragmenting an HDD makes accessing files much faster. Running TRIM on an SSD is essential for its long-term health and performance.

---

### [3] Driver & Hardware Reset

This function is designed to resolve issues with malfunctioning hardware peripherals or drivers without requiring you to manually uninstall and reinstall them.

#### What it Does

1.  **Backs Up Drivers:** It uses the `pnputil` command to export all your current third-party drivers into a folder named `C:\PhoenixDriverBackup`. This serves as a safety net in case you need to restore a specific driver later.
2.  **Scans for Hardware Changes:** It then runs a command that forces Windows to re-scan every piece of hardware connected to your computer. This process is similar to what happens when you plug in a new device for the first time.

#### What Issues it Solves

* **"Unknown Device" Errors:** Can resolve yellow exclamation marks in Device Manager by prompting Windows to find the correct driver for the device.
* **Malfunctioning Peripherals:** Fixes issues where a USB device (mouse, keyboard, webcam) suddenly stops working.
* **Driver Conflicts:** Can resolve conflicts that sometimes occur after a major Windows update by forcing a re-initialization of the hardware.
* **Provides a Driver Safety Net:** The backup ensures you have a copy of your working drivers before Windows attempts to change anything.

---

### [4] Complete Network Stack & Firewall Reset

This is a powerful "nuke and rebuild" option for your entire network configuration, designed to fix stubborn internet connectivity problems.

#### What it Does

1.  **Flushes & Renews IP/DNS:** It runs a series of `ipconfig` commands to flush the DNS cache (clearing the memory of website addresses), release your current IP address, and request a new one from your router.
2.  **Resets Network Protocols:** It uses `netsh` to completely reset three core components:
    * **Winsock Catalog:** This is a critical database that applications use to access the network. Resetting it fixes corruption that can prevent programs from connecting to the internet.
    * **TCP/IP Stack:** This resets the fundamental internet protocol configuration for your computer back to its default state.
    * **Windows Firewall:** This erases all custom rules and settings, returning the firewall to its out-of-the-box configuration.

#### What Issues it Solves

* **"Connected, no internet" or "Limited connectivity" Errors:** This is the most common issue this option fixes.
* **Website Not Found Errors:** If you can't access some or all websites, resetting the DNS and TCP/IP stack often resolves the problem.
* **IP Address Conflicts:** Forcing a renewal of your IP address can fix conflicts on your local network.
* **Software-Specific Network Issues:** If only certain applications (like a game or email client) can't connect to the internet, a Winsock reset is often the solution.
* **Blocked Connections:** Resetting the firewall can fix issues where a misconfigured rule is preventing legitimate traffic.

---

### [5] Run Security Scan (Microsoft Defender)

This provides a quick and reliable way to check your system for common security threats using Windows' built-in antivirus.

#### What it Does

1.  **Updates Definitions:** It first forces Microsoft Defender to download the latest virus and threat definitions. This is a critical step to ensure it can detect the newest forms of malware.
2.  **Initiates Quick Scan:** It then runs a "Quick Scan" (`ScanType 1`), which efficiently checks the locations on your system where malware is most commonly found, such as startup folders, the registry, and core system files.

#### What Issues it Solves

* **Suspected Malware Infection:** If your PC is acting strangely (e.g., unusual pop-ups, slow performance, browser redirects), this is a great first step to check for an infection.
* **Ensures Up-to-Date Protection:** By updating definitions first, it guarantees you are scanning with the most current information available from Microsoft.

---

### [6] System Restart

A simple but essential function for finalizing repairs.

#### What it Does

After asking for confirmation, it uses the `shutdown /r` command to perform a clean reboot of your computer.

#### What Issues it Solves

* **Finalizing Pending Changes:** Many repairs and updates require a restart to be fully applied. This option provides a controlled way to do so.
* **Clearing Memory:** A restart clears out the system's RAM, which can resolve temporary glitches and performance issues.

---

### [7] Limitations & Advanced Info

This option provides crucial context and manages user expectations.

#### What it Does

It displays a screen of text that explains the types of problems the script is **not** designed to solve.

#### What Issues it Solves

* **Prevents Wasted Time:** It informs you that the script cannot fix physical hardware failures, issues caused by third-party antivirus software, or restrictions imposed by a corporate network (Group Policy). This prevents you from running the script repeatedly for a problem it cannot solve.
* **Guides Towards the Correct Solution:** By explaining the limitations, it helps you understand when a more advanced solution, like a full Windows reinstall or professional help, might be necessary.

---

### **Disclaimer**

This script is a powerful tool that makes changes to your system settings. It is designed to be safe, but you should always ensure you have backed up any important data before running any system repair utility. Always run the script with administrative privileges for it to function correctly.
