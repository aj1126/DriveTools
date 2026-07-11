# DriveTools Architecture Map

## Overview
`DriveTools` is an optimized PowerShell module designed for high-performance drive auditing, file categorization, duplicate file resolution, and maintenance of large storage drives (3 TB+). It supports both an interactive WPF GUI and cmdlets for automation scripts.

---

## 1. Scaffolding & Components
- **DriveTools.psd1**: Module manifest declaring exported functions, versioning (`3.0.6`), and dependency properties.
- **DriveTools.psm1**: The core module script. Performs initialization, compiles inline performance-critical C# helper classes, auto-loads public functions, and exports the module's core cmdlets.
- **DriveTools.GUI.ps1**: WPF GUI launcher. Self-contained UI runner that binds UI interactions to background runspaces, allowing concurrent drive scans without freezing the main application frame.
- **public/Start-DTAuditGui.ps1**: Concrete public function to initialize and render the WPF UI, loading the window structure from `src/UI/MainWindow.xaml`.
- **src/UI/MainWindow.xaml**: Layout markup declaring the audit control panel layout, progress bars, and status text blocks.
- **lib/**: Embedded binaries containing SQLite ADO.NET assembly dependencies.
- **tests/DriveTools.Tests.ps1**: Pester test suite to verify cmdlet capabilities.
- **tools/**: Helper utilities for developers (e.g. benchmarking, version bumping, and packaging scripts).

---

## 2. Multi-Threaded Processing Pipeline
- **Producer/Consumer Queue**:
  - Traversal runs via `[System.IO.Directory]::EnumerateFiles` inside a background thread, skipping reparse points to avoid symbolic links/directory loops.
  - Files are pushed to a thread-safe bounds-limited `BlockingCollection[string]` queue.
  - Multi-threaded consumer workers (instantiated inside a PowerShell `RunspacePool` sized to the system's logical cores) process queue items concurrently.
- **High-Speed Hashing Engine**:
  - P/Invoke calls in C# (`StorageProfiler`) detect drive attributes (e.g., seek penalty query) to optimize buffer sizes.
  - Hashes are calculated in parallel via SHA256, then logged thread-safely into a shared CSV using `ReaderWriterLockSlim`.
  - Computed hashes are mapped to file paths inside a `ConcurrentDictionary[string, string]`.

---

## 3. Core Cmdlets
- `Invoke-DriveAuditFast`: Ingests metadata and hashes of file streams.
- `Update-DriveHashCache`: Manages historical hash mappings.
- `Invoke-DriveCategorize`: Segregates files based on pattern matching rules.
- `Resolve-DriveDuplicates`: Identifies exact duplicates using caches and cleans redundant data.
- `Invoke-DriveCleanup`: Performs empty directory removal and archive compression.
- `Show-DriveVisualMap`: Visualizes tree maps using console Unicode box-drawing glyphes.
