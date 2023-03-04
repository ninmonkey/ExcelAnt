function xa.__getKeyNames {
    <#
    .SYNOPSIS
        internal. returns either [1] keys of a hashtable or [2] property names of an object
    .NOTES
    future:
        - [ ] ensure it works properly on all dictionary-like types
    .LINK
        ExcelAnt\xa.__getTypeNames
    #>
    [Alias(
        # 'xa.Object.MembersOf',
        'xa.KeysOf',
        'xa.Object.KeysOf'
    )]
    [Cmdletbinding()]
    [OutputType('[string[]]')]
    param(
        [Parameter(ValueFromPipeline)]
        [object]$InputObject
    )
    process{
        if($InputObject -is 'hashtable') {
            return $InputObject.Keys.clone() | Sort-Object -unique
        } else {
            return $InputObject.PSObject.Properties.Name | Sort -unique
        }
    }
}
function xa.__getTypeNames {
    <#
    .SYNOPSIS
        internal. return typeinfo, using different formats
    .NOTES
    future:
        - [ ] ensure it works properly on all dictionary-like types
    .EXAMPLE
        $Sample1 = @{ a = 10; q = 23; 'sdf' = 4 }

        # try:
            $Sample1 | xa.KeysOf
            $Sample1 | xa.TypeOf
            $Sample1 | xa.TypeOf -FormatMode FullName
            $Sample1 | xa.TypeOf -FormatMode TypeInfo
            $Sample1 | xa.TypeOf -FormatMode Name
            $Sample1 | xa.TypeOf -FormatMode TypeInfo
            $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-ShortTypeName
            $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-GenericTypeName
            $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-ShortSciTypeName
            $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-TypeName
    .LINK
        ExcelAnt\xa.__getKeyNames
    #>
    [Alias(
        # 'xa.Object.MembersOf',
        'xa.TypeOf'
        # 'IsKind' ?
        # 'IsA' ?
        # 'xa.Object.TypeOf'
    )]
    [Cmdletbinding()]
    [OutputType('[string[]]')]
    param(
        [AllowNull()]
        [AllowEmptyString()]
        [Parameter(ValueFromPipeline, Position = 0)]
        [object]$InputObject,

        [Parameter()]
        [ArgumentCompletions(
            'FullName', 'Name',
            'PSTypeName',
            'TypeInfo'
        )]
        [string]$FormatMode = 'Name'
    )
    process{
        $Tinfo = $InputObject
        if($InputObject -isnot 'type') {
            $Tinfo = $InputObject.GetType()
        }
        switch($FormatMode) {

            'FullName' {
                return $Tinfo.FullName
            }
            'Name' {
                return $Tinfo.Name
            }
            'PSTypeName' {
                return $Tinfo.PSTypeNames | Join-String -sep ', ' -SingleQuote Name
            }
            'TypeInfo' {
                return $Tinfo
            }
            default {
                throw 'Format NotYetImplemented: {0}' -f @($FormatMode)
            }
        }
    }
}

