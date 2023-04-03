function Format-ExcelAntExactModuleVersions {
    <#
    .SYNOPSIS
        quick dump currently used modules
    .EXAMPLE
        get-module | ? name -match 'pipe|git|logger'
    .description
    was
    Import-Module PipeScript, PipeWorks, HelpOut -PassThru
    | Join-String -p { '{0} = {1}' -f @( $_.Name ; $_.Version; )} -sep ', '
    #>
    [Alias(
        'xl.PSModule.GetVersions',
        'nin.PSModule.GetExactVersions'
    )]
    [CmdletBinding()]
    param(
        [Alias('Modules')]
        [Parameter(valuefrompipeline, position = 0)]
        [object[]]$InputObject,

        # 'RequiredImportString' generates an actual import statement
        [Alias('As')]
        [parameter()]
        [ValidateSet('Json', 'RequiredImportString', 'Basic', 'MdTable')]
        [string]$OutputType = 'Basic'
    )

    begin {
        [Collections.Generic.List[Object]]$Items = @()
    }
    process {
        $Items.AddRange(@( $InputObject ))
    }
    end {
        if ( -not $Items -or $Items.Count -eq 0) {
            $query = Get-Module | Sort-Object Name
        }
        else {
            $query = $Items | Sort-Object Name
        }
        #     $query
        #     | Join-String -p { '{0} = {1}' -f @( $_.Name ; $_.Version; ) } -sep ",`n" -single
        #     # | Join-String -p { '{0} = {1}' -f @( $_.Name ; $_.Version; ) } -sep ', ' -single

        #     # $goal = 'import-module PipeScript -RequiredVersion 0.3.4'
        #     # Get-Module
        #     # | Sort-Object Name
        #     Hr

        switch ($OutputType) {
            'RequiredImportString' {
                $query
                | Join-String -p {
                    'Import-Module {0} -RequiredVersion = {1}' -f @(
                        $_.Name | Join-String -single
                        $_.Version | Join-String -single
                    )
                } -sep "`n"
                # Import-Module -RequiredVersion 'sd' -Name 'sdf'
            }
            'Json' {
                $Query | %{
                    @{
                        Name = $_.Name
                        Version = $_.Version
                    }
                }
                | SOrt-object Name
                | COnvertTo-Json -depth 1 -Compress
            }
            'Basic' {
                $query
                | Join-String -p { '{0} = {1}' -f @( $_.Name ; $_.Version; ) } -sep ",`n" -single
            }
            default {
                throw "UnhandledFormatType: $OutputType"

            }
        }
    }
}


Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
Format-ExcelAntExactModuleVersions -OutputType Basic
Format-ExcelAntExactModuleVersions -OutputType MdTable
Format-ExcelAntExactModuleVersions -OutputType Json
