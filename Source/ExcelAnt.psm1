$__buildCfg = @{
    LoadTypeAndFormatdata = $false
}

#region SourceInit
#Dot source the files
[Collections.Generic.List[Object]]$HardcodedToExportFunc = @(
    'coerce.ToFileSystemInfo'
    # 'Get-RandomExcelAntColor'
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
    Update-FormatData -PrependPath (Join-Path $PSScriptRoot 'ExcelAnt.format.ps1xml' )
    Update-TypeData -PrependPath (Join-Path $PSScriptRoot 'ExcelAnt.types.ps1xml' ) -ErrorAction Ignore
}
# }
# Export-ModuleMember -Cmdlet Find-Type, Find-Member, Format-MemberSignature, Get-Assembly, Get-Parameter -Alias *
