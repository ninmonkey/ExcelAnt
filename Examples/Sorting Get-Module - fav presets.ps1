. {
    Import-Module ..\GitLoggerAwsUtils.psd1 -Force -Verbose -global
    # simplified to
    $Props = @{
        Wanted = @( 'ModuleName', 'RefBy', 'Verb', 'Name', 'Type', 'Source' ) # had '*'
        Ft     = @{
            CommandInfo = @( 'RefBy', 'Verb', 'Noun', 'Name', 'Type' )
        }
        Sort   = @{
            CommandInfo = @('Source', 'Name')
        }
    }
    $q = Get-Command -m GitLoggerAwsUtils
    | Sort-Object -p $Props.Sort.CommandInfo
    | ForEach-Object {
        $_ | Add-Member -Force -PassThru -ea ignore -NotePropertyMembers @{
            Type  = ($_.GetType())?.Name ?? '<missing>'
            RefBy = Get-Alias -Definition $_.Name
            | Sort-Object Name -Unique | Join-String -sep ', '
        }
    }

    # $q | Format-Table Refby, *name* -AutoSize
    $ftSplat = @{
        AutoSize = $true
        GroupBy  = 'Source'
        Property = $Props.Ft.CommandInfo
    }

    $q
    | Sort-Object Noun
    #| ft -AutoSize ModuleName, RefBy, Verb, Name, Type, Source
    | Format-Table @ftSplat
}
$q
#| Sort-Object RefBy, Noun, Verb, Name
| Sort-Object Name, Verb, RefBy, Noun, Verb, Name
| Format-Table *ref*, Name, Verb, Noun


$q
#| Sort-Object RefBy, Noun, Verb, Name
| Sort-Object Verb, Name, RefBy, Noun, Verb, Name
| Format-Table *ref*, Name, Verb, Noun


$q
#| Sort-Object RefBy, Noun, Verb, Name
| Format-Table *ref*, Name, Verb, Noun
