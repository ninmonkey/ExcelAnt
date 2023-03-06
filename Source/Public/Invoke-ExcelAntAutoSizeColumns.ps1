function Invoke-ExcelAntAutoSizeColumns {
    <#
    .SYNOPSIS
        When autosize dependency is missing, fallback to a naive autosize attempt
    .DESCRIPTION
        When -AutoSize is missing, ex: an Aws Lambda
    .notes
        - [ ] maybe it should
    #>
    [Alias('xl.AutosizeColumns')]
    [CmdletBInding()]
    param(
        # todo: ArgCompletions: WorksheetName, else all

        # Include worksheets, else all
        [string[]]$WorksheetName,
        # Include Tables, else all
        [string[]]$TableName,

        # Should it only size tables that are named, not all columns?
        [switch]$OnlyTables = $true
    )
    $PSboundParameters | ft -auto | Out-String | Write-Verbose -Verbose

    throw 'nyi'
}
