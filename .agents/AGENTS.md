# PowerShell Development Rules

## 1. File Encoding and Compatibility (PowerShell 5.1+)
- **UTF-8 with BOM Requirement**: Any `.ps1` or `.psm1` script containing Unicode characters (e.g., box-drawing characters, arrows, symbols) MUST be saved in **UTF-8 with BOM** (Byte Order Mark) encoding. This ensures that Windows PowerShell 5.1 parses the file correctly instead of defaulting to ANSI and throwing syntax errors, while remaining fully compatible with PowerShell Core (7+).

## 2. Cross-Process State Management in GUI Background Jobs
- **File-Based State Communication**: When running long-running module functions in background threads or processes (e.g., via `Start-Job` in a WPF GUI launcher), do not rely on variable scope sharing for real-time status updates. Instead, have the background worker dump its status payload to a local shared JSON file (e.g., `MyBook_Status.json`), which the main thread polls to update the user interface.
