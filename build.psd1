# Use this file to override the default parameter values used by the `Build-Module`
# command when building the module (see `Get-Help Build-Module -Full` for details).
# @{
#     ModuleManifest           = "Source/TerminalBlocks.psd1"
#     OutputDirectory          = "../"
#     VersionedOutputDirectory = $true
#     CopyDirectories          = @('examples','TerminalBlocks.format.ps1xml')
#     Postfix                  = "Footer.ps1"
# }

# This  ModuleBuilder, not Invoke-Build?
@{
    # The rest of the paths are relative to the manifest
    ModuleManifest = ".\Source\ExcelAnt.psd1"
    # OutputDirectory = "..\Output"
    # OutputDirectory = "H:/data/2023/pwsh/PsModules.Import"
    OutputDirectory = "../" # Wanted: "H:/data/2023/pwsh/PsModules.Import"
    VersionedOutputDirectory = $true
    # OutputDirectory = "../../../../PsModules.Import" # this still makes a child directory
    # options
    # CopyDirectories          = @('examples','TerminalBlocks.format.ps1xml')
    # Postfix                  = "Footer.ps1"
}
# PS > Build-Module -Suffix "Export-ModuleMember -Function *-* -Variable PreferenceVariable"
