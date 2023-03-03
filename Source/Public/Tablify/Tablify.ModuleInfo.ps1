
function Tablify.ModuleInfo {
    <#
    .example
        Converts [PSModuleInfo] to tabular records
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object[]]$InputObject
    )

    process {

        wait-debugger
        $InputObject
    }

}
