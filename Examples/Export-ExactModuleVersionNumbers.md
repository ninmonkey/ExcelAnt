```ps1
Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
Format-ExcelAntExactModuleVersions -OutputType Basic
Format-ExcelAntExactModuleVersions -OutputType 
```




|DisplayHint|Date               |Day|DayOfWeek|DayOfYear|Hour|Kind |Millisecond|Microsecond|Nanosecond|Minute|Month|Second|Ticks             |TimeOfDay       |Year|
|-----------|-------------------|---|---------|---------|----|-----|-----------|-----------|----------|------|-----|------|------------------|----------------|----|
|DateTime   |04/03/2023 00:00:00|3  |Monday   |93       |18  |Local|47         |714        |900       |33    |4    |46    |638161436260477149|18:33:46.0477149|2023|




```ps1
Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
```


Import-Module 'CimCmdlets' -RequiredVersion = '7.0.0.0'
Import-Module 'Configuration' -RequiredVersion = '1.5.1'
Import-Module 'ExcelAnt' -RequiredVersion = '0.0.7'
Import-Module 'ImportExcel' -RequiredVersion = '7.6.0'
Import-Module 'Metadata' -RequiredVersion = '1.5.5'
Import-Module 'Microsoft.PowerShell.Management' -RequiredVersion = '7.0.0.0'
Import-Module 'Microsoft.PowerShell.Utility' -RequiredVersion = '7.0.0.0'
Import-Module 'ModuleBuilder' -RequiredVersion = '2.0.0'
Import-Module 'Ninmonkey.Console' -RequiredVersion = '0.2.42'
Import-Module 'Pansies' -RequiredVersion = '2.6.0'
Import-Module 'PipeScript' -RequiredVersion = '0.2.4'
Import-Module 'PipeScript.format.ps1xml' -RequiredVersion = '0.0'
Import-Module 'PSReadLine' -RequiredVersion = '2.2.6'


```ps1
Format-ExcelAntExactModuleVersions -OutputType Basic
```


'CimCmdlets = 7.0.0.0',
'Configuration = 1.5.1',
'ExcelAnt = 0.0.7',
'ImportExcel = 7.6.0',
'Metadata = 1.5.5',
'Microsoft.PowerShell.Management = 7.0.0.0',
'Microsoft.PowerShell.Utility = 7.0.0.0',
'ModuleBuilder = 2.0.0',
'Ninmonkey.Console = 0.2.42',
'Pansies = 2.6.0',
'PipeScript = 0.2.4',
'PipeScript.format.ps1xml = 0.0',
'PSReadLine = 2.2.6'

```ps1
Format-ExcelAntExactModuleVersions -OutputType MdTable -ea 'continue'
```


'| CimCmdlets | 7.0.0.0 |'
'| Configuration | 1.5.1 |'
'| ExcelAnt | 0.0.7 |'
'| ImportExcel | 7.6.0 |'
'| Metadata | 1.5.5 |'
'| Microsoft.PowerShell.Management | 7.0.0.0 |'
'| Microsoft.PowerShell.Utility | 7.0.0.0 |'
'| ModuleBuilder | 2.0.0 |'
'| Ninmonkey.Console | 0.2.42 |'
'| Pansies | 2.6.0 |'
'| PipeScript | 0.2.4 |'
'| PipeScript.format.ps1xml | 0.0 |'
'| PSReadLine | 2.2.6 |'



```ps1
Format-ExcelAntExactModuleVersions -OutputType Json
```


[{"Version":"7.0.0.0","Name":"CimCmdlets"},{"Version":"1.5.1","Name":"Configuration"},{"Version":"0.0.7","Name":"ExcelAnt"},{"Version":"7.6.0","Name":"ImportExcel"},{"Version":"1.5.5","Name":"Metadata"},{"Version":"7.0.0.0","Name":"Microsoft.PowerShell.Management"},{"Version":"7.0.0.0","Name":"Microsoft.PowerShell.Utility"},{"Version":"2.0.0","Name":"ModuleBuilder"},{"Version":"0.2.42","Name":"Ninmonkey.Console"},{"Version":"2.6.0","Name":"Pansies"},{"Version":"0.2.4","Name":"PipeScript"},{"Version":"0.0","Name":"PipeScript.format.ps1xml"},{"Version":"2.2.6","Name":"PSReadLine"}]


