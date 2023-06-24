# [ValidateNotNull()][hashtable]$script:__xaConfigState = @{}

function Get-ExcelAntConfig {
    <#
    .SYNOPSIS
        return config as nested hashtables, to be modified
    .LINK
        Get-ExcelAntConfig
    .LINK
        Set-ExcelAntConfig
    #>
    [CmdletBinding()]
    param()
    $state = $script:__xaConfigState

    $defaultValue =  @{
        Path = @{
            ExportTempFolder = 'g:\temp\xAnt'
        }
    }

    if ($state.keys.count -eq 0) {
        Write-Verbose 'Get-ExcelAntConfig: falling back to default values'
        $state = $defaultValue
    }
    return $state
}
