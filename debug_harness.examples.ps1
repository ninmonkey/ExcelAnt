err -Clear
# remove-module Ninmonkey.Console
$PSStyle.OutputRendering = 'Ansi' # 'Ansi' | 'Host' | 'NoOutput' | 'PlainText'
. (gi -ea stop 'Examples/GitLogger/sql_fetch_test.ps1')



'done'
return



$HarnessExample = @{
    SourcePath = Get-Item (Join-Path $PSScriptRoot 'Source')
    OutputPath = Get-Item (Join-Path $PSScriptRoot 'Output')
    ImportMode = 'SourcePath' # [ SourcePath | OutputPath ]
}
$HarnessExample.ImportMode = 'OutputPath'
$HarnessExample.CurImportFullpath = (Join-Path $HarnessExample.($HarnessExample.ImportMode) 'ExcelAnt')



Push-Location -StackName 'harness' -Path $HarnessExample.SourcePath
build -Verbose -ea 'break' # currently this is skippable /w ImportMode == 'SourcePath'
Pop-Location -StackName 'harness'
'run build script here' | Write-Warning -wa 'Continue'

"importing mode: {0}, path:`n`t{1}" -f @(
    $HarnessExample.ImportMode
    $HarnessExample.CurImportFullpath | Join-String -DoubleQuote
) | Write-Warning -wa 'Continue'



Remove-Module 'ExcelAnt' -ea ignore
Import-Module $HarnessExample.CurImportFullpath -Force -Verbose
# import-module (Join-Path $HarnessExample.OutputPath 'ExcelAnt') -Force
# import-module (Join-Path $HarnessExample.SourcePath 'ExcelAnt') -Force

$error.Count
$error
# err -clear

Get-Command -m ExcelAnt
| Sort-Object CommandType, Name
| Format-Table Name -GroupBy CommandType

# 'see also: "https://github.com/PoshCode/Pansies/blob/main/Source/Private/_init.ps1"'
Get-Command -m excelant | Sort-Object Verb, Name | Format-Table Verb, Name -AutoSize

hr

get-module importexcel | Tablify.ModuleInfo
