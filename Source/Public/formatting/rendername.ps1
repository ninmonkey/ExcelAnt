function Format-ExcelAntRenderItemName  {
    <#
    .SYNOPSIS
    Sugar to print different types of Excel classes, and their names, if it applies

    .DESCRIPTION

    .EXAMPLE

    .NOTES
        currently supports:
            - [x] Sheets: [OfficeOpenXml.ExcelWorksheet]
            - [ ] workbook: [OfficeOpenXml.ExcelWorkbook?]
            - [ ] package: [OfficeOpenXml.ExcelPackage?]
            - [ ] tables: [OfficeOpenXml.ExcelTable?]
            - [ ] Ranges: [OfficeOpenXml.ExcelRange?]
            - [ ] Named Ranges: [OfficeOpenXml.ExcelNamedRange?]
            - [ ] Named Styles: [OfficeOpenXml.ExcelNamedStyle?]
            - [ ] Named Colors: [OfficeOpenXml.ExcelNamedColor?]

    #>
    # BdgXL.RenderName
    [Alias('XL.RenderName')] # Format-ExcelAntRenderItemName
    [CmdletBinding()]
    param()
    process {
        $item = $_
        if( $item -is 'OfficeOpenXml.ExcelWorksheet' ) {
            $render =
                $item
                | Join-String Name -f '[Worksheet( Name: {0} )]'
            return
        }

        write-warning "UnhandledType: $($item.GetType().FullName)"
        return $Item.GetType().Name
    }
}
