
# or import nancy?

function Get-RandomNancyColor {
    <#
    .synopsis
        random 24bit color
    .DESCRIPTION
        Output is raw random, no smoothing.
    .notes
        future: differentiate between Write-Color and Get-Color

        colors are objects to mutate
        write is ansi escapes as string

        see [pansies.RGBColor] as an idea, but,
        the new behavior of 7.3 gives new posibilities, see about_AnsiTerminal
    .EXAMPLE
        Pwsh> Get-RandomNancyColor
        Pwsh> Get-RandomNancyColor -Count 10
    #>
    [Alias('xl.Rand.AnsiColor')]
    [OutputType('PoshCode.Pansies.RgbColor')]
    [CmdletBinding()]
    param(
        # Return more than one color
        [Alias('Count')][int]$TotalCount = 1
    )

    foreach ($i in 1..$TotalCount) {
        $r, $g, $b = Get-Random -Count 3 -Minimum 0 -Maximum 255
        $PSStyle.Background.FromRgb($r, $g, $b)
        # or: [PoshCode.Pansies.RgbColor]::new($r, $g, $b)
    }
}
