Err -clear
# Import-Module 'H:\data\2023\pwsh\GitLogger' -Force -MinimumVersion 0.1.0 -PassThru -ea 'stop'
impo 'H:\data\2023\pwsh\GitLogger' -Force -Verbose:$false # *>$null
Import-Module ExcelAnt -PassThru -Force -MinimumVersion 0.0.3  -Verbose:$false # *>$null
IMport-module PipeWorks

function xl.enumerateKeysOfType {
    <#
    .SYNOPSIS
        list properties/keys from a [type] type, no objects yet.
    #>
    process {
        if ($_ -isnot 'type') { Write-Error "Arg is not a type: $_ " }
        $_ | ClassExplorer\Find-Member | ForEach-Object Name | Sort-Object -Unique
    }
}


$q = @{}
$all = $q.All ??= Get-Command -m ExcelAnt -All


return
# $q.BaseTypeNames = gcm | % GetType | Sort -Unique Name | % Name
$q.BaseType_names = Get-Command | ForEach-Object GetType | ForEach-Object Fullname | Sort-Object -Unique
$q.BaseType_info = @(Get-Command | ForEach-Object GetType | ForEach-Object Fullname | Sort-Object -Unique ) | ForEach-Object { $_ -as 'type' }

# visualize types
Get-Command -m ImportExcel -All | s -First 5 | Format-List -Force *
$q.BaseType_info | ForEach-Object { $_ | xl.enumerateKeysOfType | join.ul }


'summary of '
$Q.Keys | Sort-Object | Join-String -op "`n - " -sep "`n - "

'common property names'
$q.BaseType_info | xl.enumerateKeysOfType | Group-Object -NoElement | Sort-Object Count -Descending



