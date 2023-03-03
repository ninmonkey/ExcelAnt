throw 'todo: next:
- [ ] use column names for SEt-ExcelColumn
    not id offsets
'

$lasty = 'G:\temp\xl\JumpCloud_Changes.2023-03-01_12-35-24Z.xlsx'
$lastyDest= 'G:\temp\xl\JumpCloud_Changes.2023-03-01_12-35-24Z-dest.xlsx'

$Pkg = Open-ExcelPackage $lasty -Verbose

$setExcelColumnSplat = @{
    Verbose = $true
    VerticalAlignment = 'Top'
    WorksheetName = 'errLog'
    ExcelPackage = $pkg
    Column = 1
    WrapText = $true
    Width = 90
}
Set-ExcelColumn @setExcelColumnSplat -Verbose
$Pkg.Workbook.Worksheets.MoveToStart('errLog')

[OfficeOpenXml.ExcelWorksheets]$sheets_parent = $Pkg.Workbook.Worksheets
[Collections.Generic.List[OfficeOpenXml.ExcelWorksheet]]$wsheet_items =  $sheets_parent
# [COllections.Generic.List[OfficeOpenXml.ExcelWorksheet]]$worksheet_list = $sheets_parent.GetEnumerator()

,$sheets_parent | should -BeOfType '[OfficeOpenXml.ExcelWorksheets]'
$wsheet_items | SHould -BeOfType '[OfficeOpenXml.ExcelWorksheet]'
,$wsheet_items | SHould -BeOfType '[Collections.Generic.List[OfficeOpenXml.ExcelWorksheet]]'

$newExcelStyleSplat = @{
    WrapText = $true
    VerticalAlignment = 'Top'
    HorizontalAlignment = 'CenterContinuous'
    Width = 90
    FontName = 'Cascadia Code PL'
}

$setExcelColumnSplat = @{
    Verbose = $true
    VerticalAlignment = 'Top'
    WorksheetName = 'errLog'
    ExcelPackage = $pkg
    Column = 1
    WrapText = $true
    Width = 90
}
Set-ExcelColumn @setExcelColumnSplat -Verbose

$Style_codeMono = New-ExcelStyle @newExcelStyleSplat

# $items | SHould -BeOfType '[Collections.Generic.List[OfficeOpenXml.ExcelWorksheet]]'

Close-ExcelPackage $pkg -SaveAs $LastyDest -Verbose -Show
b.copyExcel $lastyDest -Show