## ExcelAnt

A wrapper for ImportExcel using my defaults.
Pronounced as `Ex-Cell-Ant`, or `Excellent`.

## Examples

- Easily Output all loaded modules and version numbers [Export Module Version Numbers](./Examples/Export-ExactModuleVersionNumbers.md)

## More

- Powered by the great [ImportExcel](https://github.com/dfinke/ImportExcel) module
- Files with the extension `*.ps.*` are source generators using the module [PipeScript](https://github.com/StartAutomating/PipeScript)
- Uses git repo metrics from [GetGitlogger](https://gitlogger.com)
- To Inspect types in Powershell: [ClassExplorer](https://github.com/SeeminglyScience/ClassExplorer)


## Prounced on
<!--


Excel, Ant? Ent?
Ex-Cell Ant?
Excelence
exCellenche (pronounced: Ex-Cell-Ants)

still missing?

- name: UsePSDevOps
  uses: StartAutomating/PSDevOps@v0.5.8


-->


<!--
see more:

- https://github.com/StartAutomating/PSDevOps
- command cheatsheet/lookup `Get-Command -Module PSDevOps`
- [azure devops logging commands](https://learn.microsoft.com/en-us/azure/devops/pipelines/scripts/logging-commands?view=azure-devops&tabs=bash)
- [github actions](https://github.com/StartAutomating/PSDevOps#write-github-actions)
- [sample module builder.ps1](https://github.com/Jaykul/TerminalBlocks/blob/main/source/Generators/ModuleBuilderExtensions.ps1)
- [invoke-build concepts wiki](https://github.com/nightroman/Invoke-Build/wiki/Concepts)
- [recursive scriptAnalyzer rules Indented.IP](https://github.com/indented-automation/Indented.Net.IP/blob/main/Indented.Net.IP/tests/PSScriptAnalyzer.tests.ps1)
from: [PSDevOps: creating-complex-pipelines](https://github.com/StartAutomating/PSDevOps#creating-complex-pipelines)

```ps1
# create a cross-platform test of the current repository's PowerShell module.
New-ADOPipeline -Job TestPowerShellOnLinux, TestPowerShellOnMac, TestPowerShellOnWindows

New-ADOPipeline -Stage PowerShellStaticAnalysis, TestPowerShellCrossPlatform, UpdatePowerShellGallery
```

-->
