$__buildCfg = @{
    LoadTypeAndFormatdata = $false
    LooseFunctionImports = $true
}


#region SourceInit
#Dot source the files
# [Collections.Generic.List[Object]]$HardcodedToExportFunc = @(
#     'coerce.ToFileInfo'
#     # 'Get-RandomExcelAntColor'
#     'xl.Errors.Inspect'
#     '*'
# )

# $modMeta = [ordered]@{

# }
# write-warning 'cheat for now on the export rules filtering, I am not yet sure which pattern I prefer'
Foreach($FolderItem in 'Private','Public') {
    [Collections.Generic.List[Object]]$ImportItemList = Get-ChildItem -Path $PSScriptRoot\$FolderItem\*.ps1 -ErrorAction SilentlyContinue

    # [Collection.Generic.List[Object]]$ModMeta.Files = @(
    #     $ImportItemList | nin.AddProp -Name 'Stage' -Value '0_all'
    # )

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
                $isMatch = $isMatch -or ( $_ -match '^\w+\.\w+$')
                $isMatch = $isMatch -or ( $__buildCfg.LooseFunctionImports )
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
        $zed  = 0
    }
}

if ($__buildCfg.LoadTypeAndFormatdata) {
    Update-FormatData -PrependPath (Join-Path $PSScriptRoot 'ExcelAnt.format.ps1xml' )
    Update-TypeData -PrependPath (Join-Path $PSScriptRoot 'ExcelAnt.types.ps1xml' ) -ErrorAction Ignore
}
# }
# Export-ModuleMember -Cmdlet Find-Type, Find-Member, Format-MemberSignature, Get-Assembly, Get-Parameter -Alias *
