function NewSafeTimeString {
     # timenow for safe filepaths: "2022-08-17_12-46-47Z".
     # distinct values to the precision level of a full second
     param(
        [Parameter(Position=0)]
        [ArgumentCompletions('export-{0}.xlsx', 'autoexport_{0}.xlsx')]
        [string]$FilenameTemplate = 'autoexport_{0}.xlsx'
     )
     $when = (Get-Date).ToString('u') -replace '\s+', '_' -replace ':', '-'
     $FilenameTemplate -f $when
}

$ExcelPath = Join-path 'g:\temp' (New-SafeTimeString -FilenameTemplate 'export-{0}.xlsx')

Remove-Item -ea ignore $ExcelPath
$Pkg = Open-ExcelPackage -Path $ExcelPath -Create


$shareSplat = @{
    'TableStyle' = 'Light2'
    AutoSize = $true
    PassThru = $True
}

# example using Ps5 syntax
$Pkg = @( gci ~ -file ) |
    Select-Object Name, Extension, Length, Parent, FullName, LastWriteTime, CreationTime |
    Export-Excel @shareSplat -ExcelPackage $Pkg -table 'AppData' -WorksheetName 'AppDataSheet'

$pkg = @( gci $Env:LOCALAPPDATA ) |
    Select-Object Name, Length, FullName, LastWriteTime, CreationTime |
    Export-Excel @shareSplat -ExcelPackage $Pkg -table 'LocalAppData' -WorksheetName 'LocalAppDataSheet'

'wrote file: {0}' -f @( $Pkg.File )
Close-ExcelPackage $Pkg -Show
