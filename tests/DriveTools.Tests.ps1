# DriveTools.Tests.ps1
Import-Module "$PSScriptRoot/../src/DriveTools.psm1" -Force

Describe "DriveTools Module" {
    It "loads without error" {
        $module = Get-Module DriveTools
        $module | Should Not Be $null
    }

    It "exports expected functions" {
        $expected = @(
            'Write-DriveToolsLog','Set-DriveToolsStatus','Clear-DriveToolsStatus','Get-DriveToolsStatus',
            'Show-DriveVisualMap','Update-DriveHashCache','Invoke-DriveAuditFast',
            'Invoke-DriveCategorize','Resolve-DriveDuplicates','Invoke-DriveCleanup',
            'Register-DriveMaintenanceTask','Get-DriveToolsRootPath','Get-DriveScanPrediction'
        )
        foreach ($fn in $expected) {
            $cmd = Get-Command $fn -ErrorAction SilentlyContinue
            $cmd | Should Not Be $null
        }
    }
}

Describe "Audit Functions (Mocked)" {
    It "runs fast audit with mock flag" {
        $path = Invoke-DriveAuditFast -UseMock -RootPath "C:\"
        $exists = Test-Path $path
        $exists | Should Be $true
        if ($exists) { Remove-Item -Path $path -Force }
    }
}

Describe "Visual Map (Mocked)" {
    It "generates tree map with mock flag" {
        $path = Join-Path $env:USERPROFILE "Desktop\DriveTools_VisualMap.txt"
        if (Test-Path $path) { Remove-Item $path -Force }
        $lines = Show-DriveVisualMap -UseMock -RootPath "C:\"
        $lines.Count | Should Not Be 0
        $exists = Test-Path $path
        $exists | Should Be $true
        if ($exists) { Remove-Item $path -Force }
    }
}

Describe "Categorization (Mocked)" {
    It "supports DryRun with mock flag" {
        { Invoke-DriveCategorize -DryRun -UseMock -RootPath "C:\" } | Should Not Throw
    }
}

Describe "Duplicates (Mocked)" {
    It "supports DryRun duplicate resolution with mock flag" {
        { Resolve-DriveDuplicates -DryRun -UseMock -RootPath "C:\" } | Should Not Throw
    }
}

Describe "Cleanup (Mocked)" {
    It "runs cleanup safely with mock flag" {
        { Invoke-DriveCleanup -RemoveEmptyDirectories -UseMock -RootPath "C:\" } | Should Not Throw
    }
}

Describe "Maintenance Task (Mocked)" {
    It "can register maintenance task with mock flag" {
        { Register-DriveMaintenanceTask -TaskName 'DriveTools_TestTask' -Schedule Daily -UseMock } | Should Not Throw
    }
}

Describe "Production Operations (Real Local Directory)" {
    BeforeEach {
        $Script:TestTempDir = Join-Path $PSScriptRoot "TempTestDir"
        if (Test-Path $Script:TestTempDir) { Remove-Item $Script:TestTempDir -Recurse -Force -ErrorAction SilentlyContinue }
        New-Item -Path $Script:TestTempDir -ItemType Directory | Out-Null
        New-Item -Path (Join-Path $Script:TestTempDir "test1.txt") -ItemType File -Value "content" | Out-Null
        New-Item -Path (Join-Path $Script:TestTempDir "test2.txt") -ItemType File -Value "content" | Out-Null
    }

    AfterEach {
        if (Test-Path $Script:TestTempDir) {
            Remove-Item $Script:TestTempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    It "runs fast audit on a real directory" {
        $csvPath = Join-Path $Script:TestTempDir "audit.csv"
        $path = Invoke-DriveAuditFast -RootPath $Script:TestTempDir -OutputCsvPath $csvPath
        $path | Should Be $csvPath
        Test-Path $csvPath | Should Be $true
    }

    It "generates a visual map on a real directory" {
        $mapPath = Join-Path $Script:TestTempDir "map.txt"
        $lines = Show-DriveVisualMap -RootPath $Script:TestTempDir -OutputPath $mapPath -MaxDepth 2
        $lines.Count | Should Not Be 0
        Test-Path $mapPath | Should Be $true
    }

    It "categorizes files in a real directory (DryRun)" {
        { Invoke-DriveCategorize -RootPath $Script:TestTempDir -DryRun } | Should Not Throw
    }

    It "resolves duplicates in a real directory (DryRun)" {
        { Resolve-DriveDuplicates -RootPath $Script:TestTempDir -DryRun } | Should Not Throw
    }

    It "cleans up empty directories in a real directory" {
        New-Item -Path (Join-Path $Script:TestTempDir "EmptyFolder") -ItemType Directory | Out-Null
        { Invoke-DriveCleanup -RootPath $Script:TestTempDir -RemoveEmptyDirectories } | Should Not Throw
        Test-Path (Join-Path $Script:TestTempDir "EmptyFolder") | Should Be $false
    }

    It "estimates scan duration for a path" {
        $prediction = Get-DriveScanPrediction -RootPath $Script:TestTempDir
        $prediction.EstimatedFileCount | Should Be 2
        $prediction.IncludeHashes | Should Be $false
        $prediction.TotalEstimatedDuration.TotalSeconds | Should BeGreaterThan 0
    }

    It "estimates scan duration with hashes" {
        $prediction = Get-DriveScanPrediction -RootPath $Script:TestTempDir -IncludeHashes
        $prediction.EstimatedFileCount | Should Be 2
        $prediction.IncludeHashes | Should Be $true
        $prediction.TotalEstimatedDuration.TotalSeconds | Should BeGreaterThan 0
    }

    It "throws error on invalid path" {
        { Get-DriveScanPrediction -RootPath "C:\NonExistentFolder_$(Get-Random)" } | Should Throw
    }
}
