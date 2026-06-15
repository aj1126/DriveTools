$module = Import-Module ../src/MyBookTools.psm1 -Force -PassThru
$commands = $module.ExportedFunctions.Keys

$apiPath = "../docs/api/MyBookTools.md"
Remove-Item $apiPath -ErrorAction SilentlyContinue

foreach ($cmd in $commands) {
    $help = Get-Help $cmd -Full | Out-String
    Add-Content -Path $apiPath -Value "## $cmd`n"
    Add-Content -Path $apiPath -Value "``````text`n$help`n``````"
}
