
function Close-ExcelWindow { # 'Close-ExcelWindow' = { 'xa.Window.Close' }
    <#
    .SYNOPSIS
        politely close all open excel windows. Modified files will prompt for you to save.
    .DESCRIPTION
        Polite version, does not create broken recovery files
    .EXAMPLE
        PS> Close-ExcelWindow
    #>
    [CmdletBinding()]
    [Alias('xa.Window.Close')]
    param(
        # Normally it briefly pauses, otherwise future code can run too early, before cleanup  is done (indirectly causing errors)
        [switch]$NoSleep,
        # default sleep duration
        [Alias('SleepMS')]
        $SleepDurationMS = 400
    )

    $Ps = Get-Process *Excel* -ea ignore
    if ($PS) {
        $response = $ps.CloseMainWindow()

    # render process metadata
@"
<ExcelInstance {pid: $( $Ps.Id ) , handle: $( $Ps.MainWindowHandle ) }
    MainWindowTitle: "$( $Ps.MainWindowTitle )"
    MainModule: "$( $Ps.MainModule )"
"@ | Write-verbose

        $Ps.MainModule.FileVersionInfo
            | ConvertTo-Json -Depth 0 -Compress
            | write-debug

        '{0} of {1} excel windows closed' -f @(
            ($response -eq $true).Count
            $ps.count
        )   | write-information -infa 'Continue'
        write-verbose 'This count doesn''t seem to return counts > 1, did it used to? or also, could it be how the multiple instances of excel is invoked?'
    }
    sleep -ms $SleepDurationMS
    # $Ps.Id
    # $Ps.MainWindowTitle
    # $Ps.MainModule
}


