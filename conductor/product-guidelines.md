# Product Guidelines - DriveTools

## Branding, Voice, and Tone
1. **Developer-First & Professional**: The cmdlets should use standard, predictable PowerShell verb-noun naming conventions (`Invoke-DriveAuditFast`, `Resolve-DriveDuplicates`). Output objects should be cleanly structured and pipeline-friendly.
2. **Reliable & Reassuring**: Since the tool performs write operations (like file moving, deletion, and directory purging), progress logs and command confirmations must be clear, transparent, and explicit.
3. **Informative & Clean UI**: The console outputs (e.g. tree maps) should use neat box-drawing glyphs. The WPF GUI must remain responsive, with clear progress bars and smooth background runspace updates.

## User Experience (UX) Principles
1. **Asynchronous Non-blocking Operations**: Any task that reads from or writes to a disk (e.g. scanning, hashing, purging) MUST run asynchronously inside background threads or PowerShell Runspaces to keep the interface highly responsive.
2. **Safety First (Dry Run)**: All destructive commands (e.g., file deduplication, cleanup, categorization) must support a `-DryRun` switch or equivalent confirmation pattern to let users review planned changes before committing them to disk.
3. **No Console Hanging**: Provide frequent, granular updates on current tasks, especially when traversing large directories. Use decoupled progress timers (updating every 250ms) to notify the user.
