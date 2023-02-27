$PathXl = Join-Path $PSSCriptRoot 'output' 'history_summary.xlsx'
$Pkg = Open-ExcelPackage -Path $xlPath -Create

Get-History
| Export-Excel -excelPack $Pkg -WorksheetName 'default' -table 'default' -AutoSize -TableStyle Light2

Get-History
| %{
    $_ | n.Prop -name 'DurationMs' -value { $_.Duration.TotalMilliseconds }
}
| Export-Excel -ExcelPackage $Pkg -WorksheetName 'calculated' -table 'calculated' -AutoSize -TableStyle Light2

$hist[2] | fl * -Force

Close-Excel -Excel $Pkg -show

