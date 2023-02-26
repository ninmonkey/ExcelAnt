
function coerce.ToExcelPackage { #

    <#
    .synopsis
        convert filepaths or [ExcelPackage]s, resolving to a workbook

    - [ ] 1 file already exists, and is fileinfo
    - [ ] 2 file exists, is a string path
    - [ ] 3 file does not exist
    #>
    # [OutputType('System.IO.FileSystemInfo')]
    [CMdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, position = 0)]
        [object]$InputObject,

        #

        # # When creating missing items, the default type is File
        # [Parameter()]
        # [ArgumentCompletions('File', 'Directory', 'SymoblicLink', 'Junction', 'HardLink')]
        # [string]$ItemType = 'File',

        # # create file if not yet existing
        [switch]$CreateIfMissing
        # [switch]$Mandatory

    )
    begin {
        # $null = $InputObject
    }
    process {

        <#
            DirectoryInfo       isa System.IO.FileSystemInfo
            FileInfo            isa System.IO.FileSystemInfo
        #>
        if($InputObject -is 'OfficeOpenXml.ExcelPackage') {
            write-verbose 'already an ExcelPackage'
            return $InputObject
        }

        throw 'left off here
        1] simple coerce path to package if existing
        create if requested
        commit
        '

        if ($InputObject -is 'string') {
            $alreadyExists = Test-Path $InputObject
            '{0} is string, and exists? {1}' -f @(
                $InputObject | Join-String -double
                $alreadyExists
            ) | write-verbose

            'AlreadyExists? {0}. CreateIfMissing? {1}' -f @(
                $AlreadyExists,
                $CreateIfMissing
            ) | write-verbose

            if ($AlreadyExists) {
                return $InputObject | Get-Item
            }
            'Does not exist. CreateIfMissing? {0} using type: {1}' -f @(
                $CreateIfMissing
                $ItemType
            )| write-verbose


            if($CreateIfMissing) {
                'creating: {0}' -f @(
                    $InputObject | Join-String -double
                ) | write-verbose

                New-Item -ItemType $ItemType -path $InputObject -Force -passThru
                return
            }

            if(-not $AlreadyExists -and -not $CreateIfMssing){
                $PSCmdlet.WriteError(
                    [Management.Automation.ErrorRecord]::new(
                        [ArgumentException]::new(
                            'File does not exist, and CreateIfMissing is not set'
                        ),
                        'FileDoesNotExist',
                        [Management.Automation.ErrorCategory]::InvalidArgument,
                        $InputObject
                    ))
            }
            # elkse, missing with create

        }

        'unhandled type name: [{0}]' -f @(
            $InputObject.GetType().Name
        ) | Write-Error



        # return [IO.FileInfo]::new($InputObject)

        switch ($InputObject) {
            { $_ -is [System.IO.FileInfo] } {
                $InputObject
            }
            { $_ -is [string] } {
                [System.IO.FileInfo]::new($InputObject)
            }
            default {
                [System.IO.FileInfo]::new($InputObject)
            }
        }
    }
    end {}

}
