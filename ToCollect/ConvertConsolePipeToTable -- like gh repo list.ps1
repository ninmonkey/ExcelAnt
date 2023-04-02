
& {
    gh run list | ForEach-Object {
        $segments = $_ -split '\t'
        $colCount = $segments.count
        $segments | Join-String -op '| ' -os ' |' -sep ' | '
        if ($IsFirst) {
            $IsFirst = $false
            @('-' * $colCount -join '' -split '') # column row
            | Join-String -sep ' | '
        }

    } | Join-String -sep "`n"
}

hr;


& {

    Push-Location -stack 'test.export' 'H:\github_fork\Pwsh\PowerShellGuide'

    $isFirst = $true
    gh run list | ForEach-Object {
        $segments = $_ -split '\t'
        $colCount = $segments.count
        $segments | Join-String -op '| ' -os ' |' -sep ' | '
        if ($IsFirst) {
            $IsFirst = $false
            @('-' * $colCount -join '' -split '') # column row
            | Join-String -sep ' | '
        }

    } | Join-String -sep "`n"
    #popd -stack 'test.export'

    Pop-Location -stack 'test.export'
}