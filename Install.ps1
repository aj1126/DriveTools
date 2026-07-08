#Requires -Version 5.1

# Get module version from the manifest
$manifestPath = Join-Path $PSScriptRoot "src\DriveTools.psd1"
if (-not (Test-Path $manifestPath)) {
    Write-Error "Could not find manifest at $manifestPath"
    return
}
$manifest = Import-PowerShellDataFile $manifestPath
$version = $manifest.ModuleVersion

# Determine user modules directory depending on PowerShell engine
if ($PSEdition -eq 'Core') {
    $moduleRoot = "$Home\Documents\PowerShell\Modules"
} else {
    $moduleRoot = "$Home\Documents\WindowsPowerShell\Modules"
}

$destPath = Join-Path $moduleRoot "DriveTools\$version"

Write-Host "Installing DriveTools v$version to $destPath..." -ForegroundColor Cyan

# Create destination folder
if (-not (Test-Path $destPath)) {
    New-Item -ItemType Directory -Path $destPath -Force | Out-Null
}

# Copy files from src/
Copy-Item -Path (Join-Path $PSScriptRoot "src\*") -Destination $destPath -Force

# Clean up any stale/mismatched version subfolders under DriveTools to avoid version mismatch errors
$parentDir = Join-Path $moduleRoot "DriveTools"
if (Test-Path $parentDir) {
    Get-ChildItem -Path $parentDir -Directory | Where-Object { $_.Name -ne $version } | ForEach-Object {
        Write-Host "Cleaning up old/mismatched version folder: $($_.FullName)" -ForegroundColor Yellow
        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Import module to verify and load
Import-Module DriveTools -Force
Write-Host "DriveTools v$version installed and imported successfully!" -ForegroundColor Green
