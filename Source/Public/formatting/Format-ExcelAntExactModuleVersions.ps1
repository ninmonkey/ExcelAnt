function Format-ExcelAntExactModuleVersions {
    <#
    .SYNOPSIS
        Generate exact module version import requirements, using loaded modules (or pipeline)
    .description
        .
    .EXAMPLE
        # pipe specific modules
        get-module | ? name -match 'pipe|git|logger'
        | Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
    .EXAMPLE
        # or implicitly use the currently imported list

        Format-ExcelAntExactModuleVersions -OutputType RequiredImportString
        Format-ExcelAntExactModuleVersions -OutputType Basic
        Format-ExcelAntExactModuleVersions -OutputType MdTable
        Format-ExcelAntExactModuleVersions -OutputType Json
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
        [ValidateSet(
            'PSObject', 'Obj',
            'Json','JsonRoundTrip',
            'RequiredImportString',
            'Basic', 'MdTable'
        )]
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

        switch ($OutputType) {
            'RequiredImportString' {
                $query
                | Join-String -p {
                    'Import-Module {0} -RequiredVersion = {1}' -f @(
                        $_.Name | Join-String -single
                        $_.Version | Join-String -single
                    )
                } -sep "`n"
            }
            'JsonRoundTrip' {
                # flattens, coerces it into a round trip string
                $Query | ForEach-Object {
                    @{
                        Name    = $_.Name
                        Version = $_.Version
                    }
                }
                | ConvertTo-Json -Depth 1
                | ConvertFrom-Json
                | ConvertTo-Json
            }
            'Json' {
                $Query | ForEach-Object {
                    @{
                        Name    = $_.Name
                        Version = $_.Version
                    }
                }
                | Sort-Object Name
                | ConvertTo-Json -Depth 1 -Compress -AsArray
            }
            { @( 'PSObject', 'Obj' ) -contains $OutputType } {
                $Query | ForEach-Object {
                    @{
                        Name    = $_.Name
                        Version = $_.Version
                    }
                }
                | Sort-Object Name
                | ConvertTo-Json -Depth 1 -Compress -AsArray
                | ConvertFrom-Json
            }
            'Basic' {
                # prev:
                # $query | Join-String -p { '{0} = {1}' -f @( $_.Name ; $_.Version; ) } -sep ",`n" -single

                $query
                | Join-String -p { '{0} = {1}' -f @( $_.Name ; $_.Version; ) } -sep "`n"
            }
            'MdTable' {
                @(
                    '| Module | ExactVersion |'
                    '| - | - |'
                    $query
                    | Join-String -p { '| {0} | {1} |' -f @( $_.Name ; $_.Version; ) } -sep "`n"
                ) | Join-String -sep "`n"
            }
            # 'Hashtable' {
            #     $Query | ForEach-Object {
            #         @{
            #             Name    = $_.Name
            #             Version = $_.Version
            #         }
            #     }

            # }
            default {
                throw "UnhandledFormatType: $OutputType"
            }
        }
    }
}

