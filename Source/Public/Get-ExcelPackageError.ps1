# Import-Module ImportExcel

@'
initial
        15    0.009 cd 'G:\temp\xl'
        16    0.008 $whichXl = gcl |gi
        19    0.031 mkdir temp_exo
        20    0.009 cd .\temp_exo\
        24    0.012 $whichXl | cp -Destination '.'
        25    0.006 ls
        30    0.190 $src = gi JumpCloud_Changes.2023-02-24_12-22-02Z.xlsx
                    $dest = 'dir'
                    Expand-Archive $src -DestinationPath $dest
        31    0.008 ls
        33    1.207 code.cmd --new-window .\dir\

sprint
    - [ ] filepath from string or fileinfo
    - [ ] file but as an excel package
    - [ ] allow piping of either
    - [ ] maybe ValuesFromParameterType or ParameterName
        to auto coerce packages cleaner ?
'@ | write-verbose -verbose

function xl.Errors.Inspect {
    # filepath to an excel file
    # copy to g:\temp\xl\auto'
    # expand archive to subdir
    param(
        [string]$ExcelPkg
        # [string]$subdir,
        # [string]$outpath,


    )

    throw 'NYI'
    ''

    # $coerceFilepath = Get-Item $ExcelPkg
    # }
}

# transformation type
