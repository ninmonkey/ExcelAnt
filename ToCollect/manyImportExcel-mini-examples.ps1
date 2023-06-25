impo Ninmonkey.Console -ea 'stop'

& {
    label 'what' 'enumerate: tablenames'
     elseif ($ws.Workbook.Worksheets.Tables.Name -contains $TableName) {
                Write-Warning -Message "The Table name '$TableName' is already used on a different worksheet."
                return
            }
}

& {
               if ([OfficeOpenXml.FormulaParsing.ExcelUtilities.ExcelAddressUtil]::IsValidAddress($TableName)) {
                Write-Warning -Message "$TableName reads as an Excel address, and so is not allowed as a table name."
            return
            }
}
& {
    $ws.Cells['A1']
    'public class ExcelRange : ExcelRangeBase; IEnumerable, IExcelCell'
}
&{
        > $Range -match [regex]::Escape('#REF!')
        < # null/nothing
        > $Range.Address -match [regex]::Escape('#REF!')
        < # True
        # full name 'OfficeOpenXml.ExcelRange'
}
&{
    h1 'Experiment making code return values readable for screenshots, etc. saving space'
    [OfficeOpenXml.ExcelRange]::
    <# false #> IsValidCellAddress('2A2')

    [OfficeOpenXml.ExcelRange]::
    <# true #> IsValidCellAddress('A2345')
}
&{
    $ws.Cells['A1:B5']
    $ws.Cells.Address
    'A:XFD'

    $ws.Cells['A1'].GetType()


        Namespace: OfficeOpenXml

        Access        Modifiers           Name
        ------        ---------           ----
        public        class               ExcelRange : ExcelRangeBase, IExcelCell, IDisposable, IEnumerable<ExcelRangeBase>, IEnumerable, IEnumerator<ExcelRangeBase>, IEnumerator
}
& {
    $tbl = $ws.Tables.Add($Range, $TableName)
    Write-Verbose -Message "Defined table '$($tbl.Name)' at $($Range.Address)"

    > $tbl.Name
    < 'Previous_JCUsers'

    > $Range.Address
    < 'A2:#REF!'
}
& {
    #Empty string is not allowed as a name for ranges or tables.
    if ($RangeName) { Add-ExcelName  -Range $ws.Cells[$dataRange] -RangeName $RangeName }
}

& {
    label 'what' 'add excel table'
    '<file:///G:\2023-git\Pwsh📁\ImportExcel\Public\Add-ExcelTable.ps1>'
    $ws = $Range.Worksheet
            #if the table exists in this worksheet, update it.
            if ($ws.Tables[$TableName]) {
                $tbl =$ws.Tables[$TableName]
                $tbl.TableXml.table.ref = $Range.Address
                Write-Verbose -Message "Re-defined table '$TableName', now at $($Range.Address)."
            }
            elseif ($ws.Workbook.Worksheets.Tables.Name -contains $TableName) {
                Write-Warning -Message "The Table name '$TableName' is already used on a different worksheet."
                return
            }
            else {
                $tbl = $ws.Tables.Add($Range, $TableName)
                Write-Verbose -Message "Defined table '$($tbl.Name)' at $($Range.Address)"
            }
}