# [Collections.Generic.List[Object]]$script:__xantState.curWorkbook ??= @{}
# $script:__xantState.curWorkbook ??= @{}
[Collections.Generic.List[Object]]$script:__xantState.openBookList ??= @()

function Start-ExcelSession {
    <#
    .SYNOPSIS
        create a new excel package, either replace existing or create a new file
    .DESCRIPTION
        this is called the first time, allowing you to auto rotate the file, once per run. Not new files every export
    #>

    '
    todo
        - [ ] generates temp name, saves to a new sheet.
        - [ ] keep a reference based on a name or label
            which maps to the filesafetime
    '
    # future: track names to aliases

    $nextPkg = Invoke-SafeFileTimeTemplate -infa 'Continue'

    [Collections.Generic.List[Object]]$script:__xantState.openBookList.add( $nextPkg )

    return $nextPkg
}
function Close-ExcelSession {
    [CmdletBinding()]
    param(
        # instead of closing, return the stored list
        [switch]$PassThru,
        # I'm not sure whether there's a reason benefit
        [switch]$Force
    )
    $state = $script:__xantState.openBookList
    if($PassThru) {
        return $state
    }

    'Books stored: {0}' -f @( $state.Count ) | Write-Information -infa 'Continue'

    foreach ($Book in $script:__xantState.openBookList) {
        try {
            Close-ExcelPackage -ExcelPackage $Book
            if ($Force) {
                $book.close()
                $book.dispose()
            }
        }
        catch {
            Write-Error "Failed closing`nnote: `nfuture will alias a label to a session.`ncurrently I never drop a reference explicitly`n$_" -ea 'continue'
        }
    }
}
