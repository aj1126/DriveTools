<p align="center">
  <img src="https://img.shields.io/github/v/release/AJ1126/DriveTools?style=for-the-badge" />
  <img src="https://img.shields.io/github/actions/workflow/status/AJ1126/DriveTools/ci.yml?style=for-the-badge" />
  <img src="https://img.shields.io/powershellgallery/v/DriveTools?style=for-the-badge" />
  <img src="https://img.shields.io/github/license/AJ1126/DriveTools?style=for-the-badge" />
  <img src="https://img.shields.io/github/issues/AJ1126/DriveTools?style=for-the-badge" />
  <img src="https://img.shields.io/github/stars/AJ1126/DriveTools?style=for-the-badge" />
</p>

# 📦 DriveTools

> A PowerShell module for auditing, organizing, deduplicating, and maintaining large external drives (3 TB+).

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)](https://github.com/PowerShell/PowerShell)
[![Pester](https://img.shields.io/badge/Tested%20with-Pester%205-green)](https://pester.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## ✨ Features

| Feature | Description |
|---|---|
| **Fast Audit** | Recursively scans a drive and exports file metadata to CSV |
| **Hash Caching** | Stores SHA256 hashes in a JSON cache; only rehashes files that have changed |
| **Auto-Categorization** | Moves files into `Projects / Media / Archives / Uploads / System` folders based on extension and keyword patterns |
| **Duplicate Resolution** | Detects exact duplicates via hash; keeps the newest copy and removes the rest |
| **Cleanup** | Removes empty directories, reports duplicate groups, compresses the Archives folder |
| **Visual Tree Map** | Generates a Unicode tree of the drive saved to a `.txt` file |
| **Real-Time Status** | `Get-DriveStatus` returns the currently running operation, start time, and details |
| **Scheduled Maintenance** | Registers a Windows Scheduled Task to run audits automatically (Daily or Hourly) |
| **WPF GUI** | Optional graphical launcher for all operations — no command line required |

---

## 🗂️ Repository Layout

```
DriveTools/
├── 2.0/
│   ├── DriveTools.psm1        # Module implementation
│   ├── DriveTools.psd1        # Module manifest
├── tests/
│   └── DriveTools.Tests.ps1   # Pester test suite
├── tools/
│   ├── DriveTools.GUI.ps1     # WPF graphical launcher
│   └── Invoke-DriveBenchmark.ps1  # Performance benchmark script
├── profile-snippet.ps1         # PowerShell profile snippet
└── README.md
```

---

## ⚡ Installation

### Option A — Manual (recommended for personal use)

```powershell
$dest = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\DriveTools\2.0"
New-Item -Path $dest -ItemType Directory -Force
Copy-Item DriveTools.psm1, DriveTools.psd1 -Destination $dest
```

### Option B — Clone and install

```powershell
git clone https://github.com/you/DriveTools.git
Set-Location DriveTools
.\Install.ps1   # copies module to the user module path
```

### Verify installation

```powershell
Import-Module DriveTools
Get-Module DriveTools | Select-Object Name, Version, ExportedFunctions
```

---

## 🚀 Quick Start

```powershell
Import-Module DriveTools

# 1. Audit the drive
$csv = Invoke-DriveAuditFast -RootPath M:\ -IncludeHashes
Write-Host "Report saved to $csv"

# 2. Preview categorization without moving anything
Invoke-DriveCategorize -DryRun

# 3. Apply categorization
Invoke-DriveCategorize

# 4. Find and remove duplicates (dry-run first!)
Resolve-DriveDuplicates -DryRun
Resolve-DriveDuplicates

# 5. Clean up empty folders
Invoke-DriveCleanup -RemoveEmptyDirectories -ReportDuplicates

# 6. View a tree map of the drive
Show-DriveVisualMap -MaxDepth 3

# 7. Schedule nightly maintenance
Register-DriveMaintenanceTask -Schedule Daily

# 8. Monitor long-running operations
Get-DriveStatus
```

---

## 📋 Command Reference

### `Invoke-DriveAuditFast`

Scans a drive and exports a CSV with file metadata.

```
-RootPath        <string>   Drive or folder to scan          (default: M:\)
-OutputCsvPath   <string>   Destination CSV path
-IncludeHashes   <switch>   Compute SHA256 for every file
```

### `Update-DriveHashCache`

Builds or refreshes a JSON hash cache; unchanged files reuse their stored hash.

```
-RootPath   <string>   Drive root
-CachePath  <string>   Path to HashCache.json
```

### `Invoke-DriveCategorize`

Moves files into category folders based on extension and keyword matching.

```
-RootPath                  <string>    Drive root
-CategoryMap               <hashtable> Custom map (category → pattern list)
-DisableDefaultCategoryMap <switch>    Skip the built-in category map
-DryRun                    <switch>    Log actions without moving files
```

**Default CategoryMap:**

| Category | Triggers |
|---|---|
| Projects | `Unity`, `Project`, `Source`, `.sln`, `.csproj`, `Perseus` |
| Media | `.wav`, `.mp3`, `.flac`, `.mp4`, `.mov`, `.mkv`, `.jpg`, `.png`, `.psd`, `.ai` … |
| Archives | `backup`, `export`, `.zip`, `.rar`, `.7z`, `.bak` … |
| Uploads | `UPLOADS`, `upload`, `.torrent`, `.nfo` |
| System | `installer`, `setup`, `.msi`, `.exe`, `.dll`, `.log` |

### `Resolve-DriveDuplicates`

Hashes all files, groups identical hashes, keeps the newest copy.

```
-RootPath  <string>  Drive root
-DryRun    <switch>  Log what would be deleted without deleting
```

### `Invoke-DriveCleanup`

Composite cleanup: empty directories, duplicate reports, archive compression.

```
-RemoveEmptyDirectories  <switch>  Delete zero-item folders
-ReportDuplicates        <switch>  Log duplicate groups to the log file
-CompressArchives        <switch>  Zip the Archives\ subfolder
```

### `Show-DriveVisualMap`

Renders a Unicode tree of the directory structure.

```
-RootPath    <string>  Root to map
-MaxDepth    <int>     Recursion limit (default: 3)
-OutputPath  <string>  Where to save the .txt file
```

### `Register-DriveMaintenanceTask`

Registers a Windows Scheduled Task that calls `Invoke-DriveAuditFast` automatically.

```
-TaskName  <string>  Task name (default: DriveMaintenance)
-Schedule  <string>  Daily | Hourly
```

### `Get-DriveStatus`

Returns the currently active operation, start time, and last-update timestamp.

---

## 📁 Log Files

All operations write to daily log files:

```
%USERPROFILE%\Documents\DriveLogs\Drive_YYYY-MM-DD.log
```

Hash cache is stored at:

```
%USERPROFILE%\Documents\DriveLogs\Drive_HashCache.json
```

---

## 🧪 Running Tests

Requires [Pester 5](https://pester.dev/docs/introduction/installation).

```powershell
Install-Module Pester -Force -SkipPublisherCheck
Invoke-Pester .\tests\DriveTools.Tests.ps1 -Output Detailed
```

---

## 🖥️ WPF GUI

Launch the graphical interface with:

```powershell
.\tools\DriveTools.GUI.ps1
```

The GUI provides one-click access to all operations, a live status display, and a log viewer.

---

## ⚙️ Configuration

You can override the default drive root and log path in your profile or before importing the module by editing the module variables after import:

```powershell
Import-Module DriveTools
# Point to a different drive
(Get-Module DriveTools).Invoke({ $Script:Drive_DefaultRoot = 'E:\' })
```

Or supply `-RootPath` on every call.

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Add Pester tests for any new functions
4. Open a pull request

---

## 📄 License

MIT — see [LICENSE](LICENSE).
