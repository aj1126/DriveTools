# Project Workflow

## Guiding Principles

1.  **The Plan is the Source of Truth:** All work must be tracked in `plan.md`
2.  **The Tech Stack is Deliberate:** Changes to the tech stack must be
    documented in `tech-stack.md` *before* implementation
3.  **Test-Driven Development:** Write unit tests before implementing
    functionality
4.  **High Code Coverage:** Aim for >80% code coverage for all modules using Pester
5.  **User Experience First:** Every decision should prioritize user experience
6.  **Non-Interactive & CI-Aware:** Prefer non-interactive commands. Prevent automated tests/benchmarks from hanging on input prompts.

## Task Workflow

All tasks follow a strict lifecycle:

### Standard Task Workflow

1.  **Select Task:** Choose the next available task from `plan.md` in sequential
    order

2.  **Mark In Progress:** Before beginning work, edit `plan.md` and change the
    task from `[ ]` to `[~]`

3.  **Write Failing Tests (Red Phase):**
    -   Create or update Pester tests in `tests/DriveTools.Tests.ps1`.
    -   Write one or more unit tests that clearly define the expected behavior.
    -   **CRITICAL:** Run the tests and confirm that they fail as expected. This
        is the "Red" phase of TDD. Do not proceed until you have failing tests.

4.  **Implement to Pass Tests (Green Phase):**
    -   Write the minimum amount of PowerShell/C# code necessary to make the
        failing tests pass.
    -   Run the test suite again and confirm that all tests now pass. This is
        the "Green" phase.

5.  **Refactor (Optional but Recommended):**
    -   With the safety of passing tests, refactor the implementation code and
        the test code to improve clarity, remove duplication, and enhance
        performance without changing the external behavior.
    -   Rerun tests to ensure they still pass after refactoring.

6.  **Verify Coverage:** Run Pester test coverage reports if applicable:
    `Invoke-Pester -Path .\tests\DriveTools.Tests.ps1 -CodeCoverage .\DriveTools.psm1`
    Target: >80% coverage for new code.

7.  **Document Deviations:** If implementation differs from tech stack:
    -   **STOP** implementation
    -   Update `tech-stack.md` with new design
    -   Add dated note explaining the change
    -   Resume implementation

8.  **Commit Code Changes:**
    -   Stage all code changes related to the task.
    -   Propose a clear, concise commit message e.g, `feat(ui): Create basic WPF controls for Audit GUI`.
    -   Perform the commit.

9.  **Attach Task Summary with Git Notes:**
    -   **Step 9.1: Get Commit Hash:** Obtain the hash of the *just-completed commit* (`git log -1 --format="%H"`).
    -   **Step 9.2: Draft Note Content:** Create a detailed summary for the completed task.
    -   **Step 9.3: Attach Note:** Use the `git notes` command to attach the summary to the commit.

10. **Get and Record Task Commit SHA:**
    -   **Step 10.1: Update Plan:** Read `plan.md`, find the line for the completed task, update its status from `[~]` to `[x]`, and append the first 7 characters of the commit hash.
    -   **Step 10.2: Write Plan:** Write the updated content back to `plan.md`.

11. **Commit Plan Update:**
    -   Stage the modified `plan.md` file.
    -   Commit this change with a descriptive message (e.g., `conductor(plan): Mark task 'Create user model' as complete`).

### Task Correction & Plan Amendment Workflows

When an implemented task or phase requires corrections, amendments, or additions, follow these standard workflows:
1.  **In-Flight Refinements:** If minor gaps are found while a task is actively in-progress (`[~]`), make adjustments directly in the active implementation stream.
2.  **Code Review Corrections (`conductor-review`):** If issues are identified during a code review, run a review. The review agent will automatically append a `Review Fixes` phase to `plan.md`.
3.  **Logical State Reversions (`conductor-revert`):** If a task implementation is fundamentally flawed, run revert. This rolls back commits and resets the task state to pending `[ ]`.

### Phase Completion Verification and Checkpointing Protocol

1.  **Announce Protocol Start:** Inform the user that the phase is complete and the verification protocol has begun.
2.  **Ensure Test Coverage for Phase Changes:**
    -   **Step 2.1: Determine Phase Scope:** Get previous checkpoint SHA from `plan.md`.
    -   **Step 2.2: List Changed Files:** `git diff --name-only <previous_checkpoint_sha> HEAD`
    -   **Step 2.3: Verify and Create Tests:** Check code files (excluding `.md`, `.json`, etc.) and verify corresponding Pester tests exist.
3.  **Execute Automated Tests with Proactive Debugging:**
    -   Announce test command: `Invoke-Pester -Path .\tests\DriveTools.Tests.ps1`
    -   Execute and debug if necessary. Max 2 fix attempts before halting for guidance.
4.  **Propose a Detailed, Actionable Manual Verification Plan:**
    -   Detail manual steps to verify, e.g. run GUI or specific cmdlets with `-DryRun`.
5.  **Await Explicit User Feedback:**
    -   Pause and wait for user's explicit confirmation.
6.  **Identify Target Commit for Report:**
    -   Use the last functional commit made during this phase.
7.  **Attach Auditable Verification Report using Git Notes:**
    -   Attach verification notes using `git notes`.
8.  **Get and Record Phase Checkpoint SHA:**
    -   Append `[checkpoint: <sha>]` to the phase header in `plan.md`.
9.  **Commit Plan Update:**
    -   Commit the updated `plan.md` as `conductor(plan): Mark phase '<PHASE NAME>' as complete`.
10. **Announce Completion:** Inform the user that checkpointing is complete.

## Quality Gates

Before marking any task complete, verify:
- [ ] All Pester tests pass
- [ ] Code coverage meets requirements (>80%)
- [ ] Code follows project's code style guidelines
- [ ] All public functions have comment-based help block documentation (`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`)
- [ ] UTF-8 with BOM file encoding is used for files containing Unicode characters (required for WinPS 5.1 compatibility)
- [ ] Inline C# uses C# 5 or lower syntax limits
- [ ] No PSScriptAnalyzer errors or warnings

## Development Commands

### Setup

```powershell
# Import the module to verify dependencies and basic structure
Import-Module .\DriveTools.psd1 -Force
```

### Daily Development

```powershell
# Run the test suite via Pester
Invoke-Pester -Path .\tests\DriveTools.Tests.ps1

# Run static analysis
Invoke-ScriptAnalyzer -Path . -Recurse
```

### Before Committing

```powershell
# Run full validation
Invoke-ScriptAnalyzer -Path . -Recurse
Invoke-Pester -Path .\tests\DriveTools.Tests.ps1
```

## Testing Requirements

### Unit Testing
- Every public function must have corresponding Pester tests.
- Mock system/disk I/O operations where appropriate.
- Verify both success path and error handling pathways.
- Package string format arguments explicitly in an array first to avoid parameter unpacking failures in modules.
