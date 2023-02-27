function Enum.MembersFromTypeInfo {
    <#
    .SYNOPSIS
        list properties/keys from a [type] type, no objects yet.
    .example
        PS>

        $stuff = (gi .), (gi .\README.md)
        $tinfos = $stuff | % GetType | sort -Unique { $_.FullName }
        $tinfos | Enum.MembersFromTypeInfo | To-Xl
    #>
    [CmdletBinding()]
    [Alias('xl.enumerateKeysOfType')]
    param(
        [Parameter(ValueFromPipeline, Position=0, Mandatory)]
        [object] $InputObject
    )

    process {
        if ($_ -isnot 'type') { Write-Error "Arg is not a type: $_ " }
        $_ | ClassExplorer\Find-Member | ForEach-Object Name | Sort-Object -Unique
    }
}
