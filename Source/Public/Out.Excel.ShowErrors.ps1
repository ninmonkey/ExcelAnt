
function Out-ExcelAntShowErrors {
    [Alias(
        'Out.ExcelError',
        'xl.Out-ShowErrors'
    )]
    [CmdletBinding()]
    param(
        $ErrorList,
        [switch]$Show,
        [string]$DestFileName

    )
    # try {
    $ErrorList | % GetType | % Name
    $curId = 0

    $myErrs = $ErrorList
    | %{
        $curItem = $_
        $curItem | Add-Member -PassThru -force -ea 'ignore' -NotePropertyMembers @{
            Order = ($curId++)
            Kind = $curItem.GetType().Name
        }
    }

    $selectSplat = @{
        ErrorAction = 'ignore'
        Property = @(
            'Order', 'Kind', '*'
        )
    }

    $myErrs = $myErrs | Select @selectSplat
    $OutExcelPath = Join-Path 'g:/temp/xl' ((b.SafeFiletimePath), '.xlsx' -join '')
    if($DestFileName) {
        $OutExcelPath = $DestFileName
    }
    $outExcelPath | Join-String -f '::xl: OpenPkg: {0}' | write-host -fore yellow -back darkblue
    $myPkg = Open-ExcelPackage -Path $OutExcelPath -Create

    $sharedSplat = @{
        PassThru = $true
        AutoSize = $true
        TableStyle = 'Light2'
    }
    $exportSplat = @{
        WorksheetName = 'SelectStar'
        TableName = 'SelectStar_table'
        Path = $myPkg
    }
    $myPkg = $myErrs | Select * | Export-Excel @sharedSplat @exportSplat
    # $myPkg = Export-Excel $myPkg -PassThru -AutoSize -work 'PageA' -table 'A_table' -TableStyle Light2
    $exportSplat = @{
        WorksheetName = 'Implicit'
        TableName = 'Implicit_table'
        Path = $myPkg
    }
    $myPkg = $myErrs | Export-Excel @sharedSplat @exportSplat

    $exportSplat = @{
        WorksheetName = 'StaticProp'
        TableName = 'StaticProp_table'
        Path = $myPkg
    }
    $selectSplat = @{
        Property = 'Order', 'Kind'
    }
    $myPkg = $myErrs | Select @selectSplat | Export-Excel @sharedSplat @exportSplat
    $OutExcelPath ?? '?' | Join-String -f '::writeExcel: {0}' | write-host -fore 'red'
    Close-ExcelPackage $myPkg -Show:$Show -SaveAs $OutExcelPath
    # } catch {
    #     'Out.ExcelError: Failed!' |write-error
    #     throw $_
    # }

}
