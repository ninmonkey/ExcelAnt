Import-Module ExcelAnt -PassThru *>$null
Import-Module Pipeworks, ugit
impo -Force -pass 'H:\data\2023\pwsh\GitLogger\GitLogger.psd1'

# Get-SQLTable -ConnectionStringOrSetting 'SqlAzureConnectionString'

pushd -stack 'xltest' $PSScriptRoot
$table_schema = Get-SQLTable -ConnectionStringOrSetting 'SqlAzureConnectionString'
| Select TableSchema, TableName, Columns, DataTypes

remove-item 'xltest.xlsx' -ea ignore #-Force
$Pkg = Open-ExcelPackage -Path 'xltest.xlsx' -Create #-KillExcel

$table_column_schema = Get-SQLTable -ConnectionStringOrSetting 'SqlAzureConnectionString' -TableName 'github_dot_com_StartAutomating_ShowDemo_Commits'

$Pkg = $table_schema
| Export-Excel -ExcelPackage $Pkg -WorksheetName 'TablesListing' -TableName 'TablesListingTable' -AutoSize -PassThru

# $xpand = $TableSchema | %{
#     $colNames = $_.Columns
#     foreach($i in 0..($ColNames.Count -1 ) ) {
#         $ColNames | Add-Member -memberType NoteProperty -Name "CurCol" -Value $ColNames[$i] -PassThru -Force
#     }
# }
# wait-debugger
# Sql -TableName 'github_dot_com_StartAutomating_ugit_Commits'
$records = Pipeworks\Select-SQL -FromTable $table_name
$table_name ='github_dot_com_StartAutomating_ugit_Commits'
$single_table_schema =  $table_schema | ? TableName -eq $table_name
$single_table_columnNames = $single_table_schema.Columns | Sort-Object -Unique
# (gcl -Raw) -split '\s+' | ?{ $_ } |Join-String -sep ',' -SingleQuote

# $column_schema = Get-Ta

$Pkg = $records
| Export-Excel -ExcelPackage $Pkg -WorksheetName 'rowsOfTable' -TableName 'rowsOfTable' -AutoSize -PassThru

Close-ExcelPackage -Show $Pkg

popd -stack 'xltest'
return

# function xl.enumerateKeysOfType {
#     <#
#     .SYNOPSIS
#         list properties/keys from a [type] type, no objects yet.
#     #>
#     process {
#         if ($_ -isnot 'type') { Write-Error "Arg is not a type: $_ " }
#         $_ | ClassExplorer\Find-Member | ForEach-Object Name | Sort-Object -Unique
#     }
# }


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



