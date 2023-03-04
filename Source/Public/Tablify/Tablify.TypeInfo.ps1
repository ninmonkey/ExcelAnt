
class tablify_TypeInfoRecord {
    <#
    .synopsis
        Tablify.TypeInfo
    .NOTES
    future:
        - [ ] add info on generics
    .EXAMPLE
        [tablify_TypeInfoRecord]::new(( gi . ))
    #>
    [string]$Name
    [string]$FullName
    [string]$BaseType
    [string]$Namespace
    [string]$Value
    # [object]$Value
    hidden [object]$ObjInstance

    tablify_TypeInfoRecord ( [object]$InputObject ) {
        $Obj = $InputObject
        $tinfo = $Obj.GetType()
        $this.ObjInstance = $Obj
        $this.ShortName = $tinfo | Ninmonkey.Console\Format-ShortSciTypeName
        $this.Name = $tinfo.Name
        $this.FullName = $tinfo.FullName
        $this.BaseType = $tinfo.BaseType
        $this.Namespace = $tinfo.Namespace
        $this.Value = $Obj.ToString()
    }

    [string] ToString() {
        $tinfo = $this.objInstance.GetType()
        return $Tinfo | Ninmonkey.Console\FOrmat-ShortSciTypeName | StripAnsi
    }
    [string] DisplayString() {
        $tinfo = $this.objInstance.GetType()
        return $Tinfo | Ninmonkey.Console\FOrmat-ShortSciTypeName

    }
}
# return @(
# $Tinfo | Format-GenericTypeName
# $Tinfo | FOrmat-ShortSciTypeName
# $Tinfo | Format-ShortTypeName
# $Tinfo | Format-TypeName
# ) | Join.UL
# return ''
# }
# [string] FullName() {
#     return $
# }


function Tablify.TypeInfo {
    <#
    .example
        Converts [PSModuleInfo] to tabular records
    .EXAMPLE
        get-date | Tablify.TypeInfo
    .EXAMPLE
        [tablify_TypeInfoRecord]::new( (gi . ))
        gi . | Tablify.TypeInfo
    .EXAMPLE
        (gi . | Tablify.TypeInfo).FormatType()

            - String[]
            - [DirectoryInfo]
            - [IO.DirectoryInfo]
            - DirectoryInfo
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject
    )
    begin {

    }
    process {
        [tablify_TypeInfoRecord]::new( $InputObject )
    }

}

[tablify_TypeInfoRecord]::new( (Get-Item . ))
