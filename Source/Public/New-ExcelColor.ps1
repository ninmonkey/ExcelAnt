function New-ExcelTypeInfo {
    <#
    .SYNOPSIS
        sugar to get different excel types, exposing class and type references
    .examples
        see also:
        PS> find-type -FullName *excel*
    #>
    [Alias('debug.TypeInfo.ExcelColor')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet(
            'ExcelColor'
        )][string]$TypeName
    )
    switch($TypeName) {
        'ExcelColor' {
            return [ExcelColor]
        }
        default {
            "UnhandledTypeName: $TypeName"
        }
    }
    return $null
}
