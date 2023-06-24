
NAME
    Build-Module
    
SYNOPSIS
    Compile a module from ps1 files to a single psm1
    
    
SYNTAX
    Build-Module [[-SourcePath] <String>] [-OutputDirectory <String>] [-VersionedOutputDirectory] [-UnversionedOutputDirectory] [-SemVer <String>] [-CopyPaths <String[]>] [-SourceDirectories <String[]>] [-PublicFilter <String[]>] [-IgnoreAlias] [-Encoding <String>] [-Prefix <String>] [-Suffix <String>] [-Target <String>] [-Passthru] [<CommonParameters>]
    
    Build-Module [[-SourcePath] <String>] [-OutputDirectory <String>] [-VersionedOutputDirectory] [-UnversionedOutputDirectory] -Version <Version> [-Prerelease <String>] [-BuildMetadata <String>] [-CopyPaths <String[]>] [-SourceDirectories <String[]>] [-PublicFilter <String[]>] [-IgnoreAlias] [-Encoding <String>] [-Prefix <String>] [-Suffix <String>] [-Target <String>] [-Passthru] [<CommonParameters>]
    
    
DESCRIPTION
    Compiles modules from source according to conventions:
    1. A single ModuleName.psd1 manifest file with metadata
    2. Source subfolders in the same directory as the Module manifest:
       Enum, Classes, Private, Public contain ps1 files
    3. Optionally, a build.psd1 file containing settings for this function
    
    The optimization process:
    1. The OutputDirectory is created
    2. All psd1/psm1/ps1xml files (except build.psd1) in the Source will be copied to the output
    3. If specified, $CopyPaths (relative to the Source) will be copied to the output
    4. The ModuleName.psm1 will be generated (overwritten completely) by concatenating all .ps1 files in the $SourceDirectories subdirectories
    5. The ModuleVersion and ExportedFunctions in the ModuleName.psd1 may be updated (depending on parameters)
    

PARAMETERS
    -SourcePath <String>
        The path to the module folder, manifest or build.psd1
        
    -OutputDirectory <String>
        Where to build the module. Defaults to "..\Output" adjacent to the "SourcePath" folder.
        The ACTUAL output may be in a subfolder of this path ending with the module name and version
        The default value is ..\Output which results in the build going to ..\Output\ModuleName\1.2.3
        
    -VersionedOutputDirectory [<SwitchParameter>]
        DEPRECATED. Now defaults true, producing a OutputDirectory with a version number as the last folder
        
    -UnversionedOutputDirectory [<SwitchParameter>]
        Overrides the VersionedOutputDirectory, producing an OutputDirectory without a version number as the last folder
        
    -SemVer <String>
        Semantic version, like 1.0.3-beta01+sha.22c35ffff166f34addc49a3b80e622b543199cc5
        If the SemVer has metadata (after a +), then the full Semver will be added to the ReleaseNotes
        
    -Version <Version>
        The module version (must be a valid System.Version such as PowerShell supports for modules)
        
    -Prerelease <String>
        Setting pre-release forces the release to be a pre-release.
        Must be valid pre-release tag like PowerShellGet supports
        
    -BuildMetadata <String>
        Build metadata (like the commit sha or the date).
        If a value is provided here, then the full Semantic version will be inserted to the release notes:
        Like: ModuleName v(Version(-Prerelease?)+BuildMetadata)
        
    -CopyPaths <String[]>
        Folders which should be copied intact to the module output
        Can be relative to the  module folder
        
    -SourceDirectories <String[]>
        Folders which contain source .ps1 scripts to be concatenated into the module
        Defaults to Enum, Classes, Private, Public
        
    -PublicFilter <String[]>
        A Filter (relative to the module folder) for public functions
        If non-empty, FunctionsToExport will be set with the file BaseNames of matching files
        Defaults to Public\*.ps1
        
    -IgnoreAlias [<SwitchParameter>]
        A switch that allows you to disable the update of the AliasesToExport
        By default, (if PublicFilter is not empty, and this is not set)
        Build-Module updates the module manifest FunctionsToExport and AliasesToExport
        with the combination of all the values in [Alias()] attributes on public functions
        and aliases created with `New-ALias` or `Set-Alias` at script level in the module
        
    -Encoding <String>
        File encoding for output RootModule (defaults to UTF8)
        Converted to System.Text.Encoding for PowerShell 6 (and something else for PowerShell 5)
        
    -Prefix <String>
        The prefix is either the path to a file (relative to the module folder) or text to put at the top of the file.
        If the value of prefix resolves to a file, that file will be read in, otherwise, the value will be used.
        The default is nothing. See examples for more details.
        
    -Suffix <String>
        The Suffix is either the path to a file (relative to the module folder) or text to put at the bottom of the file.
        If the value of Suffix resolves to a file, that file will be read in, otherwise, the value will be used.
        The default is nothing. See examples for more details.
        
    -Target <String>
        Controls whether we delete the output folder and whether we build the output
        There are three options:
          - Clean deletes the build output folder
          - Build builds the module output
          - CleanBuild first deletes the build output folder and then builds the module back into it
        Note that the folder to be deleted is the actual calculated output folder, with the version number
        So for the default OutputDirectory with version 1.2.3, the path to clean is: ..\Output\ModuleName\1.2.3
        
    -Passthru [<SwitchParameter>]
        Output the ModuleInfo of the "built" module
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS > Build-Module -Suffix "Export-ModuleMember -Function *-* -Variable PreferenceVariable"
    
    This example shows how to build a simple module from it's manifest, adding an Export-ModuleMember as a Suffix
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS > Build-Module -Prefix "using namespace System.Management.Automation"
    
    This example shows how to build a simple module from it's manifest, adding a using statement at the top as a prefix
    
    
    
    
    -------------------------- EXAMPLE 3 --------------------------
    
    PS > $gitVersion = gitversion | ConvertFrom-Json | Select -Expand InformationalVersion
    Build-Module -SemVer $gitVersion
    
    This example shows how to use a semantic version from gitversion to version your build.
    Note, this is how we version ModuleBuilder, so if you want to see it in action, check out our azure-pipelines.yml
    https://github.com/PoshCode/ModuleBuilder/blob/master/azure-pipelines.yml
    
    
    
    
REMARKS
    To see the examples, type: "Get-Help Build-Module -Examples"
    For more information, type: "Get-Help Build-Module -Detailed"
    For technical information, type: "Get-Help Build-Module -Full"


