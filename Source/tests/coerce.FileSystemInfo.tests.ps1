Import-Module Pester
# requires @{ module = 'Pester'; moduleVersion = '5.1'}

$VerbosePReference = 'SilentlyContinue'

BeforeAll {
    $self = $PSCommandPath -replace '\.tests\.ps1$', '.ps1'
    . (Get-Item $Self) -ea stop
}

Context 'manuallyInvokedTests' {
    BeforeAll {
        # Note: Likely should use as BeforEvery, not used yet to bypass file overhead
        $Pkg = Open-ExcelPackage -Path 'temp:\test.xlsx' -CreateIfMissing
    }
    It 'from [FileInfo]' {
        # from file
        $Pkg.File | coerce.ToFileSystemInfo | Should -BeOfType 'IO.FileSystemInfo'
        $Pkg.File | coerce.ToFileSystemInfo | Should -BeOfType 'IO.FileInfo' # more specifically
        coerce.ToFileSystemInfo -InputObject $Pkg.File | Should -BeOfType 'IO.FileInfo' # more specifically
    }
    It 'from [ExcelPackage]' { # [OfficeOpenXml.ExcelPackage]
        $pkg | coerce.ToFileSystemInfo | Should -BeOfType 'IO.FileInfo'
        coerce.ToFileSystemInfo -InputObject $Pkg | Should -BeOfType 'IO.FileInfo' # more specifically
    }
      AfterAll {
        Close-ExcelPackage $Pkg -ea 'SilentlyContinue' -Verbose
    }
}

Describe 'ImportExcel.coerceFileSystemInfo' {
    BeforeAll {
        $Samples = @{
            File      = Get-Item $PSCommandPath
            Directory = Get-Item $PSScriptRoot
            Text      = @{
                Existing_Directory_String = $PSScriptRoot | Get-Item | ForEach-Object FullName
                Existing_File_String      = $PSCommandPath | Get-Item | ForEach-Object FullName
                Invalid_Directory_String  = 'g:\foo\bar\cat\dog'
                Invalid_File_String       = 'g:\foo\bar\cat\dog\readme.md'
            }
        }
    }
    It 'Identity Case <_>' {
        $Samples.File | Should -BeOfType 'IO.FileInfo'
        $Samples.Directory | Should -BeOfType 'IO.DirectoryInfo'

        $Samples.File | Coerce.toFileSystemInfo | Should -BeOfType 'IO.FileInfo'
        $Samples.Directory | Coerce.toFileSystemInfo | Should -BeOfType 'IO.DirectoryInfo'
    }

    Context 'TextAs_Existing' {
        $Samples.Text.Existing_File_String
        | Coerce.toFileSystemInfo
        | Should -BeOfType 'IO.DirectoryInfo'

        $Samples.Text.Existing_Directory_String
        | Coerce.toFileSystemInfo
        | Should -BeOfType 'IO.FileInfo'

    }
    Context 'Create When Missing?' {
        It 'ThrowIfNotSet' {
            { 'g:\foo\bar\cat\dog\readme.md'
                | coerce.toFileSystemInfo # -CreateIfMissing:$false
            } | Should -Throw -Because 'it doesn''t exist and did does not have -create set'
        }
        It 'NotThrowIfNotSet' {
            { 'g:\foo\bar\cat\dog\readme.md'
                | coerce.toFileSystemInfo -CreateIfMissing
            } | Should -Not -Throw -Because 'a missing path with create not set'
        }


    }
    # Context 'FileSystemInfo' {
    #     Context 'Get-File' {
    #         It 'should get a file' {
    #             $file = Get-File -Path $PSScriptRoot -Name 'debugHarness.ps1'
    #             $file | Should -BeOfType 'FileInfo'
    #             $file.Name | Should -Be 'debugHarness.ps1'
    #         }
    #     }
    #     Context 'Get-Directory' {
    #         It 'should get a directory' {
    #             $dir = Get-Directory -Path $PSScriptRoot -Name 'Output'
    #             $dir | Should -BeOfType 'DirectoryInfo'
    #             $dir.Name | Should -Be 'Output'
    #         }
    #     }
    # }
}
