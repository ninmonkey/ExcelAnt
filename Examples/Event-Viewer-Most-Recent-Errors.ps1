# impo Ninmonkey.Console -MinimumVersion '0.2.49' -PassThru
Import-Module PSEventViewer

[hashtable]$App = & {
    $appRoot = Get-Item $PSScriptRoot
    $exportRoot = Join-Path $appRoot 'export'
    $hash = @{
        Root    = $appRoot | ForEach-Object ToString
        Export  = $ExportRoot
        Exports = @{}
        Config  = Join-Path $appRoot 'config'
    }
    $hash.Exports += @{
        LogSources = Join-Path $exportRoot  'EventViewer.sources.xlsx'
    }
    return $hash
}

$readme = @'
https://evotec.xyz/powershell-everything-you-wanted-to-know-about-event-logs/'
'@
& {
    $now ??= [Datetime]::Now
    $Filters = @{
        Dt = @{
            Last10Hours = $now.AddHours( -20 )
        }
    }
    # $App | Json -Depth 2
    $App | Json -Depth 2
    # silly dict math for fun
    # $target ??= (get-date).AddHours(-30)


    $logs = Get-Events -Level Error -LogName 'Application' -DateFrom $Filters.Dt.Last10Hours
    $logs.count

    $Pkg = Open-ExcelPackage -Create #-Path $App.Exports.LogSources
    $exportExcelSplat = @{
        InputObject   = $logs
        WorksheetName = 'LastTenHours'
        TableName     = 'LastTenHours_table'
        Title         = '{0} logs from command: Get-Events -Level Error -LogName ''Application'' -DateFrom $Filters.Dt.Last10Hours' -f @($logs.count)
        AutoSize      = $true
        Path          = $Pkg
    }

    $pkg = Export-Excel @exportExcelSplat -InputObject $Logs -PassThru
    Close-ExcelPackage $Pkg -Show -SaveAs $App.Exports.LogSources
}
