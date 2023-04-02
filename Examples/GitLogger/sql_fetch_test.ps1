Import-Module Ugit
Import-Module ImportExcel
Import-Module Pipeworks

gcm -m PipeWorks
| sort Name
| ft -auto -group Source

gcm -m pipeworks *sql* | sort Name |ft -auto

Get-SQLTable -ConnectionStringOrSetting 'SqlAzureConnectionString'
# | Update-TypeData -
# | Add-Member -MemberType 'PSTypeName' -TypeName 'Pipeworks.Sql.Table' -PassThru
