Import-Module Ugit
Import-Module ImportExcel
Import-Module Pipeworks

gcm -m PipeWorks
| sort Name
| ft -auto -group Source

gcm -m PipeWorks
| sort Noun, Name
# | ft Noun, Name -group Noun
| ft -auto -group Noun
