$path_export = 'g:\temp\xl\proc_usage.xlsx'
# $findTypes = Get-Counter -ListSet *
$counter_set ??= @{}
$regex = [regex]::Escape('cpu')
$counter_set.CPU = $findTypes | ?{ $_.CounterSetName -Match $regex -or $_.Description -match $regex -or $_.Paths -match $regex }

$one = $counter_set.CPU | Select -first 1

$counters.counter | fl *

# ------------------------------
xL.Window.CloseAll

remove-item $path_export -ea 'ignore'
$script:Pkg = Open-ExcelPackage -Path $path_export -create

function xl.AddSheet {
    # collects list of objects from the pipeline
    [CmdletBinding()]
    param(
        # Data
        [Parameter(Mandatory ,ValueFromPipeline)]
        [object[]]$InputObject,

        [Parameter(Mandatory, Position=0)]
        [string]$SheetName
    )
    begin {
        [COllections.Generic.List[object]]$Items = @()
    }
    process {
        $items.AddRange(@($InputObject))
    }
    end {
        <#
-Style <Object[]>
    Takes style settings as a hash-table (which may be built with the New-ExcelStyle command) and applies them to the worksheet. If the
    hash-table contains a range the settings apply to the range, otherewise they apply to the whole sheet.

-CellStyleSB <ScriptBlock>
    A script block which is run at the end of the export to apply styles to cells (although it can be used for other purposes). The
    script block is given three paramaters; an object containing the current worksheet, the Total number of Rows and the number of the
    last column.

-DisplayPropertySet [<SwitchParameter>]
    Many (but not all) objects in PowerShell have a hidden property named psStandardmembers with a child property
    DefaultDisplayPropertySet ; this parameter reduces the properties exported to those in this set.
-NoAliasOrScriptPropeties [<SwitchParameter>]
    Some objects in PowerShell duplicate existing properties by adding aliases, or have Script properties which may take a long time to
    return a value and slow the export down, if specified this option removes these properties

-conditionalFormat
      One or more conditional formatting rules defined with New-ConditionalFormattingIconSet.
-conditionalText
        Applies a Conditional formatting rule defined with New-ConditionalText. When specific conditions are met the format is applied
    -ClearSheet [<SwitchParameter>]
        If specified Export-Excel will remove any existing worksheet with the selected name.
        The default behaviour is to overwrite cells in this sheet as needed (but leaving non-overwritten ones in

    -Append [<SwitchParameter>]
        If specified data will be added to the end of an existing sheet, using the same column headings.

    -PivotRows <String[]>
        Name(s) of column(s) from the spreadsheet which will provide the Row name(s) in a PivotTable created from command line parameters.

    -PivotColumns <String[]>
        Name(s) of columns from the spreadsheet which will provide the Column name(s) in a PivotTable created from command line parameters.

    -PivotData <Object>
        In a PivotTable created from command line parameters, the fields to use in the table body are given as a Hash-table in the form
        ColumnName = Average|Count|CountNums|Max|Min|Product|None|StdDev|StdDevP|Sum|Var|VarP.

    -PivotFilter <String[]>
        Name(s) columns from the spreadsheet which will provide the Filter name(s) in a PivotTable created from command line parameters.
-PivotDataToColumn [<SwitchParameter>]
    If there are multiple datasets in a PivotTable, by default they are shown as separate rows under the given row heading; this switch
    makes them separate columns.

-PivotTableDefinition <Hashtable>
    Instead of describing a single PivotTable with multiple command-line parameters; you can use a HashTable in the form PivotTableName
    = Definition;
-FreezeTopRow [<SwitchParameter>]
    Freezes headers etc. in the top row

    -FreezeFirstColumn [<SwitchParameter>]
    Freezes titles etc. in the left column.

-FreezeTopRowFirstColumn [<SwitchParameter>]
    Freezes top row and left column (equivalent to Freeze pane 2,2 ).

-Now [<SwitchParameter>]
    The -Now switch is a shortcut that automatically creates a temporary file, enables "AutoSize", "TableName" and "Show", and opens
    the file immediately.

-FreezePane <Int32[]>
    Freezes panes at specified coordinates (in the form  RowNumber, ColumnNumber)

-AutoFilter [<SwitchParameter>]

-ReturnRange [<SwitchParameter>]
    If specified, Export-Excel returns the range of added cells in the format "A1:Z100".
-NoHeader
-RangeName <String>

-ExcludeProperty

-NoAliasOrScriptPropeties [<SwitchParameter>]
    Some objects in PowerShell duplicate existing properties by adding aliases, or have Script properties which may take a long time to
    return a value and slow the export down, if specified this option removes these properties

-MoveAfter | MoveBefore <object>
      If specified, the worksheet will be moved after the nominated one (which can be a position starting from 1, or a name or *).

    If * is used, the worksheet names will be examined starting with the first one, and the sheet placed after the last sheet which
    comes before it alphabetically.

-MoveToStarto | MoveToEnd <switch>
-unhide | hideSheet [names[]]
    names, wildcards

-StartRow <Int32>
    Row to start adding data. 1 by default. Row 1 will contain the title, if any is specifed. Then headers will appear (Unless -No
    header is specified) then the data appears.
-StartColumn <Int32>
    Column to start adding data - 1 by default.
-KillExcel [<SwitchParameter>]
    Closes Excel without stopping to ask if work should be saved - prevents errors writing to the file because Excel has it open.

-Activate [<SwitchParameter>]
    If there is already content in the workbook, a new sheet will not be active UNLESS Activate is specified; when a PivotTable is
    created its sheet will be activated by this switch.


-Style <Object[]>
    Takes style settings as a hash-table (which may be built with the New-ExcelStyle command) and applies them to the worksheet. If the
    hash-table contains a range the settings apply to the range, otherewise they apply to the whole sheet.

-CellStyleSB <ScriptBlock>
    A script block which is run at the end of the export to apply styles to cells (although it can be used for other purposes). The
    script block is given three paramaters; an object containing the current worksheet, the Total number of Rows and the number of the
    last column.

-Numberformat <String>
    Formats all values that can be converted to a number to the format specified. For examples:


    '0'         integer (not really needed unless you need to round numbers, Excel will use default cell properties).

    '#'         integer without displaying the number 0 in the cell.

    '0.0'       number with 1 decimal place.

    '0.00'      number with 2 decimal places.

    '#,##0.00'  number with 2 decimal places and thousand-separator.

    '€#,##0.00' number with 2 decimal places and thousand-separator and money-symbol.

    '0%'        number with 2 decimal places and thousand-separator and money-symbol.

    '[Blue]$#,##0.00;[Red]-$#,##0.00'
    blue for positive numbers and red for negative numbers;  Both proceeded by a '$' sign

    #>
        $exportExcelSplat = @{
            PassThru = $true
            WorksheetName = $SheetName
            TableName = "${SheetName}_data"
            TableStyle = 'Light2'
            AutoSize = $true
            FreezeTopRow = $true
            DisplayPropertySet = $True
        }

        $script:Pkg = $items
        | Export-Excel @exportExcelSplat -ExcelPackage $script:Pkg
    }
}



$ROOT | xl.AddSheet -SheetName 'root'
($root).CounterSetName | sort | xl.AddSheet 'CounterStName'
Close-ExcelPackage $script:Pkg -Show


$root ??= Get-Counter -ListSet * -ea 'ignore'
# $root.PathsWithInstances

return
# $hostname = hostname
# $Date      = $args[0]
# $Threshold = $args[1]
# $Counter   = $args[2]

# $TopProcesses = Get-Counter -ErrorAction SilentlyContinue '\Process(*)\% Processor Time' |
# Select-Object -ExpandProperty countersamples |
# Select-Object -Property instancename, cookedvalue |
# ? {$_.instanceName -notmatch "^(idle|_total|system)$"} |
# Sort-Object -Property cookedvalue -Descending |
# Select-Object -First 10 |
# ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100/$env:NUMBER_OF_PROCESSORS).toString('P')}} -AutoSize

# $Value = "[{0}] {1} {2} | {3}" -F $Date, 'High CPU', $Threshold, $Counter + $TopProcesses

# Add-Content -Value $Value -Path 'C:\HighCPUAlert.log'

# ## Emails devops log errors are detected
# $body = " Error. $Value on $hostname"
# $emailFrom = "$hostname@company.com"
# $emailTo = "devops@company.com"
# $subject = "$hostname - High CPU Usage"
# $smtpServer = "mail.adtrav.com"
# $smtp = new-object Net.Mail.SmtpClient($smtpServer)
# $smtp.Send($emailFrom, $emailTo, $subject, $body)