'did not import ?: {0}' -f $PSCommandPath
| Write-Warning

function ConvertTo-MdTableFromStdout_toCleanup {
    <#
    .SYNOPSIS
    takes text from the pipeline, usually a native command

    .DESCRIPTION
    Converts Output from Native Commands. Many are easy to parse columns, because they use \t delimiters

    .EXAMPLE
    An example

    .NOTES
    - [ ] currently first line is header. argument could skip that.

    # todo: steppable ?
    - [ ] Future: Support input as Objects, table from properties
    - [ ] Future: Support input as hashtables, table from key value pairs
    - [ ] check out how pipescript defines how its objects serialize, secifically to markdown files
    #>
    [Alias(
        # 'xl.Format.MdTableFromStdoutConsole',
        'nin.TableFromStdout',
        'xl.Tablify.Md.FromStdout'
    )]
    [CmdletBinding(DefaultParameterSetName = 'FromPipeline')]
    param(
        # raw text piped in
        # use? [AllowNull()]
        # [AllowEmptyCollection()]
        # [AllowEmptyString()]

        [Alias('InputObject')]
        [Parameter(Mandatory, ValueFromPipeline, parameterSetName = 'FromPipeline')]
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'FromParam')]
        [string[]]$InputText,

        [switch]$NoHeader
    )
    begin {
        if ($NoHeader) { throw 'nyi: insert blank header, so the first record doesn''t become the header' }
        # todo: steppable ?
        [Text.StringBuilder]$StrBuild = [String]::Empty

    }
    process {
        [void]$StrBuild.AppendJoin($InputText, "`n")
    }
    end {
        $Parse = $StrBuild.ToString() -split "`n" | ForEach-Object {
            $curStr = $_
            $Segments = $_ -split '\t'
            $colCount = $segments.count
            $segments | Join-String -op '| ' -os ' |' -sep ' | '
            if ($IsFirst) {
                $IsFirst = $false
                @('-' * $colCount -join '' -split '') # column row
                | Join-String -sep ' | '
            }
        } | Join-String -sep "`n"

        return $Parse

    }
}
