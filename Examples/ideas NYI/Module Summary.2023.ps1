Import-Module ExcelAnt -PassThru

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
$all = $q.All = Get-Command -m ExcelAnt -All
# $q.BaseTypeNames = gcm | % GetType | Sort -Unique Name | % Name
$q.BaseType_names = Get-Command | ForEach-Object GetType | ForEach-Object Fullname
$q.BaseType_info = @(Get-Command | ForEach-Object GetType | ForEach-Object Fullname | Sort-Object -Unique ) | ForEach-Object { $_ -as 'type' }

# visualize types
Get-Command -m ImportExcel -All | s -First 5 | Format-List -Force *
$q.BaseType_info | %{ $_ | xl.enumerateKeysOfType | join.ul }


'summary of '
$Q.Keys | Sort-Object | Join-String -op "`n - " -sep "`n - "

'common property names'
$q.BaseType_info | xl.enumerateKeysOfType | group -NoElement | sort Count -Descending



