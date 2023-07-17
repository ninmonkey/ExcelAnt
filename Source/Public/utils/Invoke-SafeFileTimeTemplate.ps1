# 'Format-SafeFileTimeTemplate', 'Format-SafeFileTime', 'xa.Format-SafeFileTimeNow', 'xa.Invoke-FileTimeTemplate'

function Format-ExcelAntSafeFileTimeTemplate {
    <#
    .SYNOPSIS
        timenow for safe filepaths: "2022-08-17_12-46-47Z"
    .notes
        distinct values to the level of a full second

        Previously was named "Invoke-SafeFileTimeTemplate"
            changed because it did not represent behavior, it creates a new workbook.

    #>
    # [Alias('xa.New.Safetime')]
    [OutputType('OfficeOpenXml.ExcelPackage')]
    [Alias(
        'Format-SafeFileTimeTemplate',
        'Format-SafeFileTime',
        'xa.Format-SafeFileTimeNow',
        'xa.Invoke-FileTimeTemplate'
    )]
    [CmdletBinding()]
    param(
        # [parameter(Mandatory, Position = 0)]
        # [string]$Label,

        [Parameter(Position = 0)]
        # [Parameter(Position = 1)]
        [ArgumentCompletions(
            'export-{0}.xlsx',
            './.output/export-{0}.xlsx',
            '{0}.xlsx'
        )]
        [string]$NameTemplate,

        # Root output directory, if not template
        [ArgumentCompletions(
            'G:\temp\xl',
            '([IO.Path]::GetTempPath())'
        )]
        [Parameter(Position=1)]
        # [Parameter(Position=2)]
        $RelativeTo
    )
    write-warning 'finish writiong'

}
function New-ExcelAntPackageFromSafeTimeTemplate {

    <#
    .SYNOPSIS
        timenow for safe filepaths: "2022-08-17_12-46-47Z"
    .notes
        distinct values to the level of a full second

        Previously was named "Invoke-SafeFileTimeTemplate"
            changed because it did not represent behavior, it creates a new workbook.

    #>
    # [Alias('xa.New.Safetime')]
    [OutputType('OfficeOpenXml.ExcelPackage')]
    [Alias(
        'xa.New.FileTimePackage',
        'xa.New.Package.FromFileTime',
        'xa.New.SafeTime',
        'New-FileTimeTemplate'
    )]
    [CmdletBinding()]
    param(
        # [parameter(Mandatory, Position = 0)]
        # [string]$Label,

        [Parameter(Position = 0)]
        # [Parameter(Position = 1)]
        [ArgumentCompletions(
            'export-{0}.xlsx',
            './.output/export-{0}.xlsx',
            '{0}.xlsx'
        )]
        [string]$NameTemplate,

        # Root output directory, if not template
        [ArgumentCompletions(
            'G:\temp\xl',
            '([IO.Path]::GetTempPath())'
        )]
        [Parameter(Position=1)]
        # [Parameter(Position=2)]
        $RelativeTo
    )

    write-warning "NYI: Should be calling 'Format-ExcelAntSafeFileTimeTemplate' here: $PSCommandPath"

    $Final_NameTemplate = $NameTemplate ?? '{0}.xlsx'
    # $Final_RelativeTo = $RelativeTo ?? ([IO.Path]::GetTempPath())
    $Final_RelativeTo = $RelativeTo ?? 'g:\temp\xl\.output'
    $Final_fullName = Join-Path $Final_RelativeTo $Final_NameTemplate
    $Render = $Safe -f @( SafeFiletimeString )

    # (Get-Date).ToString('u') -replace '\s+', '_' -replace ':', '-'
    # always new
    if(test-path $render ) {
        'Unexpected, filetime exists. $Render = "{0}"' -f @(
            $render
        ) | Write-Error
    }
    # Ensure full filepath exists, and delete.
    # Then return a new package
    New-Item -itemtype file -path $render -force -ea 'ignore'
    Remove-Item  -path $render -force -ea 'ignore'
    $pkg = Open-ExcelPackage -Path $Render -Create -Verbose
    'Created new filetime template: {0}' -f @(
        $Pkg.File.FullName | Join-String -double
     ) | Write-Information -infa 'Continue'
    return $Pkg
}

