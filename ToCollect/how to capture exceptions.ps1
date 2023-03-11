#$pkg = Open-ExcelPackage -Path 'C:\Users\cppmo_000\AppData\Local\Temp\tmpBB42.xlsx'
#gci 'C:\Temp'   | Export-Excel -WorksheetName 'two'

$pkg = Open-ExcelPackage -Path 'temp:\foo.xlsx' -Create
gci ~          | Export-Excel -WorksheetName 'one'
gci 'c:\temp'  | Export-Excel -WorksheetName 'two'
try {
    $pkg.Workbook.Worksheets.MoveToStart('two')
    '🅰'
    $pkg.Workbook.Worksheets.MoveToStart('twfdsso')
    '🅾'
} catch {
  'yay'; $_;
}
Close-ExcelPackage $Pkg

$pkg = Open-ExcelPackage -Path 'temp:\foo.xlsx' -Create
gci ~           | Export-Excel -WorksheetName 'one' -Excel $Pkg
gci 'C:\Temp'   | Export-Excel -WorksheetName 'two' -Excel $Pkg

try {
    1 /  0
} catch {
    '👍'
}
# try {
    $pkg.Workbook.Worksheets.MoveToStart('two')
# }
Close-ExcelPackage -excel $Pkg -show



$pkg = Open-ExcelPackage -Path 'temp:\foo.xlsx' -Create