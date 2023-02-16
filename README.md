# ExcellAnt

A wrapper for ImportExcel using my defaults.
Pronounced ex-cell-ant, or ExcelEnt.

<!--


Excel. Ant? Ent?
Ex-Cell, Ant?
Excelence
exCellenche (pronounced: Ex-Cell-Ants)


-->
see more:
- https://github.com/StartAutomating/PSDevOps
- command cheatsheet/lookup `Get-Command -Module PSDevOps`
- [azure devops logging commands](https://learn.microsoft.com/en-us/azure/devops/pipelines/scripts/logging-commands?view=azure-devops&tabs=bash)
- [github actions](https://github.com/StartAutomating/PSDevOps#write-github-actions)

from: [PSDevOps: creating-complex-pipelines](https://github.com/StartAutomating/PSDevOps#creating-complex-pipelines)

```ps1
# create a cross-platform test of the current repository's PowerShell module.
New-ADOPipeline -Job TestPowerShellOnLinux, TestPowerShellOnMac, TestPowerShellOnWindows

New-ADOPipeline -Stage PowerShellStaticAnalysis, TestPowerShellCrossPlatform, UpdatePowerShellGallery
```

