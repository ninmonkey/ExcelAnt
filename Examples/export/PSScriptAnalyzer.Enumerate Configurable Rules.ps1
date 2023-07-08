# Configurable rules are disabled by default unless you configure them. search for those.
@(
    Import-Module 'ImportExcel' -PassThru -ea 'stop'
    # Import-Module 'ExcelAnt' -PassThru -ea 'continue'
    Import-Module 'PSScriptAnalyzer' -ea 'stop' -PassThru
) | Join-string { $_.Name, $_.Version -join ' = '} -sep ', '

$ExampleConfig = @{
    ExportTempFile = $true
    ExportPath = Join-Path $PSScriptRoot 'output/PSScriptAnalyzer-ConfigurableRules.xlsx'
}
MkDir -path (Join-Path $PSScriptRoot 'output') -ea 'ignore'
remove-item -LiteralPath $ExampleConfig.ExportPath -ea 'ignore'

$Pkg = Open-ExcelPackage -path $ExampleConfig.ExportPath -Create

function Transform.ProcessRecord {
    process {
        $item = $_
        $item
            | Select-Object -Prop '*', 'b' -ea 'ignore'
            | Dotils.Select-ExcludeBlankProperty
    }
}

$sharedSplat = @{
    AutoFilter    = $true
    AutoNameRange = $true
    AutoSize      = $true
    PassThru      = $true
    TableStyle    = 'Light2'
    Verbose       = $true
}
$Pkg =
    $Pkg
    # | Transform.ProcessRecord
    | Export-Excel $Pkg -work 'ProcList' -table 'ProcList_table' @sharedSplat

$closeSplat = @{
    ExcelPackage = $Pkg
    SaveAs       = $ExampleConfig.ExportPath
    Show         = $true
    Verbose      = $true
    # SaveAs       = $ExportPath
    # Calculate    = $true
    # ReZip        = $true
}

gcm -m PSScriptAnalyzer | ft -AutoSize

Close-ExcelPackage @closeSplat
$closeSplat.SaveAs | Join-String -f 'wrote: <file:///{0}>'



