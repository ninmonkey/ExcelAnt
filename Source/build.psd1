# This  ModuleBuilder, not Invoke-Build
@{
    ModuleManifest = "ExcelAnt.psd1"
    # The rest of the paths are relative to the manifest
    OutputDirectory = "..\Output"
}


# PS > Build-Module -Suffix "Export-ModuleMember -Function *-* -Variable PreferenceVariable"
