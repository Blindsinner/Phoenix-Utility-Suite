# Phoenix Windows Utility Suite
---
<div align="center">
  <img src="https://github.com/Blindsinner/Phoenix-Windows-Utility-Suite/blob/main/PX.png" alt="Phoenix Utility Suite Logo" width="250">
</div>

# Phoenix Windows Utility Suite

**Developed by:** MD Faysal Mahmud

---

## Table of Contents

1. [Introduction](#introduction)
2. [When to Use](#when-to-use)
3. [Installation & Usage](#installation--usage)
   - [PowerShell (Recommended)](#powershell-recommended)
   - [Manual Execution](#manual-execution)
4. [Menu & User Interface](#menu--user-interface)
5. [Feature Breakdown](#feature-breakdown)
   1. [Windows Update & Component Repair](#windows-update--component-repair)
   2. [Performance & Health Optimization](#performance--health-optimization)
   3. [Driver & Hardware Reset](#driver--hardware-reset)
   4. [Network Stack & Firewall Reset](#network-stack--firewall-reset)
   5. [Security Scan (Microsoft Defender)](#security-scan-microsoft-defender)
   6. [System Restart](#system-restart)
   7. [Limitations & Advanced Info](#limitations--advanced-info)
6. [Benefits](#benefits)
7. [Disclaimer](#disclaimer)
8. [License](#license)

---

<a id="introduction"></a>
## Introduction

Phoenix Windows Utility Suite is a professional-grade, all-in-one batch script toolkit that consolidates essential Windows repair and optimization routines into a clean, menu-driven interface. Ideal for IT professionals and power users, Phoenix automates complex tasks—saving time and reducing manual errors.

---

<a id="when-to-use"></a>
## When to Use

Run Phoenix whenever you experience any of the following:

- **Windows Update failures**: Error codes, stuck downloads, or rollbacks.
- **Sluggish performance**: High disk usage, slow startup or login.
- **Corrupted system files**: Unexpected crashes or Blue Screens.
- **Driver conflicts**: Unknown devices or malfunctioning peripherals.
- **Network connectivity issues**: "Limited connectivity," DNS lookup failures.
- **Security concerns**: Suspicious activity or outdated antivirus definitions.
- **Low disk space**: Accumulated temporary, cache, or obsolete files.

---

<a id="installation--usage"></a>
## Installation & Usage

<a id="powershell-recommended"></a>
### PowerShell (Recommended)

1. Open **Windows PowerShell (Admin)** or **Windows Terminal (Admin)**.
2. Paste and run:
   ```powershell
   iex (irm is.gd/winfix)

3.  A new window launches with the Phoenix menu ready to use.

<a id="manual-execution"></a>

### Manual Execution

1.  Download the script: [PX.cmd](https://raw.githubusercontent.com/Blindsinner/Phoenix-Windows-Utility-Suite/main/PX.cmd)
2.  Save to local drive.
3.  Right-click **PX.cmd** and choose **Run as administrator**.
4.  The Phoenix menu appears.

-----

<a id="menu--user-interface"></a>

## Menu & User Interface

Phoenix presents a straightforward console menu:

```text
================================================
  PHOENIX WINDOWS UTILITY SUITE
 (Developed by MD Faysal Mahmud)
================================================

 [1] Windows Update & Component Repair
 [2] Performance & Health Optimization
 [3] Driver & Hardware Reset
 [4] Network Stack & Firewall Reset
 [5] Security Scan (Microsoft Defender)
 [6] System Restart
 [7] Limitations & Advanced Info
 [0] Exit

Enter your choice [0-7]:
```

  - Select an option by typing its number and pressing **Enter**.
  - Follow on-screen prompts for progress, information, or confirmations.

-----

<a id="feature-breakdown"></a>

## Feature Breakdown

<a id="windows-update--component-repair"></a>

### 1. Windows Update & Component Repair

  - **Stops** all update-related services.
  - **Resets** and **recreates** `SoftwareDistribution` and `catroot2` caches.
  - **Re-registers** key Windows Update DLLs.
  - **Runs** DISM (`/ScanHealth`, `/RestoreHealth`, `/StartComponentCleanup`) and `sfc /scannow`.
  - **Deep clean** via `cleanmgr /verylowdisk` and Delivery Optimization removal.
  - **Restarts** services and forces a fresh update scan.

<a id="performance--health-optimization"></a>

### 2. Performance & Health Optimization

  - **Cleans** system and user temp folders, including `%SystemRoot%\Temp`, `%USERPROFILE%\AppData\Local\Temp`, and Prefetch.
  - **Executes** `sfc /scannow` and `DISM /Online /Cleanup-Image /RestoreHealth`.
  - **Optimizes** disk with `defrag %SystemDrive%: /O` (defrag/TRIM).
  - **Launches** interactive Disk Cleanup for manual selection.

<a id="driver--hardware-reset"></a>

### 3. Driver & Hardware Reset

  - **Backs up** third-party drivers to `%SystemDrive%\PhoenixDriverBackup`.
  - **Re-enumerates** hardware with `pnputil /scan-devices`.

<a id="network-stack--firewall-reset"></a>

### 4. Network Stack & Firewall Reset

  - **Flushes & renews** IP/DNS (`ipconfig` commands).
  - **Resets** Winsock and TCP/IP (`netsh winsock`, `netsh int ip`).
  - **Restores** firewall defaults (`netsh advfirewall reset`).

<a id="security-scan-microsoft-defender"></a>

### 5. Security Scan (Microsoft Defender)

  - **Updates** virus definitions (`MpCmdRun.exe -SignatureUpdate`).
  - **Performs** a Quick Scan (`-ScanType 1`).

<a id="system-restart"></a>

### 6. System Restart

  - **Prompts** for confirmation.
  - **Reboots** with `shutdown /r /t 15` to apply changes and clear memory.

<a id="limitations--advanced-info"></a>

### 7. Limitations & Advanced Info

Phoenix does **not** handle:

  - Physical hardware failures requiring repair or replacement.
  - Enterprise Group Policy or registry lockdowns.
  - Third-party antivirus conflicts blocking system tools.
  - Severely corrupted OS needing in-place upgrade or reinstall.
  - Captive portals or complex proxy authentication scenarios.

-----

<a id="benefits"></a>

## Benefits

  - **All-in-One:** Comprehensive toolkit for updates, performance, drivers, network, and security.
  - **Safe & Idempotent:** Repeatable without errors, thanks to robust checks.
  - **User-Friendly UI:** Clear menu and prompts guide you through each step.
  - **Time-Saving:** Automates complex, multi-command workflows.
  - **Flexible Execution:** Run via PowerShell or standalone.

-----

<a id="disclaimer"></a>

## Disclaimer

Use at your own risk:

  - Back up important data before running.
  - Always run as **Administrator**.
  - Compatible with Windows 10 and above.
  - No liability for data loss or system issues.

-----

<a id="license"></a>

## License

Released under the **MIT License**.

```
MIT License

Copyright (c) 2025 MD Faysal Mahmud

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

```
```
