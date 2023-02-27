function dropBlankKeys {
    <#
    .SYNOPSIS
        enumerate hashtable, drop any keys that have blankable vlaues
    #>
    [CmdletBinding()]
    [OutputType('Hashtable')]
    param(
        [Parameter(mandatory)]
        [hashtable]$InputHashtable,

        [switch]$NoMutate
    )
    $strUserKeyId = '[User={2} <CoId={0}, EmpId={1}>]' -f @(
        $finalObj.companyId
        $finalObj.employeeIdentifier
        $finalObj.userName
    )
    if ($NoMutate) {
        $targetHash = [hashtable]::new( $InputHashtable )
    }
    else {
        $targetHash = $InputHashtable
    }

    $msg = $targetHash.GetEnumerator()
    | Where-Object { [string]::IsNullOrEmpty( $_.Value ) }
    | ForEach-Object Name | Sort-Object -Unique
    | Join-String -sep ', ' -op "dropped blank fields on ${strUserKeyId}: "
    @{
        Message = $msg
    }
    | bdgLog -Category DataIntegrity -Message $msg -PassThru
    | Write-Verbose


    $toDrop = $targetHash.GetEnumerator()
    | Where-Object { [string]::IsNullOrEmpty( $_.Value ) }
    | ForEach-Object Name

    foreach ($k in $toDrop) {
        $targetHash.Remove( $k )
    }
    return $targetHash

}

# label '=== Reached final core_config.ps1 300.' $PSCommandPath
# | write-warning
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\core_config.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\stand_alone_entry.ps1 #>
