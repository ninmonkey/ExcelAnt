# if (-not $PSVersionTable.PSEdition -or $PSVersionTable.PSEdition -eq 'Desktop') {
#     Import-Module "$PSScriptRoot/bin/Desktop/ClassExplorer.dll"
# } else {
#     Import-Module "$PSScriptRoot/bin/Core/ClassExplorer.dll"
# }
$__buildCfg = @{
    LoadTypeAndFormatdata = $false
}


# if($__buildCfg.ImportFromReleases){
#     return
# }


#region SourceInit
#Dot source the files
[Collections.Generic.List[Object]]$HardcodedToExportFunc = @(
    'coerce.ToFileSystemInfo'
    'Get-RandomNancyColor'
    'xl.Errors.Inspect'
)
Foreach($FolderItem in 'Private','Public') {
    $ImportItemList = Get-ChildItem -Path $PSScriptRoot\$FolderItem\*.ps1 -ErrorAction SilentlyContinue
    Foreach($ImportItem in $ImportItemList) {
        Try {
            . $ImportItem
        }
        Catch {
            throw "Failed to import function $($importItem.fullname): $_"
        }
    }
    if ($FolderItem -eq 'Public') {
        [Collections.Generic.List[Object]]$ToExport = @(
            $ImportItemList.basename
            | Where-Object {
                $item = $_
                $isMatch = $item -match '^\w+-\w+$'
                '{0} => {1}' -f @(
                    $isMatch , $Item
                ) | Write-Verbose
                return $isMatch
            }
        )
        $ToExport | Join-String -sep ', ' -single -op 'ToExport = @( ' -os ' )'
        | write-verbose

        $ToExport.AddRange( $hardcodedToExportFunc )
        | sort -unique

        Export-ModuleMember -Function @(
            $ToExport
        )
    }
}

if ($__buildCfg.LoadTypeAndFormatdata) {
    Update-FormatData -PrependPath (Join-Path $PSScriptRoot 'Nancy.format.ps1xml' )
    Update-TypeData -PrependPath (Join-Path $PSScriptRoot 'Nancy.types.ps1xml' ) -ErrorAction Ignore
}
# }
# Export-ModuleMember -Cmdlet Find-Type, Find-Member, Format-MemberSignature, Get-Assembly, Get-Parameter -Alias *

<#

# old
if($false){
    'public', 'private' | ForEach-Object {
        # Resolve-Path -Path $PSScriptRoot -ChildPath { $_ }
        Resolve-Path (Join-Path $PSScriptRoot $_)
    }
    | Get-ChildItem -Recurse -File -Filter *.ps1
    | Where-Object Name -NotMatch '.tests.ps1$'
    | ForEach-Object {
        'dot => {0}' -f @( $_ ) | Write-Verbose
        . (Get-Item $_)
    }
}
#>
