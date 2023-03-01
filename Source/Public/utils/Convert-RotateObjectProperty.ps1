function Convert-RotateObjectProperty {
    <#
    .SYNOPSIS
        pivot into key value pairs
    .example
        Ps> b.rotateProperties $this | to-xl
    #>
    [Alias('xl.Object.RotateProperties')]
    param(
        # takes one PSObject and rotates the properties
        [Parameter(Mandatory, Position = 0)]
        [Object]$InputObject
    )
    $InputObject.PSObject.Properties | sort Name | %{
        $meta = [ordered]@{}
        $meta[ 'Property' ] = $_.Name
        $meta[ 'Value' ] = $_.Value
        [pscustomobject]$meta
    }
}
