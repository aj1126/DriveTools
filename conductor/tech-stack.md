# Technology Stack - DriveTools

## Core Stack
- **PowerShell (5.1+ & Core)**: Primary scripting host. Functions and entry point cmdlets are packaged as a module (`.psd1`, `.psm1`).
- **WPF (Windows Presentation Foundation) & XAML**: For rendering the graphical user interface (`DriveTools.GUI.ps1`, `src/UI/MainWindow.xaml`).
- **Inline C# Compilation**: Compiled at runtime using `Add-Type` inside the PowerShell host. High-performance logic like producer-consumer queues and native Win32 path integrations are implemented in C# for microsecond performance and type safety.
- **SQLite Database**: Embedded SQLite via `System.Data.SQLite.dll` is used for fast disk/file caching and index queries.

## Testing & Quality
- **Pester (3.4.0 & 5.0+)**: Dual-version compatible assertion engine for PowerShell module testing (`tests/DriveTools.Tests.ps1`).
- **PSScriptAnalyzer**: Static analysis tool for enforcing code style and syntax rules.

## Development & Deployment
- **Git**: Version control.
- **GitHub Actions**: Continuous integration, static analysis (`analyze.yml`), code quality validation (`ci.yml`), signing (`sign.yml`), docs generation, and release pipelines.
- **Chocolatey & Winget**: Package managers for publishing the compiled utility wrapper.
