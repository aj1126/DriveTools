## Clear-DriveToolsStatus

```text

NAME
    Clear-DriveToolsStatus
    
SYNTAX
    Clear-DriveToolsStatus  
    
    
PARAMETERS
    None
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Get-DriveScanPrediction

```text

NAME
    Get-DriveScanPrediction
    
SYNOPSIS
    Predicts the duration of a scan on a given path.
    
    
SYNTAX
    Get-DriveScanPrediction [[-RootPath] <String>] [-IncludeHashes] [-UseCache] [<CommonParameters>]
    
    
DESCRIPTION
    

PARAMETERS
    -RootPath <String>
        The directory to analyze.
        
        Required?                    false
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -IncludeHashes [<SwitchParameter>]
        Whether the scan will compute hashes.
        
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -UseCache [<SwitchParameter>]
        Whether the scan will utilize the hash cache.
        
        Required?                    false
        Position?                    named
        Default value                True
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-DriveScanPrediction -RootPath M:\ -IncludeHashes
    
    
    
    
    
    
    
RELATED LINKS




```
## Get-DriveToolsRootPath

```text

NAME
    Get-DriveToolsRootPath
    
SYNTAX
    Get-DriveToolsRootPath [[-Path] <string>]  
    
    
PARAMETERS
    -Path <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Get-DriveToolsStatus

```text

NAME
    Get-DriveToolsStatus
    
SYNTAX
    Get-DriveToolsStatus  
    
    
PARAMETERS
    None
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Invoke-DriveAuditFast

```text

NAME
    Invoke-DriveAuditFast
    
SYNTAX
    Invoke-DriveAuditFast [[-RootPath] <string>] [[-OutputCsvPath] <string>] [-IncludeHashes] [-UseMock]  
    
    
PARAMETERS
    -IncludeHashes
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -OutputCsvPath <string>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -RootPath <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Invoke-DriveCategorize

```text

NAME
    Invoke-DriveCategorize
    
SYNTAX
    Invoke-DriveCategorize [[-RootPath] <string>] [[-CategoryMap] <hashtable>] [-DisableDefaultCategoryMap] [-DryRun] 
    [-UseMock] [-WhatIf] [-Confirm]  [<CommonParameters>]
    
    
PARAMETERS
    -CategoryMap <hashtable>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Confirm
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      cf
        Dynamic?                     false
        
    -DisableDefaultCategoryMap
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -DryRun
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -RootPath <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -WhatIf
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      wi
        Dynamic?                     false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Invoke-DriveCleanup

```text

NAME
    Invoke-DriveCleanup
    
SYNTAX
    Invoke-DriveCleanup [[-RootPath] <string>] [-RemoveEmptyDirectories] [-ReportDuplicates] [-CompressArchives] 
    [-UseMock] [-WhatIf] [-Confirm]  [<CommonParameters>]
    
    
PARAMETERS
    -CompressArchives
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Confirm
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      cf
        Dynamic?                     false
        
    -RemoveEmptyDirectories
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -ReportDuplicates
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -RootPath <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -WhatIf
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      wi
        Dynamic?                     false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Register-DriveMaintenanceTask

```text

NAME
    Register-DriveMaintenanceTask
    
SYNTAX
    Register-DriveMaintenanceTask [[-TaskName] <string>] [[-Schedule] <string>] [-UseMock]  
    
    
PARAMETERS
    -Schedule <string>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -TaskName <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Resolve-DriveDuplicates

```text

NAME
    Resolve-DriveDuplicates
    
SYNTAX
    Resolve-DriveDuplicates [[-RootPath] <string>] [-DryRun] [-UseMock] [-WhatIf] [-Confirm]  [<CommonParameters>]
    
    
PARAMETERS
    -Confirm
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      cf
        Dynamic?                     false
        
    -DryRun
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -RootPath <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -WhatIf
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      wi
        Dynamic?                     false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Set-DriveToolsStatus

```text

NAME
    Set-DriveToolsStatus
    
SYNTAX
    Set-DriveToolsStatus [[-Operation] <string>] [[-Details] <string>]  
    
    
PARAMETERS
    -Details <string>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Operation <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Show-DriveVisualMap

```text

NAME
    Show-DriveVisualMap
    
SYNTAX
    Show-DriveVisualMap [[-RootPath] <string>] [[-MaxDepth] <int>] [[-OutputPath] <string>] [-UseMock]  
    
    
PARAMETERS
    -MaxDepth <int>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -OutputPath <string>
        
        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -RootPath <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Update-DriveHashCache

```text

NAME
    Update-DriveHashCache
    
SYNTAX
    Update-DriveHashCache [[-RootPath] <string>] [[-CachePath] <string>] [-UseMock]  
    
    
PARAMETERS
    -CachePath <string>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -RootPath <string>
        
        Required?                    false
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -UseMock
        
        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
## Write-DriveToolsLog

```text

NAME
    Write-DriveToolsLog
    
SYNTAX
    Write-DriveToolsLog [-Message] <string> [[-Level] {Info | Warning | Error}]  [<CommonParameters>]
    
    
PARAMETERS
    -Level <string>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Message <string>
        
        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None




```
