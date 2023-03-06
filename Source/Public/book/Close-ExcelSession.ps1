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

    foreach ($Book in $state) {
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
