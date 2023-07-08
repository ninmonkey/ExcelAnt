Import-Module 'ImportExcel' -ea 'stop'
<#
About:
    I was trying move a folder that a workspace was in.
    I had vs coded open, opened a project.code-workspace file.
    closed that window.

    MicrosoftPowerToys reported the blocking process was pwsh with Pid
    was blocking path:

        H:\data\2023\pwsh\PsModules\TypeWriter

    the parent window though, was 'otherStuff'. An entirely different project.
    I verified it wasn't a git repo or readonly file attribute, that was in place.

    There was a file lock on the no-longer-opened folder. explorer,
    etc weren't using it. So I went to see where this 'pwsh' process was from

    I was curious if maybe the dialog to close terms didn't kill it
    it appears that the other vs code process that was still open,
    was the parent, so this pwsh didn't exit.
#>

$PropertyName = @{
    Ancestor = 'Name', '*Path*', '*commandLine', '*parent*', 'Company', 'Description', 'Product', 'Handle', 'HasExited', 'StartTIme', 'ExitCode', 'SessionId', 'MainModule', 'ProcessName', 'MainWindowHandle', 'MainWindowTitle', 'Responding', '*'
}
$blockingPs ??= Get-Process -id 24560
[Collections.Generic.List[Object]]$anne<#cestors#> = @(
    # for fun: using two walrus expressions
    ( $parent = $blockingPs )
    while( ($parent = $parent.Parent )) { $Parent }
)
# function Test-ColumnIsBlank {
#     param(
#         [ValidateNotNullOrEmpty()]
#         [Alias('Obj')][Parameter(Mandatory, Position = 0)]
#         [object]$InputObject,

#         [ValidateNotNullOrEmpty()]
#         [Alias('Name', 'Prop')][Parameter(Mandatory, Position = 1)]
#         [string[]]$ColumnName
#     )

#     $Props = $InputObject.PSObject.Properties
#     foreach($name in $ColumnName) {
#         # no wildcards for now
#         if( @($Props.Name) -notContains $ColumnName ) {
#             return $true
#         }
#     }



#     $InputObject.PSObject.Properties | %{

#     }


# $t.psobject.properties | ?{ [string]::IsNullOrWhiteSpace($_.Value ) }

#     return [string]::IsNullOrWhiteSpace(
#         $InputObject.PSObject.Properties.Value )

# }

function Select-ExcludeBlankProperty {
    <#
    .SYNOPSIS
        take a property, and automatically strip blanks
    .DESCRIPTION
        propertes are removed using Select-Object -Exclude so their type changes.
        or rather it's PSTypeName changes from:
            [Diagnostics.Process] , to
            [Selected.Diagnostics.Process]
    .NOTES
        newer version was in Dotils.Select-ExcludeBlankProperty
    .link
        Dotils\Dotils.Select-ExcludeBlankProperty
    #>
    [CmdletBinding()]
    [OutputType(
        'System.Object',
        'Selected.System.Diagnostics.Process',
        'System.Management.Automation.PSCustomObject'

    )]
    param(
        [ValidateNotNullOrEmpty()]
        [Alias('Obj')][Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [object]$InputObject
    )
    process {
        $Props = $InputObject.PSObject.Properties
        [Collections.Generic.List[object]]$exclusionList = @()

        $Props | ForEach-Object {
            if( [string]::IsNullOrWhiteSpace( $_.Value ) ) {
                $exclusionList.Add( $_.Name )
            }
        }

        $exclusionList
            | Join-string -sep ', ' -SingleQuote -op '$exclusionList: '
            | write-verbose

        return $InputObject | Select-Object -excludeProperty $exclusionList
    }
}
function Transform.ProcessRecord {
    process {
        $item = $_
        $item
            | Select-Object $PropertyName.Ancestor -ea 'ignore'
            | Select-ExcludeBlankProperty
    }
}

$ExampleConfig = @{
    ExportTempFile = $true
    ExportPath = Join-Path $PSScriptRoot 'output/ProcessInfoAndAncestors.xlsx'
}
MkDir -path (Join-Path $PSScriptRoot 'output')

$Pkg = Open-ExcelPackage -path $ExampleConfig.ExportPath #-Create

$sharedSplat = @{
    AutoSize = $true
    PassThru = $true
}
$Pkg = $Anne
    | Transform.ProcessRecord
    | Export-Excel $Pkg -work 'ProcList' -table 'ProcList_table' @sharedSplat -TableStyle Light2  -AutoSize -AutoFilter -AutoNameRange

$closeSplat = @{
    ExcelPackage = $Pkg
    Show         = $true
    NoSave       = $true
    # SaveAs       = $ExportPath
    # Calculate    = $true
    # ReZip        = $true
}
if(-not $ExampleConfig.ExportTempFile) {
    $ExampleConfig.ExportPath
    throw 'just declare params from config'
} else {
    $ExampleConfig.ExportPath
        | Join-String -f "`nwrote: => `n    {0}"
}

Close-ExcelPackage @closeSplat

<#
additional
    'Append' = ''
    'AutoFilter' = ''
    'AutoNameRange' = ''
    'AutoSize' = ''
    'Calculate' = ''
    'ClearSheet' = ''
    'MaxAutoSizeRows' = ''
    'NoAliasOrScriptPropeties' = ''
    'NoClobber' = ''
    'NoLegend' = ''
    'NoNumberConversion' = ''
    'Show' = ''
    'ShowCategory' = ''
    'ShowPercent' = ''
    'TableStyle' =  'Light2 '
    'TableTotalSettings' = @{}
    'Title' = '' 'a'
    'TitleBackgroundColor' = ''
    'TitleFillPattern' = ''
    'TitleSize' = ''

m#>




