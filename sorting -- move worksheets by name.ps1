    function xl.Worksheet.ReOrder {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory, Position=0)]
            $ExcelPackage,

            # todo: autocomplete sheet names.
            # works if CurrentPackage is set to something
            [Parameter(Mandatory, Position=1)]
            [string[]]$SheetNames
        )

        $validNames = $ExcelPackage.Workbook.Worksheets.Name

        [Collections.Generic.List[Object]]$existingNames = $SheetNames
        | ?{ $validNames -contains $_ }
        $existingNames.Reverse()

        $existingNames | Join-String -sep ', ' -op 'reOrder Worksheets: ' | Write-verbose

        $existingNames | %{
            $ExcelPackage.workbook.Worksheets.MoveToStart($_)
        }

    }

    xl.Worksheet.ReOrder $Pkg -SheetNames @(
        'Changed', 'All', 'PayloSettings', 'New_JCUsers', 'Previous_JCUsers', 'log_changed', 'metrics'
    )


function xl.Worksheet.Hide {
    <#
    .SYNOPSIS
    hide sheets
        # reorder worksheet names, in-order of param
    .EXAMPLE
        xl.Worksheet.Hide $Pkg -SheetNames 'Changed', 'New_JCUsers', 'badname''

    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)]
        $ExcelPackage,

        # todo: autocomplete sheet names.
        # works if CurrentPackage is set to something
        [Parameter(Mandatory, Position=1)]
        [string[]]$SheetNames
    )

    $validNames = $ExcelPackage.Workbook.Worksheets.Name

    [Collections.Generic.List[Object]]$existingNames = $SheetNames
    | ?{ $validNames -contains $_ }

    $existingNames | Join-String -sep ', ' -op 'hide Worksheets: ' | Write-verbose

    $existingNames | %{
        $ExcelPackage.workbook.Worksheets[$_].Hidden  = [OfficeOpenXml.eWorkSheetHidden]::Hidden
    }

}
