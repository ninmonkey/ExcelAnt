
function Get-ExcelAddress {
    <#
    .NOTES
        future: allow autocomplete of currently open file
    todo:
        - [ ] arg completer enumerates tables, enumerates worksheets
    #>
    [Alias('xl.Addr.Lookup')]
    [CmdletBinding()]
    [OutputType('string')]
    param(
        # required param Package, worksheet, table name
        [Parameter(Mandatory, Position = 0)]
        [OfficeOpenXml.ExcelPackage]$Package,

        [ArgumentCompletions(
            'PayloSettings',
            'Changes',
            'New_JCUsers',
            'Previous_JCUsers',
            'Metrics',
            'errLog'
        )]
        [Parameter(Mandatory, Position = 1)]
        [string]$Worksheet,

        [ArgumentCompletions(
            'PayloSettings',
            'Changes',
            'New_JCUsers',
            'Previous_JCUsers',
            'Metrics',
            'errLog'
        )]
        [Parameter(Mandatory, Position = 2)]
        [string]$TableName
        # [switch]$TestIsValid # return bool
    )

    'Trying: {0}, {1}' -f @(
        $Worksheet, $TableName
    ) | Write-Verbose

    $sheetExists = -not $null -eq $Package.Workbook.Worksheets[$Worksheet]
    $tableExistsSomewhere = $TableName -in @($package.Workbook.Worksheets.Tables.Name)
    # $TableExistsInSameSheet = -not $null -eq $Package.Workbook.Worksheets[$Worksheet]
    $TableExistsInSameSheet = -not $null -eq $Package.Workbook.Worksheets[$Worksheet].Tables[$TableName]

    # try {
    # I was going to write: $Pkg.Workbook.Worksheets['Changes'].Tables['Changes'].Address.Address

    # write-verbose sheetExists, TableExistsSOmewhere, and TableExistsInSameSheet
    @{
        'SheetExists'            = $sheetExists
        'TableExistsSomewhere'   = $tableExistsSomewhere
        'TableExistsInSameSheet' = $TableExistsInSameSheet
    } | bdgLog -category ModuleEvent -message 'xl.Addr.Lookup' -PassThru
    | write-verbose

    return $Package.Workbook.Worksheets[ $Worksheet ].Tables[ $TableName ].Address.Address
}
