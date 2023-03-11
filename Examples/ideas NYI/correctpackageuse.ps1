$XlPath = 'temp:\324fas.xlsx'
Close-ExcelPackage $pkg ; remove-item $XlPath -ea ignore
err -Clear ; hr -fg magenta ; # reset state



# should run if you have the module
$pkg =  Open-ExcelPackage $XlPath -Create
ls . | Export-Excel -WorksheetName 'z' -PassThru
ls . | Export-Excel -WorksheetName 'r' -PassThru


Close-ExcelPackage $Pkg
Remove-Item $XlPath
