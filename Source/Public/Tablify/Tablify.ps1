
function Tablify {
    <#
    .SYNOPSIS
        Flattens or converts types to be tabular records
    .DESCRIPTION
        delegates to other functions
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject,

        [hashtable]$Options
    )
    begin {
        $Config = ExcelAnt.Join-Hashtable -Other $Options -Base @{
            StrictTypes = $true
        }

    }
    process {
        switch ($InputObject.GetType().Name) {
            {
                $InputObject.GetType().BaseType.Name -eq 'CmdletInfo'
                # $_ -in @('CommandInfo', 'AliasInfo', 'CmdletInfo', 'FunctionInfo')
            } {
                $CmdInfoFields = @(
                    # 'ToString'
                    'ResolveParameter'
                    'Name'
                    'CommandType'
                    'Source'
                    'Version'
                    'Definition'
                    'Visibility'
                    'ModuleName'
                    'Module'
                    'RemotingCapability'
                    'Parameters'
                    'ParameterSets'
                    'OutputType'
                )
                throw "NYI: $Switch"
            }
            'AliasInfo' {
                throw "NYI: $Switch"

            }
            'CmdletInfo' {
                throw "NYI: $Switch"

            }
            'FunctionInfo' {
                throw "NYI: $Switch"

            }
            'PSModuleInfo' {
                $InputObject | Tablify.ModuleInfo
            }
            default {
                if ($Config.StrictTypes) {
                    throw "Tablify: UnhandledTypeException: '$switch'"
                    continue
                }
                Write-Verbose "Tablify: UnhandledTypeException: '$switch'"
            }
        }
    }
    end {

    }
}
