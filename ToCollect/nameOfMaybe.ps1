function Get-Names {
    [Alias('xl.Object.Name')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject,

        [ValidateSet(
            'Property',
            'Method',
            'Event',
            'NoteProperty',
            'AliasProperty',
            'ScriptProperty',
            'MemberSet',
            'All'
        )]
        [Alias('Of')]
        [string[]]$PropertyType
    )
    process {
        switch($PropertyType) {
            'Property' {
                $InputObject.PSObject.Properties
            }
            'ShortName' {
                $inputObject.GetType().Name
            }
            'TypeInfo' {

            }

            default { write-warning "NYI: PropertyHandler for '$PropertyType'" }
        }
        # use PSCustomObject PSMemberInfo return set of all properties

    }
}
