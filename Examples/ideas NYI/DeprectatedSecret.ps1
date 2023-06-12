throw 'see also: <file:///H:\data\2023\dotfiles.2023\pwsh\src\autoloadNow_ArgumentCompleter-butRefactor.ps1>'

## module deprecated, just a chance for quick completion test

# Get-SecureSetting | % Name

<#
- see: <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/register-argumentcompleter?view=powershell-7.4>
- native command sample: <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/register-argumentcompleter?view=powershell-7.4#example-3-register-a-custom-native-argument-completer>
#>

function completer.Values.FromSetting {
    Import-Module Pipeworks
    Pipeworks\Get-SecureSetting | ForEach-Object Name | Sort-Object -Unique
}
function completer.Values.FromEnum {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER EnumType
    Parameter description

    .EXAMPLE
    Ps> [Enum]::GetValues( [System.Management.Automation.CompletionResultType] )

    .NOTES
    General notes
    #>
    param( [enum]$EnumType )

}
$NewSB = {
    <#
    #>
    param(
        $commandName, # 'Get-SecureSetting'
        $parameterName, # 'Name'
        $wordToComplete, # ''
        $commandAst, # { .. }
        $fakeBoundParameters # @{}
    )

    completer.Values.FromSetting | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# Register-ArgumentCompleter -CommandName Get-SQLTable -ParameterName ConnectionStringOrSetting -ScriptBlock $NewSB
# Register-ArgumentCompleter -CommandName Pipeworks\Get-SecureSetting -ParameterName Name -ScriptBlock $NewSB -Verbose
Register-ArgumentCompleter -CommandName Get-SecureSetting -ParameterName Name -ScriptBlock $NewSB -Verbose
