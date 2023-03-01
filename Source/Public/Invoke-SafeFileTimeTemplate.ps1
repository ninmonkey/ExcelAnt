function Invoke-SafeFileTimeTemplate {

    <#
    .SYNOPSIS
        timenow for safe filepaths: "2022-08-17_12-46-47Z"
    .notes
        distinct values to the level of a full second
    #>
    # [Alias('xl.New.Safetime')]
    [Outputs('OfficeOpenXml.ExcelPackage')]
    [Alias(
        'xl.New.SafeTime',
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

