
function SafeFileTimeString {

    <#
    .SYNOPSIS
        timenow for safe filepaths: "2022-08-17_12-46-47Z"
    .notes
        distinct values to the level of a full second
    #>
    # [Alias('xl.New.Safetime')]
    [CmdletBinding()]
    param(
        # [Parameter(Mandatory, Position = 0)]
    )

    (Get-Date).ToString('u') -replace '\s+', '_' -replace ':', '-'
}
