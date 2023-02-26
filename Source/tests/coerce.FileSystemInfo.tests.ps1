Import-Module Pester -MinimumVersion 5.1
$VerbosePReference = 'SilentlyContinue'

BeforeAll {
    $self = $PSCommandPath -replace '\.tests\.ps1$', '.ps1'
    . (Get-Item $Self) -ea stop
}


Describe 'ImporExcel.coerceFileSystemInfo' {
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
        it 'ThrowIfNotSet' {
            { 'g:\foo\bar\cat\dog\readme.md'
                | coerce.toFileSystemInfo # -CreateIfMissing:$false
            } | Should -Throw -Because 'it doesn''t exist and did does not have -create set'
        }
        it 'NotThrowIfNotSet' {
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
