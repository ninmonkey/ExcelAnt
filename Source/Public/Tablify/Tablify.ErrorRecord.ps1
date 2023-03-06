<#

samples to re-create


    'a'..'c' | ForEach-Object -Parallel { 3..0 | %{ 1 / $_ ; '9' }; sleep 0.3; 'x' }
    $wFlat ??= err -Num 1
    $wErr ??= err -Num 1 | Get-Error
#>
