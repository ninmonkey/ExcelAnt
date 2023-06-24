
# [ValidateNotNull()][hashtable]$script:__xaConfigState = @{}
function Set-ExcelAntConfig {
    <#
    .SYNOPSIS
        return config as nested hashtables, to be modified
    .DESCRIPTION
        totally truncates the existing config with your new config
    .EXAMPLE
        Get-ExcelAntConfig | ConvertTo-Json
        $XantConf = Get-ExcelAntConfig
        $XantConf.Path.ExportTempFolder = 'g:\temp\xl'
        Set-ExcelAntConfig $xAntConf -Verbose
    .LINK
        Get-ExcelAntConfig
    .LINK
        Set-ExcelAntConfig
    #>
    [CmdletBinding()]
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory, Position=0)]
        [hashtable]$InputObject
    )
    # $state = $script:__xaConfigState
    $script:__xaConfigState = $InputObject

    Get-ExcelAntConfig
        | ConvertTo-Json -depth 6 | Join-string -op "Set Config: `n" -sep "`n"
        | Write-Verbose
        # | write-host -fg 'gray70' -bg gray30
}
