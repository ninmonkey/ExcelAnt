function Close-ExcelWindow {
    <#
    .SYNOPSIS
        politely close all open excel windows. Modified files will prompt for you to save.
    .DESCRIPTION
        Polite version, does not create broken recovery files
    .EXAMPLE
        PS> Close-ExcelWindow
    #>
    [CmdletBinding()]
    [Alias('xL.Window.CloseAll')]

    $Ps = Get-Process *Excel* -ea ignore
    if ($PS) {
        $response = $ps.CloseMainWindow()
    }
    '{0} of {1} excel windows closed' -f @(
        ($response -eq $true).Count
        $ps.count
    ) | write-information -infa 'Continue'
}
