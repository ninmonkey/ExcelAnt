# if (-not $PSVersionTable.PSEdition -or $PSVersionTable.PSEdition -eq 'Desktop') {
#     Import-Module "$PSScriptRoot/bin/Desktop/ClassExplorer.dll"
# } else {
#     Import-Module "$PSScriptRoot/bin/Core/ClassExplorer.dll"
# }
$__buildCfg = @{
    LoadTypeAndFormatdata = $false
}
# if ($False) {
#     'public', 'private' | ForEach-Object {
#         # Resolve-Path -Path $PSScriptRoot -ChildPath { $_ }
#         Resolve-Path (Join-Path $PSScriptRoot $_)
#     }
#     | Get-ChildItem -Recurse -File -Filter *.ps1
#     | Where-Object Name -NotMatch '.tests.ps1$'
#     | ForEach-Object {
#         'dot => {0}' -f @( $_ ) | Write-Verbose
#         . (Get-Item $_)
#     }

if ($__buildCfg.LoadTypeAndFormatdata) {
    Update-FormatData -PrependPath (Join-Path $PSScriptRoot 'Nancy.format.ps1xml' )
    Update-TypeData -PrependPath (Join-Path $PSScriptRoot 'Nancy.types.ps1xml' ) -ErrorAction Ignore
}
# }
# Export-ModuleMember -Cmdlet Find-Type, Find-Member, Format-MemberSignature, Get-Assembly, Get-Parameter -Alias *

