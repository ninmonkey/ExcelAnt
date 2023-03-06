
function Set-ExcelAntSession {
    <#
    .SYNOPSIS
        sets the current excel session
    #>

    # Write-Warning 'still a WIP'
    # $nextPkg = Invoke-SafeFileTimeTemplate -infa 'Continue'
    # $state = $script:__xantState.openBookList
    # $state.add( $nextPkg )
    # 'Number of items: {0}' -f @( $state.count )
    # | Write-Verbose -Verbose

    # foreach ($book in $state) {
    #     Close-ExcelPackage -ExcelPackage $book -ea 'continue'
    #     $state.Remove( $book )
    # }
    # 'hardcoded temp behavior: closing existing sessions' | Write-Debug

    # # [Collections.Generic.List[Object]]$script:__xantState.openBookList.add( $nextPkg )
    # # throw
    # 'StartedXlsx => "{0}"' -f @(
    #     $nextPkg.File.fullName
    # )
    # | Write-Information -infa 'Continue'
    # return $nextPkg

}
function Get-ExcelAntBook {
    <#
    .SYNOPSIS
        from the current named session
    #>
    [ExcelSessionState]::GetCurrentPackage()
}
function New-ExcelAntBook {
    <#
    .SYNOPSIS
        create a new workbook for the given filepath. (Compare with New-ExcelAntSession)
    .DESCRIPTION

        #>
    [CmdletBinding()]
    param(
        #filepath
        [Alias('Name', 'FullName', 'LiteralPath')]
        [Parameter(Mandatory, position = 0)]
        [string]$FilePath
    )

    'New-ExcelAntBook: "{0}"' -f @(
        $FilePath
    ) | Write-Verbose

    $Pkg = Open-ExcelPackage -FilePath $FilePath -Create
    if($Pkg){
        [ExcelSessionState]::SetCurrentPackage( $Pkg )
    }
}
function old_New-ExcelAntSession {
    <#
    .SYNOPSIS
        starts a session using a label -- autogenerates a unique filename
    .DESCRIPTION
        this is called the first time, allowing you to auto rotate the file, once per run. Not new files every export
    .notes
    '
    todo
        - [ ] generates temp name, saves to a new sheet.
        - [ ] keep a reference based on a name or label
            which maps to the filesafetime
    '
    # future: track names to aliases
    #>



    Write-Warning 'still a WIP'
    $nextPkg = Invoke-SafeFileTimeTemplate -infa 'Continue'
    $state = $script:__xantState.openBookList
    $state.add( $nextPkg )
    'Number of items: {0}' -f @( $state.count )
    | Write-Verbose -Verbose

    foreach ($book in $state) {
        Close-ExcelPackage -ExcelPackage $book -ea 'continue'
        $state.Remove( $book )
    }
    'hardcoded temp behavior: closing existing sessions' | Write-Debug

    # [Collections.Generic.List[Object]]$script:__xantState.openBookList.add( $nextPkg )
    # throw
    'StartedXlsx => "{0}"' -f @(
        $nextPkg.File.fullName
    )
    | Write-Information -infa 'Continue'
    return $nextPkg
}
