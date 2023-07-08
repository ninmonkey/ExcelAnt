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
    param(
        # how to transform the [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.RuleInfo]
        [Alias('ScriptAnalyzerRule')]
        [Parameter(ValueFromPipeline)]
        # [object]
        [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.RuleInfo]$InputObject,

        # default is aka 'implicit', verbose is '*'
        [ValidateSet('Default','Verbose')]
        [Parameter( Position=0)]
        [string]$OutputStyle = 'Default'

    )
    process {
        switch($OutputStyle){
            'Default' {
                $InputObject
                    #| Select-Object
                    # | Dotils.Select-ExcludeBlankProperty
            }
            'Verbose' {
                $InputObject
                    | Select-Object -Prop '*' -ea 'ignore'
                    # | Dotils.Select-ExcludeBlankProperty
            }
            default { throw "unknown OutputStyle: $OutputStyle" }
        }
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
$all_rules = @(
    Get-ScriptAnalyzerRule
    | Sort-Object RuleName, Severity, SourceName
)

$Pkg =
    $all_rules
        | Transform.ProcessRecord
        | Sort-Object RuleName, Severity, SourceName
        | Export-Excel $Pkg -work 'All_Default' -table 'All_Default_table' @sharedSplat
$Pkg =
    $all_rules
        | Transform.ProcessRecord -OutputStyle 'Verbose'
        | Sort-Object RuleName, Severity, SourceName
        | Export-Excel $Pkg -work 'All_Star' -table 'All_Star_table' @sharedSplat

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



