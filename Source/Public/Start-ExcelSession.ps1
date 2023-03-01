# [Collections.Generic.List[Object]]$script:__xantState.curWorkbook ??= @{}
# $script:__xantState.curWorkbook ??= @{}
[Collections.Generic.List[Object]]$script:__xantState.openBookList ??= @()

function Start-ExcelSession {
    <#
    .SYNOPSIS
        create a new excel package, either replace existing or create a new file
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
    write-warning 'still a WIP'
    $nextPkg = Invoke-SafeFileTimeTemplate -infa 'Continue'
    $state = $script:__xantState.openBookList
    $state.add( $nextPkg )
    'Number of items: {0}' -f @( $state.count )
    | write-verbose -Verbose

    foreach($book in $state) {
        Close-ExcelPackage -ExcelPackage $book -ea 'continue'
        $state.Remove( $book )
    }
    'hardcoded temp behavior: closing existing sessions' | write-debug

    # [Collections.Generic.List[Object]]$script:__xantState.openBookList.add( $nextPkg )
    # throw
    'StartedXlsx => "{0}"' -f @(
        $nextPkg.File.fullName
    )
    | write-information -infa 'Continue'
    return $nextPkg
}
