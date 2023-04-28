# from: <https://discord.com/channels/180528040881815552/1094669741039296632/1096251223914590269>


filter Expand-Property {
    <#
        .SYNOPSIS
            Expands an array property, creating a duplicate object for each value
    #>
    param(
        # The name of a property on the input object, that has more than one value
        [Alias("Property")]
        [string]$Name,

        # The input object to duplicated
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    foreach ($Value in $InputObject.$Name) {
        $InputObject | Select-Object *, @{ Name = $Name; Expr = { $Value } } -Exclude $Name
    }
}



function Group-Property {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [psobject]
        ${InputObject},

        [Parameter(Position = 0)]
        [string]
        ${Name},

        [string]
        ${Culture},

        [switch]
        ${CaseSensitive}
    )

    begin {
        try {
            $outBuffer = $null
            $null = $PSBoundParameters.Remove("Name")
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Group-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
        } catch {
            throw
        }
    }

    process {
        try {
            if (!$steppablePipeline) {
                $PSBoundParameters["Property"] = $InputObject.PSObject.Properties.Name.Where{ $_ -ne $Name }
                $null = $PSBoundParameters.Remove("InputObject")
                Write-Verbose "Group by $($PSBoundParameters["Property"] -join ', ')"
                $scriptCmd = { & $wrappedCmd @PSBoundParameters | ForEach-Object { $_.Group[0].$Name = $_.Group.$Name; $_.Group[0] } }
                $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
                $steppablePipeline.Begin($PSCmdlet)
            }

            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }

    clean {
        if ($null -ne $steppablePipeline) {
            $steppablePipeline.Clean()
        }
    }
}
