
write-warning 'Func not loading'
# function Compare-ExcelAntCustomDateFormatStrings {
#     <#
#     .SYNOPSIS
#     Quickly Compare custom format strings, including passing multiple cultures (I don't like the name)
#     .DESCRIPTION

#     .EXAMPLE
#         xl.Format.DateTime.CompareStrings
#     .EXAMPLE
#         Compare-ExcelAntCustomDateFormatStrings -FormatStrings 'o', 'u','O', 'U' -Cultures 'en-us', 'de-de'
#     .EXAMPLE
#         Get-Culture 'en-us', 'en-gb', 'es-us', 'de', 'de-de', 'fr', 'fr-fr', 'ja' | sort DisplayName

#     .NOTES
#     General notes
#     #>
#     [CmdletBinding()]
#     [Alias(
#         'xl.Format.Datetime.CompareStrings'
#     )]
#     [OutputType('PSCustomObject')]
#     param(
#         [ArgumentCompletions(
#             "'o', 'u','O', 'U'",
#             "'o', 'O', 'u'"
#         )]
#         [Parameter(Mandatory, Position = 0)]
#         [string[]]$FormatStrings,

#         [ArgumentCompletions(
#             "'en-us', 'de-de'",
#             "'en-us', 'de-de', 'en-es', 'en-gb'",
#             "'es-us', 'es'"
#         )]
#         [Parameter(Mandatory, Position = 1)]
#         [string[]]$Cultures,
#         # [switch]$TestIsValid # return bool


#         # required param Package, worksheet, table name
#         [Alias('InputObject')]
#         [Parameter()]
#         [datetime]$When
#     )
#     $Now = $When ?? [Datetime]::Now
#     # wait-debugger
#     # begin {}
#     # process {
#     # @(
#         throw 'failed'

#         'sdfdssf' | out-host
#         foreach ($CultName in $CultureList) {
#             foreach ($fStr in $FormatStrings) {
#                 wait-debugger
#                 $Cult = Get-Culture -Name $CultName
#                 [pscustomobject]@{
#                     PSTypename = 'ExcelAnt.FormatStringComparison'
#                     Culture    = $Cult
#                     FormatStr  = $FStr
#                     Local      = $Now.ToString( $fStr, $cult )
#                     Universal  = $Now.ToUniversalTime().ToString( $fStr, $Cult )
#                     Default    = $Now.ToString($Cult)
#                 }
#             }
#         }
#     # ) #| Sort-Object Culture, FormatStr

#     # }
#     # end {}

# }


# # $SplatDate = @{
# #     FormatStrings = 'o', 'u', 'O', 'U'
# #     Cultures = 'en-us', 'de-de', 'en-es', 'en-gb'
# # }

# # xl.Format.DateTime.CompareStrings @SplatDate
