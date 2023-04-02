
function Tablify.ModuleInfo {
    <#
    .example
        Converts [PSModuleInfo] to tabular records
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object[]]$InputObject
    )
    begin {
        $Properties = @(

            'AccessMode',
            'Author',
            'ClrVersion',
            'CompanyName',
            'CompatiblePSEditions',
            'Copyright',
            'Definition',
            'Description',
            'DotNetFrameworkVersion',
            'ExperimentalFeatures',
            'ExportedAliases',
            'ExportedCmdlets',
            'ExportedCommands',
            'ExportedDscResources',
            'ExportedFormatFiles',
            'ExportedFunctions',
            'ExportedTypeFiles',
            'ExportedVariables',
            'FileList',
            'Guid',
            'HelpInfoUri',
            'IconUri',
            'ImplementingAssembly',
            'LicenseUri',
            'LogPipelineExecutionDetails',
            'ModuleBase',
            'ModuleList',
            'ModuleType',
            'Name',
            'NestedModules',
            'OnRemove',
            'Path',
            'PowerShellHostName',
            'PowerShellHostVersion',
            'PowerShellVersion',
            'Prefix',
            'PrivateData',
            'ProcessorArchitecture',
            'ProjectUri',
            'ReleaseNotes',
            'RepositorySourceLocation',
            'RequiredAssemblies',
            'RequiredModules',
            'RootModule',
            'Scripts',
            'SessionState',
            'Tags',
            'Version'
        )
    }

    process {
        write-warning 'finish me'
        throw 'finish me'
        Wait-Debugger
        $InputObject
    }
    end {

    }

}

