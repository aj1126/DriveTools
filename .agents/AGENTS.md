# Global Rules

- **Continuous Verification & Bug-Checking**: When you learn a new rule or constraint (e.g., via the `/learn` workflow), you must immediately ask to check/verify the rule against the current project files to scan for and resolve any existing violations.
- **Git Push/Pull Synchronization**: When pushing changes to the `main` branch on GitHub, be aware that automated CI/CD workflows (such as Semantic Versioning bumps) will trigger and commit updates back to `main`. After pushing, if `main` is currently checked out, wait briefly for any remote runs to complete and always pull/rebase (`git pull --rebase origin main`) before starting new tasks or making subsequent pushes, preventing rejected refs.

---

# PowerShell Development Rules

## 1. File Encoding and Compatibility (PowerShell 5.1+)
- **UTF-8 with BOM Requirement**: Any `.ps1` or `.psm1` script containing Unicode characters (e.g., box-drawing characters, arrows, symbols) MUST be saved in **UTF-8 with BOM** (Byte Order Mark) encoding. This ensures that Windows PowerShell 5.1 parses the file correctly instead of defaulting to ANSI and throwing syntax errors, while remaining fully compatible with PowerShell Core (7+).
  *Note*: In .NET Core / PowerShell 7+, `[System.Text.Encoding]::UTF8` defaults to UTF-8 *without* BOM. To force BOM generation cross-version safely, instantiate `[System.Text.UTF8Encoding]::new($true)` explicitly.

## 2. Cross-Process State Management in GUI Background Jobs
- **File-Based State Communication**: When running long-running module functions in background threads or processes (e.g., via `Start-Job` in a WPF GUI launcher), do not rely on variable scope sharing for real-time status updates. Instead, have the background worker dump its status payload to a local shared JSON file (e.g., `MyBook_Status.json`), which the main thread polls to update the user interface.

## 3. Pester Cross-Version Syntax Compatibility (Pester 3.4.0 to Pester 5)
- **Dual-Version Safe Assertions**: Pester v3.4.0 does not support advanced dash-prefixed parameters (e.g., `Should -Not -BeNullOrEmpty` or `Should -Not -Throw`), but Pester v5 does not support legacy space-separated negation (e.g., `Should Not BeNullOrEmpty` or `Should Not Throw`), throwing a `ParameterBindingException`.
- **To write assertions that work seamlessly on both versions**:
  - **Null / Empty Negation**: Use parenthesized string/null checks asserted via `Should -Be $true` or `Should -Be $false`:
    ```powershell
    # Correct (works on both Pester 3 and Pester 5):
    ([string]::IsNullOrEmpty($Type.Type)) | Should -Be $false
    ($null -ne $Engine) | Should -Be $true
    ```
  - **Exception Negation (Should Not Throw)**: Wrap the code block in a `try/catch` and assert a boolean flag status:
    ```powershell
    # Correct (works on both Pester 3 and Pester 5):
    $ranWithoutThrow = $true
    try {
        Show-DriveVisualMap -RootPath "C:\"
    } catch {
        $ranWithoutThrow = $false
    }
    $ranWithoutThrow | Should -Be $true
    ```
  - **Collection Null Checks**: Avoid piping empty collections (like `BlockingCollection` or arrays) directly to `Should Not Be $null`. PowerShell unpacks the empty collection to nothing, causing the check to fail. Instead, check using a parenthesized boolean assertion: `($null -ne $Engine.FileQueue) | Should -Be $true`.

## 4. Re-Saving UTF-8 with BOM Safely
- **Avoiding Encoding Corruption**: When converting/saving a file to UTF-8 with BOM via PowerShell, ensure you read the file using `-Encoding UTF8` before writing it back. Reading it as ANSI will corrupt existing Unicode glyphs:
  ```powershell
  # CORRECT:
  $content = Get-Content -LiteralPath "src\File.psm1" -Encoding UTF8 -Raw
  $content | Set-Content -LiteralPath "src\File.psm1" -Encoding UTF8

  # INCORRECT (converts already-corrupted characters):
  (Get-Content "src\File.psm1" -Raw) | Set-Content "src\File.psm1" -Encoding UTF8
  ```
  If re-saving programmatically from .NET APIs:
  ```powershell
  # CORRECT (Force BOM in PowerShell 7+):
  [System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($true))
  ```

## 5. Safe String Formatting in Modules
- **Explicit Array Packaging**: When using the string format operator (`-f`) inside module functions, avoid passing comma-separated lists of mixed characters and strings directly. PowerShell can experience parameter unpacking failures. Package formatting arguments explicitly in an array first:
  ```powershell
  $fmtArgs = @($indent, [string]$charCorner, [string]$charDash, $name)
  $lines.Add('{0}{1}{2}{2} {3}' -f $fmtArgs)
  ```

## 6. Non-Interactive Test Runs
- **Always Pass Target Paths**: When testing module functions that contain fallback interactive prompts (e.g., `Read-Host` console selection menus), always pass explicit target parameters (like `-RootPath "C:\"`) inside test blocks to prevent automated/background test suites from hanging on input prompts.

## 7. PSAvoidEmptyCatchBlock Compliance
- **Justify Empty Catch Blocks**: Catch blocks must not be empty. If an error is meant to be ignored silently (e.g. transient file lock or background status serialization), include an explicit comment inside the catch block explaining the rationale:
  Additionally, since PSScriptAnalyzer treats blocks containing only comments as empty, you must include a dummy statement (such as `$null = $_` or `$null = $PSItem`) to satisfy the analyzer.
  For single-line catch blocks, use block comments `<# ... #>` instead of line comments `#` to prevent commenting out the closing brace.
  ```powershell
  try {
      Remove-Item -Path $statusFile -Force
  } catch {
      $null = $_ # Ignore removal errors if status file is already deleted or locked by another process.
  }

  # Single-Line Correct Example:
  try { $Queue.Enqueue($item) } catch { $null = $_ <# PSAvoidEmptyCatchBlock #> }
  ```

## 8. Artifact and Workspace File Operations
- **Artifact Directory Bounds**: Always write user-facing reports, plan documents, and walk-throughs in the designated conversation brain directory `C:\Users\ajjuk\.gemini\antigravity\brain\<conversation-id>/` and provide `ArtifactMetadata`.
- **Workspace Files**: Never provide `ArtifactMetadata` when creating or modifying files inside the user's workspace directory (e.g. source files, `.vscode/settings.json`, `.cursorrules`).

## 9. C# Inline Compilation Compatibility (PowerShell 5.1+)
- **C# 5 Syntax Limits**: When defining inline C# class definitions via `Add-Type` in module files, restrict the code syntax to C# 5 or lower. Windows PowerShell 5.1 compiles code using the .NET 4.0 C# compiler, which does not support C# 6+ features (e.g., expression-bodied properties `=>`, string interpolation `$""`, null-conditional operator `?.`).
- **Property Getters**: Use standard explicit getters instead of `=>`:
  ```csharp
  // Correct (C# 5):
  public int ProcessedCount { get { return _processedCount; } }

  // Incorrect (C# 6):
  public int ProcessedCount => _processedCount;
  ```

## 10. Safe Directory Cleanup in Module Installers
- **Strict Version Pattern Filtering**: When writing directory cleanup routines in PowerShell installers that remove stale, non-matching module version folders (e.g. cleaning up outdated versions under `Documents/PowerShell/Modules/<ModuleName>/`), you must never delete folders using a generic "name not equal to active version" check.
- **Validation Guard**: Always filter directory names using a strict numeric version regex pattern (like `^\d+(\.\d+)*$`) to ensure only versioned directories (such as `3.0.2` or `2.0`) are matched, leaving git metadata (`.git`), source paths (`src`, `lib`), and local repository assets unharmed:
  ```powershell
  # CORRECT:
  Get-ChildItem -Path $parentDir -Directory | Where-Object { $_.Name -match '^\d+(\.\d+)*$' -and $_.Name -ne $version } | Remove-Item -Recurse -Force

  # INCORRECT (will delete repository metadata/source folders if developed in-place):
  Get-ChildItem -Path $parentDir -Directory | Where-Object { $_.Name -ne $version } | Remove-Item -Recurse -Force
  ```

## 11. Folder-Scoped Database Operations
- **Constraint**: When running database queries or file modifications (such as deduplication or catalog cleanup) targeted at a specific `-RootPath`, you MUST restrict the operation scope using SQL parameters or local file path checks.
- **Path Prefix Match**: Ensure the query prefix handles trailing directory separators correctly (e.g. `$resolvedPath.TrimEnd('\') + '\%'` in SQLite) to avoid matching sibling directories with similar prefixes (like `C:\Folder-copy` matching `C:\Folder`).

## 12. NotebookLM Workspace Binding
- **Prevent Incorrect Workspace Notebook Connection**: Do not assume the active notebook returned by `notebooklm status` (which represents the global/last used CLI context) is the correct one for the current project. 
- **Binding Check**: Before performing any NotebookLM-related operation (such as syncing, listing sources, or asking questions), always check for `.workspace_context/notebooklm.json`. If it exists, verify it contains the correct workspace notebook ID and run `uvx --from notebooklm-py notebooklm use <notebook_id>` if needed to bind the session. If it does not exist, search the user's notebooks for a match with the project name (e.g., `MyDriveTools`), use it, and save the notebook ID to `.workspace_context/notebooklm.json` to initialize the project binding.



