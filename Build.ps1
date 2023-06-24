#requires -Module Configuration, @{ ModuleName = "ModuleBuilder"; ModuleVersion = "1.6.0" }

[CmdletBinding()]
param(
    [ValidateSet("Release","Debug")]
    $Configuration = "Release",

    # The version of the output module
    [Alias("ModuleVersion","Version")]
    [string]$SemVer
)

$examples = @(
    'G:\2023-git\Jaykul🧑\Pansies\Build.ps1'
    'G:\2023-git\Jaykul🧑\Pansies\Build.psd1'
    'G:\2023-git\Jaykul🧑\TerminalBlocks\build.psd1'
    'G:\2023-git\Jaykul🧑\TerminalBlocks\build.ps1'
    'G:\2023-git\Jaykul🧑\TerminalBlocks\RequiredModules.psd1'
    'G:\2023-git\Jaykul🧑\TerminalBlocks\.vscode\tasks.json'
    'G:\2023-git\Jaykul🧑\TerminalBlocks\.vscode\launch.json'
)
$Examples | Join-String -op 'try others: ' -f "`n- <file:///{0}>"
          | Write-Host -ForegroundColor orange -bg 'gray30'

throw 'nyi, examples'
Push-Location $PSScriptRoot -StackName BuildTestStack

if (!$SemVer -and (Get-Command gitversion -ErrorAction Ignore)) {
    $SemVer = gitversion -showvariable nugetversion
}

try {
    $ErrorActionPreference = "Stop"
    Write-Host "## Calling Build-Module" -ForegroundColor Cyan

    $Module = Build-Module -Passthru -SemVer $SemVer
    $Folder  = Split-Path $Module.Path

    if (!$SkipBinaryBuild) {
        Write-Host "## Compiling Pansies binary module" -ForegroundColor Cyan
        # dotnet restore
        # dotnet build -c $Configuration -o "$($folder)\lib" | Write-Host -ForegroundColor DarkGray
        dotnet publish -c $Configuration -o "$($Folder)\lib" | Write-Host -ForegroundColor DarkGray
        # We don't need to ship any of the System DLLs because they're all in PowerShell
        Get-ChildItem $Folder -Filter System.* -Recurse | Remove-Item
    }

    Write-Host "## Compiling Documentation" -ForegroundColor Cyan

    Remove-Item "$($folder)\en-US" -Force -Recurse -ErrorAction SilentlyContinue
    $null = New-ExternalHelp -Path ".\Docs" -OutputPath  "$($folder)\en-US"

    $Folder

} catch {
    throw $_
} finally {
    Pop-Location -StackName BuildTestStack
}
