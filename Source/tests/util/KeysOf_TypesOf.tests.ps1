Import-Module Pester
# requires @{ module = 'Pester'; moduleVersion = '5.1'}
$VerbosePReference = 'SilentlyContinue'

BeforeAll {
    Import-Module ExcelAnt -Force
    # $self = $PSCommandPath -replace '\.tests\.ps1$', '.ps1'
    # . (Get-Item $Self) -ea stop
}

Describe 'xa.Object.KeysOf' {
    BeforeAll {
        $Sample = @{
            Hash = @{ a = 1; z = 100 ; b = 4 }
        }
        It 'KeysInOrder' {
            $Names = $Sample.Hash | xa.KeysOf
            $expected = $Sample.Hash.Keys.Clone() | Sort-Object

            $Sample.Hash | xa.KeysOf
            | Should -BeExactly $expected
        }
    }

    It 'from [FileInfo]' {
        # from file
        $Pkg.File | coerce.ToFileInfo | Should -BeOfType 'IO.FileSystemInfo'
        $Pkg.File | coerce.ToFileInfo | Should -BeOfType 'IO.FileInfo' # more specifically
        coerce.ToFileInfo -InputObject $Pkg.File | Should -BeOfType 'IO.FileInfo' # more specifically
    }
}
Describe 'xa.Object.NameOf' {
    BeforeAll {
        $Sample = @{
            Hash          = @{ a = 10 ; b = 50 }
            File1         = Get-Item $PSCommandPath
            File2         = Get-ChildItem . -File | s -First 1
            Dir           = Get-Item . -directory
            Int           = 35
            List_implicit = 0..4
            List          = [Collections.Generic.List[Object]]::new( @(0..4))
        }
    }
    It 'KeysOf [FileInfo]' {

        $Expected = @('Name'
        'Attributes',  'BaseName',  'CreationTime',  'CreationTimeUtc',  'Directory',  'DirectoryName',  'Exists',  'Extension',  'FullName',  'IsReadOnly',  'LastAccessTime',  'LastAccessTimeUtc',  'LastWriteTime',  'LastWriteTimeUtc',  'Length',  'LinkTarget',  'LinkType',  'Mode',  'ModeWithoutHardLink',  'Name',  'PSChildName',  'PSDrive',  'PSIsContainer',  'PSParentPath',  'PSPath',  'PSProvider',  'ResolvedTarget',  'Target',  'UnixFileMode',  'VersionInfo')
        #| Should -BeExactly 'KeysOf_TypesOf.tests.ps1'
        $Sample.File1 | xa.keysOf
        | Should -BeIn $Expected
    }
    it 'TypeOf [FileInfo]' {

        $Sample.File2 | xa.TypeOf | Should -Match 'FileInfo'
        (Get-Item .) | xa.TypeOf | Should -Match 'directoryinfo'
    }
    It 'TypeOf [hashtable]' {
        $Sample.Hash | xa.TypeOf | Should -Match 'hashtable'
    }
}
    # describe
    # # It
    #  '<name> is <expected> for <label>' -ForEach @(

    #     @{
    #         obj      = @{ a = 10 }
    #         expected = 'Hashtable'
    #         label    = 'Hash'
    # if ($false) {

    #     $Sample1 = @{ a = 10; q = 23; 'sdf' = 4 }

    #     $Sample1 | xa.KeysOf

    #     $Sample1 | xa.TypeOf | Join-String -sep ', ' -SingleQuote
    #     $Sample1 | xa.TypeOf | Join.UL

    #     # 1 | xa.Object.KeysOf
    #     $Sample
    #     1 | xa.Object.KeysOf

    #     $Sample1 = @{ a = 10; q = 23; 'sdf' = 4 }
    #     $Sample1 | xa.KeysOf
    #     $Sample1 | xa.TypeOf
    #     $Sample1 | xa.TypeOf -FormatMode FullName
    #     $Sample1 | xa.TypeOf -FormatMode TypeInfo
    #     $Sample1 | xa.TypeOf -FormatMode Name
    #     $Sample1 | xa.TypeOf -FormatMode TypeInfo
    #     $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-ShortTypeName
    #     $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-GenericTypeName
    #     $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-ShortSciTypeName
    #     $Sample1 | xa.TypeOf -FormatMode TypeInfo | Format-TypeName
    #     }
    # ) {
    #     $Sample.$label | xa.$name | Should -BeExactly $expected
    # }
#     }
# }
