$Harness = @{
    SourcePath = GI (join-path $PSScriptRoot 'Source')
    OutputPath = GI (join-path $PSScriptRoot 'Output')
    ImportMode = 'SourcePath' # [ SourcePath | OutputPath ]
}
$Harness.ImportMode = 'OutputPath'
$Harness.CurImportFullpath = (Join-Path $Harness.($Harness.ImportMode) 'ExcelAnt')


pushd -StackName 'harness' $Harness.SourcePath
build # currently this is skippable /w ImportMode == 'SourcePath'
popd -stackname 'harness'
'run build script here' | write-warning -wa 'Continue'

"importing mode: {0}, path:`n`t{1}" -f @(
    $Harness.ImportMode
    $Harness.CurImportFullpath  | Join-string -DoubleQuote
) | write-warning -wa 'Continue'

remove-module 'ExcelAnt'
import-module $Harness.CurImportFullpath -Force
# import-module (Join-Path $Harness.OutputPath 'ExcelAnt') -Force
# import-module (Join-Path $Harness.SourcePath 'ExcelAnt') -Force

Get-Command -m ExcelAnt
| Sort-Object CommandType, Name
| Format-Table Name -GroupBy CommandType

# 'see also: "https://github.com/PoshCode/Pansies/blob/main/Source/Private/_init.ps1"'
