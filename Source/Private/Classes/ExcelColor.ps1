
function mangle_colorHexToRgb {
    # oh gosh. terrible hack.
    [OutputType('System.Drawing.Color')]
    param( [string]$HexStr )
    if ($HexStr.Length -eq 8) { write-error '8char wip' }

    $alpha = 0xff
    $strRgb = $HexStr.Substring(0, 6)
    $r, $g, $b = [rgbcolor]::FromRgb( $strRgb ).ToRgb()

    return [System.Drawing.Color]::FromArgb( $alpha, $r, $g, $b)
}
class ExcelColor {
    # future: convert to argument transformation type
    [int]$Red = 0xff
    [int]$Green = 0xff
    [int]$Blue = 0xff
    [int]$Alpha = 0xff
    [System.Drawing.Color]$Color = 'white'


    ExcelColor ( [string]$HexStr ) {
        $this.Color = [ExcelColor]::FromHex( $HexStr )

    }
    ExcelColor ( [int]$Red, [int]$Green, [int]$Blue ) {
        $This.Red = $Red
        $This.Green = $Green
        $This.Blue = $Blue
        $This.Color = [ExcelColor]::FromRGBA( $this.Red, $This.Green, $This.Blue )

    }
    ExcelColor ( [int]$Red, [int]$Green, [int]$Blue, [int]$Alpha ) {
        $This.Red = $Red
        $This.Green = $Green
        $This.Blue = $Blue
        $This.Alpha = $Alpha
        $This.Color = [ExcelColor]::FromRGBA( $this.Red, $This.Green, $This.Blue, $This.Alpha )
    }
    [string] ToString() {
        # outputs: [ExcelColor('#0f232490')]
        return [ExcelColor]::__repr__( $This )
    }
    hidden static [string] __repr__ (  [ExcelColor]$Object ) {
        # outputs: [ExcelColor('#0f232490')]
        return '[ExcelColor(''#{0:x}{1:x}{2:x}{3:x}'')]' -f @(
            $Object.Red.ToString('x')
            $Object.Green.ToString('x')
            $Object.Blue.ToString('x')
            $Object.Alpha.ToString('x')
        )
    }
    [string] ToHexString() {
        # outputs: #0f232490
        return '#{0:x}{1:x}{2:x}{3:x}' -f @(
            $this.Red.ToString('x')
            $this.Green.ToString('x')
            $this.Blue.ToString('x')
            $this.Alpha.ToString('x')
        )
    }

    # static [ExcelColor] FromHex( [string]$HexStr) {
    static [System.Drawing.Color] FromHex( [string]$HexStr) {
        [System.Drawing.Color]$res = _colorHexToRgb -HexStr $HexStr
        return $res
    }
    static [System.Drawing.Color] FromRGB( [int]$Red, [int]$Green, [int]$Blue ) {
        return [System.Drawing.Color]::FromArgb( $Red, $Green, $Blue)
    }
    static [System.Drawing.Color] FromRGBA( [int]$Red, [int]$Green, [int]$Blue, [int]$Alpha ) {
        return [System.Drawing.Color]::FromArgb( $Alpha, $Red, $Green, $Blue)
    }
}

function mangle_l.NewColor {
    return [ExcelColor]
}

function mangle_l.Addr.Lookup {
    <#
    .NOTES
        future: allow autocomplete of currently open file
    #>
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
