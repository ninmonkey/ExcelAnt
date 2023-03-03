Function ExcelAnt.Join-Hashtable {
    <#
    .description
        Copy and append BaseHash with new values from UpdateHash
    .notes
        future: add valuefrom pipeline to $UpdateHash param ?

    .example
        Join-Hashtable -Base $
    .link
        Ninmonkey.Console\Join-Hashtable
    .link
        Ninmonkey.Console\Merge-HashtableList
    .link
        Ninmonkey.Powershell\Join-Hashtable
    .link
        PSScriptTools\Join-Hashtable
    #>
    # [Alias('mergeHashtable')]

    [Alias(
        # 'xl.mergeHashtable',
        'ExcelAnt.MergeHashtable'
    )]
    [OutputType('System.Collections.Hashtable')]
    [cmdletbinding()]
    [outputType(
        'System.Collections.Hashtable'
        # 'System.Collections.Specialized.OrderedDictionary' # not currently, but may
    )]
    param(
        # base hashtable
        # [ValidateNotNull()] # ?
        [AllowNull()]
        [Parameter(Mandatory)][hashtable]$BaseHash,

        # New values to append and/or overwrite
        # or allow null, coerce to empty hash ?
        # [ValidateNotNull()]
        [AllowNull()]
        [Parameter(Mandatory)][hashtable]$OtherHash,

        # default is case-insensitive, to align with regular defaults
        [ArgumentCompletions(
            'InvariantCulture', # todo: make re-usable string comparer transformation attribute
            'InvariantCultureIgnoreCase',
            'CurrentCulture',
            'CurrentCultureIgnoreCase',
            'Ordinal',
            'OrdinalIgnoreCase' )]
        [System.StringComparer]
        [Parameter()]$ComparerType = [StringComparer]::CurrentCultureIgnoreCase,

        # normal is to not modify left, return a new hashtable
        [Parameter()][switch]$MutateLeft
    )

        $BaseHash ??= @{}
        $OtherHash ??= @{}

        if (! $MutateLeft ) {
            $TargetHash = [hashtable]::new( $BaseHash, $ComparerType )
        } else {
            Write-Debug 'Mutate enabled'
            $TargetHash = $BaseHash
        }
        $OtherHash.GetEnumerator() | ForEach-Object {
            $TargetHash[ $_.Key ] = $_.Value
        }

        return $TargetHash
}

