function Tablify.TypeInfo {
    <#
    .example
        Converts [PSModuleInfo] to tabular records
    #>
    # [Alias('xl.Object.TypeInfo')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject
    )
    begin {
        $InputObject
    }

}
