throw 'should never run, is an example'
throw 'old version, grab more'
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\core_config.ps1 #>
# using namespace system.collections.generic


# custom format string for this date 'Sat, 05 Aug 2022 19:35:36 GMT'
# $fmt = 'ddd, dd MMM yyyy HH:mm:ss "GMT"'


$script:__writeDotEnabled = $false
$script:__writeDotOptions = @{
    SkipTypes = [Collections.Generic.List[string]]@(
        'CacheHit', 'Processing', 'default'
    )
}


# . (Get-Item -ea stop (Join-Path $global:appConf.prefixRootActual 'te sts-invoke\.env\oauth-test-env.ps1'))



# maybe neeads to change to not include self
# $appConf.prefixRootActual_self =  'bad path not used'
# $appConf.prefixRootActual_self =  $null
#   Join-Path $appConf.prefixRootActual 'self'
# [Collections.Generic.List[object]]$script:LiveDB_EmployeeInfo = @()

# [hashtable]$script:DbgCfg = @{
#     MaxRequestsPerInvoke = 6
#     # MaxRequestsPerInvoke = 200
#     totalRequestCount    = 0
#     # sleepStepSizeMs = 1000
#     sleepStepSizeMs      = 40 # 50
#     WatchOnEmployee      = @('11666')
# }

# $global:PathsExcel = @{}


# if ( 'always' -or (! $AppConf) ) {
# $AppConf = @{ Root = (Join-Path Get-Item $PSScriptRoot '..') }

$tempAppRoot = Get-Item ($AppConf.prefixRootActual)
if (! ($tempAppRoot)) {
    throw 'Fatal missing root'
}

# $ErrorActionPreference = 'break'
# $ErrorActionPreference = 'stop'
# $ErrorActionPreference = 'continue'

'🐇 ->' | Write-Warning
@(
    '/var/task/modules/bdg_lib'
    Join-Path $appConf.prefixRootActual '.env/jumpcloud.env'
    Join-Path $appConf.prefixRootActual '../.env/jumpcloud.env'
    Join-Path $appConf.prefixRootActual '/var/task/modules/bdg_lib/.env/jumpcloud.env'
    Join-Path $appConf.prefixRootActual '/var/task/modules/.env/jumpcloud.env'
) | ForEach-Object {
    [pscustomobject]@{
        TestPath = Test-Path $_
        rawStr   = $_
        Item     = Get-Item -ea 'ignore' $_
    }
}
| Sort-Object Test-Path
| Format-List | oss | Join-String -sep "`n"
# | Format-Table -auto | oss | Join-String -sep "`n"
| Write-Warning
'🐇 <-' | Write-Warning

# b.ensureExists -
#  (Join-Path $appConf.prefixRootActual '.temp')
# editfunc ensureExists

$tempAppRoot = $appConf.prefixRootActual

if (Test-Path '/var/task/module') {
    $_temp_ModuleRoot = Get-Item '/var/task/module' -ea 'continue'
    $appConf.prefixRootActual = $_temp_ModuleRoot
}
else {
    $_temp_ModuleRoot = Get-Item $appConf.prefixRootActual
}
# $_temp_ModuleRoot = gi '/var/task/module' -ea 'SilentlyContinue'
# $_temp_ModuleRoot = if(-not $_)

<#
    see also: $ExportExcelCfg.Exports.Worksheet
#>
# Set-PSBreakpoint -Command 'Join-Path'
$ErrorActionPreference = 'break'

$AppConf.prefixModuleRoot.FullName | Write-Debug

[hashtable]$global:PathsExcel = @{
    # for 'copyexcel'

    export_finalStatic_JCImport = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output_static/For_JCUser.csv')
    export_safeTimeRootTemplate = Join-Path $AppConf.prefixRootActual 'tests-invoke/.temp/ExportSummary_{0}.export.xlsx'
    export_PayloJsonCache       = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/PayloJsonCache.json')
    export_payloFull            = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/paylo_full.raw.csv')
    export_step0_raw            = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/iter3.EmployeeInfo.step0-raw.csv')
    export_step0                = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/iter3.EmployeeInfo.step0.csv')
    export_step1                = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/iter3.EmployeeInfo.step1.csv')
    export_json_step0           = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/iter3.EmployeeInfo.step0.json')
    export_debug_step1          = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/iter3.EmployeeInfo.step1.json')
    export_empNewToDb           = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output/employee_isnew.csv')
    # | gi -ea stop

    # | gi -ea stop

    # export_allProps             = Get-Item -ea stop (Join-Path $AppConf.prefixRootActual 'output\import-excel_selectAll.csv')
    export_allProps             = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output\import-excel_selectAll.csv')
    export_final                = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output\final-JC-UpdateUsers.csv')
    # export_namedProps  = Get-Item -ea stop (JOin-Path $AppConf.prefixRootActual 'output\import-excel_selectNamed.csv')
    export_mergedExcel          = b.ensureExists -File (Join-Path $AppConf.prefixRootActual 'output\final-excel-debug-v2.xlsx')
    export_IncludesJumpCloud    = $true

}


$global:AppConf += @{
    Limit                = @{
        MaxJumpCloudQueryCount = 15 # 0
    }
    DynamicRoot          = @{
        Temp            = Get-Item -ea 'ignore' /tmp # switch to user env var overrides on path
        ModulePSModules = Get-Item $_temp_ModuleRoot
        SystemRoot      = @{
            ModuleRoot = Join-Path $PSScriptRoot '.' | Get-Item -ea ignore

        }
    }
    Verbosity            = @{
        MuteGetJCUser = $true
    }
    JumpCloudEnv         = @(
        # todo: fully move to secret
        Get-Item -ea 'ignore' (Join-Path $appConf.prefixRootActual '.env/jumpcloud.env') # todo: fully move to secret
        Get-Item -ea 'ignore' '/var/task/modules/.env/jumpcloud.env'
    )[0]

    PaylocityEnvConfRoot = @(
        # todo: fully move to secret
        # PaylocityEnvConfRoot = Get-Item -ea 'Continue' (Join-Path $appConf.prefixRootActual '.env/paylocity.env') # todo: fully move to secret
        Get-Item -ea 'ignore' (Join-Path $appConf.prefixRootActual '.env/pyalocity.env') # todo: fully move to secret
        Get-Item -ea 'ignore' '/var/task/modules/.env/pyalocity.env'
    )[0]
    # JumpCloudEnv         = Get-Item -ea stop (Join-Path $PSSCriptRoot '.env/jumpcloud.env') # todo: fully move to secret
    # PaylocityEnvConfRoot = Get-Item -ea stop (Join-Path $PSSCriptRoot '.env/paylocity.env') # todo: fully move to secret
    LiveDB               = @{
        # Required for 'EmployeeNumbers[0].employeeList'
        EmployeeList = b.ensureExists -File (Join-Path $appConf.prefixRootActual '.env/liveDb_employeeList2.json')
        # EmployeeInfo = Get-Item -ea stop (Join-Path $appConf.prefixRootActual '.env/liveDb_employeeInfo2.json')
    }
    LLogPath             = b.ensureExists -File (Join-Path $appConf.prefixRootActual 'log/main.log')
    ExportPrefix         = b.ensureExists -Directory (Join-Path $appConf.prefixRootActual 'output')

    Cache                = @{
        JsonForceCachedDataOnly = $true
        EmployeeNumberSummary   = b.ensureExists -File (Join-Path (Join-Path $appConf.prefixRootActual 'output') 'EmployeeNumberSummary.cache.csv')
        EmployeeSummaryIndex    = b.ensureExists -File (Join-Path (Join-Path $appConf.prefixRootActual 'output') 'EmployeeSummaryIndex.cache.json')
        JCSummaryIndex          = b.ensureExists -File (Join-Path (Join-Path $appConf.prefixRootActual 'output') 'JumpCloudIndex.cache.json')
    }
    ExportTemp           = b.ensureExists -Fil e (Join-Path $appConf.prefixRootActual '.temp')
    AlreadyConnected     = $_LastAlreadyConnected ?? $false
    BDG_Whatif           = $true # obsolete?
    # disabled_CsvTemplate = @{
    # 'JC_NewUser'    = '"FirstName","LastName","Username","Password","Email","alternateEmail","manager","managedAppleId","MiddleName","preferredName","jobTitle","employeeIdentifier","department","costCenter","company","employeeType","`ion","location","home_streetAddress","home_poBox","home_city","home_state","home_postalCode","home_country","work_streetAddress","work_poBox","work_city","work_state","work_postalCode","work_country","mobile_number","home_number","work_number","work_mobile_number","work_fax_number","Group1","Group2","Group3","Group4","Group5","Group6","Group7","Group8","Group9","Group10"'
    # 'JC_UpdateUser' = 'Username,alternateEmail,manager,managedAppleId,MiddleName,preferredName,jobTitle,employeeIdentifier,department,costCenter,company,employeeType,description,location,home_streetAddress,home_poBox,home_city,home_state,home_postalCode,home_country,work_streetAddress,work_poBox,work_city,work_state,work_postalCode,work_country,mobile_number,home_number,work_number,work_mobile_number,work_fax_number,Group1,Group2,Group3,Group4,Group5,Group6,Group7,Group8,Group9,Group10'
    # }
    Paylocity            = @{
        CachedFulltimeNumber = Join-Path $appConf.prefixRootActual '/.env\import\CachedFulltimeNumber.json'
        SchemaCo_13294       = Join-Path $appConf.prefixRootActual '/.env\import\co_schema_13294.json'
        SchemaCo_812849      = Join-Path $appConf.prefixRootActual '/.env\import\co_schema_89849.json'
    }
}

# $PathsExcel.export_pathForFTPUpdates = Join-Path $AppConf.ExportTemp 'for_ftp_push.xlsx'

if ($global:AppConf.Verbosity.MuteGetJCUser) {
    $PSDefaultParameterValues['Get-JCUser:Debug'] = $false
    $PSDefaultParameterValues['Get-JCUser:Verbose'] = $false
    $global:PSDefaultParameterValues['Get-JCUser:Debug'] = $false
    $global:PSDefaultParameterValues['Get-JCUser:Verbose'] = $false
}
else {
    if($ENV:enable_global_verbose) {
        $PSDefaultParameterValues['Get-JCUser:Debug'] = $true
        $PSDefaultParameterValues['Get-JCUser:Verbose'] = $true
        $global:PSDefaultParameterValues['Get-JCUser:Debug'] = $true
        $global:PSDefaultParameterValues['Get-JCUser:Verbose'] = $true
    }
}

$ErrorActionPreference = 'continue'


function bdgLog {
    <#
    .synopsis
        local logging
    .example
        PS> ls . -Depth 2 *json | select -First 5 | % name
            | bdgLog -PassThru -Category Query 'find all files'
    .example
        PS> get-date | bdglog -passerrthru
    .example
        PS> get-date | bdglog -passthru -
    .EXAMPLE
        $Sample = Get-Variable -Scope 0 | % Name
        $Sample  |  bdgLog -Category ModuleEvent
        $Sample  |  bdgLog -Category ModuleEvent -PassThru
        $Sample  |  bdgLog -Category ModuleEvent -PassThru -Message 'vars from scope 0'



    .NOTES
        ~~currently allows too much of no-arg null values for all~~
    #>
    [CmdletBinding(DefaultParameterSetName = 'FromPipe')]
    param(
        [Alias('Label')]
        # [Parameter(Mandatory, Position = 0)]
        # [Parameter(Position = 0)]
        [Parameter( Position = 0)]
        $Message = [string]::Empty,

        [Alias('Payload')]
        [Parameter(
            ParameterSetName = 'FromPipe',
            ValueFromPipeline)]
        # Mandatory, ValueFromPipeline)]
        [Parameter(
            ParameterSetName = 'fromParam',
            Position = 1)]
        # Mandatory, Position = 1)]
        [object[]]$InputObject,

        # more useful than traditional severity levels only
        [Parameter()]
        [ArgumentCompletions(
            'ModuleEvent',
            'DataIntegrity',
            'CacheEvent',
            'Query',
            'Warn',
            'Verbose',
            'Pester',
            'WebRequest'
        )]
        [string]$Category,


        # kwargs for config
        [Parameter()]
        [hashtable]$Options = @{},

        # output information stream
        [switch]$PassThru,
        [switch]$JoinAsCsv
    )
    begin {
        if ($JoinAsCsv) {
            throw '-JoinAsCsv NYI'
        }
        if ($null -eq $global:AppConf) { return }
        if (-not $global:AppConf) { return }

        # if (! (Test-Path $global:AppConf.LLogPath)) {
        #     # if (! (Test-Path $global:AppConf.LLogPath)) {
        #     New-Item -ItemType File -Path $global:AppConf.LLogPath -Force
        #     # New-Item -ItemType File -Path $global:AppConf.LLogPath -Force
        # }
        # b.ensureExists -Directory -path $global:AppConf.LLogPath | out-null
        $Config = @{
            FormatMode   = 'default' # 'inverse'
            JoinAsString = $False
            JsonSplat    = @{
                Depth          = 4 # 8
                EnumsAsStrings = $true
                AsArray        = $true
                Compress       = $true
            }
        }
        $Config = mergeHash $Config $Options

        $log_dest = b.ensureExists -File ($global:AppConf.LLogPath)
        # $log_dest = $(
        #     Get-Item $global:AppConf.LLogPath -ea 'ignore'
        #     b.ensureExists -Directory -path $global:AppConf.LLogPath
        #     # Get-Item $global:AppConf.LLogPath -ea 'ignore'
        #     # Get-Item $global:AppConf.LLogPath -ea 'ignore'
        # ) | Select-Object -First 1

        $items = [Collections.Generic.List[object]]::new()
    }
    process {
        if ($null -eq $InputObject) {
            return
        }
        $items.AddRange( $InputObject)
    }
    end {

        $now = ([datetime]::now).ToUniversalTime().ToString('u')
        # $items.ToString()
        # traditional forma
        try {
            if ($Config.FormatMode -eq 'inverse') {
                # New: Moved date to suffix.
                $prefix = @(
                    $Category ? "${Category}: " : ''
                    $Message ? "${Message}: " : ''
                ) -join ''

                $Suffix = @(
                    ' ㏒: '
                    $Now
                ) -join ''
            }
            else {
                $prefix = @(
                    "${now}: "
                    $Category ? "${Category}: " : ''
                    $Message ? "${Message}: " : ''
                ) -join ''
                $Suffix = ''
            }
        }
        catch {
            Write-Warning 'BDGLog.FormatMode == inverse was null'
            $prefix = "${Category}: ${Suffix}"
        }


        # if ($JoinAsString) {
        #     $render = $Items | Join-String -sep ', ' -op $Prefix #"${Message}: "

        # } else {

        $splatJson = $Config.JsonSplat
        if ( [string]::IsNullOrWhiteSpace( $InputObject)) {
            $InputObject = @()

        }

        $render = $Items | ConvertTo-Json @splatJson
        | Join-String -op $Prefix -os $Suffix
        # }
        if ( [string]::IsNullOrWhiteSpace( $render)) {
            Write-Warning 'render null'
        }

        $addContentSplat = @{
            Path = $log_dest
        }
        if ($PassThru) {
            # $render | Add-Content @addContentSplat -PassThru
            # changed behavior to strip ansi better
            $render
            # | str$renderipAnsi # for not not required
            | Add-Content @addContentSplat
            return
            # | Write-Information TryZ
            # return
        }
        $render | Add-Content @addContentSplat
    }

}

# | write-host

# $irmConfigPath = b.ensureExists -verbose -TestNoCreate -WithoutForce -File (Join-Path $appConf.prefixRootActual '.env/core_env.json')
# $ErrorActionPreference = 'break'

$irmConfigPath = Join-Path -Path $appConf.prefixRootActual '.env/core_env.json'

Test-Path $irmConfigPath
| Join-String -op 'Test-Path: $irmConfigPath: '
| Write-Host -fore magenta


@{
    'Test-Path'      = Test-Path $irmConfigPath
    '$irmConfigPath' = $irmConfigPath ?? ''
} | Format-Table | oss
| Join-String -sep "`n" | Write-Host -fore magenta
# | write-host -fore red

# | Join-String


if ($true -or 'override ') {
    # #AuthFix: clientKey
    $script:IrmConfig = @'
{"ClientId":"O8kJeUWvn0+pj89iEnFBaS04NTg1NTE4MDY1MjgwNDcxNzY0","TokenName":"WebTokenProd","xml_modulus":"ud9IWIoY0c3/zL3iGJsUTWZZnhMg2VfW1CZXoppkBn8EegPvJP56rrRYEbEv7l7WlOauFJbOaf1hqrLIw5vJAptOgW1HLNjPCf9iV8o+MI/lJH2uHD7waX4YQ+Lup4tX/tC50XBcUyFhFlIqtm+PVWgjYLMGvX2EYPWbV/3FVcU+MPieqr43s+Itov3GDIwaYCxmEzctZxE0CmREU4BBCd26CkcMoWpTioaYhFYy/cB/StUMUiSzvIuRBpqIOAH6J0jlEKocMb95gAkODiqlYC9JOv5zWGfasDUu3pwhkJd0S+V7JGyrAMtgkqkbzpiqbdgTkB5V/J+nllen2+QYPw==","lastAuthReq":"TzhrSmVVV3ZuMCtwajg5aUVuRkJhUzA0TlRnMU5URTRNRFkxTWpnd05EY3hOelkwOmxzeExmOU1Zd3dQVWE1SS9RMm9rU09DbEVpREt5Q3oyTVR0L0lJNVNZWGxpcmNaVVNpU1VxWlRteTNJV215R0x4MVN5S3dNdzJnWnp1N20xNHlhV3p3PT0=","Scope":"WebLinkAPI","AuthUrl":"https://api.paylocity.com/IdentityServer/connect/token","xml_Path":".env/PaylocityPublicKey.xml","xml_power":"AQAB","CurToken_BearerString":"","CurToken":"","Payload":"","RequestMode":"-header","ClientSecret":"lsxLf9MYwwPUa5I/Q2okSOClEiDKyCz2MTt/II5SYXlircZUSiSUqZTmy3IWmyGLx1SyKwMw2gZzu7m14yaWzw==","BaseUrl":"https://api.paylocity.com","_HeaderPrefix":"Bearer"}
'@ | ConvertFrom-Json
}
else {
    $script:IrmConfig = Get-Content $irmConfigPath -ea 'continue' | ConvertFrom-Json
    $script:IrmConfig.xml_Path = b.ensureExists -WithoutForce -TestNoCreate -File (Join-Path $appConf.prefixRootActual $IrmConfig.xml_Path -ea ignore)
    if (-not $IrmConfig) {
        $null = 0

        '{0}, was: {1} (glob: {2}' -f @(
            'Missing $irmConfig.xml_path'
            $IrmConfig.xml_Path ?? '?'
            $script:IrmConfig.xml_Path ?? '?'
            $global:IrmConfig.xml_Path ?? '?'

        )
        | Write-Warning
    }
}
# // move import to

#// on sand this is /tmp/

# $test =  Join-Path $appConf.prefixRootActual $IrmConfig.xml_Path
# $test =  b.ensureExists -verbose -TestNoCreate -File ($irmConfigPath)
# $test =  b.ensureExists -verbose -TestNoCreate -File (Join-Path $appConf.prefixRootActual $IrmConfig.xml_Path)

# $ErrorActionPreference = 'continue'
# $irmConfigPath = $script:IrmConfigPath ?? $irmConfigPath
# $irmConfig = $script:IrmConfig ?? $irmConfig
if (-not $irmConfig ) {
    Write-Warning 'missing config irmConfigPath'
}
@{
    # prefix_Self   = $AppConf.prefixRootActual_self
    prefix_Output = $AppConf.prefixRootOutput
    prefix_Actual = $AppConf.prefixRootActual

}
| Format-Table -auto | oss | Join-String -sep "`n"
| Write-Warning

# ls -Force (join-path $AppConf.prefixModuleRoot '..')
# $script:IrmConfig.payload = '{0}:{1}' -f @(
#     $IrmConfig.ClientId
#     $IrmConfig.ClientSecret
# )
# $payload = '{0}:{1}' -f @(
#     $IrmConfig.ClientId
#     $IrmConfig.ClientSecret
# )
function dropBlankKeys {
    <#
    .SYNOPSIS
        enumerate hashtable, drop any keys that have blankable vlaues
    #>
    [CmdletBinding()]
    [OutputType('Hashtable')]
    param(
        [Parameter(mandatory)]
        [hashtable]$InputHashtable,

        [switch]$NoMutate
    )
    $strUserKeyId = '[User={2} <CoId={0}, EmpId={1}>]' -f @(
        $finalObj.companyId
        $finalObj.employeeIdentifier
        $finalObj.userName
    )
    if ($NoMutate) {
        $targetHash = [hashtable]::new( $InputHashtable )
    }
    else {
        $targetHash = $InputHashtable
    }

    $msg = $targetHash.GetEnumerator()
    | Where-Object { [string]::IsNullOrEmpty( $_.Value ) }
    | ForEach-Object Name | Sort-Object -Unique
    | Join-String -sep ', ' -op "dropped blank fields on ${strUserKeyId}: "
    @{
        Message = $msg
    }
    | bdgLog -Category DataIntegrity -Message $msg -PassThru
    | Write-Verbose


    $toDrop = $targetHash.GetEnumerator()
    | Where-Object { [string]::IsNullOrEmpty( $_.Value ) }
    | ForEach-Object Name

    foreach ($k in $toDrop) {
        $targetHash.Remove( $k )
    }
    return $targetHash

}

# label '=== Reached final core_config.ps1 300.' $PSCommandPath
# | write-warning
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\core_config.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\stand_alone_entry.ps1 #>
function _colorHexToRgb {
    # oh gosh. terrible hack.
    [OutputType('System.Drawing.Color')]
    param( [string]$HexStr )
    if ($HexStr.Length -eq 8) { write-error '8char wip' }

    $alpha = 0xff
    $strRgb = $HexStr.Substring(0, 6)
    $r, $g, $b = [rgbcolor]::FromRgb( $strRgb ).ToRgb()

    return [System.Drawing.Color]::FromArgb( $alpha, $r, $g, $b)
}
class excelColor {
    # future: convert to argument transformation type
    [int]$Red = 0xff
    [int]$Green = 0xff
    [int]$Blue = 0xff
    [int]$Alpha = 0xff
    [System.Drawing.Color]$Color = 'white'


    excelColor ( [string]$HexStr ) {
        $this.Color = [excelColor]::FromHex( $HexStr )

    }
    excelColor ( [int]$Red, [int]$Green, [int]$Blue ) {
        $This.Red = $Red
        $This.Green = $Green
        $This.Blue = $Blue
        $This.Color = [excelColor]::FromRGBA( $this.Red, $This.Green, $This.Blue )

    }
    excelColor ( [int]$Red, [int]$Green, [int]$Blue, [int]$Alpha ) {
        $This.Red = $Red
        $This.Green = $Green
        $This.Blue = $Blue
        $This.Alpha = $Alpha
        $This.Color = [excelColor]::FromRGBA( $this.Red, $This.Green, $This.Blue, $This.Alpha )
    }

    # static [excelColor] FromHex( [string]$HexStr) {
    static [System.Drawing.Color] FromHex( [string]$HexStr) {
        [System.Drawing.Color]$res = _colorHexToRgb -HexStr $HexStr
        return $res
    }
    static [System.Drawing.Color] FromRGB( [int]$Red, [int]$Green, [int]$Blue ) {
        return [System.Drawing.Color]::FromArgb( $Red, $Green, $Blue)
    }
    static [System.Drawing.Color] FromRGBA( [int]$Red, [int]$Green, [int]$Blue, [int]$Alpha ) {
        return [System.Drawing.Color]::FromArgb( $Alpha, $Red, $Green, $Blue)
    }
}

function xl.NewColor {
    return [excelColor]
}

function xl.Addr.Lookup {
    <#
    .NOTES
        future: allow autocomplete of currently open file
    #>
    [CmdletBinding()]
    [OutputType('string')]
    param(
        # required param Package, worksheet, table name
        [Parameter(Mandatory, Position = 0)]
        [OfficeOpenXml.ExcelPackage]$Package,

        [ArgumentCompletions(
            'PayloSettings',
            'Changes',
            'New_JCUsers',
            'Previous_JCUsers',
            'Metrics',
            'errLog'
        )]
        [Parameter(Mandatory, Position = 1)]
        [string]$Worksheet,

        [ArgumentCompletions(
            'PayloSettings',
            'Changes',
            'New_JCUsers',
            'Previous_JCUsers',
            'Metrics',
            'errLog'
        )]
        [Parameter(Mandatory, Position = 2)]
        [string]$TableName
        # [switch]$TestIsValid # return bool
    )

    'Trying: {0}, {1}' -f @(
        $Worksheet, $TableName
    ) | Write-Verbose

    $sheetExists = -not $null -eq $Package.Workbook.Worksheets[$Worksheet]
    $tableExistsSomewhere = $TableName -in @($package.Workbook.Worksheets.Tables.Name)
    # $TableExistsInSameSheet = -not $null -eq $Package.Workbook.Worksheets[$Worksheet]
    $TableExistsInSameSheet = -not $null -eq $Package.Workbook.Worksheets[$Worksheet].Tables[$TableName]

    # try {
    # I was going to write: $Pkg.Workbook.Worksheets['Changes'].Tables['Changes'].Address.Address

    # write-verbose sheetExists, TableExistsSOmewhere, and TableExistsInSameSheet
    @{
        'SheetExists'            = $sheetExists
        'TableExistsSomewhere'   = $tableExistsSomewhere
        'TableExistsInSameSheet' = $TableExistsInSameSheet
    } | bdgLog -category ModuleEvent -message 'xl.Addr.Lookup' -PassThru
    | write-verbose

    return $Package.Workbook.Worksheets[ $Worksheet ].Tables[ $TableName ].Address.Address
}

# try {
#     Export-ModuleMember -ea stop -Function @(
#         'xl.NewColor'
#         'xl.Addr.Lookup'
#     )
# } catch {
#     write-verbose 'is not a module'
# }
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\stand_alone_entry.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\always_first_static.ps1 #>
Set-PSDebug -Trace 0
#Import-Module ImportExcel

function map.resolveAlias {
    process {
        # missses any not imported
        $_ | Resolve-CommandName -QualifiedName | ForEach-Object Name
    }
}
$script:__warnCache ??= @{}
function warnOnce {

    # warn once withing spam
    param(
        [Parameter(Mandatory)]
        [string]$Message
    )
    # if(-not $script:__warnCache ) {
    #     $state = $script:__warnCache = @{}
    # }
    $state = $script:__warnCache
    if ($state.ContainsKey($Message)) {
        return
    }
    Write-Warning $Message
    b.ToastIt -Title 'warnOnce' -Text $Message
    $state[$Message] = $true
    # not actually used just a quick hack to use set

}

function b.formatRemoveLogAnsiContent {
    <#
    .SYNOPSIS
        strip ansi escapes, saving the result to the original file
    .EXAMPLE
        formatRemoveLogAnsiContent -LogPath 'c:\foo.log'
    #>
    param( [string]$LogPath )
    if ( -not (Test-Path $LogPath) ) { return }
    # note, if not using -raw, some escapes are not replaced
    $newContent = Get-Content $LogPath -Raw | StripAnsi
    $newContent | Set-Content -Path $LogPath
}



function selectAndSort {
    <#
    .SYNOPSIS
        user custom sorting of properties and drop others, does not autosort the rest
    .EXAMPLE
        $record
            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                Name = $record.username
                InPaylo       = '$inPaylo'
                InJC          = '$inJC'
            }
            | selectAndSort -RequiredWild 'name' -ExcludeWild 'guid'
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject,

        [Parameter()]
        # [ValidateNotNullOrEmpty()]
        [string[]]$RequiredWild,
        # [string[]]$RequiredPropertyRegex,
        #
        [Parameter()]
        [string[]]$ExcludeWild
        # [string[]]$ExcludeRegex
    )

    process {
        $splat = @{
            Property = $RequiredWild
            Exclude  = $ExcludeWild
        }
        if (-not $RequiredWild) {
            $splat.Remove('Property')
        }
        if (-not $ExcludeWild) {
            $splat.Remove('Exclude')
        }

        $AllProps = $InputObject.Psobject.properties.name | Sort-Object
        $InputObject
        | Select-Object -Property @( $RequiredWild; '*'; ) -ExcludeProperty $ExcludeWild -ea Ignore
    }
}
function Sort.ByProp.BlanksFirst {
    # todo: toextract: 2023-01-20
    <#
    .SYNOPSIS
        user custom sorting of properties and drop others, does not autosort the rest
    .notes
        refactor selectAndSort and this, to a generic
            "operate sortby X on table"
            make that pipescript
    .EXAMPLE
        $record
            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                Name = $record.username
                InPaylo       = '$inPaylo'
                InJC          = '$inJC'
            }
            | selectAndSort -RequiredWild 'name' -ExcludeWild 'guid'
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject,

        [Alias('Descending')]
        [switch]$SortBlanksLast
        # [ValidateNotNullOrEmpty()]
        # [string[]]$RequiredWild,
        #         # [string[]]$RequiredPropertyRegex,
        # #
        #         [Parameter()]
        #         [string[]]$ExcludeWild
        #         # [string[]]$ExcludeRegex
    )
    begin {
        Write-Warning 'validate working'
    }

    process {
        # if(-not $RequiredWild) {
        #     $splat.Remove('Property')
        # }
        # if(-not $ExcludeWild) {
        #     $splat.Remove('Exclude')
        # }


        [string[]]$AllProps = $InputObject.Psobject.properties
        | Sort-Object { [STRING]::IsNullOrWhiteSpace( $_.value ) }
        | ForEach-Object Name

        $splatSo = @{
            Property = $AllProps
            # Exclude = $ExcludeWild
        }
        # $splatSort
        # $InputObject.psobject.properties
        $InputObject
        | Select-Object -Property @( $allProps) #
        | Sort-Object -Descending:$SortBlanksLast
        | Select-Object -ExcludeProperty $ExcludeWild -ea Ignore
    }
}


function b.updateObjectFromHash {
    <#
    .SYNOPSIS
        update props to an object from hashtable
    .example
        b.updateObjectFromHash $SomeUser @{ Name = 'bob' }
    #>
    param(
        # what to mutate
        [Alias('Obj')][object]$InputObject,
        [Alias('Other')][Parameter(mandatory)]$Hashtable,

        # add new properties to object?
        [switch]$IncludeNewProperty
    )
    if ($IncludeNewProperty) { Throw 'NYI' }

    foreach ($Key in $Hashtable.keys.clone()) {
        (Get-Item .).psobject.properties.name -contains 'name'
        if ( @($InputObject.psobject.properties.name) -contains $Key) {
            $InputObject.$Key = $Hashtable[ $Key ]
        }
    }
}
function b.ReplaceIfBlank {
    <#
    .synopsis
        basically it's blank-aware version of using: $x ?? $y'
    .EXAMPLE
        b.ReplaceIfBlank $User.Name '<defaultUser>'
    .NOTES
        todo:

        - [ ] optionally replaceCoalasce like SQL

        Pwsh>
            b.ReplaceIfBlank $User.Name $User.AccountId '<default_user>'

        and also
        Pwsh>
           @( $User.Name ;  $User.AccountId ) |  b.ReplaceIfBlank -FinalFallback '<default_user>'


        name, BlankDefaults   ?

    #>
    [Alias('b.CoalesceBlanks')]
    [cmdletBinding()]
    param(
        # some string that might be blank
        [AllowNull()]
        [AllowEmptyString()]
        [Parameter(Mandatory)]
        [string]$InputText,

        # fallback, does not have to be text
        [Alias('Default')]
        [AllowNull()]
        [AllowEmptyString()]
        [Parameter(Mandatory)]
        [object]$Fallback,

        [switch]$RequireTrueEmptyStr
    )

    # if($null -eq $Fallback) {
    $Fallback ??= "[`u{2400}]"

    # }
    $shouldReplace = $false
    $aIsBlank = [string]::IsNullOrWhiteSpace( $InputText )
    $bIsBlank = [string]::IsNullOrWhiteSpace( $Fallback )
    if ( -not $AIsBlank ) {
        return $InputText
    }
    if ($aIsBlank -and (-not $bIsBlank)) {
        return $Fallback
    }
    if ($aIsBlank -and $bIsBlank) {
        return "[`u{2400}]"
    }

    # write-warning 'needs autotest'


    if ( [string]::IsNullOrWhiteSpace( $InputText) ) {
        $shouldReplace = $True
    }
    if ($RequireTrueEmptyStr) {
        if ( -not [String]::Empty -eq $InputText ) {
            $shouldReplace = $false
        }
    }
    "[ ShouldReplace: {0}, Val1 = '{1}', Val2 = '{2}', requireTrueEmptyStr: {3} ]" -f @(
        $shouldReplace, $InputText, $Fallback, $RequireTrueEmptyStr
    ) | Write-Debug
    if ($shouldReplace) { return $Fallback } else { return $InputText }
}

function b.TestIsEmployeeActive {
    # test: is this employee considered active?
    [OutputType('System.Boolean')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $InputObject
    )


    # if(-not ($null -eq $INputObject)) {
    #     $null = 0
    # }
    # if($after -gt $before) {
    #     $null = 0
    #    b.ToastIt 'IsEmployeeActive'  'new', (
    #         ($InputObject)?.GetType().Name ?? '<?>'
    #     )
    #     wait-debugger
    # }


    $isEmployeeActive = $false
    $target = $InputObject ?? 'badtarget'
    switch ( $target.GetType().Name ) {


        'PayloExportRecord' {
            $statusIsBlank = [String]::IsNullOrWhiteSpace( $target.employeeStatus )
            if ($statusIsBlank) { return $false }
            # todo: 2022-10-20: filter on location equals remote

            if ( $Target.employeeStatus -eq 'A' -and (-not $statusIsBlank) ) {
                $isEmployeeActive = $true
            }
            else {
                $isEmployeeActive = $false
            }
            break
        }
        'JCUserUpdate_CsvRecord' {
            $statusIsBlank = [String]::IsNullOrWhiteSpace( $target.employeeStatus )
            if ($statusIsBlank) { return $false }
            # todo: 2022-10-20: filter on location equals remote
            # hasa: employeeType       : RFT

            # it doesn't have that field
            $a = ($Target)?.employeeStatus -eq 'A' # shouldn't have one

            if ( $a -and (-not $statusIsBlank) ) {
                $isEmployeeActive = $true
            }
            else {
                $isEmployeeActive = $false
            }
            break
        }

        default {
            b.ToastIt -title 'IsEmployeeFullTime' 'new', (
                ($InputObject)?.GetType().Name ?? '<?>'
            )
            ($InputObject)?.GetType().Name ?? ''
            | bdgLog -Category Warn 'Unhandled isEmployeeActiveType!' -PassThru
            | Write-Warning
            Wait-Debugger
            return $false #// should be false but true for debug test
            return $true
        }
    }
    return $isEmployeeActive

}

function b.TestIsEmployeeFullTime {
    # Test: Is this employee considered full time?
    [OutputType('System.Boolean')]
    [CmdletBinding()]
    param(
        [ValidateNotNull()]
        [Parameter(Mandatory)]
        $InputObject
    )

    $isFullTime = $false
    $target = $InputObject
    switch ( ($target)?.GetType().Name) {

        'PayloExportRecord' {
            # todo: 2022-10-20: filter on location equals remote
            $statusIsBlank = [String]::IsNullOrWhiteSpace( $target.employeeStatus )
            if ( $Target.employeeStatus -eq 'A' -and (-not $statusIsBlank) ) {
                $isFullTime = $true
            }
            else {
                $isFulLTime = $false
            }
            break
        }
        'JCUserUpdate_CsvRecord' {
            # todo: 2022-10-20: filter on location equals remote
            $statusIsBlank = [String]::IsNullOrWhiteSpace( $target.employeeStatus )
            if ( $Target.employeeStatus -eq 'A' -and (-not $statusIsBlank) ) {
                $isFullTime = $true
            }
            else {
                $isFulLTime = $false
            }
            break
        }

        default {
            b.ToastIt -title 'IsEmployeeFullTime' 'new', (
                ($InputObject)?.GetType().Name ?? '<?>'
            )
            # wait-debugger
            # write-error "Unhandled IsFullTimeType: $($InputObject.GetType().Name)!"
            $InputObject.GetType().Name
            | bdgLog -Category Warn 'Unhandled isEmployeeActiveType!' -PassThru
            | Write-Warning
            # wait-debugger
            return $false

        }
    }
    return $isFullTime
}


function b.Text.WrapString {
    <#
    .EXAMPLE
        b.Text.WrapString ('a'..'z' -join '_') -MaxWidth 10

            a_b_c_d_e_
            f_g_h_i_j_
            k_l_m_n_o_
            p_q_r_s_t_
            u_v_w_x_y_
            z
    #>
    param(
        [Alias('Text')]
        [Parameter(Mandatory, Position = 0)]
        [string]$InputText,

        [Alias('Cols')]
        [int]$MaxWidth = 120
    )
    $regex_charCount = '(.{', $MaxWidth, '})' -join ''
    # $InputText -join "`n" -split '(.{80})' -join "`n" -replace '\n+', "`n"
    $InputText -join "`n" -split $regex_charCount -join "`n" -replace '\n+', "`n"
}



function b.addProp {
    [CmdletBinding(DefaultParameterSetName = 'addSingleProperty')]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        [Parameter(Position = 0)]
        [Alias('Name', 'Label')]
        [string]$PropertyName,


        [Parameter(Position = 1, Mandatory, ParameterSetName = 'addSingleProperty')]
        [object]$Value,

        # requires explicit parameter name else it gets complicated because object, hash, etc
        # could all possibly be valid, or invalid, depending on context
        [Alias('hashtable', 'Dict', 'NotePropertyMembers', 'Members')]
        [Parameter(Position = 1, Mandatory, ParameterSetName = 'addManyProperties')]
        [hashtable]$AddPropertyMembers
    )
    process {

        $splat_addMember = @{
            Force       = $true
            ErrorAction = 'ignore'
            PassThru    = $true
        }

        if ($PSBoundParameters.ContainsKey('Value') -or $PSCmdlet.ParameterSetName -eq 'addSingleProperty') {
            $splat_addMember.NotePropertyName = $PropertyName
            $splat_addMember.NotePropertyValue = $Value
        }
        else {
            $splat_addMember.NotePropertyMembers = $AddMembers

        }


        $InputObject | Add-Member @splat_addMember
    }


}


# Export-ModuleMember -Function @(
#     'b.Html.Table.FromHashtable'


#     'b.Text.WrapString'
#     'selectAndSort'
#     'b.fm'
#     'b.TestIsEmployeeActive'
#     'b.TestIsEmployeeFullTime'
#     'fzf.getCommand'
#     'map.resolveAlias'
#     'b.updateObjectFromHash'
#     'b.getAll.Props'
#     'b.addProp'

# )


class EmployeeIdPair {
    # edit: new business logic is
    #      GUID: work email

    # unique keys used for dictionary
    # future: add equality test, compare using these two columns
    # [ValidateNotNullOrEmpty()] # //actually need invalid records in cases
    [ArgumentCompletions('13294', '89849')]
    # [Nullable[String]]$CompanyId
    [String]$CompanyId

    # [ValidateNotNullOrEmpty()]
    # [Nullable[String]]$EmployeeId
    [String]$EmployeeId

    EmployeeIdPair ( [string]$CoEmpIdPair ) {
        $this.CompanyId, $this.EmployeeId = $CoEmpIdPair -split ','
        if ($null -eq $this.CompanyId -or $null -eq $This.EmployeeId) {
            Write-Warning 'Invalid Id Pair, null value'
        }

    }

    EmployeeIdPair ( [string]$CompanyId, [string]$EmployeeId ) {
        if ($null -eq $CompanyId -or $null -eq $EmployeeId) {
            Write-Error 'Invalid Co, Id Pair, null value'
        }
        $this.CompanyId = $CompanyId
        $this.EmployeeId = $EmployeeId
    }
    [string] ToKeyId () {
        # warning: if one is missing, should it return nothing? no?
        return ('{0},{1}' -f @(
            ($this)?.CompanyId ?? ''
            ($this)?.EmployeeId ?? ''
        )).ToLower()
    }
    [string] ToString() {
        return $this.ToKeyId()
    }
    [string] ToJson() {
        return ($This | ConvertTo-Json -Depth 6 -Compress)
    }
    [string] ToRepr() {
        return '[Co: {0}, EmpId: {1}]' -f @(
            ($this)?.CompanyId ?? ''
            ($this)?.EmployeeId ?? ''
        )
    }
}
function b.New-EmployeeIdPair {
    [OutputType('EmployeeIdPair')]
    [cmdletBinding()]
    param(
        [Parameter(Mandatory, ParameterSetName = 'FromCsv', Position = 0)]
        [ArgumentCompletions(
            '13294,12022', '13294,89849'
        )]
        [string]$IdPairAsCsv,

        [Parameter(Mandatory, ParameterSetName = 'FromPosition', Position = 0)]
        [ArgumentCompletions('89849', '13294')]
        [string]$CompanyId,

        [Parameter(Mandatory, ParameterSetName = 'FromPosition', Position = 1)]
        [ArgumentCompletions('11548', '12022')]
        [string]$EmployeeId
    )

    switch ($PSCmdlet.ParameterSetName) {
        'FromCsv' {
            return [EmployeeIdPair]::new( $IdPairAsCsv )
        }
        'FromPosition' {
            return [EmployeeIdPair]::new( $CompanyId, $EmployeeId )
        }

        default {
            throw "Unhandled ParameterSet: $($PSCmdlet.ParameterSetName)"
        }
    }
}

function Format-BlanksToDefault {
    <#
    .SYNOPSIS
        Takes a parameter, if null, apply missing string
    .DESCRIPTION
    #>
    [OutputType('System.String', 'System.Object')]
    [CmdletBinding()]
    param(
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [AllowNull()]
        [Parameter(Mandatory)]$InputObject,

        [ArgumentCompletions('<missing>', '<empty>', '<null>', '$null', '[blank]', '[␀]')]
        [Parameter()][string]$DefaultValue = '<empty>'

    )
    if ( [string]::IsNullOrWhiteSpace($InputObject) ) {
        return $DefaultValue
    }
    return $InputObject
}

function b.Html.Table.FromHashtable {
    <#
    .SYNOPSIS
        render html table
    .example
        $selectEnvVarKeys = 'TMP', 'TEMP', 'windir'
        $selectKeysOnlyHash = @{}
        ls env: | ?{
            $_.Name -in @($selectEnvVarKeys)
        } | %{ $selectKeysOnlyHash[$_.Name] = $_.Value}

        #>
    param(
        [hashtable]$InputHashtable
    )
    $renderBody = $InputHashTable.GetEnumerator() | %{
        '<tr><td>{0}</td><td>{1}</td></tr>' -f @(
            $_.Key ?? '?'
            $_.Value ?? '?'
        )

    } | Join-String -sep "`n"
    $renderFinal = @(
        '<table>'
        $renderBody
        '</table>'
    ) | Join-String -sep "`n"
    return $renderFinal
    # '<table>'
    # '</table>'

}




function formatBlankText {
    <#
            .SYNOPSIS
                remplace empty str and nulls with symbols
            .DESCRIPTION
                "`u{2420}" = '␠'
                $null = '␀'
                empty array
                '@(␀)' ?
            #>
    [OutputType('System.String', 'System.Object')]
    [CmdletBinding()]
    param(
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [AllowNull()]
        [Parameter(ValueFromPipeline)]$InputObject,

        [switch]$NoRecurse
    )
    if ($null -eq $InputObject) {
        return '[␀]'
    }
    if ($InputObject -is 'array' -and $InputObject.count -eq 0) {
        return '[empty[]]'
        return '[ @() ]'
        return '@(␀)'
    }
    if ($InputObject -is 'String') {
        if ($InputObject.Length -eq 0) {
            return '[␠]'
        }
        if ( [string]::IsNullOrWhiteSpace( $InputObject )) {
            return '[blank ␠]'
        }
    }
    # pass thru if conditions are false
    # or maybe recurse with InputObject.ToString()
    if ( $NoRecurse) {
        return $InputObject
    }
    [string]$implicitText = ($InputObject)?.ToString() ?? ''
    [string]$fromImplicit = formatBlankText $implicitText -NoRecurse
    return $fromImplicit
    #  if( [string]::IsNullOrWhiteSpace( $ImplicitText ) )  {
    #  }

    #  return $inputObject
}

# no requirement sugar
function b.wrapLikeWildcard {
    <#
    .SYNOPSIS
        converts like-patterns to always wrap wildcards
    .example
        'cat', 'CAT*' | b.wrapLikeWildcard
        '*cat*', '*cat*
    #>
    process {
        @( '*', $_.ToLower(), '*') -join '' -replace '\^\*{2}', '*' -replace '\*{2}$', '*'
    }
}

function b.fm {
    <#
    .SYNOPSIS
        Find member, sugar to show full name, and enforce wildcard
    .EXAMPLE
        Pwsh> $eis | b.fm fetch


    #>
    param( [string]$Pattern )
    process {
        $pattern = $pattern | b.wrapLikeWildcard
        # $pattern = @( '*', $patter.ToLower(), '*') -join '' -replace '\^\*{2}', '*'

        if ($Pattern) {
            $_ | Find-Member $Pattern | Sort-Object Name | Format-Table Name, DisplayString
        }
        else {
            $_ | Find-Member | Sort-Object Name | Format-Table Name, DisplayString
        }
    }
}


function b.getAll.Props {
    # for all, get all common props
    <#
        .SYNOPSIS
        get a distinct list of all properties of all objects piped
        .example
            gi . | b.getAll.Props
        #>
    $items = $input

    @(foreach ($x in $items) {
            $x.PSObject.Properties.Name
        }) | Sort-Object -Unique
}

<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\always_first_static.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\paylo_restapi.ps1 #>

function PayloRest-GetAllEmployees {
    param(
        [Parameter(Mandatory)]
        [ArgumentCompletions('13294', '89849')]
        [string]$companyId
    )

    # /https://api.paylocity.com/api/v2/companies/:companyId/employees?pagesize=3000&pagenumber=0&includetotalcount=true
    $irmSplat = @{
        Uri                     = @(
            $script:IrmConfig.BaseUrl
            '/api/v2/companies/{0}/employees' -f @(
                $companyId
            )
        ) -join ''
        Body                    = @{
            'pagesize'          = '3000'
            'pagenumber'        = '0'
            'includetotalcount' = 'true'
        }
        Method                  = 'GET'
        # Authentication = 'Bearer'
        ResponseHeadersVariable = '_respHeaders'
        StatusCodeVariable      = '_statusCode'
        SkipHttpErrorCheck      = $true
        # Credential = 'a'
        # Token = 'x'
        SessionVariable         = '_session'
        RetryIntervalSec        = 1
        Headers                 = @{
            'Authorization'   = $script:IrmConfig.CurToken_BearerString
            'Accept'          = '*/*'
            'Cache-Control'   = 'no-cache'
            # 'Postman-Token'   = '95ef7613-5784-4c49-83ae-b572d3439e31'
            'Host'            = 'api.paylocity.com'
            'Accept-Encoding' = 'gzip, deflate, br'
            'Connection'      = 'keep-alive'
            # 'Cookie'          = 'TS01bbcf67=01a24764559ca92f4d226c11c64d8655f4dfad7bda207a52b4790ac8da155c156fd71fdf4a51fe33b28fe402df5ecd5a1f70639825'
        }
    }
    # bdgLog -Message 'enumerate employee ids' -InputObject @{
    #     Url  = $IrmSplat.Uri
    #     Body = $IrmSplat.Body
    # } -PassThru | Write-Host
    __writeDot HttpRequest
    $response = Invoke-RestMethod @irmSplat

    if ($_statusCode -eq 200) {
        __writeDot Good
        return $response
    } else {
        __writeDot HttpError
    }

    if ($_statusCode -eq 401) {
        bdgLog -Message 'had HTTP 401, Refreshing Auth Token' -Category WebRequest
        Write-Error -ea 'stop' -Message 'HTTP401: get new Auth token'
        return $null
    }

    return $null
}
function PayloRest_CompanyResourceCode {
    [cmdletBinding()]
    param(
        [ArgumentCompletions('13294', '89849')]
        [Parameter(Mandatory)]
        $companyId,

        # Company Code. Common values costcenter1, costcenter2, costcenter3, deductions, earnings, taxes, paygrade, positions.
        [Parameter(Mandatory)]
        [ValidateSet(
            'costcenter1', 'costcenter2', 'costcenter3', 'deductions', 'earnings', 'taxes', 'paygrade', 'positions'
        )]
        [string]$ResourceType,

        [Parameter()]
        [string]$KeyName
    )
    if (-not $keyName ) {
        return '?'
    }
    # "A", "L", "T", "XT", "D", "R"
    # double check
    $resourceMap = ($script:localDB.CoResourceMapping | Where-Object CompanyId -EQ $companyId).codeResource
    $lookUp = $resourceMap.$resourceType | Where-Object Code -EQ $KeyName
    if ( -not $Lookup ) {
        return ''
    }

    $finalText = @(
        # $KeyName
        $lookUp.Code ?? '?'
        $lookup.JobTitle ?? $lookUp.Description ?? '?'
        # $KeyValue
    ) -join '-'
    return $finalText
}
#

export-modulemember -Function @(
    'PayloRest-GetAllEmployees'
    'PayloRest_CompanyResourceCode'
)
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\paylo_restapi.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\employee_infostate.ps1 #>
# using namespace System.Collections.Generic
# $VerbosePreference = 'continue'
# import-module ImportExcel

write-warning 'reached end of emp state🍌'


if ($ENV:enable_global_verbose) {
    $PSDefaultParameterValues['ImportExcel\*:verbose'] = 'continue'
}
function b.copyWorkBook0 {
    [CmdletBinding()]
    param(
        [string]$OriginalPath = $kwarg.NewDest ?? 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\output\debug-mini.partial_always.xlsx',
        # [string]$ExportTemplate = $kwarg.ExportTemplate ?? 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\.temp\debug-mini.partial_always_{0}.export.xlsx',
        [Parameter(Mandatory)]
        [string]$ExportTemplate,
        # $kwarg.ExportTemplate ?? 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\.temp\debug-mini.partial_always_{0}.export.xlsx',
        [switch]$WithoutConditional
    )
    '📚 maybe error throwing logic here, to catch null paths ==>  bdg_lib\src_static\employee_infostate.ps1/0fef9826-7f93-4c53-8c5d-b48fa56bfd49' | Write-Warning
    $splatIt = @{
        OriginalPath   = $OriginalPath #$kwarg.NewDest
        exportTemplate = $ExportTemplate # $kwarg.ExportTemplate
    }



    $OriginalPath, $ExportTemplate, $WithoutConditional
    | Write-Debug

    '📚 b.copyWorkBook ==> other ==>  bdg_lib\src_static\employee_infostate.ps1/16cdb9c8-94ce-4fc5-a621-20af75e10412' | Write-Warning


    # b.conditionalFormat.applyDefaultFormatting
    $meta = @{
        WithoutCondition  = $WithoutConditional
        OriginalPath      = ($OriginalPath)?.ToString() ?? '<null>'
        ExportTemplate    = ($ExportTemplate)?.ToString() ?? '<null>'
        OriginalPathForce = Get-Item $OriginalPath -Force | ForEach-Object ToString
    }

    $meta
    | bdgLog -Category Warn -Message 'invoke => b.copyWorkBook' -PassThru
    | Out-String
    | Write-Verbose -Verbose

    $forceOriginalPath = Get-Item $OriginalPath -Force
    $pkg = Open-ExcelPackage -Path $OriginalPath

    if (-not $PKG) {
        $meta
        | bdgLog -Category Warn -Message 'File does not exist: OriginalPath' -PassThru
        | Write-Error

        return
    }

    if (-not $WithoutConditional) {
        # b.conditionalFormat.applyDefaultFormatting $Pkg # did ot
        b.conditionalFormat.notBlankToAll $Pkg # -ea Break  # works
    }
    Close-ExcelPackage $Pkg -ea silentlyContinue
    b.copyExcel -Show @splatIt #-ea 'break'
}

function debug.buildExportCsv {

    # $ErrorActionPreference = 'break'

    # emp KeyId pairs from emails
    $EmpIdPairs_fromEmail = $sample.HardEmails | ForEach-Object { $ess.LookupPayloEmpIdPair( $_ ) }

    $sample.HardEmails
    $sample.HardEmails | ForEach-Object { $ess.LookupPayloEmpIdPair( $_ ) }
    Write-Warning '<last here>'
    hr -fg magenta

    $eis.ExportExcelDebug() && b.copyExcel -Show
}

# . debug.buildExportCsv


function x.enumerateWorksheetNames {
    <#
    .synopsis
        enumerate every worksheet name in this workbook
    #>
    [OutputType('string', 'string[]')]
    [CmdletBinding()]
    param(
        [Alias('Pl')]
        [Parameter(Mandatory)]
        [OfficeOpenXml.ExcelPackage]$ExcelPackage
    )
    @( $ExcelPackage.Workbook.Worksheets.name )
}

function x.enumerateWorksheets {
    <#
    .synopsis
        enumerate worksheet objects
    #>
    # enumerate the actual instances
    [OutputType('[OfficeOpenXml.ExcelWorksheet[]]')]
    [CmdletBinding()]
    param(
        [Alias('Pl')]
        [Parameter(Mandatory)]
        [OfficeOpenXml.ExcelPackage]$ExcelPackage
    )

    @( x.enumerateWorksheetNames $ExcelPackage | ForEach-Object {
            $curSheet = $_
            try {
                # x.selectWorksheet -ea 'Stop' -pl $ExcelPackage -WorkSheetName $curSheet
                x.selectWorksheet -pl $ExcelPackage -WorkSheetName $curSheet
            }
            catch {
                'Exception: x.enumerateWorksheets {0}' -f @(
                    $_
                )
                | Write-Verbose -Verbose
            }
        } )

}


function x.selectWorksheet {
    # select worksheet, if invalid, error
    [OutputType('OfficeOpenXml.ExcelWorksheet')]
    [CmdletBinding()]
    param(
        [Alias('Pl')]
        [Parameter(Mandatory)]
        [OfficeOpenXml.ExcelPackage]$ExcelPackage,

        [string]$WorkSheetName
    )

    # wait-debugger
    $ErrorActionPreference = 'break'
    $ErrorActionPreference = 'continue'
    try {
        $worksheet? = $ExcelPackage.Workbook.Worksheets[$WorkSheetName]
        if ( $ExelPackage.Workbook.Worksheets.Count -eq 0) {
            'ExcelPackage currently has {0} worksheets' -f @( $ExcelPackage.Workbook.Worksheets.Count )
            | Write-Warning
            return
        }
        if ($null -eq $worksheet?) {
            'ExcelPackage currently has {0} worksheets' -f @( $ExcelPackage.Workbook.Worksheets.Count )
            | Write-Warning

            Write-Error "WorkSheetNotFound: Sheet does not exist: '$WorkSheetName'"
            return
        }

        return $worksheet?
    }
    catch {
        $null = 0
    }
    $ErrorActionPreference = 'continue'
}

function b.addSheet {
    <#
    .SYNOPSIS
        latest wrapper to internal '_xcelAddSheet : sugar quick export
    .NOTES

        future:
            - [ ] column name sort order:
                ... | select Emp*, Co*, *name* -ea ignore

            - [ ] row name sort order
                $InputObject | sort { prop }

            - [ ] totals rowcount subtotals
                $InputObject | sort { prop }

        todo: support: see also: params:
    'ClearSheet', 'Append', 'NoLegend', 'Calculate', 'AutoSize', 'Path', 'TitleSize', 'Title', 'TitleBold', 'TitleBackgroundColor', 'TitleFillPatternLightGrid', 'AutoFilter', 'MaxAutoSizeRows', 'NoClobber', 'FreezeTopRow', 'FreezeFirstColumn', 'FreezeTopRowFirstColumn', 'FreezePane', 'MoveAfter', 'PassThru', 'ReZip', 'Numberformat', 'MoveToStart', 'MoveToEnd', 'MoveBefore', 'PivotDataToColumn', 'IncludePivotChart', 'NoHeader', 'RangeName', 'WorksheetName', 'TableName', 'PivotTableName', 'AutoNameRange'
    .EXAMPLE
        Pwsh
        > b.addSheet @splatShare -Options $optConfig -InputObject @(
            $xObj ) -Label 'label' -nTableName 'tab' -nSheetName 'name' -nTitleStr 'title'
    .LINK
        b.addExcelSheet
    .LINK
        b.addSheet
    .link
        _excelAddSheet
    #>
    [CmdletBinding()]
    param(
        [Alias('Data')]
        # [AllowNull()]
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        # [Parameter(Mandatory)]
        [string]$Label = 'missing',

        [Alias('Path')]
        [Parameter()]
        [string]$DestinationPath,

        [Parameter()]
        [hashtable]$Options,

        [Parameter()]
        # $TableStyle = 'Light2',
        $TableStyle = 'Light2',

        [string]$nTableName,
        [string]$nSheetName,
        [string]$nTitleStr,
        # do not truncate data
        [switch]$AppendAll
        # [OfficeOpenXml.Table.TableStyles]$TableStyle = [OfficeOpenXml.Table.TableStyles]::sty


    )
    begin {}
    process {
        $xObj = $InputObject
        $strTable = $nTableName ?? $Label ?? ''
        $titleStr = '{0} {1}' -f @(
            $strTable
            $xObj.count
        )

        $renderSheetName = $nsheetName ?? $Options.SheetName ?? ''
        $Options = @{
            Label         = $renderSheetName
            Title         = $nTitleStr ?? $titleStr
            TableName     = $nTableName ?? "t_${renderSheetName}"
            WorksheetName = $renderSheetName
            # Append = -not $Append
            # TableName = $sheetName
            # WorksheetName = $sheetName
        }
        if ($AppendAll) {
            $Options.Append = $true
        }
        # $mergeSplat = mergeHash $Options


        _excelAddSheet -DestinationPath $DestinationPath -Options $Options -InputObject $xObj -Label $Label
        # _excelAddSheet -DestinationPath $kwarg.NewDest @exSplat -Options $Options -Label $Options.Label -InputObject $xObj
        # _excelAddSheet -InputObject $xobj -De
        # [OfficeOpenXml.ExcelPackage]$pl = Open-ExcelPackage -Path $PathsExcel.export_mergedExcel -ea stop
        # Close-ExcelPackage $pl
        # b.copyExcel -Show -OriginalPath $kwarg.NewDest -exportTemplate $kwarg.ExportTemplate
    }
    end {}
}

# $ErrorActionPreference = 'break'

function b.conditionalFormat.notBlankToAll {
    [Alias('_applyNonBlankToAll')]
    [CmdletBinding()]
    [OutputType('OfficeOpenXml.ExcelPackage')]
    param(
        [Alias('ExcelPackage')]
        [Parameter(Mandatory)][OfficeOpenXml.ExcelPackage]$Package,

        [Parameter()]
        [hashtable]$Options = @{} )
    # orange to every (first) table of every sheet
    x.enumerateWorksheetNames $Package | Join-String -sep ', ' -op 'ConditionalFormattingWorksheets: ' | Write-Debug
    x.enumerateWorksheets $Package | ForEach-Object {
        try {
            [OfficeOpenXml.ExcelWorksheet]$t_sheet = $_
            [OfficeOpenXml.Table.ExcelTable]$t_table = $t_sheet.Tables[0]
            $address = $t_table.Address.Address

            $addConditionalFormattingSplat = @{
                Address         = $address
                WorkSheet       = $t_sheet
                RuleType        = 'ContainsBlanks'
                BackgroundColor = [excelColor]::FromRGB( 0xff, 0xbf, 0x89 ) #'#ffbf89'
            }
            $Package = Add-ConditionalFormatting @addConditionalFormattingSplat #-PassThru
        }
        catch {
            'b.conditionalFormat.notBlankToAll: Caught Error: {0}' -f @(
                $_
            )
            | Write-Error
        }
    }
    return $Package
}

function b.conditionalFormat.boolean {
    [Alias('_applyIsTrueBoolToAll')]
    param(

        [Parameter()][OfficeOpenXml.ExcelPackage]$Package,
        [Parameter()]$OriginalPath,
        [Parameter()][hashtable]$Options = @{} )

    if ($PSBoundParameters.ContainsKey('OriginalPath')) {
        $pkg = Open-ExcelPackage -Path $OriginalPath
    }
    else {
        $pkg = $Package
    }

    x.enumerateWorksheets $Pkg | ForEach-Object {
        [OfficeOpenXml.ExcelWorksheet]$t_sheet = $_
        [OfficeOpenXml.Table.ExcelTable]$t_table = $t_sheet.Tables[0]
        $address = $t_table.Address.Address
        'conditionalFormat: $address = {0}' -f @( $Address)
        | Out-String | Write-Verbose


        $addConditionalFormattingSplat = @{
            Address         = $address
            WorkSheet       = $t_sheet
            BackgroundColor = [excelColor]::FromRGB( 0xf3, 0x92, 0x6c ) #'#f3926c'
            # BackgroundColor = [excelColor]::FromRGB( 0xa7, 0x66, 0x4c ) #'#a7664c'
            # #ffc7c7
            # #f3926c
            RuleType        = 'ContainsText'
            ConditionValue  = 'false'
        }
        Add-ConditionalFormatting @addConditionalFormattingSplat

        $addConditionalFormattingSplat = @{
            Address         = $address
            WorkSheet       = $t_sheet
            # BackgroundColor = [excelColor]::FromRGB( 0x56, 0x77, 0x4a ) #'#a4f3a2'
            # BackgroundColor = [excelColor]::FromRGB( 0x56, 0x77, 0x4a ) #'#56774a'
            BackgroundColor = [excelColor]::FromRGB( 0xb4, 0xce, 0xb3 ) #'#b4ceb3'
            RuleType        = 'ContainsText'
            ConditionValue  = 'true'
        }
        Add-ConditionalFormatting @addConditionalFormattingSplat
    }

    if ($PSBoundParameters.ContainsKey('OriginalPath')) {
        Close-ExcelPackage $Pkg -ea silentlyContinue
    }
}

# orange to every (first) table of every sheet
# x.enumerateWorksheetNames $Package | Join-String -sep ', ' -op 'ConditionalFormattingWorksheets: ' | Write-Debug
# x.enumerateWorksheets $Package | ForEach-Object {
#     [OfficeOpenXml.ExcelWorksheet]$t_sheet = $_
#     [OfficeOpenXml.Table.ExcelTable]$t_table = $t_sheet.Tables[0]
#     $address = $t_table.Address.Address

#     $addConditionalFormattingSplat = @{
#         Address         = $address
#         WorkSheet       = $t_sheet
#         RuleType        = 'ContainsBlanks'
#         BackgroundColor = [excelColor]::FromRGB( 0xff, 0xbf, 0x89 ) #'#ffbf89'
#     }
#     Add-ConditionalFormatting @addConditionalFormattingSplat
# }
# }

function xl.conditionalFormat.notBlank {
    <#
    .NOTES
        warning:
            worksheets are [0..., count]
                tables are [1..., count-1 ]
    #>
    [CmdletBinding()]
    param(
        $Path
    )
    # $ErrorActionPreference = 'break'
    $ErrorActionPreference = 'continue'
    $Source = Get-Item -ea stop $Path

    $Pkg = Open-ExcelPackage -Path $Source

    # $i_max = $pkg.Workbook.Worksheets.Count
    # foreach ($i in @(1..$i_max)) {
    #     $w_sheet = $Pkg.Workbook.Worksheets[$i]
    foreach ($cur_sheet in $pkg.Workbook.Worksheets) {
        <#
        # $t_max = $w_sheet.Tables.count - 1
        # bug when t <= 0
            $t_max = $w_sheet.Tables.count - 1
            foreach ($j_table in @(0..$t_max)) {
        #>
        # $t_max = $w_sheet.Tables.count - 1
        # foreach ($j_table in @(0..$t_max)) {
        foreach ($cur_table in $cur_sheet.Tables) {
            # foreach ($cur_table in $Pkg.Workbook.Worksheets[ $i ].Tables) {
            #>
            try {
                $addConditionalFormattingSplat = @{
                    # Address         = $Pkg.Workbook.Worksheets[ $i ].Tables[ $j_table ].Address.Address
                    Worksheet       = $cur_sheet
                    Address         = $cur_table.Address.Address
                    RuleType        = 'ContainsBlanks'
                    BackgroundColor = [excelColor]::FromRGB( 0xff, 0xbf, 0x89 ) #'#ffbf89'
                }
                Add-ConditionalFormatting @addConditionalFormattingSplat -Verbose

            }
            catch {
                # wait-debugger
                # @{
                #     # Package = $Pkg
                #     workSheet   = $cur_sheet | to->Json -depth 1
                #     tableMax    = $cur_table | to->Json -depth 1
                # } | from->Json
                bdgLog -Category Warn -Message 'xl.conditionalFormat.notBlank: Exception' -PassThru
                | Write-Error

                Write-Error 'maybe not $_' #$_
            }
        }
    }
    $ErrorActionPreference = 'continue'
    $closeExcelPackageSplat = @{
        # SaveAs = 'g:\temp\xl\out8.xlsx'
        # Show = $true
        ExcelPackage = $Pkg
    }
    Close-ExcelPackage @closeExcelPackageSplat
    $ErrorActionPreference = 'continue'
}
function xl.conditionalFormat.Gen2.notBlankToAll {
    <#
    .NOTES
        warning:
            worksheets are [0..., count]
                tables are [1..., count-1 ]
    #>
    [OutputType('OfficeOpenXml.ExcelPackage')]
    [CmdletBinding()]
    param(
        [Alias('Pkg')]
        [OfficeOpenXml.ExcelPackage]$ExcelPackage
    )

    # $i_max = $ExcelPackage.Workbook.Worksheets.Count
    # foreach ($i in @(1..$i_max)) {
    #     $w_sheet = $ExcelPackage.Workbook.Worksheets[$i]
    foreach ($cur_sheet in $ExcelPackage.Workbook.Worksheets) {
        <#
        # $t_max = $w_sheet.Tables.count - 1
        # bug when t <= 0
            $t_max = $w_sheet.Tables.count - 1
            foreach ($j_table in @(0..$t_max)) {
        #>
        # $t_max = $w_sheet.Tables.count - 1
        # foreach ($j_table in @(0..$t_max)) {
        foreach ($cur_table in $cur_sheet.Tables) {
            # foreach ($cur_table in $ExcelPackage.Workbook.Worksheets[ $i ].Tables) {
            #>
            try {
                $addConditionalFormattingSplat = @{
                    # Address         = $ExcelPackage.Workbook.Worksheets[ $i ].Tables[ $j_table ].Address.Address
                    Worksheet       = $cur_sheet
                    Address         = $cur_table.Address.Address
                    RuleType        = 'ContainsBlanks'
                    BackgroundColor = [excelColor]::FromRGB( 0xff, 0xbf, 0x89 ) #'#ffbf89'
                }
                Add-ConditionalFormatting @addConditionalFormattingSplat -Verbose

            }
            catch {
                # wait-debugger
                # @{
                #     # Package = $ExcelPackage
                #     workSheet   = $cur_sheet | to->Json -depth 1
                #     tableMax    = $cur_table | to->Json -depth 1
                # } | from->Json
                bdgLog -Category Warn -Message "xl.conditionalFormat.Gen2.notBlankToAll: Exception: $_" -PassThru
                | Write-Error

                'maybe {0}' -f @(
                    $_
                 )
                |write-error
            }
        }
    }
    return $ExcelPackage
}



function b.conditionalFormat.applyDefaultFormatting {
    <#
        See more, custom default /w pipeline
            https://github.com/dfinke/ImportExcel/blob/master/Examples/CustomizeExportExcel/Out-Excel.ps1
    .LINK
        https://github.com/dfinke/ImportExcel/blob/master/Examples/CustomizeExportExcel/Out-Excel.ps1
    #>
    [Alias('_excelApplyConditionalFormatting')]
    param(
        [ValidateNotNull()]
        [OfficeOpenXml.ExcelPackage]$Package,
        [hashtable]$Options = @{} )
    $Config = mergeHash -OtherHash $Options -BaseHash @{
        Color = @{
            # Blanks = [excelColor]::FromRGB( 0xff, 0xbf, 0x89 )
            Blanks = [Drawing.Color]::FromArgb(255, 255, 191, 137) # actual: rgb(255,191,137)
        }
    }
    # $ErrorActionPreference = 'break'


    . b.conditionalFormat.notBlankToAll -Package $Package
    Write-Warning 'may not exactly be passing package along?'

    # tier2: nyi: how do I convert column to address?
    # $t_sheet = $pl.Workbook.Worksheets['IndexCache']
    # $t_table = $t_sheet.Tables['IndexCache']
    # $addConditionalFormattingSplat = @{
    #     Address         = $t_sheet.Tables['IndexCache'].Columns['terminationDate'] #$t_table.Address.Address # note, .Address 1 time will not work
    #     WorkSheet       = $t_sheet
    #     RuleType        = 'NotContainsBlanks'
    #     BackgroundColor = [excelColor]::FromRGB( 0xff, 0x5f, 0x89 ) #'#ff5f89'
    # }
    # Add-ConditionalFormatting @addConditionalFormattingSplat
}
function d1.NewFinalJumpObj {
    <#
    .synopsis
        replaced c5.FinalJuimpObj
    .NOTES
        - [ordered] hashtables lack the  .ContainsKey() method
        - doesn't enforce sensitivty
        - allow schema, assign strict hashtable values?
            or just depth 1
            maybe New-Module inline would allow dynamically
            creating a strongly typed class, but dynamically
    .EXAMPLE
        $fin_JCUpdate = $j0 = c5.NewFinalJumpObj $refr.JCUpdateCsv -TransformFrom JCUpdateCsv -ExcludeProperty $toIgnorePropList
        $fin_JCUser =  $j1 = c5.NewFinalJumpObj $refr.JCUserRecord -TransformFrom JCUserRecord -ExcludeProperty $toIgnorePropList

        $fin_JCUpdate_noNew = $j0_noNew = c5.NewFinalJumpObj -DoNotCreateNewKeys $refr.JCUpdateCsv -TransformFrom JCUpdateCsv -ExcludeProperty $toIgnorePropList
        $fin_JCUser_noNew =  $j1_noNew = c5.NewFinalJumpObj -DoNotCreateNewKeys $refr.JCUserRecord -TransformFrom JCUserRecord -ExcludeProperty $toIgnorePropList
        # c5.NewFinalJumpObj $refr.JCUserRecord -TransformFrom JCUpdateCsv -ExcludeProperty $toIgnorePropList
        $diff = basicDiff $fin_JCUpdate $fin_JCUser
        $diff_noNew = basicDiff $fin_JCUpdate_noNew $fin_JCUser
    #>
    # [Alias('d1.NewFinalJumpObj.1')]
    param(
        # [ValidateSet('Default')]
        [Parameter(Mandatory)][object]$InputObject,

        [ValidateSet(
            'TransformedLeftShape',
            'JumpCloudShape')]
        [Parameter(Mandatory)][string]$TransformShape,

        # any keys to enforce values on
        # [Alias('PropertyName')]
        # [Parameter()]
        # [string[]]$AllwaysIncludeProperty,

        # [switch]$DoNotCreateNewKeys,

        # [string[]]$ExcludeProperty,
        [switch]$NoSort
    )

    $allPossibleJCUserParams = @(
        'account_locked'
        'allow_public_key'
        'alternateEmail'
        'ByID'
        'company'
        'costCenter'
        'Debug'
        'department'
        'description'
        'displayname'
        'email'
        'employeeIdentifier'
        'employeeType'
        'enable_managed_uid'
        'enable_user_portal_multifactor'
        'ErrorAction'
        'ErrorVariable'
        'external_dn'
        'external_source_type'
        'externally_managed'
        'firstname'
        'home_country'
        'home_locality'
        'home_number'
        'home_poBox'
        'home_postalCode'
        'home_region'
        'home_streetAddress'
        'InformationAction'
        'InformationVariable'
        'jobTitle'
        'lastname'
        'ldap_binding_user'
        'location'
        'managedAppleId'
        'manager'
        'middlename'
        'mobile_number'
        'NumberOfCustomAttributes'
        'OutBuffer'
        'OutVariable'
        'password'
        'password_never_expires'
        'passwordless_sudo'
        'PipelineVariable'
        'recoveryEmail'
        'RemoveAttribute'
        'state'
        'sudo'
        'suspended'
        'unix_guid'
        'unix_uid'
        'UserID'
        'Username'
        'Verbose'
        'WarningAction'
        'WarningVariable'
        'work_country'
        'work_fax_number'
        'work_locality'
        'work_mobile_number'
        'work_number'
        'work_poBox'
        'work_postalCode'
        'work_region'
        'work_streetAddress'
    )
    $selectedJCUserParams = @(
        # 'account_locked'
        # 'allow_public_key'
        'alternateEmail'
        'company'
        'costCenter'
        'department'
        'description'
        'displayname'
        # 'email'
        'employeeIdentifier'
        'employeeType'
        # 'enable_managed_uid'
        # 'enable_user_portal_multifactor'
        # 'external_dn'
        # 'external_source_type'
        # 'externally_managed'
        'firstname'
        'home_country'
        # 'home_locality'
        'home_number'
        'home_poBox'
        'home_postalCode'
        'home_region'
        'home_streetAddress'
        'jobTitle'
        'lastname'
        # 'ldap_binding_user'
        'location'
        # 'managedAppleId'
        'manager'
        'middlename'
        'mobile_number'
        # 'NumberOfCustomAttributes'
        # 'password'
        # 'password_never_expires'
        # 'passwordless_sudo'
        # 'recoveryEmail'
        # 'RemoveAttribute'
        'state'
        # 'sudo'
        # 'suspended'
        # 'unix_guid'
        # 'unix_uid'
        # 'UserID'
        'username'
        'work_country'
        'work_fax_number'
        'work_locality'
        'work_mobile_number'
        'work_number'
        'work_poBox'
        'work_postalCode'
        'work_region'
        'work_streetAddress'
    )
    # $obj = [ordered]@{}
    $obj = @{}

    #     $obj[ $Key ] = [string]::Empty
    # }

    foreach ($Key in $selectedJCUserParams) {
        $Obj[ $Key ] = ''
    }
    # wait-debugger
    switch ($TransformShape) {
        'TransformedLeftShape' {
            $obj.PSTypeName = 'd1.NewFinalJumpObj.TransformedLeftShape'
            foreach ($Key in $selectedJCUserParams) {
                $Obj[ $Key ] = $InputObject.$Key ?? ''
            }
            $null = 0
        }
        'JumpCloudShape' {
            $obj.PSTypeName = 'd1.NewFinalJumpObj.JumpCloudShape'
            foreach ($Key in $selectedJCUserParams) {
                $Obj[ $Key ] = $InputObject.$Key ?? ''
            }
            $null = 0
        }
        default { "UnhandledTransformShape: $switch" }
    }

    $obj.work_mobile_number = ($inputObject)?.work_mobilePhone




    $sortedObj = [ordered]@{}
    $obj.GetEnumerator() | Sort-Object Key | ForEach-Object {
        $sortedObj[ $_.Key ] = $_.Value
    }
    if ( $noSort ) {
        return [pscustomobject]$obj
    }
    return [pscustomobject]$sortedObj

    # Remove-Item 'g:\temp\xl\log.xlsx' -ea ignore

    # $other = $InputObject
    # $obj.alternateEmail = ''
    # # $obj.ChangeReason = ''
    # $obj.Company =
    # $obj.displayName = ''
    # $obj.companyId = ''
    # $obj.companyName = ''
    # $obj.costCenter1 = ''
    # $obj.costCenter2 = ''
    # $obj.costCenter3 = ''
    # $obj.effectiveDate = ''
    # $obj.employeeId = ''
    # $obj.employeeStatus = ''
    # $obj.employeeType = ''
    # $obj.firstName = ''
    # $obj.hireDate = ''
    # $obj.home_city = ''
    # $obj.home_country = ''
    # $obj.home_email = ''
    # $obj.home_mobilePhone = ''
    # $obj.home_postalCode = ''
    # $obj.home_state = ''
    # $obj.home_streetAddress = ''
    # $obj.jobTitle = ''
    # $obj.lastName = ''
    # $obj.Location = ''

    # $obj.manager = ''
    # $obj.managerCo = ''
    # $obj.managerId = ''
    # $obj.mobile_number = ''
    # $obj.preferredName = ''
    # $obj.terminationDate = ''
    # $obj.userName = ''
    # $obj.work_city = ''
    # $obj.work_country = ''
    # $obj.work_location = ''
    # $obj.work_mobilePhone = ''
    # $obj.work_postalCode = ''
    # $obj.work_state = ''
    # $obj.work_streetAddress = ''
    # $obj.Email = ''

    # $obj.Keys.clone() | ForEach-Object {
    #     if ( @($ExcludeProperty) -contains $_ ) {
    #         $ExcludeProperty | Join-String -sep ', ' -DoubleQuote
    #         | bdgLog -Category Verbose -Message 'c5.NewFinalJumpObj -ExcludeProps = '
    #         | Write-Warning 'removing props: '
    #     }
    # }

    throw 'ShouldNeverReach'
    # $otherHash = $InputObject # otherhash is better aliased as 'targetObject'
    # $otherHash = #$refr.JCUpdateCsv | from->Json -AsHashtable
    # $ErrorActionPreference = 'break' #






}


function c5.NewFinalJumpObj {
    <#
    .synopsis
    .NOTES
        - [ordered] hashtables lack the  .ContainsKey() method
        - doesn't enforce sensitivty
        - allow schema, assign strict hashtable values?
            or just depth 1
            maybe New-Module inline would allow dynamically
            creating a strongly typed class, but dynamically
    .EXAMPLE
        $fin_JCUpdate = $j0 = c5.NewFinalJumpObj $refr.JCUpdateCsv -TransformFrom JCUpdateCsv -ExcludeProperty $toIgnorePropList
        $fin_JCUser =  $j1 = c5.NewFinalJumpObj $refr.JCUserRecord -TransformFrom JCUserRecord -ExcludeProperty $toIgnorePropList

        $fin_JCUpdate_noNew = $j0_noNew = c5.NewFinalJumpObj -DoNotCreateNewKeys $refr.JCUpdateCsv -TransformFrom JCUpdateCsv -ExcludeProperty $toIgnorePropList
        $fin_JCUser_noNew =  $j1_noNew = c5.NewFinalJumpObj -DoNotCreateNewKeys $refr.JCUserRecord -TransformFrom JCUserRecord -ExcludeProperty $toIgnorePropList
        # c5.NewFinalJumpObj $refr.JCUserRecord -TransformFrom JCUpdateCsv -ExcludeProperty $toIgnorePropList
        $diff = basicDiff $fin_JCUpdate $fin_JCUser
        $diff_noNew = basicDiff $fin_JCUpdate_noNew $fin_JCUser
    #>
    [Alias('c5.NewFinalJumpObj.2')]
    param(
        # [ValidateSet('Default')]
        [Parameter(Mandatory)][object]$InputObject,

        [ValidateSet( 'DeltaPropsExpectedShape', 'JCUpdateCsv', 'JCUserRecord', 'FTPUnstagedRecord')]
        [Parameter(Mandatory)][string]$TransformFrom,

        # any keys to enforce values on
        [Alias('PropertyName')]
        [Parameter()]
        [string[]]$AllwaysIncludeProperty,

        [switch]$DoNotCreateNewKeys,

        [string[]]$ExcludeProperty,
        [switch]$NoSort
    )
    # $obj = [ordered]@{}
    $obj = @{}
    foreach ($Key in $IncludeProperty) {
        $obj[ $Key ] = [string]::Empty
    }

    Remove-Item 'g:\temp\xl\log.xlsx' -ea ignore

    $other = $InputObject
    $obj.alternateEmail = ''
    # $obj.ChangeReason = ''
    $obj.Company =
    $obj.displayName = ''
    $obj.companyId = ''
    $obj.companyName = ''
    $obj.costCenter1 = ''
    $obj.costCenter2 = ''
    $obj.costCenter3 = ''
    $obj.effectiveDate = ''
    $obj.employeeId = ''
    $obj.employeeStatus = ''
    $obj.employeeType = ''
    $obj.firstName = ''
    $obj.hireDate = ''
    $obj.home_city = ''
    $obj.home_country = ''
    $obj.home_email = ''
    $obj.home_mobilePhone = ''
    $obj.home_postalCode = ''
    $obj.home_state = ''
    $obj.home_streetAddress = ''
    $obj.jobTitle = ''
    $obj.lastName = ''
    $obj.Location = ''

    $obj.manager = ''
    $obj.managerCo = ''
    $obj.managerId = ''
    $obj.mobile_number = ''
    $obj.preferredName = ''
    $obj.terminationDate = ''
    $obj.userName = ''
    $obj.work_city = ''
    $obj.work_country = ''
    $obj.work_location = ''
    $obj.work_mobilePhone = ''
    $obj.work_postalCode = ''
    $obj.work_state = ''
    $obj.work_streetAddress = ''
    $obj.Email = ''

    $obj.Keys.clone() | ForEach-Object {
        if ( @($ExcludeProperty) -contains $_ ) {
            $ExcludeProperty | Join-String -sep ', ' -DoubleQuote
            | bdgLog -Category Verbose -Message 'c5.NewFinalJumpObj -ExcludeProps = '
            | Write-Warning 'removing props: '
        }
    }
    $otherHash = $InputObject # otherhash is better aliased as 'targetObject'
    # $otherHash = #$refr.JCUpdateCsv | from->Json -AsHashtable
    # $ErrorActionPreference = 'break' #

    switch ($TransformFrom) {
        'JCUpdateCsv' {
            if ($otherHash -isnot 'hashtable') {
                $OtherHash = $otherHash | to->Json -Depth 8 | from->Json -AsHashtable
            }

            $otherHash.Keys.Clone() | ForEach-Object {
                $key = $_
                $isNewKey = -not $Obj.ContainsKey( $key )

                if ( -not $IsNewKey ) {
                    $obj[ $key ] = $otherHash[ $key ]
                    return
                }

                Write-Debug "New Key not in base: $Key"
                if ( -not $DoNotCreateNewKeys ) {
                    Write-Debug '--> creating new key'
                    $obj[ $key ] = $otherHash[ $key ]
                    return

                }
            }
        }
        'DeltaPropsExpectedShape' {
            $selectedJCUserParams = @(
                'account_locked'
                'allow_public_key'
                'alternateEmail'
                'ByID'
                'company'
                'costCenter'
                'Debug'
                'department'
                'description'
                'displayname'
                'email'
                'employeeIdentifier'
                'employeeType'
                'enable_managed_uid'
                'enable_user_portal_multifactor'
                'ErrorAction'
                'ErrorVariable'
                'external_dn'
                'external_source_type'
                'externally_managed'
                'firstname'
                'home_country'
                'home_locality'
                'home_number'
                'home_poBox'
                'home_postalCode'
                'home_region'
                'home_streetAddress'
                'InformationAction'
                'InformationVariable'
                'jobTitle'
                'lastname'
                'ldap_binding_user'
                'location'
                'managedAppleId'
                'manager'
                'middlename'
                'mobile_number'
                'NumberOfCustomAttributes'
                'OutBuffer'
                'OutVariable'
                'password'
                'password_never_expires'
                'passwordless_sudo'
                'PipelineVariable'
                'recoveryEmail'
                'RemoveAttribute'
                'state'
                'sudo'
                'suspended'
                'unix_guid'
                'unix_uid'
                'UserID'
                'Username'
                'Verbose'
                'WarningAction'
                'WarningVariable'
                'work_country'
                'work_fax_number'
                'work_locality'
                'work_mobile_number'
                'work_number'
                'work_poBox'
                'work_postalCode'
                'work_region'
                'work_streetAddress'
            )

            if ($otherHash -isnot 'hashtable') {
                $OtherHash = $otherHash | to->Json -Depth 8 | from->Json -AsHashtable
            }
            $otherHash.Keys.Clone() | ForEach-Object {
                $key = $_
                $isNewKey = -not $Obj.ContainsKey( $key )

                @{
                    Key               = $key
                    isNewKey          = $isNewKey
                    DoNotCreateNewKey = $DoNotCreateNewKeys
                    otherKeys         = $otherHash.Keys.clone() | Join-String -sep ', '
                }
                | Write-Debug

                if ( -not $IsNewKey ) {
                    $obj[ $key ] = $otherHash[ $key ]
                    return
                }

                "New Key not in base: $Key"
                | Write-Debug

                if ( -not $DoNotCreateNewKeys ) {
                    '--> creating new key'
                    | Write-Debug

                    $obj[ $key ] = $otherHash[ $key ]
                    return

                }
            }
        }
        'JCUserRecord' {
            if ($otherHash -isnot 'hashtable') {
                $OtherHash = $otherHash | to->Json -Depth 8 | from->Json -AsHashtable
            }
            $otherHash.Keys.Clone() | ForEach-Object {
                $key = $_
                $isNewKey = -not $Obj.ContainsKey( $key )

                if ( -not $IsNewKey ) {
                    $obj[ $key ] = $otherHash[ $key ]
                    return
                }

                Write-Debug "New Key not in base: $Key"
                if ( -not $DoNotCreateNewKeys ) {
                    Write-Debug '--> creating new key'
                    $obj[ $key ] = $otherHash[ $key ]
                    return

                }
            }
        }
        'FTPUnstagedRecord' {
            <#
            previous ones are duplicate: JCUpdateCsv, JCUserRecord
            then this extends some extra behavior

            #>
            if ($otherHash -isnot 'hashtable') {
                $OtherHash = $otherHash | to->Json -Depth 8 | from->Json -AsHashtable
            }
            # ftp currently missing: 'alternateEmail', 'Company', 'companyId', 'companyName', 'costCenter1', 'costCenter2', 'costCenter3', 'effectiveDate', 'Email', 'employeeId', 'employeeStatus', 'employeeType', 'firstName', 'hireDate', 'home_city', 'home_country', 'home_email', 'home_mobilePhone', 'home_postalCode', 'home_state', 'home_streetAddress', 'jobTitle', 'lastName', 'Location', 'manager', 'managerCo', 'managerId', 'mobile_number', 'preferredName', 'terminationDate', 'userName', 'work_city', 'work_country', 'work_location', 'work_mobilePhone', 'work_postalCode', 'work_state', 'work_streetAddress'

            $otherHash.Keys.Clone() | ForEach-Object {
                $key = $_
                $isNewKey = -not $Obj.ContainsKey( $key )

                if ( -not $IsNewKey ) {
                    $obj[ $key ] = $otherHash[ $key ]
                    return
                }

                Write-Debug "New Key not in base: $Key"
                if ( -not $DoNotCreateNewKeys ) {
                    Write-Debug '--> creating new key'
                    $obj[ $key ] = $otherHash[ $key ]
                    return

                }
            }

            # custom json column mappings
            # change: business logic: use first name when not preferred
            # no longer fatal
            if ( [string]::IsNullOrWhiteSpace( $obj.preferredName )) {
                $ErrMsg = '📚 c5.NewFinalJumpObj: TransformFail ==> User Missing Required [PreferredName] field  ==>  tests-invoke\LocalInvoke\from_aws-end\manual-create-new-user.ps1/a24b543f-7534-41ad-b985-162d32af1619'
                # $ErrMsg | Write-Error -ea
                $errMsg | Write-Warning
                # throw $ErrMsg
                # return
            }
            $obj.department = '{0}-{1}' -f @(
                $otherHash.'EMPLOYMENT'  # number first
                $otherHash.'EMPLOYMENT Name'
            )

            $obj.companyId = $otherHash.'Company Code'
            $obj.employeeId = $otherHash.'Employee Id'
            $obj.firstName = $otherHash.'First Name'
            $obj.lastName = $otherHash.'Last Name'
            $obj.preferredName = $otherHash.'Preferred Name'
            '📚 todo: rfi?: which of 3 email addresses? manual-create-new-user.ps1/717427ee-8f95-446f-9d9e-cf2f053807cc' | Write-Warning
            # $obj.Email = '<??> set later'
            $obj.home_email = $OtherHash.'Personal Email Address'
            $obj.alternateEmail = '' #/ $otherHash.
            $obj.hireDate = $otherHash.'Hire Date' # is number?
            $obj.displayName = '{0} {1}' -f @(
                $Obj.firstName
                $Obj.lastName
            )

            $obj.employeeType = $otherHash.'Employee Type'
            # $obj.employeeStatus
            try {
                $obj | to->Csv | from->Csv
                | Export-Excel -Append -work 'Obj' -table 'table_obj' -Path 'g:\temp\xl\potential.xlsx'
            }
            catch {
                Write-Verbose "SomeException: $_"
            }

            #             'still not using
            #             {0}' -f @(
            #                 @'
            # EMPLOYMENT Name        : SALES
            # EMPLOYMENT             : 300
            # Address 1              : 300 Harrison Avenue
            # Address 2              : 1-812
            # City                   : Boston
            # State                  : MA
            # ZIP Code               : 02118
            # '@
            #             ) | Write-Warning



            @( $obj | to->Json | from->Json )
            | Export-Excel -Append -work 'obj' -table work_1 -AutoSize 'g:\temp\xl\log.xlsx'

            @( $otherHash | to->Json | from->Json )
            | Export-Excel -Append -work 'otherHash' -table work_2 -AutoSize 'g:\temp\xl\log.xlsx'

            $obj.Remove( 'Company Code' )
            $obj.Remove( 'Employee Id' )
            $obj.Remove( 'First Name' )
            $obj.Remove( 'Last Name' )
            $obj.Remove( 'Preferred Name' )
            $obj.Remove( 'Employee Type' )
            $obj.Remove( 'Personal Email Address' )
            $obj.Remove( 'Hire Date' )
            $obj.Remove( 'EMPLOYMENT Name' )
            $obj.Remove( 'EMPLOYMENT' )
            $obj.Remove( 'Address 1' )
            $obj.Remove( 'Address 2' )
            $obj.Remove( 'Zip Code' )
            $null = 0


            try {
                $obj | ConvertFrom-Csv | ConvertTo-Csv -ea ignore
                | Export-Excel -ea ignore -Append -work 'Obj_after' -table 'table_obj' -Path 'g:\temp\xl\potential.xlsx'
            }
            catch {
                Write-Verbose 'skip local log'
            }

        }
        default {
            throw "UnhandledEnum: -TransformFrom: '$TransformFrom';  ==> tests-invoke\LocalInvoke\manual-create-new-user.ps1/83878f0b-7587-4b09-9eba-0601b4ed6f72 "
        }

    }
    foreach ($k in $ExcludeProperty) {
        $obj.Remove( $k )
    }
    $ErrorActionPreference = 'continue'
    $sortedObj = [ordered]@{}
    $obj.GetEnumerator() | Sort-Object Key | ForEach-Object {
        $sortedObj[ $_.Key ] = $_.Value
    }
    if ( $noSort ) {
        return [pscustomobject]$obj
    }

    return [pscustomobject]$sortedObj

}


class InfoStateStats {
    [int]$Request_RawTotalCount = 0
    [int]$Request_CacheHit = 0
    [int]$Request_CacheMiss = 0
    [bool]$Performance_DisableSerialization = $true
    [Diagnostics.Stopwatch]$totalRequestTime = [Diagnostics.Stopwatch]::new()

    InfoStateStats () {
        $This.Reset()
    }

    [void] Reset() {
        $This.Request_CacheHit = 0
        $This.Request_CacheMiss = 0
        $this.Request_RawTotalCount = 0
        $this.totalRequestTime.Stop()
        $this.totalRequestTime.Reset()
    }

    [string] ToString() {
        if ($this.Performance_DisableSerialization) {
            return '[InfoStateStats]'
        }
        $durationStr = '{0:n1} secs' -f @($this.totalRequestTime.Elapsed.TotalSeconds ?? 0)

        $meta = @{
            Request_RawTotalCount = $this.Request_RawTotalCount
            Request_CacheHit      = $this.Request_CacheHit
            Request_CacheMiss     = $this.Request_CacheMiss
            totalRequestTime      = $durationStr
        }
        return $Meta | Format-Table | Out-String | Join-String -op 'InfoState: '
    }

}


# [object[]]$script:__PayloResponseCache = @()
class EmployeeInfoState {
    # after API response
    # [Collections.Generic.List[PayloExportRecord]]$PayloExports = [Collections.Generic.List[PayloExportRecord]]::new()
    # [Collections.Generic.List[PayloExportRecord]]$PayloExports = @()
    # [Collections.Generic.List[PayloExportRecord]]$PayloFull = @()
    [Collections.Generic.List[Object]]$PayloExports = @()
    [Collections.Generic.List[Object]]$PayloExports_AfterTransform = @()
    [Collections.Generic.List[Object]]$PayloFull = @()

    # after step2:  to->csv
    # [Collections.Generic.List[JCUserUpdate_CsvRecord]]$JCUpdateCsv = [Collections.Generic.List[JCUserUpdate_CsvRecord]]::new()
    [Collections.Generic.List[object]]$JCUpdateCsv = [Collections.Generic.List[Object]]::new()
    [bool]$Using_CachedEmployeeIdIndex = $true

    # [Collections.Generic.List[EmployeeNumbersRecord]]$EmployeeNumbers = [Collections.Generic.List[EmployeeNumbersRecord]]::new()
    [Collections.Generic.List[object]]$EmployeeNumbers = [Collections.Generic.List[Object]]::new()

    # [Collections.Generic.List[object]]$KnownFulltime_EmployeeNumbers = @()
    [hashtable]$KnownFulltime_Employee = @{}

    [Collections.Generic.List[object]]$FailedLookups = [Collections.Generic.List[Object]]::new()

    # remove me
    [Collections.Generic.Dictionary[[string], [string]]]$KnownBadEmpId = [Collections.Generic.Dictionary[[string], [string]]]::new()
    [Collections.Generic.List[object]]$FailedRequestSummary = [Collections.Generic.List[Object]]::new()

    [int]$MaxRequests = 99999 #15 #9999 # 100
    [int]$Debug_LimitMaxIterations = 20 # 0
    # [int]$MaxRequests = 30 # 100
    [int]$CurrentRequestCount = 0
    [int]$SleepStepSizeMs = 1 # 40
    # [bool]$EnableMaxRequestCount = $false
    [infoStateStats]$stats = [InfoStateStats]::new()


    [JCUserUpdate_CsvRecord] New_JCUpdateRecord ( [object]$Object ) {
        #, [string]$TransformType ) {
        # switch($TransformType) { }

        <#
        to construct:
            1] $eis.FetchPaylo_Employee( 13294, 11548 )
            2] access $eis.JCUpdate
        #>

        # $restResp = PayloRest-GetEmployee -companyId 13294 -employeeId 11548

        $record = [JCUserUpdate_CsvRecord]::new( $Object )

        return $record
    }



    [bool] Test_IsBadEmployeeId ($CoId, $employeeId) {
        'deprecated: Test_IsBadEmployeeId .==>  bdg_lib\src_static\employee_infostate.ps1/01af6379-81bf-4b8a-822f-0678f65dd193"'
        | Write-Warning
        $key = $CoId, $EmployeeId
        return $this.KnownBadEmpId.ContainsKey($key)
    }

    <#
        [1] REST fetch employee info
        [2] => map response to [PayloExportRecord]
        [3] => map that to a [JCUserUpdate_CsvRecord]

        append errors to: $this.FailedLookups
    #>
    [void] FetchPaylo_Employee ($CoId, $employeeId) {
        if ( [string]::IsNullOrWhiteSpace($CoId)) {
            $this.FailedRequestSummary.Add(@{
                    kind     = 'NullRequiredValue'
                    Messaage = 'FetchPaylo_Employee() CoId was blank'
                    json     = @{ CoId = $CoId; EmpId = $employeeId } | ConvertTo-Json -Compress -ea 'ignore'                # json = $errData
                })
            # throw 'FetchPaylo_Employee: Blank $Co parameter'
        }
        if ( [string]::IsNullOrWhiteSpace($employeeId)) {
            $this.FailedRequestSummary.Add(@{
                    kind     = 'NullRequiredValue'
                    Messaage = 'FetchPaylo_Employee() EmpId was blank'
                    json     = @{ CoId = $CoId; EmpId = $employeeId } | ConvertTo-Json -Compress -ea 'ignore'               # json = $errData
                })
            # throw 'FetchPaylo_Employee: Blank $employeeId parameter'
        }
        # __writeDot Processing

        $this.stats.Request_RawTotalCount++
        $step0 = $this._getEmployee($CoId, $employeeId) | Select-Object -First 1
        if (-not $step0) {
            $this.stats.Request_CacheMiss++
            __writeDot CacheMiss
            $this.FailedRequestSummary.add(( @{
                        kind  = 'cacheMiss'
                        msg   = 'failed step0 $_.getEmployee'
                        coId  = $CoId
                        empId = $employeeId

                    } ))

            $null = $this.stats.totalRequestTime.Start()
            $response = PayloRest-GetEmployee -companyId $CoId -employeeId $employeeId
            __writeDot ActualRequest
            $null = $this.stats.totalRequestTime.Stop()

            if ($response.HasError) {
                # $null = $this.KnownBadEmpId.TryAdd( $k, $True )
                $errInfo = @{
                    Kind    = 'ApiError'
                    Command = 'Failed: $step0 = $this._getEmployee($CoId, $employeeId)'
                    # ExceptionType = $_.Exception.GetType().ToString()
                    json    = @{
                        Source_Co         = formatBlankText $CoId
                        Source_EmployeeId = formatBlankText $EmployeeId
                    } | ConvertTo-Json -Compress
                }
                $ErrInfo
                | bdgLog -Category WebRequest -m '$step0 failed'
                $this.FailedRequestSummary.Add( $errInfo )


            }
            $step0 = [PayloExportRecord]::new( $Response )
            if (-not $step0 -or -not $step0.employeeId ) {
                $errMsg = 'failed step0 record: ResponseError?  {0}{1}' -f @(
                    '?'
                    $response.HasError ?? '?'
                    "`n    bdg_lib\src_static\employee_infostate.ps1/eb3d1828-1956-4c0a-b1bd-ccc9ba04b134"
                )
                $errMsg | Write-Warning
                $errMsg | Write-Error

            }
            # $responseCache.Add( $Response )
        }
        else {
            Write-Host -non $this.payloExports.count
            $global:EmployeeSummaryIndex.SetIndex( $step0 )
            $this.stats.Request_CacheHit++
            __writeDot CacheHit
        }

        __writeDot Processing

        $this.stats.Request_RawTotalCount++
        $manager = $this._getEmployee($step0.managerCo, $step0.managerId)

        $this.FailedRequestSummary.Add( @{
                kind          = 'missingManager'
                source        = 'EmployeeInfoState.FetchPaylo_Employee'
                command       = $PSCommandPath
                EmpId         = $step0.employeeId
                CoId          = $step0.companyId
                coName        = $step0.companyName
                manager_EmpId = $step0.managerId
                manager_CoId  = $step0.managerCo
            })

        if ($Manager) {
            $global:EmployeeSummaryIndex.SetIndex( $manager )
        }
        if ( -not $manager) {
            $this.stats.Request_CacheMiss++
            $this.CurrentRequestCount++
            __writeDot CacheMiss
            __writeDot Warn
            $this.FailedRequestSummary.add(( @{
                        kind    = 'cacheMiss'
                        source  = 'EmployeeInfoState.FetchPaylo_Employee'
                        command = $PSCommandPath
                        Message = @(
                            'failed step1 $_.getEmployee'
                            if (-not $step0.employeeId) {
                                'because Step0.EmployeeId failed'
                            }
                        ) -join ' '
                        Json    = @{
                            coId  = $CoId
                            empId = $employeeId
                        } | ConvertTo-Json -Compress

                    } ))
            # $this.stats.Request_CacheMiss

            try {
                $this.stats.totalRequestTime.Start()
                $manager = PayloRest-GetEmployee -employeeId $step0.managerId -companyId $step0.managerCo
                __writeDot ActualRequest
                $this.stats.totalRequestTime.Stop()
            }
            catch {
                __writeDot Warn
                Write-Verbose "manager of employee failed: [co = $CoId, employeeId = $employeeId ]"
                if ($manager.HasError) {
                    __writeDot Bad

                    $errInfo = @{
                        Kind    = 'ApiError'
                        Message = 'Failed: $manager = PayloRest-GetEmployee( $step0.manager )'
                        # ExceptionType = $_.Exception.GetType().ToString()
                        json    = @{
                            Source_Co          = formatBlankText $CoId
                            Source_EmployeeId  = formatBlankText $EmployeeId
                            Manager_Co         = formatBlankText $step0.ManagerCo
                            Manager_EmployeeId = formatBlankText $step0.ManagerId
                        } | ConvertTo-Json -Compress
                    }
                    $ErrInfo
                    | bdgLog -Category WebRequest -m '$step0 => manager failed'
                    $this.FailedRequestSummary.Add( $errInfo )


                    $errInfo = [ordered]@{
                        PSTypeName       = 'bdg.RequestErrorInfoRecord'
                        ExceptionType    = ($_.Exception.GetType())?.ToString()
                        From_Co          = formatBlankText $CoId
                        From_EmployeeId  = formatBlankText $EmployeeId
                        Super_Co         = formatBlankText $step0.managerCo
                        Super_EmployeeId = formatBlankText $step0.managerId
                        Kind             = "manager of employee failed: [co = $CoId, employeeId = $employeeId ]"
                    }

                    $this.FailedLookups.add( $errInfo )
                    $this.FailedRequestSummary.Add( $errInfo )

                    # $this.stats.totalRequestTime.Stop()
                    return # bad so skip JCUpdateCSV
                }
            }
            # $manager = [PayloExportRecord]::New($manager)

        }
        else {
            $this.stats.Request_CacheHit++
            __writeDot CacheHit
            # $this.stats.Request_CacheHit++
        }
        # '{0}, {1} <{2}> [{3}_{4}]' -f @(
        $ErrorActionPreference = 'continue'
        if ( -not $manager ) {

            $msg = '<Missing manager: [Co: {0}, EmpId: {1}]>' -f @(
                $step0.managerCo ?? '?'
                $step0.managerId ?? '?'
            )
            # $step0.managerCo = $msg

            $this.FailedRequestSummary.add(@{
                    kind = 'notManager'
                    json = $step0
                })

            'EmpId = {0}, Co = {1}, Error: {2}' -f @(
                $step0.employeeId ?? '?'
                $step0.managerCo ?? '?'
                $msg
            )
            | bdgLog -Category DataIntegrity -PassThru
            | Write-Error

            __writeDot DataIntegrity

        }
        else {
            $step0.manager = Format-BlanksToDefault $manager.username '' #'<missing>'
            # try {
            # }
            # catch {
            #     "📚 error formatting manager name =>  bdg_lib\src_static\employee_infostate.ps1/25bfbe1a-f535-4cd6-ae93-bba3af244802`nException:   $_"
            #     | Write-Error
            #     # | write-warning

            # }
            # $step0.managerName = '{0} [{1}_{2}]' -f @(
            #         ($manager.username)?.ToString() ?? ''
            #         ($manager.employeeId)?.ToString() ?? ''
            #         ($manager.managerCo)?.ToString() ?? ''
            # )
        }
        $msg = '[EmployeeInfoState] Exception: ⚠ ==> ctor  bdg_lib\src_static\employee_infostate.ps1/36ca75ac-1c1e-472f-ad12-5cba1d5769b9'
        if ($null -eq $Step0) {
            @( $msg ; '$step0 == $null' )
            | bdgLog -Category DataIntegrity -PassThru -Message 'Step0 is null'
            | Write-Error -ea 'SilentlyContinue'
        }

        $step1 = [JCUserUpdate_CsvRecord]::new($step0)
        if ($null -eq $step1) {
            @( $msg ; '$step1 == $null' )
            | bdgLog -Category DataIntegrity -PassThru -Message 'Step1 is null'
            | Write-Error -ea 'SilentlyContinue'
        }
        if (-not $step1) {
            @( $msg ; '-not $step1' )
            | bdgLog -Category DataIntegrity -PassThru -Message 'Step0 is null'
            | Write-Error -ea 'SilentlyContinue'
        }

        if ($null -eq $this.PayloFull) {
            @( $msg ; '$this.PayloFull == $null' )
            | bdgLog -Category DataIntegrity -PassThru -Message 'this.PayloFull is null'
            | Write-Error -ea 'SilentlyContinue'
        }
        if (-not $this.PayloFull) {
            @( $msg ; '-not $this.PayloFull, attempting PayloExports' )
            | bdgLog -Category DataIntegrity -PassThru -Message '-not PayloFull, so trying $this.PayloExports'
            | Write-Error #-ea 'SilentlyContinue'




            try {
                ($this.PayloExports)?.Add( $step0 )
                try {
                    ($this.PayloFull)?.Add( $step0 )
                }
                catch { Write-Debug "error on step0: $_" }
                ($this.JCUpdateCsv)?.Add( $step1 )

            }
            catch {
                $msg = '==>  bdg_lib\src_static\employee_infostate.ps1/3b4cb916-d51d-4027-9b9a-5bb7d4813f55'
                $msg | Write-Error


                # maybe not?
                # $PSCmdlet.WriteError( $msg )

            }
            __writeDot Good
            return
        }
    }

    # true if match was removed
    <#
    returns bool: Was there a record removed?
    #>
    [bool] _removeEmployee ($CoId, $employeeId) {
        $target = $this.PayloExports
        | Where-Object { $_.managerCo -eq $CoId }
        | Where-Object { $_.employeeId -eq $employeeId }
        if ($Target) {
            $this.PayloExports.Remove( $target )

            # <note:distinct> also remove from
            if ($false -and '-not config-PayloFull is append only') {
                $this.PayloFull.Remove( $target )
            }
            return $true
        }
        else {
            return $false
        }

    }

    # [void] _setEmployee ($CoId, $employeeId, $data ) {
    #     Write-Error '._setEmployee() : NYI, see ._replaceEmployee'
    # }
    <#
    return existing user from record, else null
    #>
    [PayloExportRecord] _getEmployee ($CoId, $employeeId) {
        # returns payloRecord else null
        # $isBad = $this.Test_IsBadEmployeeId($CoId, $EmployeeId)
        <#
        $isBad = $false
        if ($isBad) {
            throw 'deprecated'
            $errData = @{ Co = $CoId; EmployeeId = $EmployeeId; IsBad = $IsBad }
            $errData
            | bdgLog -Category CacheEvent -Message 'Test: IsbadEmployeee?'

            $this.FailedRequestSummary.Add(@{
                    kind = 'Test_IsBadEmployeeId'
                    json = $errData
                })

            return $null
        }
        #>
        if ( ( -not $CoId) -or (-not $employeeId ) ) {
            bdgLog "Missing Co: $CoId, or Emp: $EmployeeId" -Category DataIntegrity
            $this.FailedRequestSummary.Add(@{
                    kind    = 'MissingValue'
                    message = '_getEmployee() called with missing CoId/EmpId'
                    json    = @{ CoId = $CoId; EmpId = $employeeId } | ConvertTo-Json -Compress
                })
            return $null
        }
        # $ErrorActionPreference = 'break'
        $query = $this.PayloExports
        | Where-Object { $_.managerCo -eq $CoId }
        | Where-Object { $_.employeeId -eq $employeeId }
        | Select-Object -First 1

        if ( -not $Query ) {
            $this.FailedRequestSummary.Add(@{
                    kind    = 'CacheMiss'
                    Message = '_getEmployee() : empty from this.PayloExports'
                    json    = @{ CoId = $CoId; EmpId = $employeeId } | ConvertTo-Json -Compress
                    # json = $errData
                })
            $query = PayloRest-GetEmployee -companyId $CoId -employeeId $employeeId
            $this.FailedRequestSummary.Add(@{
                    kind    = 'InvalidOperation'
                    Message = '_getEmployee() : invoked PayloRest-GetEmployee() error after cache-miss'
                    json    = @{ CoId = $CoId; EmpId = $employeeId } | ConvertTo-Json -Compress
                    # json = $errData
                })

        }

        # $ErrorActionPreference = 'continue'
        # ensure typed

        # note: this can call:
        #    Cannot convert the "payloExportRecord" value of type "System.String" to type "System.Type".
        # if ($query -is 'payloExportRecord') {
        if ($query.GetType().FullName -eq 'payloExportRecord' ) {
            $result = $query
        }
        else {
            # see:
            # <file:///bdg_lib\src_static\paylo_exportRecord.ps1>
            $result = [PayloExportRecord]::new( $query )
        }
        if ($result) {
            try {
                $global:EmployeeSummaryIndex.SetIndex( $result )
            }
            catch {
                $this.FailedRequestSummary.Add(@{
                        kind     = 'FailedTransform'
                        Messaage = '_getEmployee(): [PayloExportRecord] failed on EmployeeSummaryIndex.SetIndex()'
                        json     = @{ CoId = $CoId; EmpId = $employeeId; Ex = $_.Exception.ToString() } | ConvertTo-Json -Compress
                        # json = $errData
                    })
                "_getEmployee.SetIndex : $_ "
            }
            return $result
        }

        #old code  was broken:  "$this.add"

        $this.FailedRequestSummary.Add(@{
                kind     = 'FailedTransform'
                Messaage = '_getEmployee(): failed transform to [PayloExportRecord]'
                json     = @{ CoId = $CoId; EmpId = $employeeId } | ConvertTo-Json -Compress
                # json = $errData
            })

        return $null
    }

    EmployeeInfoState () {
        $this.EmployeeNumbers ??= [Collections.Generic.List[Object]]::new()
        $this.FailedLookups ??= [Collections.Generic.List[Object]]::new()
        $this.FailedRequestSummary ??= [Collections.Generic.List[Object]]::new()
        $this.JCUpdateCsv ??= [Collections.Generic.List[Object]]::new()
        # $this.KnownFulltime_EmployeeNumbers ??= [Collections.Generic.List[Object]]::new()
        $this.PayloExports ??= [Collections.Generic.List[Object]]::new()
        $this.PayloExports_AfterTransform ??= [Collections.Generic.List[Object]]::new()
        $this.PayloFull ??= [Collections.Generic.List[Object]]::new()


        $this.PayloFull = @(Get-Content $global:PathsExcel.export_payloFull
            | ConvertFrom-Csv)
        | ForEach-Object {
            $_
            # should be a:
            # [PayloExportRecord]( $_ )
        }

        bdgLog -Category ModuleEvent -Message ('EmployeeInfoState::new() => PayloFull.count = {0}' -f @( $this.PayloFull.Count ) ) -PassThru
        | Write-Verbose -Verbose

        $this.PayloFull.Count
        Paylo-GetNewIdentity -Verbose
        $clearNumberCache = $false
        $this.LoadEmployeeNumbers($clearNumberCache) # $clearCache
        $this._ensureDistinct()
    }
    [void] ReFetchEverything () {
        bdgLog -Category Query -Message 'ReFetchEverything() -> ~2000 records'
        # fetch all 2000
        $CoId = $this.EmployeeNumbers[0].companyId
        $EmpList = $this.EmployeeNumbers[0].EmployeeList.employeeId
        $this.FetchEmployeeList( $CoId, $EmpList )

        if ( $script:AppConf.exportVerbosity.frequently_exportCsv) {
            iF ($false) {
                $this.ExportCsv()
                $global:paylo_JsonCache.SaveToFile()
            }
        }

        $CoId = $this.EmployeeNumbers[1].companyId
        $EmpList = $this.EmployeeNumbers[1].EmployeeList.employeeId
        $this.FetchEmployeeList( $CoId, $EmpList )

        # $this.ExportCsv()
        # $global:paylo_JsonCache.SaveToFile()
        if ( $script:AppConf.exportVerbosity.frequently_exportCsv) {
            $this.ExportCsv()
            $global:paylo_JsonCache.SaveToFile()
        }
    }
    [void] FetchEmployeeList ( [string]$CompanyId, [string[]]$EmployeeIdList) {
        # fetch N-employees
        # skip cache? only wanted, sometimes

        $this.CurrentRequestCount = 0
        $ParamCoId = $CompanyId
        $EmployeeIdList = $EmployeeIdList

        @{ CoId = $CompanyId ; EmployeeIdListCount = $EmployeeIdList.Count }
        | bdgLog -Category Query -Message 'FetchEmployeeList()'

        $this.stats.totalRequestTime ??= [Diagnostics.Stopwatch]::StartNew()
        $this.stats.totalRequestTime.Start()
        $iterationsPerExportCsv = 200
        $iterationsPerExportCounter = 0

        # <tmp:debugNull>: ($global:JCSummaryIndex)?.TotalCount() ?? '' | Label 'JCIndex Count'

        if ($this.Debug_LimitMaxIterations -gt 0) { 'Debug: LimitMax {0}' -f $This.Debug_LimitMaxIterations | Write-Warning }

        foreach ($Id in $EmployeeIdList) {
            # for debug, quick exit
            if ($this.Debug_LimitMaxIterations -gt 0) {
                if ($iterationsPerExportCounter -gt $this.Debug_LimitMaxIterations) { break }
            }

            if ( $this.CurrentRequestCount -gt $this.MaxRequests) {
                $this.CurrentRequestCount = 0
                bdgLog -Category WebRequest -m 'hit reached .MaxRequests' -InputObject @{
                    MaxRequests = $this.MaxRequests
                }
                break
            }

            $this.FetchPaylo_Employee( $ParamCoId, $Id )
            if ( (($iterationsPerExportCounter++) % $iterationsPerExportCsv) -eq 0) {
                # <tmp:debugNull>: @{ IterPerExport = $iterationsPerExportCounter ; PerExportCsv = $iterationsPerExportCounter }
                # <tmp:debugNull>: | bdgLog -Category WebRequest 'Iter: PostCtorInit foreach {}' -PassThru
                # <tmp:debugNull>: | Write-Host

                # <tmp:debugNull>: $this.stats | Write-Debug
                if ( $script:AppConf.exportVerbosity.frequently_exportCsv  ) {
                    $this.ExportCsv()
                    $global:paylo_JsonCache.SaveToFile()
                }
            }
        }


        bdgLog -Message 'InfoState: Get Employees' -Category Query
        ($global:JCSummaryIndex)?.TotalCount() ?? '' | Label 'JCIndex Count'
        if ($this.PayloExports.Count -ne $this.JCUpdateCsv.Count) {
            Write-Verbose 'PostInit: Two lists are unequal counts'
        }

        $this.stats.totalRequestTime.Stop()
        ($this.stats)?.ToString() ?? '' | bdgLog -Category Verbose 'InfoStats'
        $this.CurrentRequestCount = 0
        $global:paylo_JsonCache.SaveToFile()

        $this.strCounts()
    }
    [void] ReCalculate () {
        Write-Verbose 'Recalculating: payloExports_AfterTransform...'
        # recalc JCUpdateCsv

        #[JCUserUpdate_CsvRecord]::new( $eis.PayloExports[5] )  | Fl
        if (-not $this.payloExports_AfterTransform) {
            $this.PayloExports_AfterTransform = [Collections.Generic.List[Object]]::New()
        }

        if ($null -eq $this.PayloExports -and $null -eq $this.PayloExports_AfterTransform) {

                'ReCalculate(): PayloExports AND PayloExports_AfterTransform are null.'
                | write-warning

        }
        ($this.payloExports_AfterTransform)?.Clear()
        $this._ensureDistinct()
        $this.payloExports
        | Where-Object { $_ } # skip nullls
        | ForEach-Object {
            $curRecord = $_
            $next = c5.NewFinalJumpObj -InputObject $curRecord -TransformFrom 'JCUserRecord'
            $this.payloExports_AfterTransform.Add( $next )
        }


        'recalc stats: {0}' -f @( $this.strCounts() ) | Write-Verbose


        #         $this.PayloExports | %{

        #         }
        # @(
        #    c5.NewFinalJumpObj -InputObject $this.PayloExports[0] -TransformFrom JCUpdateCsv
        #    c5.NewFinalJumpObj -InputObject $this.PayloExports[0] -TransformFrom JCUserRecord
        # ) | to-xl
        # write-warning 'Recalculate/retransform : currently  No-Op'


        # $global:JCSummaryIndex.get


        ($global:JCSummaryIndex)?.TotalCount() ?? '' | Label 'JCIndex Count' | Write-Warning
        if ($script:AppConf.Cache.JsonForceCachedDataOnly) {
            Write-Warning 'JsonForceCachedDataOnly: Enabled'
        }
        ($global:JCSummaryIndex)?.TotalCount() ?? '' | Label 'JCIndex Count' | Write-Warning

    }
    [void] PostCtorInit() {
        # wait-debugger
        # redundantly ensure distinct
        # try {
            $this.LoadEmployeeNumbers($true) # always refresh
            $this._ensureDistinct()

            $this.ReFetchEverything()

            $this._ensureDistinct()
            $this.ReCalculate()

            $this._ensureDistinct()
            $this.ExportCsv()
            # b.copyExcel @copySplat
        # }
        # catch {
        #     Write-Warning $_
        #     Write-Error "NoFetch: $_"
        # }
        # $this.ExportExcelDebug()

    }

    [string] ToString() {
        # $ErrorActionPreference = 'break'
        # try {
        try {
            $msg = @(
                '[EmployeeInfoState]:'
                "`n"
                '   EmployeeNumbers = [ idCount = {0}, {1}, listCount {2}, {3} ]' -f @(
                    ($this.EmployeeNumbers)?[0].employeeId.count ?? '?'
                    ($this.EmployeeNumbers)?[1].employeeId.count ?? '?'

                    ($this.EmployeeNumbers)?[0].employeeList.Count ?? '?'
                    ($this.EmployeeNumbers)?[1].employeeList.Count ?? '?'
                )
                "`n"
                '   PayloExports  = {0}' -f @( $this.PayloExports.Count )
                '   PayloFull     = {0}' -f @( $This.PayloFull.count )
                "`n"
                '   JCUpdateCsv   = {0}' -f @( $this.JCUpdateCsv.Count )
                "`n"
                '   FailedLookups = {0}' -f @( $this.FailedLookups.Count )
                ' ]'
                "`n"
                "`n"
                'misc:'
                '   StaticFullTime_EmployeeCount = {0}' -f @(
                    $script:static_fulltime_employee_list.count ?? '?'
                )
            ) -join ''
        }
        catch {
            $msg = '[EmployeeInfoState]::null'
        }
        # } catch { Throw "ToString() threw"}

        # $ErrorActionPreference = 'continue'
        return $msg
    }

    # EmployeeNumbers only, mapped to company
    [void] SaveEmployeeNumbers() {
        <#
        .file.inputs
        .file.outputs
            $global:AppConf.LiveDB.EmployeeList
        #>
        $this.EmployeeNumbers
        | ConvertTo-Json -Depth 8
        | Set-Content -Path $global:AppConf.LiveDB.EmployeeList
    }
    # Refresh EmployeeNumbers list
    [void] LoadEmployeeNumbers() {
        $this.LoadEmployeeNumbers($false)
        # $this.LoadEmployeeNumbers($true) # for now, forces quicker cache
    }

    [bool] _testKnownEmpId ( $CoId, $EmpId ) {
        throw 'deprecated? : _testKnownEmpId'
        $key = $CoId, $EmpId -join ','
        return $this.KnownFulltime_Employee.ContainsKey( $key)
    }
    <#
        .SYNOPSIS
            pair: SaveKnownFullTimeEmployee() ; load shortlist from: $global:AppConf.Paylocity.CachedFulltimeNumber
    #>


    # Refresh EmployeeNumbers list, force cache clear, default false
    [void] LoadEmployeeNumbers( [bool]$ClearCachedIndex ) {
        <#
        .file.inputs
            $global:AppConf.LiveDB.EmployeeList
        .file.outputs
        #>
        Write-Debug "=> LoadEmployeeNumbers( ClearCach? = $ClearCachedIndex )"
        # if($true -and 'hardcoded') {
        #     $
        # }
        # populate hard list only


        # $TempDisableNewCache = $true
        # always try
        if (-not $ClearCachedIndex) {
            __writeDot FileIO
            $this.EmployeeNumbers = Get-Content -Path $global:AppConf.LiveDB.EmployeeList
            | ConvertFrom-Json

            @{
                EmpCount_C0 = ($this.EmployeeNumbers)?[0].employeeList.Count ?? '?'
                EmpCount_C1 = ($this.EmployeeNumbers)?[1].employeeList.Count ?? '?'
            } | bdgLog -Category CacheEvent @(
                'LoadEmployeeNumbers: loaded cache: {0}' -f @($global:AppConf.LiveDB.EmployeeList)
            )
            # SaveEmployeeNumbers

            return
        }
        if ($ClearCachedIndex) {
            __writeDot ActualRequest
            try {
                $this.EmployeeNumbers = @(
                    [EmployeeNumbersRecord]@{
                        companyId    = 89849
                        # employeeList = @( PayloRest-GetAllEmployees 89849)
                        employeeList = [Collections.Generic.List[object]]@(
                            PayloRest-GetAllEmployees 89849
                            # |  maybe remove
                            | Add-Member -NotePropertyName 'isFullTime' -NotePropertyValue '' -PassThru -ea ignore -Force
                        )
                    }
                    [EmployeeNumbersRecord]@{
                        companyId    = 13294
                        employeeList = [Collections.Generic.List[object]]@(
                            PayloRest-GetAllEmployees 13294
                            | Add-Member -NotePropertyName 'isFullTime' -NotePropertyValue '' -PassThru -ea ignore -Force
                        )
                    }
                )
            }
            catch {
                $this.FailedRequestSummary.Add(@{
                        kind    = 'InvalidAPIResponse'
                        message = 'LoadEmployeeNumbers'
                        json    = @{ Ex = $_.Exception.ToString() }
                    })
                Write-Warning 'FailedLookup, 401'

                Write-Error -ea stop 'PayloRest-GetAllEmployees failed'
                $this.EmployeeNumbers.Clear()
            }
        }

        function _empInStatic {

            # doesn't detect as distinct pair, but, good enough filter for now now
            param( [string]$CompanyId, [string]$EmployeeId )

            throw 'deprecated: _empInStatic'
            # $query = $static_fulltime_employee_list
            # # | ?{  $_.CompanyId -eq $CompanyId -and $_.EmployeeId -eq $EmployeeId }
            # | Where-Object { $static_fulltime_employee_list.companyid -contains $companyId }
            # | Where-Object { $static_fulltime_employee_list.employeeId -contains $EmployeeId }
            # return ($query.count -gt 0)
        }
        try {
            if ( $this.EmployeeNumbers ) {
                'count: {0}' -f @(
                ($this.EmployeeNumbers)?[1].employeeList.Count ?? '0'
                )
                | bdgLog -cat CacheEvent 'EmployeeCount in Emplist[1] after filter'

            }
            else {
                Write-Warning 'empty content, expected: "$this.EmployeeNumbers[1].employeeList.Count"'
            }
        }
        catch {
            throw $_
        }
        # | write-host -ForegroundColor 'orange' -bg 'gray70'
    }

    # remove any duplicates + final filtering rules
    [void] _ensureFullTime() {
        # filters in-place, removing any missing workEmail or IsFullTimeEmployee
        # I guess you can't be fulltime without email
        # throw "Employee IsActive? requires new logic"
        # Write-Warning 'assert whether property name is right'
        if ($this.PayloExports.Count -gt 0) {
            $this.PayloExports = @(
                $this.PayloExports
                | Where-Object { $_.IsFullTimeEmployee() }
                | Where-Object { -not [string]::IsNullOrWhiteSpace( $_.workEmail ) }
                # | Where-object { $_.IsActiveEmployee()  }
            )
        }
        if ($this.JCUpdateCsv.count -gt 0) {
            $this.JCUpdateCsv = @(
                $this.JCUpdateCsv
                | Where-Object { $_.IsFullTimeEmployee() }
                | Where-Object { -not [string]::IsNullOrWhiteSpace( $_.email ) }
            )
        }
    }
    [void] _ensureDistinct() {
        # enforce distinct list after dropping non-fulltime employees
        if ($this.payloExports.count -gt 1 ) {
            $null = 0
        }
        $this.PayloExports = @(
            $this.PayloExports
            | Sort-Object -Unique { $_.GetGuid() } # old":  $_.employeeId, $_.companyId }
            # | Sort-Object -Unique { $_.employeeId, $_.managerCo }
        )
        $this.PayloExports_AfterTransform = @(
            $this.PayloExports_AfterTransform
            | Sort-Object -Unique { $_.companyId, $eis.employee }
            # | Sort-Object -Unique { $_.GetGuid() } # old":  $_.employeeId, $_.companyId }
            # | Sort-Object -Unique { $_.employeeId, $_.managerCo }
        )

        # either no removal, or,
        if ($false) {
            # for debugging might not want to remove same keyid/email but diff comp

            $this.PayloFull = @(
                $this.PayloFull
                | Sort-Object -Unique { $_.GetKeyIdPair() } # maybe not because they changed?
            )
        }
        $this.JCUpdateCsv = @(
            $this.JCUpdateCsv
            | Sort-Object -Unique { $_.GetGuid() } #$_.employeeIdentifier, $_.companyId }
            | Where-Object { -not [string]::IsNullOrEmpty( $_.GetGuid() ) } #this, otherwise
            | Where-Object { -not ([string]::IsNullOrWhiteSpace($_.username)) -and -not ([string]::IsNullOrWhiteSpace($_.email)) }
        )

        # drop blank records
        $this.PayloExports = $this.PayloExports
        | Where-Object {
            (-not [string]::IsNullOrWhiteSpace( $_.CompanyId )) -and (-not [string]::IsNullOrWhiteSpace( $_.EmployeeId ))
        }

        $this.PayloExports_AfterTransform = $this.PayloExports_AfterTransform
        | Where-Object {
            (-not [string]::IsNullOrWhiteSpace( $_.CompanyId )) -and (-not [string]::IsNullOrWhiteSpace( $_.EmployeeId ))
        }
    }

    [void] ExportExcelDebug() {
        $ExportExcelCfg = $global:ExportExcelCfg # why not global?
        $alwaysRecalculate = $true
        if ($alwaysRecalculate) {
            $this.ReCalculate()
        }
        if ($ExportExcelCfg.Exports.Csv.AlwaysExportCsvFirst) {
            $this.ExportCsv() # redundant?
        }

        __writeDot Processing

        $Dest = $global:PathsExcel.export_mergedExcel
        $splatExcel = @{
            Path = $dest
            # // see more: https://github.com/dfinke/ImportExcel/blob/master/Examples/OutTabulator/start-demo.ps1
            # Show         = $true
            # Title        = 'all properties: {0}' -f $src.Name
            # InputObject = $csvData
            # TableName = 'rawData'
            # WorksheetName = 'rawData'
        }
        $exSplat = @{
            # Debug             = $true
            Verbose           = $true
            # TableStyle = 'Light2'
            InformationAction = 'Continue'
        }

        _excelResetSheet $Dest

        function _excel_addSheetFromObj {
            param(
                [Parameter(Mandatory, ValueFromPipeline)]
                $InputObject,

                # future, add regex one too
                [Alias('LiteralProperty')]
                [Parameter()]
                $Property,

                [switch]$IncludeHidden
            )
            process {
                Write-Error 'Deprecated, now use [..].TransformTo(style)'
                Write-Warning 'fix later, might be an issue on custom names like pstypename'
                $propNames = if ($InputObject.count -gt 1) {
                    $propNames = @( $InputObject )[0]
                }
                else {
                    $propNames = $InputObject
                }

                if ( -not $IncludeHidden ) {
                    $InputObject | Select-Object -ea Ignore -Property * # to be vvar
                    return
                }
                $propsIncludingHidden = $InputObject
                | Get-Member -Name $Property -Force -MemberType Properties | ForEach-Object Name

                return $InputObject | Select-Object -ea Ignore -Prop $propsIncludingHidden
                # $propNames = @( $InputObject )[0] # works on scalar
            }

        }
        # wait-debugger

        # entry point for excel output
        if ($ExportExcelCfg.Exports.WorkSheet.LastToCompareReference) {
            $LastToCompare = Get-Item (Join-Path $global:appConf.prefixRootActual 'output_static\FinalToCompare - Final JC Attribute update.csv')
            if ($LastToCompare) {
                _excelAddSheet @exSplat -InputObject (Get-Content $LastToCompare | ConvertFrom-Csv) -Label 'finalAttr'-Options @{ Title = 'FinalToCompare - Final JC Attribute update.csv' }
            }
            else {
                Write-Warning 'ExcelToCompare referencesheet not found'
            }
            $null = 0
        }

        $null = 0

        # if('includeTabMeta') {
        #    $metaObj = [pscustomobject]@{

        #         'GeneratedOn' = [Datetime]::Now.ToString('o')
        #         'Mapping_JumpCloud_JCUpdateUser.CurrentProps_UpdateUser' = $script:Mapping_JumpCloud_JCUpdateUser.CurrentProps_UpdateUser

        #    }
        #    _excelAddSheet @exSplat -InputObject $metaObj -Label 'm'
        # }

        if ($this.JCUpdateCsv) {

            $ExportExcelCfg.Exports.Worksheet.csv_WithoutIgnored = $true

            $titleStr = '=> JCUpdateCsv'
            _excelAddSheet @exSplat -Label 'UpdateCsv' -InputObject @(
                $this.JCUpdateCsv

                # $this.JCUpdateCsv
                # | ForEach-Object {
                # }
                # | ?{ $_.IsEmployeeActive.() }
                # | ?{ $_.IsFullTimeEmployee() }

            ) -Options @{ Title = $titleStr }
            if ($ExportExcelCfg.Exports.Worksheet.csv_WithoutIgnored) {

                $titleStr = '=> JCUpdateCsv : IsFullTimeEmployee + IsEmployeeActive'
                _excelAddSheet @exSplat -Label 'UpdateCsv' -InputObject @(
                    $this.JCUpdateCsv
                    | Where-Object { $_.IsFullTimeEmployee() }
                    | Where-Object { $_.IsEmployeeActive() }
                    # | ForEach-Object {
                    #     $_.TransformTo('JCUpdate_WithoutIgnored')
                    # }
                ) -Options @{ Title = $titleStr }
            }
            # $ErrorActionPreference = 'break'
            if ( $true -or $ExportExcelCfg.Exports.Worksheet.csv_noFilter) {
                _excelAddSheet @exSplat -Label 'csv_noFilter' -InputObject $this.JCUpdateCsv
            }
            # _excelAddSheet @exSplat -Label 'csv_withIgnored' -InputObject $this.JCUpdateCsv
            # if($false -and 'live only') {
            # _excelAddSheet @exSplat -Label 'csv_noFilter' -InputObject $this.JCUpdateCsv
            # } else {
            #     # additional columns for debugging
            #     _excelAddSheet @exSplat -Label 'csv_withIgnored' -InputObject @(
            #         $this.JCUpdateCsv | %{
            #            $_
            #            | Add-Member -force -ea Ignore -PassThru -NotePropertyName 'wasEmployeeActive' -NotePropertyValue $_.IsEmployeeActive()
            #            | Add-Member -force -ea Ignore -PassThru -NotePropertyName 'wasFulltimeEmployee' -NotePropertyValue $_.IsFulltimeEmployee()

            #         }
            #     )

            # }


            # if($false -and 'live only') {
            #     _excelAddSheet @exSplat -Label 'Update_csv' -InputObject $this.JCUpdateCsv
            # } else {
            #     # additional columns for debugging
            #     _excelAddSheet @exSplat -Label 'Update_csv' -InputObject @(
            #         $this.JCUpdateCsv | %{
            #            $_
            #            | Add-Member -force -ea Ignore -PassThru -NotePropertyName 'wasEmployeeActive' -NotePropertyValue $_.IsEmployeeActive()
            #            | Add-Member -force -ea Ignore -PassThru -NotePropertyName 'wasFulltimeEmployee' -NotePropertyValue $_.IsFulltimeEmployee()

            #         }
            #     )

            # }


            if ($ExportExcelCfg.Exports.Worksheet.export_finalStatic_JCImport) {
                $This.JCUpdateCsv
                | ConvertTo-Csv
                | Set-Content -Path $global:PathsExcel.export_finalStatic_JCImport# -passthru

                label 'wrote "export_finalStatic_JCImport"' $global:PathsExcel.export_finalStatic_JCImport
            }

            if ($true) {
                # block: for create
                $props_jcUpdate = $this.JCUpdateCsv
                | Select-Object -prop ($script:Mapping_JumpCloud_JCUpdateUser.CurrentProps_UpdateUser ) -ea ignore
            }
            if ($ExportExcelCfg.Exports.Worksheet.FromPaylo) {
                $titleStr = 'PayloExports {0}' -f @(
                    $this.PayloExports.count
                )
                if ($this.PayloExports) {
                    _excelAddSheet @exSplat -InputObject $this.PayloExports -Label 'FromPaylo' -Options @{ Title = $titleStr }
                }
            }
            if($this.PayloExports) {
                _excelAddSheet @exSplat -InputObject $this.PayloExports -Label 'Zed' -Options @{ Title = $titleStr }
            } else {
                write-error '$this.PayloExports is empty'
            }
            # if($true) {
            # $titleStr = 'PayloExports {0}' -f @(
            #     $this.PayloExports.count
            # )

            # _excelAddSheet @exSplat -Label 'all_a' -InputObject @(

            # )
            # $this.PayloFull | s -First 3 |  %{ [JCUserUpdate_CsvRecord]::new( $_ ) } | ft
            #     #-Options @{ Title = $titleStr }
            # }
            # $this.PayloFull | s -First 3 |  %{ [JCUserUpdate_CsvRecord]::new( $_ ) } | ft
            # $this.PayloFull | s -First 3 | to->Json | from->Json | %{ [CachedEmployeeIndexRecord]::new( $_ ) } | Ft
            # }
            if ($ExportExcelCfg.Imports.JumpCloud) {
                'Querying JCUsers for Values...AppConf.Limit.MaxJumpCloudQueryCount = {0}' -f @(
                    $global:AppConf.Limit.MaxJumpCloudQueryCount
                )
                | bdgLog -PassThru -Category Verbose 'JC Query: $ExportExcelCfg.Imports.JumpCloud'
                | Write-Host


                # null method exception
                # $emailsToQuery = $global:EmployeeSummaryIndex.GetEnumerator() | % Value | % workEmail
                $emailsToQuery = $global:EmployeeSummaryIndex.AsList().WorkEmail | Sort-Object -Unique
                if ($null -eq $emailsToQuery) {
                    throw "Invalid '`$EmailsToQuery'"
                }
                if ($global:AppConf.Limit.MaxJumpCloudQueryCount -ne 0  ) {
                    $emailsToQuery = $emailsToQuery
                    | Select-Object -First $global:AppConf.Limit.MaxJumpCloudQueryCount
                }

                # wait-debugger
                $emailsToQuery | ForEach-Object {
                    # index into null aarray error here
                    $curEmail = $_
                    try {
                        warnOnce 'IndexIsNotAccessableScope'
                        $maybeRecord = $global:JCSummaryIndex.GetOrFetchIndex( $curEmail, $false )



                    }
                    catch {
                        # old logic
                        Write-Warning "Err: $_"
                        # write-error "Err: $_"
                        if ($_.ErrorDetails.Message -match 'host.*failed.*respond') {
                            $_.ErrorDetails.Message.ToString()
                            | bdgLog -Message 'Get-JCUser Error, timeout' -PassThru | Write-Host
                            Start-Sleep -sec 5
                            Get-JCUser -email $_ -ea Stop -Verbose:$false -Debug:$false
                        }
                        else { throw $_ }
                    }
                    # if(-not $MaybeRecord) {

                    #     $query = Get-JCUser -email $curEmail -debug:$false -verbose:$false # super verbosy
                    #     $query = $global:JCSummaryIndex.SetIndex( $query )
                    #     "Missing JCQuery: $curEmail"
                    #     | label 'JCQuery'
                    #     | bdgLog -Category CacheEvent 'missing or stale JSQuery' -PassThru
                    #     | write-host
                    # }
                }
                $global:JCSummaryIndex.SaveToFile()
                # $script:JCSummaryIndex.file

            }
            if ($true) {
                # block: JC for all

                function b.debugTestJCUserTransform {
                    Write-Host 'invoke => b.debugTestJCUserTransform()'
                    throw 'deprecated, see: [class].TransformTo( name ) '

                    $someUser = $query_jcNow_raw | Select-Object -First 1

                    # $empFromEis = $eis.JCUpdateCsv | ? employeeIdentifier -eq 12865
                    $empFromEis = $eis.JCUpdateCsv | Where-Object { $_.employeeIdentifier -eq $someUser.employeeIdentifier }

                    $someUser | s -p $str.all_cols_finalAttr
                    hr
                    $someUser | s -p $str.all_cols_fromJCv1
                    hr
                    [Get_JCUser]::new( $someUser )
                    hr
                }
                if ($true -and $global:globCfg.FinalJumpTransform) {
                    b.debugTestJCUserTransform
                }

                # if ($ExportExcelCfg.Exports.Worksheet.FromJC) {
                #     _excelAddSheet @exSplat -InputObject @($query_jcNow) -Label 'FromJC'
                # }
                # if ($ExportExcelCfg.Exports.Worksheet.FromJC_raw) {
                #     _excelAddSheet @exSplat -InputObject @($query_jcNow_raw) -Label 'FromJC_raw'
                # }

                if ($ExportExcelCfg.Exports.Worksheet.JCIndexCache) {
                    if ($global:JCSummaryIndex ) {

                        $titleStr = 'JCSummaryIndex {0}' -f @(
                            $Global:JCSummaryIndex.TotalCount()
                        )
                        # _excelAddSheet @exSplat -InputObject @( $global:JCIndexCache ) -Label 'JCIndexCache'
                        _excelAddSheet @exSplat -InputObject @( $global:JCSummaryIndex.TransformTo('Excel') ) -Label 'JCIndexCache' -Options @{ Title = $titleStr }


                        $global:JCSummaryIndex.TotalCount() | Label 'JCIndex Count'
                    }
                }
                $ExportExcelCfg.Exports.Worksheet.TempDebug = $true
                # wait-debugger
                if ($ExportExcelCfg.Exports.Worksheet.TempDebug) {
                    # see related <file:///C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\always-mini.partial_only3.ps1>

                    $null = 0
                    $splat_copyWork = @{
                        OriginalPath   = Join-Path $global:AppConf.ExportTemp 'buff_table'
                        ExportTemplate = Join-Path $global:AppConf.ExportTemp 'buff_table_{0}.xlsx'
                    }
                    $splat_copyWork | bdgLog -Category Verbose 'Export filepaths'

                    $splatShare = @{
                        DestinationPath = $splat_copyWork.OriginalPath
                    }

                    b.newExcelBook -Path $splat_copyWork.OriginalPath
                    $sheetName = '$sheetName'

                    $optConfig = @{
                        Label         = '$sTemp.page'
                        Title         = '$titleStr'
                        TableName     = '$sTemp.TableName' ?? "t_${sheetName}"
                        WorksheetName = $sheetName
                    }

                    _excelAddSheet @exSplat -Label 'db.JCUpdateCsv' -InputObject @(
                        $this.JCUpdateCsv
                        | Where-Object { $_.IsFullTimeEmployee() }
                        | Where-Object { $_.IsEmployeeActive() }
                    )

                    #     $_.TransformTo('JCUpdate_WithoutIgnored')

                    # }
                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $this.JCUpdateCsv
                        | Where-Object { $_.IsFullTimeEmployee() }
                        | Where-Object { $_.IsEmployeeActive() }
                    ) -nSheetName 'db.JCUpdateCsv.2' -nTitleStr 'csv_WithoutIgnored'


                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $this.PayloExports
                        # | %{
                        #     $_
                        #     | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                        #         'Made it' = get-date
                        #         Guid = ($_)?.GetGuid()
                        #     }
                        # }
                    ) -nSheetName 'a.paylo' -nTitleStr 'a.paylo'

                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $this.PayloFull
                        # | %{
                        #     $curRecord = $_
                        #     try {
                        #         $curRecord
                        #         | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                        #             'Made it' = get-date
                        #             Guid = ($_)?.GetGuid()
                        #         }
                        #         return
                        #     } catch {
                        #         # $_ | write-verbose Happens when type didn't coerce
                        #         $curRecord
                        #     }
                        # }
                    ) -nSheetName 'a.paylo_ALL' -nTitleStr 'a.paylo_ALL'


                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $global:EmployeeSummaryIndex.AsList() | ForEach-Object {
                            $_
                            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                                Guid = ($_)?.GetGuid()
                            }
                        }


                    ) -nSheetName 'd.Ess' -nTitleStr 'd.EmployeeSummaryIndex'

                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $global:EmployeeSummaryIndex.TransformTo('Excel')
                        | ForEach-Object {
                            $_
                            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                                Guid = ($_)?.GetGuid()
                            }
                        }
                    ) -nSheetName 'd.Ess.Xls' -nTitleStr 'd.EmployeeSummaryIndex.TransformTo("Excel")'
                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $global:EmployeeSummaryIndex.TransformTo('Excel')
                        | ForEach-Object {
                            $_
                            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                                Guid = ($_)?.GetGuid()
                            }
                        }
                    ) -nSheetName 'd.Ess.Xls.2' -nTitleStr 'd.EmployeeSummaryIndex'

                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $global:EmployeeSummaryIndex.TransformTo('Excel')
                        | Where-Object {
                            ($_)?.Department -notmatch 'remote|^rm$'
                        }
                        | ForEach-Object {
                            $_
                            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                                Guid = ($_)?.GetGuid()
                            }
                        }
                    ) -nSheetName 'd.Ess.WithoutRM' -nTitleStr 'Index minus remote'

                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $global:EmployeeInfoState.PayloExports
                        | ForEach-Object {
                            $_
                            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                                Guid = ($_)?.GetGuid()
                            }
                        }
                    ) -nSheetName 'd.Eis.Paylo' -nTitleStr 'd.PayloIndex'

                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        $global:EmployeeInfoState.JCUpdateCsv
                        | ForEach-Object {
                            $_
                            | Add-Member -PassThru -Force -ea 'continue' -NotePropertyMembers @{
                                Guid = ($_)?.GetGuid()
                            }
                        }
                    ) -nSheetName 'd.Eis.JCUp' -nTitleStr 'd.JCUpdateCsv'

                    b.addSheet @splatShare -Options $optConfig -InputObject @(
                        ($global:EmployeeInfoState.EmployeeNumbers)?[0].EmployeeList
                        ($global:EmployeeInfoState.EmployeeNumbers)?[1].EmployeeList
                    ) -nSheetName 'd.EmpNo' -nTitleStr 'd.EmployeeNumbers'




                    b.copyWorkBook0 @splat_copyWork
                }
                if ($ExportExcelCfg.Exports.Worksheet.IndexCache) {
                    if ($global:EmployeeSummaryIndex ) {
                        $titleStr = 'EmployeeSummaryIndex {0}' -f @(
                            $Global:EmployeeSummaryIndex.TotalCount()
                        )

                        _excelAddSheet @exSplat -InputObject @( $global:EmployeeSummaryIndex.TransformTo('Excel') ) -Label 'IndexCache' -Options @{ Title = $titleStr }

                    }
                }

                # wait-debugger

                if ($ExportExcelCfg.Exports.Worksheet.ExistSummaryTable) {

                    # wait-debugger
                    $global:ExistInBothTable = b.GenerateExistSummaryTable -InJumpCloud
                    # Set-PSBreakpoint -Command 'ConvertTo-Json'
                    $titleStr = 'Test: Users ExistIn Paylo and JCIndex? {0}' -f @(
                        ($global:ExistInBothTable).count
                    )
                    # wait-debugger
                    _excelAddSheet @exSplat -InputObject @(
                        $global:ExistInBothTable

                    ) -Label 'ExistCache' -Options @{ Title = $titleStr }

                }
                # wait-debugger

                # add excel sheets to main workboook here

                if ($ExportExcelCfg.Exports.Worksheet.ChangesSummaryTable) {
                    [Collections.Generic.List[Object]]$all_changes = @()

                    $all_possible_names = @(
                        $global:EmployeeSummaryIndex.AsList().WorkEmail
                        $global:JCSummaryIndex.AsList().Email
                    ) | Sort-Object -Unique

                    # test throttle
                    $moreList = @( 'alissa.london@bustle.com', 'anne.vorrasi@bustle.com', 'barri.grossman@bustle.com', 'bryan@bustle.com', 'chris@bustle.com', 'danielle.kraese@bustle.com', 'eunice.bruno@bustle.com', 'faith.brown@wmagazine.com', 'irma@bustle.com', 'jackie@bustle.com', 'jacob.kleinman@bustle.com', 'jen.glennon@bustle.com', 'jerome.covington@bustle.com', 'kaitlin.cubria@bustle.com', 'kaitlin.kimont@bustle.com', 'karen@bustle.com', 'kathy.kaplan@bustle.com', 'kylie@bustle.com', 'mateo.delgadillo@bustle.com', 'meghan@bustle.com', 'nancy@bustle.com', 'olivia.craighead@bustle.com', 'suzanne.collins@bustle.com', 'trang.chuong@wmagazine.com', 'wesley.bonner@bustle.com', 'ysenia.valdez@wmagazine.com' )
                    $tryFirst = $global:JCSummaryIndex.AsList().Email

                    $tryFirst = @(
                        $global:EmployeeInfoState.JCUpdateCsv.email | Get-Random -Count 10
                        'jbolton@dev.bustle.com'
                        'rob.eastman@bustle.com'
                    )
                    Write-Warning 'only queries some emails <file:///C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\employee_infostate.ps1>'
                    # wait-debugger
                    $tryFirst | ForEach-Object {
                        $curEmail = $_
                        # $ErrorActionPreference = 'break'
                        try {
                            $fp = $find_indexPaylo = $global:EmployeeSummaryIndex.GetIndex( $curEmail )
                            $fj = $find_indexJC = $global:JCSummaryIndex.GetIndex( $curEmail )
                            $d = [ordered]@{
                                # paylo is source of truth
                                WorkEmail  = $fp.WorkEmail
                                CompanyId  = $fp.CompanyId
                                EmployeeId = $fp.EmployeeId
                            }
                            $emptyObj = [pscustomobject]@{}
                            $fp = $fp ?? $emptyObj
                            $fj = $fj ?? $emptyObj
                            if (-not $find_indexJC) {
                                # wait-debugger
                                # @{
                                #     findPaylo = $fp.ToString()
                                #     findJumpCloud = $fj ?? '<nothing>'
                                # }
                                # wait-debugger
                                # @{
                                #       findPaylo = $fp.ToString() ?? '<nothing>'
                                #     payloType_type =  $fp.GetType() ?? '<bnothing>'
                                #     findJumpCloud = $fj.ToString() ?? '<nothing>'
                                #     findJumpCloud_type = $fj.GetType() ?? '<nothing>'
                                # } | bdgLog -Category DataIntegrity -PassThru 'ComparingBlankableObjectException: Verify user exists in JumpCloud'
                                # | write-warning

                                if (-not $find_indexPaylo) {
                                    # @{
                                    #     findPaylo = $fp.ToString() ?? '<nothing>'
                                    #     payloType_type =  $fp.GetType() ?? '<bnothing>'
                                    #     findJumpCloud = $fj.ToString() ?? '<nothing>'
                                    #     findJumpCloud_type = $fj.GetType() ?? '<nothing>'
                                    # }
                                    # | bdgLog -Category DataIntegrity -PassThru 'ComparingBlankableObjectException: Verify user exists in Paylocity'
                                    # | write-warning
                                    # wait-debugger
                                }
                                # wait-debugger
                                $result = basicDiff $Fp $Fj -ea 'break'


                                if ($null -eq $result) {
                                    'Unexpected null baseDiff for user: "{0}"' -f @(
                                        $curEmail
                                    ) | Write-Error
                                    return
                                }
                                $result
                                | Add-Member -Force -PassThru -ea 'break' -NotePropertyMembers $d -TypeName 'b.ActivePropertyDiffResult'

                                # $result | ? HasChanged # this works
                                # wait-debugger
                                if ($Result) {
                                    $all_changes.addRange( $Result )
                                }
                            }
                        }
                        catch {
                            # wait-debugger
                            throw "shouldneverreachException $_"
                        }
                        $ErrorActionPreference = 'continue'

                    }

                    if ( -not $all_changes) {
                        'empty allchanges'
                        | Write-Warning
                    }
                    else {
                        $titleStr = 'Changes {0}' -f @(
                            ($all_changes).count ?? '0'
                        )
                        # wait-debugger
                        _excelAddSheet @exSplat -InputObject @(
                            $all_changes
                        ) -Label 'Changes' -Options @{ Title = $titleStr }
                    }
                }
                Write-Warning 'debug working...'
                # wait-debugger

                # add error table, or at least some
                function b.debugWriteErrors {
                    param()
                    $allKeys = @($eis.FailedRequestSummary.keys | Sort-Object -Unique)
                    $hash = @{}
                    foreach ($key in $allKeys) {
                        $hash[ $key ] = $null #$key
                    }
                    # wait-debugger
                    $objWithAll = [pscustomobject]$hash
                    $rows = @(
                        $objWithAll
                        $eis.FailedRequestSummary
                        | ForEach-Object { [pscustomobject]$_ }
                    )
                    # wait-debugger
                    if ($ExportExcelCfg.Exports.Worksheet.errorSummary) {
                        _excelAddSheet @exSplat -InputObject @(
                            $rows
                            | Where-Object { $_.kind -match 'missingManager|notManager' }
                            | Sort-Object kind -Descending
                        ) -Label 'errorSummary'
                    }
                    # wait-debugger
                    if ($ExportExcelCfg.Exports.Worksheet.errorSummary) {
                        _excelAddSheet @exSplat -InputObject @($rows) -Label 'errorSummary_raw'
                    }
                }

                #| %{ [pscustomobject]$_ } | s -First 20 | fl
                . b.debugWriteErrors
                # wait-debugger



                $ErrorActionPreference = 'continue'
                [OfficeOpenXml.ExcelPackage]$pl = Open-ExcelPackage -Path $global:PathsExcel.export_mergedExcel -ea stop
                _excelApplyConditionalFormatting -Package $Pl
                Close-ExcelPackage $Pl
            }

            if ('who called me, exporting dup?') {}
        }

        # _excel-AutosizeColumns -path $Dest # *should* be redundant
        # write-warning 'last json hang here?'
        # wait-debugger
        $ExportExcelCfg.Exports.export_errors1 = $true
        if ($ExportExcelCfg.Exports.export_errors1) {

            $this.PayloExports
            | ConvertTo-Json -Depth 6
            | Set-Content -Path $global:PathsExcel.export_json_step0

            $global:PathsExcel.export_step0
            | bdgLog -Message 'exportJson: step0' -Category CacheEvent -PassThru | Write-Host
        }
        if ($ExportExcelCfg.Exports.Json.export_json_step0) {

            $this.PayloExports
            | ConvertTo-Json -Depth 6
            | Set-Content -Path $global:PathsExcel.export_json_step0

            $global:PathsExcel.export_step0
            | bdgLog -Message 'exportJson: step0' -Category CacheEvent -PassThru | Write-Host
        }
        # wait-debugger
        if ($ExportExcelCfg.Exports.Worksheet.export_debug_step1) {

            $this.JCUpdateCsv
            | ConvertTo-Json -Depth 6
            | Set-Content -Path $global:PathsExcel.export_debug_step1

            $global:PathsExcel.export_step1
            | bdgLog -Message 'exportJson: step1' -Category CacheEvent -PassThru | Write-Host

            __writeDot Complete

            __writeDot Bright

            'made it'
            # wait-debugger
        }
        # postCtor: if('who called me, exporting dup?') {}
    }


    [void] ClearCachedPayloExports() {
        # throw 'never used?'
        # New-BurntToastNotification -Text 'Cache: Clear'
        if( $null -eq $This.PayloExports) {
            $this.PayloExports = [Collections.Generic.List[Object]]::new()
        }
        if($this.PayloExports.Count -gt 0) {
            $this.PayloExports = @()
        }


        $this.JCUpdateCsv.Clear()
        Clear-Content -Path $global:PathsExcel.export_step0 -ea ignore
        Clear-Content -Path $global:PathsExcel.export_step0_raw -ea ignore
        # Clear-Content -Path $global:PathsExcel.export_payloFull -ea ignore
        # Clear-Content -Path $global:PathsExcel.export_json_step0
    }
    # [void] LoadCachedPayloExports() {
    #     # cache is now in the JSON response rather than the ETL
    #     $this.PayloExports = @(
    #         $this.PayloExports
    #     )
    #     $This._ensureDistinct()
    #     # bdgLog -Message 'loadCachedCsv: step0: AfterDistinct Loaded records: ' -Category CacheEvent -PassThru | Write-Host
    #     # | bdgLog -Message 'loadCachedCsv: step0: AfterDistinct Loaded records: ' -Category CacheEvent #-PassThru | Write-Host
    # }
    [string] strCounts () {
        return $this.strCounts('oneline')
    }
    [string] strCounts ( [string]$FormatMode ) {
        [string]$render = ''
        if ($FormatMode -eq 'pretty' ) {
            $render =
            '
PayloExports    | Count = {0}, +A = {2}, +F = {4}, +F+A = {6}
JCUpdateCsv     | Count = {1}, +A = {3}, +F = {5}, +F+A = {7}
' -f @(
                '{0} ({1})' -f @(
                    $this.PayloExports.count
                    $this.PayloFull.count
                )
                $this.JCUpdateCsv.Count

                # paylohas: IsEmployeeActive
                # 2, 3
                try {
 ($this.PayloExports | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }

                try {
 ($this.JCUpdateCsv | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }

                # 4, 5
                try {
 ($this.PayloExports | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee()
                    }).count
                }
                catch {
                    0
                }

                try {
 ($this.JCUpdateCsv | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee()
                    }).count
                }
                catch {
                    0
                }
                # 6, 7
                try {
 ($this.PayloExports | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee() -and $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }

                try {
 ($this.JCUpdateCsv | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee() -and $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }
            )
            return $render
        }

        # default short
        # default or 'strCounts'
        if ($true -or ($FormatMode -eq 'oneline')   ) {
            $render =
            'PayloExports    | Count = {0}, +A = {2}, +F = {4}, +F+A = {6}
JCUpdateCsv     | Count = {1}, +A = {3}, +F = {5}, +F+A = {7}
' -f @(
                '{0} ({1})' -f @(
                    $this.PayloExports.count
                    $this.PayloFull.count
                )

                $this.JCUpdateCsv.Count

                # paylohas: IsEmployeeActive
                # 2, 3
                try {
                    ($this.PayloExports | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }

                try {
                    ($this.JCUpdateCsv | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }

                # 4, 5
                try {
                    ($this.PayloExports | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee()
                    }).count
                }
                catch {
                    0
                }

                try {
                    ($this.JCUpdateCsv | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee()
                    }).count
                }
                catch {
                    0
                }
                # 6, 7
                try {
                    ($this.PayloExports | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee() -and $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }

                try {
                    ($this.JCUpdateCsv | Where-Object { $null -ne $_ } | Where-Object {
                        $_.IsFulltimeEmployee() -and $_.IsEmployeeActive()
                    }).count
                }
                catch {
                    0
                }
            )

        }
        [string]$minfifyRender = $render -replace '\r?\n', ', ' -replace ' +', ' ' -replace '\t', ' '
        return $minfifyRender ?? '' # required for lint?
    }
    [void] ExportDiagnosticInfo () {
        # export debug numbers not normally used
        $destPath = Join-Path $global:appConf.ExportTemp 'ExportDiagnosticInfo.xlsx'
        Remove-Item $destPath -ea ignore

        $this.ToString()
        | Join-String -op '[EmployeeInfoState]::ExportDiagnosticInfo()'
        | Write-Verbose

        $Pkg = Open-ExcelPackage -Path $destPath -Create
        '[EmployeeInfoState]::ExportDiagnosticInfo => wrote: {0}' -f ($destPath)

        $rows = $global:paylo_JsonCache.Records
        if ($rows.count -gt 0) {
            $exportExcelSplat = @{
                WorksheetName = 'jsonCache'
                TableName     = 'jsonCache'
                PassThru      = $true
                TableStyle    = 'Light2'
                AutoSize      = $true
                Title         = 'global:paylo_JsonCache.Records type not hashtable'
                ClearSheet    = $true
                # Append        = $true
            }
            $pkg = $rows
            | Where-Object { $_ -isnot 'hashtable' }
            | Sort-Object { [int]$_.employeeId } -Descending
            | Export-Excel @exportExcelSplat -ExcelPackage $pkg



            # $exportExcelSplat = @{
            #     WorksheetName = 'cAsHash'
            #     TableName     = 'cAsHash'
            #     PassThru      = $true
            #     TableStyle    = 'Light2'
            #     AutoSize      = $true
            #     Title         = 'global:paylo_JsonCache.Records where type is hashtable'
            #     ClearSheet    = $true
            #     # Append        = $true
            # }
            # $maybeHasRows = $rows
            # | Where-Object { $_ -is 'hashtable' }
            # # | ?{ ($paylo_JsonCache.records | ?{ $_ -isnot 'hashtable' } )
            # # | ? ($paylo_JsonCache.records | ?{ $_ -isnot 'hashtable' } )
            # | Sort-Object { [int]$_.employeeId } -Descending
            # if ($maybeHasRows) {
            #     $maybeHasRows | Export-Excel @exportExcelSplat -ExcelPackage $pkg
            # }
            <#
                Export-Excel: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\employee_infostate.ps1:2849:15
                Line |
                2849 |              | Export-Excel @exportExcelSplat -ExcelPackage $pkg
                |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                | Cannot bind argument to parameter 'Range' because it is null.

     #>#>

            $exportExcelSplat = @{
                WorksheetName = 'EmpNum'
                TableName     = 'EmpNum'
                PassThru      = $true
                TableStyle    = 'Light2'
                AutoSize      = $true
                Title         = 'eis.EmployeeNumbers[0].EmployeeList'
                ClearSheet    = $true
                # Append        = $true
            }


            $currows = @(
                $this.EmployeeNumbers[0].EmployeeList
                | Add-Member -NotePropertyName 'companyId' -NotePropertyValue $this.EmployeeNumbers[0].companyId -PassThru -Force -ea ignore
                $this.EmployeeNumbers[1].EmployeeList
                | Add-Member -NotePropertyName 'companyId' -NotePropertyValue $this.EmployeeNumbers[1].companyId -PassThru -Force -ea ignore
            )

            $pkg = $currows
            | Sort-Object { [int]$_.employeeId } -Descending
            | Export-Excel @exportExcelSplat -ExcelPackage $pkg
        }
        Close-ExcelPackage -ExcelPackage $pkg -Verbose
    }
    [void] ExportCsv () {
        <#
        writes to:

            $global:PathsExcel.export_PayloJsonCache
            $global:PathsExcel.export_step0
            $global:PathsExcel.export_step0_raw
            $global:PathsExcel.export_step1
        #>
        # moved to export before and after distinct
        # write cache to disk
        __writeDot FileIO
        $exportConfig = $script:ExportConfig
        $ExportConfig | bdgLog -Message 'ExportCsv: ExportConfig == ' -Category Verbose

        try {
            ($this.strCounts() ) -replace '\r\n', ', '
            | bdgLog -Category Verbose -Message '=> ExportCsv : before changes' -PassThru
            | Write-Host
        }
        catch {
            $this.FailedRequestSummary.Add(@{
                    kind    = 'ExportError'
                    Message = 'ExportCsv(): {0}' -f @( $_.Exception.ToString()  )
                    # json = @{ Ex = $_.Exception.ToString() } | ConvertTo-Json -Compress                # json = $errData
                })

            Write-Verbose $_
        }

        #         ($ .PayloExports ).count
        # ($eis.PayloExports | ?{ $_.IsEmployeeActive() }).count

        # $this.SaveEmployeeNumbers()   # [global]: is removing cache?

        if ( -not $global:paylo_JsonCache ) {
            # if ( -not $global:paylo_JsonCache ) {
            Write-Error -ea stop 'unexpected not-existing cache: $global:paylo_JsonCache'
        }
        $global:paylo_JsonCache.SaveToFile( $global:PathsExcel.export_PayloJsonCache ) #   # [global]: is removing cache?

        if ($true) {
            # $ErrorActionPreference = 'break'

            $coNum0 = $this.EmployeeNumbers[0].companyId
            $coNum1 = $this.EmployeeNumbers[1].companyId

            $EmployeeNumberSummary = @(
                # | s -First 4
                $this.EmployeeNumbers[0].employeeList
                | Add-Member -NotePropertyName 'companyId' -NotePropertyValue $coNum0 -Force -PassThru -ea ignore

                $this.EmployeeNumbers[1].employeeList
                # | s -First 4
                | Add-Member -NotePropertyName 'companyId' -NotePropertyValue $coNum1 -Force -PassThru -ea ignore
            )

            __writeDot FileIO
            $EmployeeNumberSummary
            | ConvertTo-Csv
            | Set-Content -Path $global:AppConf.Cache.EmployeeNumberSummary

            $global:AppConf.Cache.EmployeeNumberSummary | Get-Item | ForEach-Object FullName
            | bdgLog -Message 'exportCsv: EmployeeNumberSummary' -Category CacheEvent -PassThru | Write-Host
        }


        # if ($this.PayloExports) { # this should be good enough but get ToString() errors
        if ($true -and $this.PayloFull.count -gt 0) {
            $this.PayloExports
            | ConvertTo-Csv
            | Set-Content -Path $global:PathsExcel.export_payloFull

            'Wrote Export_PayloFull: <file:///{0}>' -f @(
                $global:PathsExcel.export_payloFull
            ) | bdgLog -Category ModuleEvent 'wote: PayloFull' -PassThru
            | Write-Host -ForegroundColor 'green'

        }
        if ($this.PayloExports -and ($this.PayloExports.count -gt 0) -and ($null -ne $this.PayloExports)) {


            if ($ExportConfig.Exports.Csv.Step0_raw ) {
                __writeDot FileIO

                $this.PayloExports
                | ConvertTo-Csv
                | Set-Content -Path $global:PathsExcel.export_step0_raw
            }

            $this._ensureFullTime()
            $this._ensureDistinct()

            if ($ExportConfig.Exports.Step0 ) {

                __writeDot FileIO
                $this.PayloExports
                | ConvertTo-Csv
                | Set-Content -Path $global:PathsExcel.export_step0
            }

            $null = 0
        }
        else {
            Write-Warning 'Could not export csv: empty list: $this.PayloExports, ensure $eis.PostCtor() has ran'
            write-warning "ensure update doesn''t regress: $PSCommandPath"
            return
        }

        $global:PathsExcel.export_step0
        | bdgLog -Message 'exportCsv: step0' -Category CacheEvent -PassThru #| write-verbose

        __writeDot FileIO

        if ($this.JCUpdateCsv) {
            if ($ExportConfig.Exports.Csv.Step1) {
                $this.JCUpdateCsv
                | ConvertTo-Csv
                | Set-Content -Path $global:PathsExcel.export_step1
            }
        }
        else {
            Write-Warning 'Could not export csv: empty list: $this.JCUpdateCsv, ensure $eis.PostCtor() has ran'
            return
        }

        $global:PathsExcel.export_step1
        | bdgLog -Message 'exportCsv: step1' -Category CacheEvent -PassThru
        #| write-verbose

        # __writeDot Complete
        $ErrorActionPreference = 'continue'
    }
}

function b.debug.dumpEnvVars {
    [CmdletBinding()]
    param(
        [string[]]$ExtraExclude,
        [switch]$All
    )
    [Collections.Generic.List[Object]]$KeysToExclude = @(
        'ALLUSERSPROFILE', 'APPDATA', # 'ChocolateyInstall', 'ChocolateyLastPathUpdate', 'ChocolateyToolsLocation',
        # 'CLASS_EXPLORER_TRUE_CHARACTER',
        'CommonProgramFiles', 'CommonProgramFiles(x86)',
        'CommonProgramW6432',
        'COMPUTERNAME',
        'ComSpec', 'DriverData', 'FP_NO_HOST_CHECK', 'HOMEDRIVE', 'HOMEPATH',
        'LOCALAPPDATA', 'LOGONSERVER', 'MSMPI_BENCHMARKS', 'MSMPI_BIN',
        'Nin_PSModulePath', 'NUMBER_OF_PROCESSORS', # 'OneDrive', 'OneDriveConsumer',
        # 'OS', 'Path', 'PATHEXT',
        'POWERSHELL_DISTRIBUTION_CHANNEL', 'PROCESSOR_ARCHITECTURE',
        'PROCESSOR_IDENTIFIER', 'PROCESSOR_LEVEL', 'PROCESSOR_REVISION',
        'ProgramData', 'ProgramFiles',
        'ProgramFiles(x86)', 'ProgramW6432',
        'PSModulePath',
        'PUBLIC', 'SystemDrive', 'SystemRoot',
        'TEMP',
        'TMP', #'USERDOMAIN', 'USERDOMAIN_ROAMINGPROFILE',
        #'USERNAME', 'USERPROFILE',
        'VS120COMNTOOLS', 'VS140COMNTOOLS', 'windir',
        'WSLENV', 'WT_PROFILE_ID', 'WT_SESSION'
    )

    # $KeysToExclude.AddRange([object[]]@(
    $KeysToExclude.AddRange(@(
            $ExtraExclude
        ))
    $keysToExclude = $keysToExclude | Sort-Object -Unique -Stable

    Get-ChildItem env: | Where-Object Key -NotIn $KeysToExclude
    #  | select key, value | to->json -Compress
    | ForEach-Object { @( $_.key ; $_.value; ) -join ' = ' }
    | Join-String -sep "`n" -op "EnvVars:`n"
    # | Write-Verbose

    if ($All) {
        Get-ChildItem env: | Where-Object Key -NotIn $KeysToExclude
        #  | select key, value | to->json -Compress
        | ForEach-Object { @( $_.key ; $_.value; ) -join ' = ' }
        | Join-String -sep "`n" -op "EnvVars:`n"
        # | Write-Verbose

    }
}

function b.New-PayloRestResponseRecord {
    <#
    .SYNOPSIS
        transforms the response from PayloRest-GetEmployee into a PayloExportRecord
    .EXAMPLE
        $resp ??= PayloRest-GetEmployee  -companyId 13294 -employeeId 13029
        $resp | b.New-PayloRestResponseRecord
    #>
    [OutputType('PayloExportRecord')]
    [CmdletBinding()]
    param(
        [Alias('InputObject')]
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PayloRestResponse
    )
    process {
        [PayloExportRecord]::new( $PayloRestResponse )
    }
}

function b.module.GetTypeInfo {
    <#
    .SYNOPSIS
        debug export of inner definitions
    #>
    param(
        [Parameter(Mandatory)]
        [validateSet('PayloExportRecord', 'InfoStateStats', 'EmployeeInfoState')]
        [string]$TypeName
    )
    switch($TypeName) {
        'PayloExportRecord' {
            [PayloExportRecord]
        }
        'InfoStateStats' {
            [InfoStateStats]
        }
        'EmployeeInfoState' {
            [EmployeeInfoState]
        }
        'JCUserUpdate_CsvRecord' {
            [JCUserUpdate_CsvRecord]
        }
        default {
            throw "UnhandledParam: $TypeName"
        }
    }
}
# $resp ??= PayloRest-GetEmployee  -companyId 13294 -employeeId 13029
# [PayloExportRecord]::new( $resp )

Export-ModuleMember -Function @(
    'b.module.GetTypeInfo'
    'b.New-PayloRestResponseRecord'
    'b.AddSheet'
    'b.conditionalFormat.applyDefaultFormatting'
    'b.conditionalFormat.boolean'
    'b.conditionalFormat.notBlankToAll'
    'b.copyWorkBook'
    'b.debug.dumpEnvVars'
    'c5.NewFinalJumpObj'
    'd1.NewFinalJumpObj'
    'x.enumerateWorksheetNames'
    'x.enumerateWorksheets'
    'x.selectWorksheet'
    'xl.conditionalFormat.Gen2.notBlankToAll'
    'xl.conditionalFormat.notBlank'
)

write-warning 'reached end of emp state🍌'
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\employee_infostate.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\paylo_exportRecord.ps1 #>
# using namespace System.Collections.Generic
# using namespace System.Management.Automation

class PayloExportRecord {
    # structured file for the CSV JC expectes for UserUpdate
    <#
        structured file for the CSV JC expectes for UserUpdate
    #>
    # [ValidateNotNullOrEmpty()]
    [string]$alternateEmail = ''
    [string]$companyName = ''

    [string]$preferredName = ''
    [string]$firstName = ''
    [string]$lastName = ''
    [string]$middleName = ''
    [string]$username = ''

    [string]$costCenter1 = ''
    [string]$costCenter2 = ''
    [string]$costCenter3 = ''
    [string]$employeeId = ''
    [string]$companyId = '' # set by caller


    # [string]$employeeState = '' #      # not sure if set
    [string]$employeeType = ''         # 'RFT' fulltime
    [string]$employeeStatus = ''        # T like terminated, Active

    # [string]$work_location = ''  # [MaybeRemoveAttr()]
    [string]$home_streetAddress = ''
    [string]$home_city = ''
    [string]$home_state = ''
    [string]$home_country = ''
    [string]$home_postalCode = ''
    [string]$home_email = ''
    [string]$home_mobilePhone = ''

    [string]$jobTitle = ''

    [string]$Location = '?'

    [string]$mobile_number = ''

    [string]$managerCo = ''
    [string]$managerId = ''
    [string]$manager = ''

    [string]$work_location = ''  # [MaybeRemoveAttr()]
    [string]$work_streetAddress = ''
    [string]$work_city = ''
    [string]$work_state = ''
    [string]$work_country = ''
    [string]$work_postalCode = ''

    # alias WorkEmail ?
    [string]$workEmail = ''
    [string]$work_mobilePhone = ''

    #not yet
    [string]$ChangeReason
    [Nullable[Datetime]]$effectiveDate
    [Nullable[Datetime]]$hireDate
    [Nullable[Datetime]]$terminationDate


    [string] GetGuid () {
        # this should be adistinct
        return $this.username # previously was: WorkEmail
    }

    [EmployeeIdPair] GetKeyIdPair () {
        if ( (-not $this.companyId) -or (-not $this.employeeId)) {
            write-error "Missing EmpId or CoId: $this"
            return $null

            # throw "Missing EmpId or CoId: $this"
            # return
        }
        return [EmployeeIdPair]::new($this.companyId, $this.employeeId)
    }

    PayloExportRecord ([object]$JsonObject) {
        if ($JsonObject -is 'string') {
            $JsonObject = $JsonObject | ConvertFrom-Json -Depth 8
        }


        $this.home_streetAddress = $JsonObject.homeAddress.address1
        $this.home_city = $JsonObject.homeAddress.city ?? ''
        $this.home_state = $JsonObject.homeAddress.state ?? ''
        $this.home_country = $JsonObject.homeAddress.country ?? ''
        $this.home_postalCode = $JsonObject.homeAddress.postalCode ?? ''
        $this.home_mobilePhone = $JsonObject.homeAddress.mobilePhone ?? ''
        $this.home_email = $JsonObject.homeAddress.emailAddress ?? ''
        $this.work_streetAddress = $JsonObject.workAddress.address1
        $this.work_city = $JsonObject.workAddress.city
        $this.work_state = $JsonObject.workAddress.state
        $this.work_country = $JsonObject.workAddress.country
        $this.work_postalCode = $JsonObject.workAddress.postalCode
        $this.work_location = $JsonObject.workAddress.location
        $this.companyId = $JsonObject.companyId

        $this.employeeId = $JsonObject.employeeId

        $domain = if ($this.companyId -eq '89849') {
            'wmagazine.com'
        }
        elseif ($this.companyId -eq '13294') {
            'bustle.com'
        }
        else {
            # 'error'
            $msg = "Domain for Company not known: $($this.companyId) is not in [89849,13294]"
            write-verbose $msg
            # throw $msg
        }
        if($this.username -match 'cody.manker') {
            wait-debugger
        }

        # wait-debugger

        function cleanup.RemoveWhitespaceAndQuotes {
            # removes quotes, and whitespace, allows '-'
            param( [string]$Name )
            $regexQuote = '["'']'
            $Name -replace '\s+', '' -replace $regexQuote, ''
        }
        # $this.firstName = Format-BlanksToDefault $JsonObject.firstName '' # <empty>'
        # $ErrorActionPreference = 'break'
        $this.firstName = cleanup.RemoveWhitespaceAndQuotes $JsonObject.firstName '' # <empty>'
        $this.preferredName = cleanup.RemoveWhitespaceAndQuotes $JsonObject.preferredName '' # <empty>'
        $this.lastName = cleanup.RemoveWhitespaceAndQuotes $JsonObject.lastName '' # <empty>'
        $this.middleName = cleanup.RemoveWhitespaceAndQuotes $JsonObject.middleName '' # <empty>'
        $this.work_mobilePhone = $JsonObject.workAddress.mobilePhone
        $this.work_mobilePhone = Format-BlanksToDefault $this.work_mobilePhone '' # <empty>'

        # warn and remove hyphen
        if ($this.preferredName -match '-') {
            $msg = 'User contains unexpected value: in: {0}' -f @(
                $this.username, $this.firstName, $this.lastName, $this.preferredName | Join-String -sep ', ' -DoubleQuote
            )
            bdgLog -Category Warn -PassThru -Message $msg
            | write-debug

            # throw $msg
            # $PSCmdlet.WriteError( [System.Management.Automation.ErrorRecord]::
            $this.preferredName -replace '-', ''
        }
        $preferenceName = $this.preferredName
        if ( [String]::IsNullOrEmpty( $preferenceName )) {
            $preferenceName = $this.firstName
        }

        if ( [String]::IsNullOrEmpty( $preferenceName )) {
            $ErrorActionPreference = 'break'
            # wait-debugger
            $ErrorActionPreference = 'continue'
            write-warning '[PayloExportRecord]: InvalidUsername: No Preference, No Firstname'
            # write-error -ea stop 'here'
            $ErrorActionPreference = 'continue'
            return
        }
        $This.username = '{0}.{1}' -f @(
            $preferenceName.ToLower()
            $this.lastName.ToLower()
        )
        # $This.username = $jsonobject
        $this.workEmail = '{0}@{1}' -f @(
            $this.username ?? ''
            $domain ?? ''
        )
        $ErrorActionPreference = 'continue'

        # if([string]::IsNullOrWhiteSpace( $this.work_mobilePhone) ) {
        #     $this.work_mobilePhone = '<missing>'
        #     # $this.work_mobilePhone = $JsonObject.emergencyContacts.mobilePhone | Join-String -sep ', ' -op 'emergency: ' { $_ }
        # }

        $this.employeeStatus = Format-BlanksToDefault $JsonObject.status.employeeStatus '' # <empty>'
        $this.companyName = Format-BlanksToDefault $JsonObject.companyName '' # <empty>'

        $this.Location = '{0}, {1}' -f @(
            $this.home_city
            $this.home_state
        )

        $this.costCenter1 = $JsonObject.departmentPosition.costCenter1
        $this.costCenter2 = $JsonObject.departmentPosition.costCenter2
        $this.costCenter3 = $JsonObject.departmentPosition.costCenter3
        $this.employeeType = $JsonObject.departmentPosition.employeeType
        $this.jobTitle = $JsonObject.departmentPosition.jobTitle
        $this.alternateEmail = $this.home_email

        $this.managerId = $JsonObject.departmentPosition.supervisorEmployeeId
        $this.managerCo = $JsonObject.departmentPosition.supervisorCompanyNumber
        $this.manager = '' # '<empty>' # set later by 'etchPaylo_Employee'

        $this.ChangeReason = $JsonObject.status.ChangeReason
        $this.effectiveDate = $JsonObject.status.effectiveDate
        $this.hireDate = $JsonObject.status.hireDate
        $this.terminationDate = $JsonObject.status.terminationDate

        if($this.username -match 'marilee.hodge'){
            # wait-debugger
        }


        if ( [string]::IsNullOrEmpty( $this.companyId) -or [string]::IsNullOrEmpty( $this.employeeId) ) {
            # bdgLog -Category DataIntegrity 'warning: '
            __writeDot Red
            'Employee is missing values: [Co = {0}, EmpId = {1}]' -f
            @(
                $this.companyId ?? '?'
                $this.employeeId ?? '?'
                $this | to->Json -Depth 5 -Compress -ea Ignore
            )
            | Write-Warning
        }
    }

    [string] ToString() {
        return ($this | ConvertTo-Json -Depth 12 -ea 'continue')
    }
    [bool] IsEmployeeActive() {
        return (b.TestIsEmployeeActive -InputObject $this)
        # Now: Rule is active must be 'A' and no TerminationDate
        # filter Terminated, LeaveOfAbsence, .#  "A", "L", "T", "XT", "D", "R"
        # Select by exclusion or inclusion?  ?
        # $this.employeeState -in @('A', 'L', 'T', 'XT', 'D', 'R' )
        # throw "Employee IsActive? requires new logic"
        # $hasActiveState = $this.employeeStatus -in @('A')
        # # $hasNoTermDate = $null -eq $this.terminationDate
        # $hasNoTermDate = [string]::IsNullOrWhiteSpace( $this.terminationDate )
        # $hasValidEmail = -not [string]::IsNullOrWhiteSpace( $this.workEmail )
        # $hasWorkEmail = -not [string]::IsNullOrWhiteSpace( $this.workEmail )
        # return [bool]($hasActiveState -and $hasNoTermDate -and $hasWorkEmail)

    }
    [bool] IsFulltimeEmployee () {
        # All otlher employee types should be ignored/dropped
        return (b.TestIsEmployeeFullTime -InputObject $this)
    }
}

class JCUserUpdate_CsvRecord {
    # structured file for the CSV JC expectes for UserUpdate
    <#
        structured file for the CSV JC expectes for UserUpdate
        class redundant,
        just use PayloExportRecord ?


        JC Names
            -email, -alternateEmail, -recoveryEmail

    #>

    [string]$Group1 = ''
    [string]$Group2 = ''
    [string]$Group3 = ''
    [string]$username = '' # else WorkAddress.EmailAddress
    [string]$email = '' # replace by renaming as 'email'
    [string]$alternateEmail = ''
    [string]$managerCo = ''
    [string]$managerId = ''
    [string]$manager = ''
    [string]$middleName = ''
    [string]$preferredName = ''
    [string]$jobTitle = ''
    [string]$employeeIdentifier = ''
    [string]$employment = ''
    [string]$Company = ''
    hidden [string]$companyId = ''  # duplicate: companyId, CostCenter
    [string]$employeeType = ''
    [string]$costCenter = '' # duplicate: companyId, CostCenter
    [string]$department = ''

    [string]$LastName = ''
    [string]$FirstName = ''



    [string]$location = ''
    # [SourceField='employeeId']

    [string]$recoveryEmail = ''

    # [string]$email = ''
    # [string]$description = '' # removed, unwanted in their JC


    # [string]$parentCompany = ''
    # [string]$employmentType = ''
    [string]$work_location = ''

    hidden [string]$costCenter1 = '' # => Department
    hidden [string]$costCenter2 = '' # => Employment
    hidden [string]$costCenter3 = '' # => Company Name

    [string]$EmployeeStatus = ''




    [string]$home_city = ''
    [string]$home_country = ''
    [string]$home_number = ''
    # [string]$home_poBox = ''
    [string]$home_postalCode = ''
    [string]$home_state = ''
    [string]$home_streetAddress = '' # JSUser in: addresses[1].streetAddress

    [string]$mobile_number = ''

    # [string]$work_city = ''
    # [string]$work_country = ''
    # [string]$work_fax_number = 'missing'
    [string]$work_mobilePhone = ''
    # [string]$work_number = ''
    # [string]$work_postalCode = ''
    # [string]$work_state = ''
    # [string]$work_streetAddress = '' # JSUser in: addresses[0].streetAddress



    [string]$work_city = ''
    [string]$work_country = ''

    # repla

    [string]$work_postalCode = ''
    [string]$work_state = ''
    [string]$work_streetAddress = ''

    # maybe try
    # [string]$work_fax_number = 'missing'
    # [string]$work_mobile_number = 'missing'
    # [string]$work_number = ''

    [Nullable[Datetime]]$terminationDate


    hidden [string]$Group4 = ''
    hidden [string]$Group5 = ''
    hidden [string]$Group6 = ''
    hidden [string]$Group7 = ''
    hidden [string]$Group8 = ''
    hidden [string]$Group9 = ''
    hidden [string]$Group10 = ''

    hidden [string[]]$HideColumns = @(
        'costCenter1'
        'costCenter2'
        'costCenter3'
    )


    JCUserUpdate_CsvRecord ([object]$Source ) {
        # todo: validate unique employee records
        if ([string]::IsNullOrWhiteSpace( $Source.workEmail )) {
            $SOurce
            | bdgLog -Category Warn 'Email Was Empty for [JCUserUpdate_CsvRecord].[workEmail], so skip it' -PassThru
            | Write-Warning
            return
        }
        $this.employment = '' #'<blank>'
        $this.department = $this.employment        # if( -not $IsMissingCo ) {
        # Maybelocation = deparment
        $this.location = $Source.department

        $this.FirstName = $Source.FirstName
        $this.LastName = $Source.LastName
        $this.MiddleName = $Source.MiddleName
        $this.preferredName = $Source.preferredName

        # $this.companyId = 'not set' # $Source.companyId
        $this.companyId = $Source.companyId
        $this.employeeIdentifier = $Source.employeeId
        $this.employeeType = $Source.employeeType


        $this.alternateEmail = $Source.home_email ?? '' #'<missing>'  # $Source.alternateEmail
        $this.jobTitle = $Source.jobTitle
        $this.terminationDate = $Source.terminationDate




        # $this.employmentType = $source.employeeType
        # $this.department = '{0}-{1}' -f @(
        #     $Source.costCenter2 ?? '?'
        #     $null ?? '(requires-export)'
        # )
        # $this.department = 'lookup: NY-New York' , set below

        $this.costCenter1 = $Source.costCenter1
        $this.costCenter2 = $Source.costCenter2
        $this.costCenter3 = $Source.costCenter3
        $this.company = $Source.companyName # => CostCenter3


        # $this.parentCompany = $Source.companyName


        $this.home_city = $Source.home_city
        $this.home_country = $Source.home_country
        $this.home_number = $Source.home_number
        # $this.home_poBox = $Source.home_poBox
        $this.home_postalCode = $Source.home_postalCode
        $this.home_state = $Source.home_state
        $this.home_streetAddress = $Source.home_streetAddress
        if ($false -and 'save fields not mapped') {
            $this.Group9 = $Source.location

        }
        # $this.mobile_number = $Source.mobile_number '' # double check

        # $this.work_fax_number    = $Source.work_fax_number ?? '?'
        $this.work_mobilePhone = $Source.work_mobilePhone
        $this.work_city = $Source.work_city
        $this.work_country = $Source.work_country
        # $this.workEmail = $Source.workEmail

        $this.email = $Source.WorkEmail
        if (-not ( [string]::IsNullOrWhiteSpace( $Source.username ) )) {
            $this.username
            'debug test, does username already exist? else grab workEmail'
            | Write-Debug
        }
        $this.username = @($this.email -split '@')[0]

        if($this.username -match 'marilee.hodge') {
            # wait-debugger
        }

        $this.work_location = $Source.work_location
        $this.work_postalCode = $Source.work_postalCode
        $this.work_state = $Source.work_state
        $this.work_streetAddress = $Source.work_streetAddress


        $this.Group2 = $Source.Group2
        $this.Group3 = $Source.Group3
        $this.Group4 = $Source.Group4
        $this.Group5 = $Source.Group5
        $this.Group6 = $Source.Group6
        $this.Group7 = $Source.Group7
        $this.Group8 = $Source.Group8
        $this.Group9 = $Source.Group9
        $this.Group10 = $Source.Group10

        'grab department for home or not'
        'ensure username is paylo, and email is set by me'

        ''
        '$this.username = $Null'



        $this.alternateEmail = $Source.alternateEmail
        $this.recoveryEmail = $Source.alternateEmail

        $this.managerCo = $source.managerCo
        $this.managerId = $source.managerId
        $this.manager = $source.manager
        $this.EmployeeStatus = $Source.employeeStatus
        # wait-debugger

        $isMissingCo = [string]::IsNullOrWhiteSpace( $Source.managerCo )
        if ($isMissingCo) {
            $msg = 'record missingCo for Employee: [Co: {0}, EmpId: {1}, {2} ]' -f @(
                ($this)?.company ?? '?'
                ($this)?.employeeIdentifier ?? '?'
                ($this)?.email ?? '?'
            )

            bdgLog -Category DataIntegrity -PassThru -Message $msg
            | Write-Error -ea 'continue'
        }



        if ($true) {
            # 'named block: employment'
            $getPaylo_CompanyResourceCodeSplat = @{
                companyId    = $Source.managerCo
                ResourceType = 'costCenter2'
                KeyName      = $Source.costCenter2
            }

            $fullEmploymentString = PayloRest_CompanyResourceCode @getPaylo_CompanyResourceCodeSplat
            if (-not $fullEmploymentString) {
                $fullEmploymentString ??= $Source.costCenter2
                "Missing managerCompany /w costCenter2 for user: $($Source.username)"
                | Write-Verbose
                # | write-error
            }
            $this.employment = $fullEmploymentString
            # 'named block: employment'
            $this.Group1 = $fullEmploymentString


            if ('named block: Company') {
                $getPaylo_CompanyResourceCodeSplat = @{
                    companyId    = $Source.managerCo
                    ResourceType = 'costCenter3'
                    KeyName      = $Source.costCenter3

                }

                $fullCompanyString = PayloRest_CompanyResourceCode @getPaylo_CompanyResourceCodeSplat
                <#
                this.company is being generated from costCenter3, if it is not found, else use the fullCompanyString
                #>
                if (-not $fullCompanyString) {
                    $fullCompanyString ??= $Source.costCenter3
                    "Missing managerCompany /w costCenter3 for user: $($Source.username)"
                    | Write-Verbose
                    # | write-error

                    $msg = 'fullCompanyString blank for user: {0}' -f @(
                        $this.username
                    )
                    bdglog -category DataIntegrity -Message $msg
                }
                $this.company = $fullCompanyString
                if([string]::isnullorwhitespace($this.company)) {
                    $msg = 'failed to set company, maybe it is: costCenter3 {0} for user: {1}' -f @(
                        $this.costCenter3
                        $this.username
                    )
                    | write-error
                    bdglog -category DataIntegrity -Message $msg

                }
            }
            if ('named block: department') {
                $getPaylo_CompanyResourceCodeSplat = @{
                    companyId    = $Source.managerCo
                    ResourceType = 'costCenter1'
                    KeyName      = $Source.costCenter1
                }

                $fullDepartmentString = PayloRest_CompanyResourceCode @getPaylo_CompanyResourceCodeSplat
                if (-not $fullDepartmentString) {
                    $fullDepartmentString ??= $Source.costCenter1
                    "Missing managerCompany /w costCenter1 for user: $($Source.username)"
                    | Write-Verbose
                    # | write-error
                }
                $this.department = $fullDepartmentString
            }

        }

        $this.costCenter = $this.companyId
    }

    # new
    [string] GetGuid () {
        # is a [JCUserUpdate_CsvRecord]
        return $this.email
    }
    [EmployeeIdPair] GetKeyIdPair () {
        if ( (-not $this.companyId) -or (-not $this.employeeId)) {
            write-error "Missing EmpId or CoId: $this"
            return $null
            # or one if partial exists?' [EmployeeIdPair]::new($this.companyId, $this.employeeIdentifier)
            # throw "Missing EmpId or CoId: $this"
            # return
        }
        return [EmployeeIdPair]::new($this.companyId, $this.employeeIdentifier)
    }

    [bool] IsEmployeeActive() {

        # FOr: [JCUserUpdate_CsvRecord]
        # Now: Rule is active must be 'A' and no TerminationDate
        # filter Terminated, LeaveOfAbsence, ...
        #  "A", "L", "T", "XT", "D", "R"
        # Select by exclusion or inclusion?  ?
        # $this.employeeState -in @('A', 'L', 'T', 'XT', 'D', 'R' )

        # $this.employeeState -in @('A', 'L', 'T', 'XT', 'D', 'R' )
        # $hasNoTermDate = $null -eq $this.terminationDate\

        return (b.TestIsEmployeeActive -InputObject $this)
        # $hasWorkEmail = -not [string]::IsNullOrWhiteSpace( $this.workEmail )
        # $hasActiveState = $this.employeeStatus -in @('A')
        # # actually, notes request: keep when term date?
        # $hasNoTermDate = [string]::IsNullOrWhiteSpace( $this.terminationDate )

        # return [bool]($HasWorkEmail -and $HasActiveState -and $hasNoTermDate)
    }

    [bool] IsFullTimeEmployee () {
        return (b.TestIsEmployeeFullTime -InputObject $this)
        # throw "Employee IsActive? requires new logic"
        # $isFull = @('TFT', 'RFT') -contains $this.employeeType
        # return $isFull
    }

    [object] TransformTo( [string]$TransformType ) {
        # edit: really should transform a new record, not itself
        # is [JCUserUpdate_CsvRecord]
        $ValidTypes = @('JCUpdate_WithIgnored', 'JCUpdate_WithoutIgnored')
        if ($ValidTypes -notcontains $TransformType) {
            $msg = @(
                'Invalid transformation type: ',
                'Expected values: '
                $ValidTypes | Join-String -sep ', ' -SingleQuote
            ) | Join-String
            bdgLog -msg $Msg -Category Warn -passThru
            | write-error
            return $this
        }

        switch ($TransformType) {
            # is [JCUserUpdate_CsvRecord]
            'JCUpdate_WithIgnored' {
                $obj = $this
                | Add-Member -PassThru -Force -ea 'ignore' -NotePropertyMembers @{
                    'description' = $this.JobTitle
                    'Guid'        = ($this)?.GetGuid()
                    'displayName' = $this.preferredName
                    'manager'     = $this.manager
                }
                return $obj
            }
            'JCUpdate_WithoutIgnored' {
                # is [JCUserUpdate_CsvRecord]
                # edit Face palm, yeah, parent has to do the removal
                $obj = $this
                # | ?{ $_.IsFulltimeEmployee() }
                # | ?{ $_.IsEmployeeActive() }
                # label 'should be this?'  | out-null
                | Add-Member -PassThru -Force -ea 'ignore' -NotePropertyMembers @{
                    # 'Guid' = ($_)?.GetGuid()
                    'wasEmployeeActive'   = $_.IsEmployeeActive()
                    'wasFulltimeEmployee' = $_.IsFullTimeEmployee()
                }

                return $obj
            }
            'JCUpdate_OutputIndexCache' {
                # is [JCUserUpdate_CsvRecord]
                # label 'should be this?' | Out-Null
                $obj = $this
                | Where-Object { $_.IsFulltimeEmployee() }
                | Where-Object { $_.IsEmployeeActive() }
                | Select-Object 'CompanyId', 'EmployeeId', 'WorkEmail', 'terminationDate', 'employeeType', 'employeeStatus'
                | Add-Member -PassThru -Force -ea 'ignore' -NotePropertyMembers @{
                    'Guid'                = ($_)?.GetGuid()
                    'wasEmployeeActive'   = $this.IsEmployeeActive()
                    'wasFulltimeEmployee' = $this.IsFullTimeEmployee()
                }
                return $obj
            }

            default { write-error "Unhandled type: $TransformType" }
        }

        return $this

    }

    [object] ConvertToCsv () {
        return ($this | Select-Object -ExcludeProperty 'companyId')

    }

    [string] ToString() {
        return ($this | ConvertTo-Json -Depth 6)
    }
}

class CachedEmployeeIndexRecord {
    # One *single* record?
    # [EmployeeIdPair]$IdPair
    # see: https://powershell.one/powershell-internals/attributes/transformation
    <#
        cache minimum metata, specifcally

            EmpId
            CoId
            Username
            WorkEmail (guid)
            IsFullTimeEmployee?
        #>

    [string]$UserName = ''

    # [ValidateNotNullOrEmpty()]
    [string]$CompanyId
    [string]$Department

    # [ValidateNotNullOrEmpty()]
    [string]$EmployeeId

    # [ValidateNotNull()]

    [string]$employeeType
    [string]$employeeStatus

    # [ValidateNotNullOrEmpty()]
    [string]$WorkEmail # alias guid

    # nullable
    [Nullable[datetime]]$terminationDate
    [Nullable[datetime]]$LastIndexedDate

    [bool]$wasActiveEmployee = $false
    [bool]$wasFullTimeEmployee = $false

    [bool] RequestShouldInclude () {

        <# inline validate test

            $this.GetEnumerator() | % Value
            | ?{ -not [string]::IsNullOrWhiteSpace( $_.WorkEmail ) }

        #>
        # unless active employee changes, should this normally fetch?
        Write-Warning 'Currently WIP, should parent decide or me? '
        # write-error -ea stop 'phased  out?'
        $isNotBlankEmail = -not [string]::IsNullOrWhiteSpace( $this.WorkEmail )
        return (
            $isNotBlankEmail -and $this.wasFullTimeEmployee -and $this.wasActiveEmployee -and ($null -eq $this.terminationDate)
        )
    }
    CachedEmployeeIndexRecord () {}

    [EmployeeIdPair] ToEmployeeIdPair () {
        try {
            return ([EmployeeIdPair]::new( $this.CompanyId, $this.EmployeeId ))
        }
        catch {
            return $null
        }
    }

    [String] ToString() {
        # still needs equality comp[are]
        return ($this.ToEmployeeIdPair())?.ToString()
    }

    [string] GetGuid() {
        # is a [CachedEmployeeIndexRecord]
        return $this.workEmail
    }

    CachedEmployeeIndexRecord ( [object]$Record ) {


        $this.UserName = $Record.UserName
        $this.CompanyId = $Record.CompanyId
        $this.EmployeeId = $Record.EmployeeId
        $this.employeeType = $Record.employeeType
        $this.employeeStatus = $Record.employeeStatus
        $this.WorkEmail = $Record.WorkEmail
        $this.Department = ($Record)?.Department ?? ($Record)?.CostCenter1
        $this.terminationDate = $Record.terminationDate
        $this.wasActiveEmployee = $Record.wasActiveEmployee
        $this.wasFullTimeEmployee = $Record.wasFullTimeEmployee
        $this.LastIndexedDate = $Record.LastIndexedDate ?? ([Datetime]::now)
        # 2022-10-03 : confirmed transform from object
        if ( -not $this.workEmail ) {
            # write-error "Other missing required workEmail"
            $Record
            | bdgLog -Category DataIntegrity 'ImportFrom: missing required workEmail'
        }
        # $this.LastIndexedDate = $Record.LastIndexedDate
    }

    CachedEmployeeIndexRecord ( [CachedEmployeeIndexRecord]$Other ) {
        if ($null -eq $Other) {
            Write-Error "CachedEmployeeIndexRecord::Ctor( `$Null ) "
            return
        }
        $this.UserName = $other.UserName
        $this.CompanyId = $other.CompanyId
        $this.EmployeeId = $other.EmployeeId
        $this.employeeType = $other.employeeType
        $this.employeeStatus = $other.employeeStatus
        $this.Department = ($other)?.Department
        $this.WorkEmail = $other.WorkEmail
        $this.terminationDate = $other.terminationDate
        $this.LastIndexedDate = $other.LastIndexedDate
        $this.wasActiveEmployee = $other.wasActiveEmployee
        $this.wasFullTimeEmployee = $other.wasFullTimeEmployee
        if ( -not $this.workEmail ) {
            # write-error "Other missing required workEmail"
            $other
            | bdgLog -Category DataIntegrity 'ImportFrom: missing required workEmail'
        }
        # 2022-10-03: confirmed transform
        $this.LastIndexedDate = $other.LastIndexedDate
    }
    CachedEmployeeIndexRecord ( [PayloExportRecord]$Record ) {
        $this.employeeType = $record.employeeType
        $this.employeeStatus = $record.employeeStatus
        $this.UserName = $record.username
        $this.CompanyId = $record.companyId
        $this.EmployeeId = $record.employeeId
        $this.WorkEmail = ($record)?.workEmail ?? ($record)?.work_email #?? $record.email
        $this.Department = ($Record)?.costCenter1 ?? ($Record)?.Department
        $this.wasFullTimeEmployee = $record.IsFulltimeEmployee()
        $this.wasActiveEmployee = $record.IsEmployeeActive()
        $this.terminationDate = $record.terminationDate
        $this.LastIndexedDate = [datetime]::Now
        # 2022-10-03 : validated transform
        if ( -not $this.WorkEmail ) {
            # write-error "record missing required workEmail" -ea SilentlyContinue
            $this | to->Json | from->Json
            | bdgLog -Category DataIntegrity -Message 'No work email for CachedEmployeeIndexRecord'
        }

    }
}

class EmployeeSummaryIndex {
    <#
        preserve summary stats to quickly ignore unwanted employees, or known bad records
    .example


    #>
    hidden [ValidateNotNull()][hashtable]$_index = @{}
    EmployeeSummaryIndex() {
        <#
        cache minimum metata, specifcally

            EmpId
            CoId
            Username
            WorkEmail (guid)
            IsFullTimeEmployee?
        #>
        Write-Warning 'skip loading esi'
        '📚 EmpSummaryIndex::ctor ==> skip loading esi ==>  bdg_lib\src_static\paylo_exportRecord.ps1/d7d40610-3655-446b-88ba-ece4ddd6c493' | Write-Warning
        # throw "left off"
        # <tmp:debugNull>:
        $this.LoadFromFile()
    }
    # [void] SetIndex ( [string]$KeyId,  [Object]$Record ) {
    [CachedEmployeeIndexRecord] GetIndex ( [string]$WorkEmail ) {
        # do not throw
        if ( -not $this._index.ContainsKey( $WorkEmail) ) {
            return $null
        }
        $query = $this._index[ $WorkEmail]
        $finalRecord = [CachedEmployeeIndexRecord]::new( $query )
        return $FinalRecord
        # 2022-10-03 confirmed transform
    }

    [string] LookupEmail( $CompanyId, $EmployeeId ) {
        # turn (Co, EmpId) to (user.@foo.ocm)
        # first force paylo fetch
        # then get transformed [PayloExports] WorkEmail
        $global:EmployeeInfoState.FetchPaylo_Employee( $CompanyId, $EmployeeId )
        $global:EmployeeInfoState._ensureDistinct()

        $query = $global:EmployeeInfoState.PayloExports
        | Where-Object {
            $_.companyId -eq $CompanyId -and $_.EmployeeId -eq $EmployeeId
        }
        a
        return $Query | Select-Object -First 1 | ForEach-Object WorkEmail
        return $Null
    }
    [EmployeeIdPair] LookupPayloEmpIdPair( [string]$WorkEmail ) {
        # [EmployeeIdPair]
        $query = $this.AsList()
        | Where-Object {
            $_.WorkEmail -match [regex]::escape( $WorkEmail )
            # $_.WorkEmail -match [regex]::Escape( 'eastman' ) }
        } | ForEach-Object {
            $_.ToEmployeeIdPair()
        }
        return $query
        # return $Null
    }

    [CachedEmployeeIndexRecord] LookupIndex( $CompanyId, $EmployeeId ) {
        $a = [String]::IsNullOrWhiteSpace( $CompanyId )
        $b = [String]::IsNullOrWhiteSpace( $EmployeeId )
        if ($a -or $b) {
            return $Null
        }
        if ($null -eq $CompanyId -or $null -eq $EmployeeId) {
            return $Null
        }
        $vals = $this._index.Values
        $vals | Where-Object { ($_.CompanyId -eq $CompanyId ) -and ($_.EmployeeId -eq $EmployeeId) }

        $query = $vals.GetEnumerator() | Where-Object { $_.CompanyId -eq $CompanyId -and $_.EmployeeId -eq $EmployeeId }
        return @($query)[0]
        # return @($Vals)[0]
    }
    [void] LoadFromFile() {
        # is [EmployeeSummaryIndex]
        $dest = $global:AppConf.Cache.EmployeeSummaryIndex
        # [optional]
        '📚 [EmpSummaryIndex]::LoadFromFile: ==> Try->Catch => bdg_lib\src_static\paylo_exportRecord.ps1/7590ad6-68ff-45ac-b8a9-92d6f2836948' | Write-Warning
        '📚 LoadFromFile ==> other ==>  bdg_lib\src_static\paylo_exportRecord.ps1/377de41c-5d59-4241-a03f-affebcf6aa1c' | Write-Warning
        try {
            $null = 0

            $json = Get-Content (Get-Item $global:AppConf.Cache.EmployeeSummaryIndex)
            | ConvertFrom-Json -AsHashtable -Depth 6

            $json.Values | ForEach-Object {
                $record = [CachedEmployeeIndexRecord]::new( $_ )
                $this.SetIndex( $record )

                $record.WorkEmail
                | bdgLog -Category CacheEvent -Message 'LoadFromFile: Added'
            }

            # $dest # coerces to a massive json doc, because of fileinfo
            # | bdgLog 'Loaded: EmployeeSummaryIndex'
        }
        catch {
            $msg = "📚 [EmpSummaryIndex]::LoadFromFile ==> error Loading cache!.event '  bdg_lib\src_static\paylo_exportRecord.ps1/c624efad-9e04-4c76-9b74-83b8b7506f2b"
            $msg | Write-Warning

            $_.Exception.Message.ToString()
            | bdgLog -Message $msg -Category Warn
        }
        '📚 [EmpSummaryIndex]::LoadFromFile: ==> completed => bdg_lib\src_static\paylo_exportRecord.ps1/'
    }
    [void] SaveToFile( [string]$path ) {
        # is [EmployeeSummaryIndex]
        $msg = '📚 [EmpSummaryIndex]::SaveToFile ==> path = {0}  bdg_lib\src_static\paylo_exportRecord.ps1/c624efad-9e04-4c76-9b74-83b8b7506f2b' -f @($Path)
        $msg | Write-Verbose

        $dest = $Path
        Write-Warning "save: $dest" | Write-Host
        $this._index | to->Json -Depth 3 | Set-Content -Path $dest
        $dest | bdgLog 'Saved: EmployeeSummaryIndex'
        # $this.SaveToFile( $Dest )
    }
    [void] SaveToFile() {
        # is [EmployeeSummaryIndex]
        $dest = $global:AppConf.Cache.EmployeeSummaryIndex
        $this.SaveToFile( $dest )
    }

    [CachedEmployeeIndexRecord[]] GetRequestShouldIncludeList () {
        $query = @($this.GetEnumerator()
            | Select-Object -exp value
            | Where-Object {
                $_.RequestShouldInclude()

            })

        Write-Warning 'next: hyi'
        return $query
        # RequestShouldInclude
    }
    [int] TotalCount () {
        # Number of records
        $c = 0
        try {
            $c = @($this._index.keys).count
        }
        catch {
            $c = 0
        }

        return $c
    }

    [void] SetIndex ( [object]$Record ) {
        # argument expected to be transformable to a [CachedEmployeeIndexRecord]
        if ( -not $Record -or [string]::IsNullOrEmpty($Record) ) {
            return
        }
        if (
            [string]::IsNullOrWhiteSpace( $Record.UserName ) -or
            [string]::IsNullOrWhiteSpace( $Record.EmployeeId )) {
            return
        }

        if ($null -eq $Record) { return }
        [CachedEmployeeIndexRecord]$cei_value = [CachedEmployeeIndexRecord]::new( $Record )
        $KeyId = $cei_value.WorkEmail
        if ( [String]::IsNullOrWhiteSpace($KeyId) ) {
            return
        }
        # if($Record -is 'CachedEmployeeIndexRecord') {
        #     # 2022-10-03 : transform confirmed
        # } else {
        #     $record.pstypenames | Join-String -sep ', ' -op 'Need to validate other types: '
        # if($cei_value.UserName -notmatch 'allia.alliata di montereale') {
        #     $x = $Null
        # }

        #     | write-warning
        # }
        # throw 'before cei'
        # "set index ${record}" | Write-debug -ForegroundColor purple

        $this._index[ $KeyId ] = $cei_value
    }

    [object[]] TransformTo( [string]$TransformType ) {
        # is [EmployeeSummaryIndex]
        # Convert to tabular shape for excel exprts
        $ValidTypes = @('Excel')
        if ($ValidTypes -notcontains $TransformType) {
            $msg = @(
                'Invalid transformation type: ',
                'Expected values: '
                $ValidTypes | Join-String -sep ', ' -SingleQuote
            ) | Join-String
            bdgLog -msg $Msg -Category Warn
            throw $Msg
        }

        switch ($TransformType) {
            # is [EmployeeSummaryIndex]
            'Excel' {

                [object[]]$records = $this.GetEnumerator()
                | ForEach-Object { [pscustomobject]$_.Value }
                # | Add-Member -PassThru -Force -ea 'ignore' -NotePropertyMembers @{
                #     'description' = $_.JobTitle
                #     'displayName' = $_.preferredName
                #     'manager'     = $_.manager
                # }
                return $records
            }
            default { throw "UhandledTransformType: $TransformType" }
        }
        return @()
    }

    [object] GetEnumerator() {
        # might actually wan this to return Select -extract Value to iterate insances
        return $this._index.GetEnumerator()
    }

    [Collections.Generic.List[object]] AsList() {
        # when you want a list, not an enumerator
        [Collections.Generic.List[object]]$result = @(
            $this._index.GetEnumerator() | ForEach-Object Value
            | Sort-Object -prop WorkEmail -Unique )
        return $result
    }

    [string] AsCsv() {
        return ($this.GetEnumerator()
            | Select-Object -exp value | ConvertTo-Csv)
    }
    [string] ToString() {
        return ($this._index | ConvertTo-Json -Depth 6 )
    }
}



# Export-ModuleMember -Function @(
#     # 'b.NewFinalJumpObj'
# )



# return
# class CachedJCIndexRecord {
class CachedJCIndexRecord {
    # single JumpCloud Cached Record
    <#
        .SYNOPSIS
        instances used by [JCSummaryIndex]

    #>
    # [EmployeeIdPair]$IdPair
    # see: https://powershell.one/powershell-internals/attributes/transformation
    <#

        $me | select -Property  $props

        account_locked           : False
        company                  : BDG Media
        costCenter               : 2000
        employeeIdentifier       : 33333
        enable_managed_uid       : False
        displayname              : Joe deer
        firstname                : Joe
        lastname                 : deer
        username                 : jdeer
        mail                     :
        password_expiration_date : 11/22/2022 5:22:10 PM

    #>
    <#
        old version
                    [string]$Email

                    [string]$company       # ex:
                    [string]$costCenter
                    [string]$UserName = ''

                    # Alias: employeeId
                    [string]$employeeIdentifier
                    [string]$displayName
                    [string]$firstName
                    [string]$lastName


                    [string]$department
                    [string]$employeeType
                    [string]$first
    #>
    [string]$employeeType       # ex: RFT
    [string]$costCenter         # department
    [string]$employeeStatus     # ex: A (active)
    [string]$email              # <user>
    [string]$username           # <user>
    [string]$company            # BDG Media
    [string]$displayname        # john
    [string]$firstname          # John
    [string]$lastname           # deer
    [string]$wasActiveEmployee          # $true
    [string]$wasFullTimeEmployee #$true
    [string]$jobTitle
    [string]$employeeIdentifier # 2134
    # [bool]$wasActiveEmployee = $false
    # [bool]$wasFullTimeEmployee = $false


    [Nullable[datetime]]$terminationDate
    [Nullable[datetime]]$LastIndexedDate # when was I indexed? (not a JC value)


    [bool] RequestShouldInclude () {

        <# inline validate test

            $this.GetEnumerator() | % Value
            | ?{ -not [string]::IsNullOrWhiteSpace( $_.email ) }

        #>
        # unless active employee changes, should this normally fetch?
        Write-Warning 'rsi?'
        $isNotBlankEmail = -not [string]::IsNullOrWhiteSpace( $this.email )
        return (
            $isNotBlankEmail -and $this.wasFullTimeEmployee -and $this.wasActiveEmployee -and ($null -eq $this.terminationDate)
        )
    }


    [EmployeeIdPair] ToEmployeeIdPair () {
        # is called
        return ([EmployeeIdPair]::new( ($this)?.Company, ($this)?.employeeIdentifier ))
    }

    [String] ToString() {
        # still needs equality comp[are]
        $render = '[CachedJCIndexRecord {0} ]' -f @(
                ($this)?.ToEmployeeIdPair() ?? '(?,?)'
        )
        return $render
    }

    [string] GetGuid() {
        return $this.email
    }
    [void] LoadFromType ( $Object, $SchemaTypeName ) {
        <#
            SchemeTypeName is != Object.TypeName

            SchemaTypeName := 'PayloExportRecord', 'CachedJCIndexRecord', 'Hashtable','Any'

            TyepeName is the schema, does not have to be the *actual* type of object
        #>
        if ($Null -eq $Object) {
            Write-Warning 'Object is Null!'
            return
            # throw "Object is Null!"
        }

        function __handlePayloExportRecord {
            # transform: new [CachedJCIndexRecord] from [PayloExportRecord]
            if ( [string]::IsNullOrEmpty( $this.email )) {
                $Other
                | bdgLog -Category Warn 'missing email column: Expected: [CachedJCIndexRecord].Email != blank'
            }

            $this.company = ($Other)?.company
            $this.costCenter = ($Other)?.costCenter
            $this.displayname = ($Other)?.displayname
            $this.email = ($Other)?.email
            $this.employeeIdentifier = ($Other)?.employeeIdentifier
            $this.employeeStatus = ($Other)?.employeeStatus
            $this.employeeType = ($Other)?.employeeType
            $this.firstname = ($Other)?.firstname
            $this.jobTitle = ($Other)?.jobTitle
            $this.LastIndexedDate = ($Other)?.LastIndexedDate ?? $null
            $this.lastname = ($Other)?.lastname
            $this.terminationDate = ($Other)?.terminationDate
            $this.username = ($Other)?.username
            $this.wasActiveEmployee = ($Other)?.wasActiveEmployee
            $this.wasFullTimeEmployee = ($Other)?.wasFullTimeEmployee

        }
        function __handleCachedJCIndexRecord {

            # transform: new [CachedJCIndexRecord] from [CachedJCIndexRecord]
            # $this.employeeStatus      = $record.employeeStatus
            # $ErrorActionPreference = 'break'
            $this.company = $record.company
            $this.costCenter = $record.costCenter
            $this.displayname = $record.displayname
            $this.email = $record.email
            $this.employeeIdentifier = $record.employeeIdentifier
            $this.employeeStatus = $record.employeeStatus
            $this.employeeType = $record.employeeType
            $this.firstname = $record.firstname
            $this.jobTitle = $record.jobTitle
            $this.LastIndexedDate = $Record.LastIndexedDate ?? $null
            $this.lastname = $record.lastname
            $this.terminationDate = $record.terminationDate
            $this.UserName = $record.username
            $this.wasActiveEmployee = $record.wasActiveEmployee
            $this.wasFullTimeEmployee = $record.wasFullTimeEmployee
            $ErrorActionPreference = 'continue'
        }

        function __handleObjectFromHash {

            $this.employeeIdentifier = ($Object)?.EmployeeId
            $this.costCenter = ($Object)?.CompanyId
            $this.LastIndexedDate = ($object)?.LastUpdate
            $this.wasActiveEmployee = ($Object)?.wasActiveEmployee
            $this.wasFullTimeEmployee = ($Object)?.wasFullTimeEmployee
            $this.employeeType = ($Object)?.employeeType
            $this.costCenter = ($Object)?.costCenter
            $this.employeeStatus = ($Object)?.employeeStatus
            # $this.email               = ($Object)?.WorkEmail ?? ($Object)?.Email
            $this.email = ($Object)?.WorkEmail ?? ($Object)?.WorkEmail
            $this.UserName = ($Object)?.UserName
            $this.company = ($Object)?.company
            $this.displayname = ($Object)?.displayname
            $this.firstname = ($Object)?.firstname
            $this.lastname = ($Object)?.lastname
            $this.company = ($object)?.Department
            $this.displayname = ($object)?.displayname
            $this.firstname = ($object)?.firstname
            $this.lastname = ($object)?.lastname
            $this.jobTitle = ($Object)?.jobTitle
            $this.wasActiveEmployee = ($Object)?.wasActiveEmployee
            $this.wasFullTimeEmployee = ($Object)?.wasFullTimeEmployee
            $this.employeeIdentifier = ($Object)?.employeeId
            $this.terminationDate = ($Object)?.terminationDate
            $this.LastIndexedDate = ($Object)?.LastIndexedDate
        }

        switch ($SchemaTypeName) {
            'CachedJCIndexRecord' { __handleCachedJCIndexRecord }
            'PayloExportRecord' { __handlePayloExportRecord }
            'Hashtable' { __handleObjectFromHash }
            'Any' { __handleObjectFromHash }

            default { throw "UnhandledTypeName: $SchemaTypeName, Expected: ('PayloExportRecord', 'CachedJCIndexRecord', 'Hashtable', 'Any') " }
        }
    }


    CachedJCIndexRecord ( [object]$Object ) {
        <#
                Called when parsing Get-JCUser type (which has no type )
        #>
        if ($null -eq $Object) {
            # throw "Object is null"
            Write-Verbose 'Invalid Ctor, ObjectIsNull'
            return
        }
        if ( ($Object)?.GetType().Name -eq 'CachedJCIndexRecord') {

            $this.LoadFromType( $Object, 'CachedJCIndexRecord' )
            return
        }
        if ( ($Object)?.GetType().Name -eq 'PayloExportRecord') {
            $this.LoadFromType( $Object, 'PayloExportRecord' )
            return
        }

        $this.LoadFromType( $Object, 'Any')
    }
}


class JCSummaryIndex {
    <#
    .SYNOPSIS
        summarizes and caches JumpCloud results
    .NOTES
        manages [JCSummaryIndex]
    .example

        $jsi.GetIndex('jbolton@dev.bustle.com')
        $jsi.AsCsv()


    #>
    hidden [ValidateNotNull()][hashtable]$_index = @{}
    hidden [Collections.Generic.List[object]]$_cachedKnownNotInJC = @()

    JCSummaryIndex() {
        <#
        cache minimum metata, specifcally

            EmpId
            CoId
            Username
            email (guid)
            IsFullTimeEmployee?
        #>
        # throw "left off"
        # throw "left off"
        $this.LoadFromFile()
    }
    # [void] SetIndex ( [string]$KeyId,  [Object]$Record ) {
    [CachedJCIndexRecord] GetOrFetchIndex ( [string]$email ) {
        $result = $this.GetOrFetchIndex( $email, $false )
        # $result -is 'CachedJCIndexRecord' | write-debug
        return $result
    }

    [Collections.Generic.List[object]] GetKnownMissingIdList (  ) {
        # currencly cached dnown list
        return $this._cachedKnownNotInJC
    }

    [object] GetOrFetchRawJCRecord ( [string]$WorkEmail) {
        return $this.GetOrFetchRawJCRecord( $WorkEmail, $true )
    }
    [object] GetOrFetchRawJCRecord ( [string]$WorkEmail, $forceClear) {

        if ($this._cachedKnownNotInJC.Contains( $WorkEmail ) ) {
            "GetOrFetchIndex: requestedKnownInvalidUser: `$this._cachedKnownNotInJC.Contains( $WorkEmail )"
            | Write-Warning
            return $Null
        }

        if ($ForceClear) {
            # $this._index.Remove( $WorkEmail )
            $this._cachedKnownNotInJC.Remove( $WorkEmail )
            "Cleared _index and _knownBad from the cache: where query = '$WorkEmail'"
            | Write-Debug
        }

        #   try {
        if ($global:AppConf.Verbosity.MuteGetJCUser) {
            $query = Get-JCUser -email $workEmail -Debug:$false -Verbose:$false 4>$null #5>$null # super verbosy
        }
        else {
            $query = Get-JCUser -email $workEmail -Debug:$true -Verbose:$true #5>$null # super verbosy
        }
        if ($null -eq $query) {
            $this._cachedKnownNotInJC.Add( $workEmail )
            return $null
        }
        return $query
    }
    [CachedJCIndexRecord] GetOrFetchIndex (
        # [ValidateNotNull()] # test on, may not work
        [string]$email,
        [bool]$ForceClear
    ) {
        # Does it exist yet?
        # or force the request, skip cache
        # do not throw
        if ($this._cachedKnownNotInJC.Contains( $email ) ) {
            "GetOrFetchIndex: requestedKnownInvalidUser: `$this._cachedKnownNotInJC.Contains( $email ) "
            | Write-Warning
            return $Null
        }

        if ( -not $Email ) { return $null }
        $query = $this.GetIndex( $email )
        if ($query -and ($query -isnot 'CachedJCIndexRecord')) {
            b.Label 'Datatype' '$query isnot [CachedJCIndexRecord]'
            | Write-Warning
        }
        if ( $ForceClear ) {
            $query = $Null
        }
        if ( $query ) {
            return $query
        } # good request, unless flushed

        # if ( -not $this._index.ContainsKey( $email) ) {
        #     return $null
        # }
        # return ($this._index[ $email] )
        if ($ForceClear) {
            $this._index.Remove( $email )
            $this._cachedKnownNotInJC.Remove( $email )
            "Cleared _index and _knownBad from the cache: where query = '$email'"
            | Write-Debug
        }
        if (-not $Query) {
            # wait-debugger
        }

        if (-not $Query -or $ForceClear) {
            # shouldn't be valid for any other case currently?
            "Missing JCQuery: '$email' (forced: $ForceClear)"
            # | StripAnsi
            | bdgLog -Category CacheEvent 'missing or stale JSQuery' -PassThru
            | Write-Warning

            # $query = Get-JCUser -email $email -debug:$false -verbose:$false 4>$null 5>$null # super verbosy
            # try {
            if ($global:AppConf.Verbosity.MuteGetJCUser) {
                $query = Get-JCUser -email $email -Debug:$false -Verbose:$false 4>$null #5>$null # super verbosy
            }
            else {
                $query = Get-JCUser -email $email -Debug:$true -Verbose:$true #5>$null # super verbosy
            }
            if ($null -eq $query) {
                $this._cachedKnownNotInJC.Add( $email )
            }
            # }catch {
            Write-Warning "Err: $_"
            # write-error "Err: $_"
            return $Null
            #  }
            $cacheRecord = [CachedJCIndexRecord]::new( $query )


            $this.SetIndex( $cacheRecord )
            # $this.SetIndex( $query )

            #                 $query = $global:JCSummaryIndex.SetIndex( $query )
            #                 "Missing JCQuery: $curEmail"
            #                 | label 'JCQuery'
            #                 | bdgLog -Category CacheEvent 'missing or stale JSQuery' -PassThru
            #                 | write-host
        }
        # gross but ensures transform is not missed
        return $this.GetIndex( $email )
        # return $Null # should never
    }

    [CachedJCIndexRecord] GetIndex ( [string]$email ) {
        # do not throw
        # this can triggger error on stats
        if ($this._cachedKnownNotInJC.Contains( $email ) ) {
            "requestedKnownInvalidUser: $email"
            | Write-Warning

            return $null
        }

        if ( -not $this._index.ContainsKey( $email) ) {
            return $null
        }
        $lookup = $this._index[ $email]
        $asTyped = [CachedJCIndexRecord]::new( $lookup )
        return $asTyped
    }
    [CachedJCIndexRecord] LookupIndex( $CompanyId, $EmployeeId ) {
        # query if user email is unknown
        $isEmpty = 0 -eq $this._index.keys.count
        if ($isEmpty) {
            return $Null
        }
        $query = $this.AsList()
        | Where-Object { $_.costCenter -eq $CompanyId -and $_.employeeIdentifier -eq $EmployeeId }

        return $query
    }
    [void] LoadFromFile() {
        $dest = $global:AppConf.Cache.JCSummaryIndex
        Write-Warning "attempt load: $dest" | Write-Host

        $dest = $global:AppConf.Cache.EmployeeSummaryIndex
        Write-Warning "attempt load: $dest" | Write-Host
        $json = Get-Content $global:AppConf.Cache.EmployeeSummaryIndex
        | from->Json -AsHashtable

        $json.Values | ForEach-Object {
            if ( $null -eq $_) {
                continue
            }
            try {
                $record = [CachedJCIndexRecord]::new( $_ )
                $this.SetIndex( $record )
            }
            catch {
                $_.Exception.Message
                | bdgLog -Message 'Error loading cache record!' -Category Warn
            }

            $record.Email
            | bdgLog -Category CacheEvent -Message 'LoadFromFile: Added'
        }

        # $dest | bdgLog 'Loaded: EmployeeSummaryIndex'
    }
    [void] SaveToFile() {
        $dest = $global:AppConf.Cache.JCSummaryIndex
        $this.SaveToFile( $dest )
    }
    [void] SaveToFile( [string]$Path ) {
        $dest = $Path
        Write-Warning "save: '$dest'" | Write-Host
        $this._index | to->Json -Depth 3 -Compress | Set-Content -Path $dest
        $dest | bdgLog 'Saved: JCSummaryIndex'
        # $this.SaveToFile( $Dest )
    }
    [Collections.Generic.List[object]] AsList() {
        # $ErrorActionPreference = 'break'
        # when you want a list, not an enumerator
        # write-warning 'should actually be [Collections.Generic.List[CachedJCIndexRecord]]'
        [Collections.Generic.List[object]]$result = @(
            $this._index.GetEnumerator() | ForEach-Object Value
            | Sort-Object -prop Email -Unique )

        # $ErrorActionPreference = 'continue'
        return $result
    }
    [CachedJCIndexRecord[]] GetRequestShouldIncludeList () {
        Write-Warning "NYI: 'GetRequestShouldIncludeList' , duplicate implementation"
        Write-Warning "next: '$PSCommandPath'"


        return @()
        $query = $this.AsList()
        | Where-Object {
            $true
        }

        return $query
    }
    [int] TotalCount () {
        # Number of records
        return @($this._index.keys).count
    }

    [void] SetIndex ( [object]$Record ) {
        if ($null -eq $Record) {
            bdgLog -Category Verbose -Message 'NullValueException: [JCSummaryIndex].SetIndex( $null )'
            write-error "SetIndex: null record: $PSCommandPath"
            return
        }
        if (-not $Record) {
            Write-Error 'empty value' -ea 'break' # temp
            write-error "SetIndex: null record: $PSCommandPath"
            Return
        }
        # wait-debugger
        # argument expected to be transformable to a [CachedJCIndexRecord]
        # try {
        # $cei_value = [CachedJCIndexRecord]::new( $Record )
        # } catch {
        # $_ | Label 'bad' | write-warning
        # }
        $cei_value = [CachedJCIndexRecord]::new( $Record )
        <#$
            [CachedJCIndexRecord]
        #>

        if (
            -not($cei_value -is 'CachedJCIndexRecord') -and (
                ($cei_value)?.GetType().Name -ne 'CachedJCIndexRecord') -and (
                $cei_value -as 'CachedJCIndexRecord' -isnot 'CachedJCIndexRecord'
            )
            # ($cei_value.value)?.GetType().Name -ne 'CachedJCIndexRecord' )
        ) {
            'isnotCachedRecord? {0} = {1}' -f @(
                ($cei_Value)?.GetType().Name ?? '?'
                $cei_value | ConvertTo-Json -Depth 1 -Compress
            )
            | Write-Error
            return
            # throw "BadStuff $PSCommandPath"
            # throw "`$cei_value -isNot 'CachedJCIndexRecord'"
            # $null  = 0
        }
        $KeyId = $cei_value.email
        if ( [String]::IsNullOrWhiteSpace($KeyId) ) {
            return
        }

        $this._index[ $KeyId ] = $cei_value
        $null = 0
    }

    [object[]] TransformTo( [string]$TransformType ) {
        # Convert to tabular shape for excel exprts
        $ValidTypes = @('Excel')
        if ($ValidTypes -notcontains $TransformType) {
            $msg = @(
                'Invalid transformation type: ',
                'Expected values: '
                $ValidTypes | Join-String -sep ', ' -SingleQuote
            ) | Join-String
            $msg | bdgLog -msg "TransformTo: '$TransformType'" -Category Warn -passTHru
            | Write-warning
            # throw $Msg
            write-error $Msg
            return @()
        }

        switch ($TransformType) {
            'Excel' {

                [object[]]$records = $this.GetEnumerator()
                | ForEach-Object { [pscustomobject]$_.Value }
                | ForEach-Object {
                    $_ | Add-Member -PassThru -Force -ea 'ignore' -NotePropertyMembers @{
                        'description' = $_.JobTitle
                        'Guid'        = ($_).GetGuid()
                        'displayName' = $_.preferredName
                        'manager'     = $_.manager
                    }
                }
                # | Add-Member -PassThru -Force -ea 'ignore' -NotePropertyMembers @{
                #     'description' = $_.JobTitle
                #     'displayName' = $_.preferredName
                #     'manager'     = $_.manager
                # }
                return $records
            }
            default { throw "UhandledTransformType: $TransformType" }
        }
        return @()
    }

    [object] GetEnumerator() {
        # might actually wan this to return Select -extract Value to iterate insances
        return $this._index.GetEnumerator()
    }
    [string] AsCsv() {
        return ($this.GetEnumerator()
            | Select-Object -exp value | ConvertTo-Csv )
    }
    [string] ToString() {
        return ($this._index | ConvertTo-Json -Depth 6 -Compress )
    }
}

function type.PayloExportRecord {
    param(
        [object]$Input,
        [switch]$PassThru
    )
    if ($PassThru) { return [PayloExportRecord] }

    [PayloExportRecord]::new( $InpuT )
}
# CachedJCIndexRecord {
function type.JCSummaryIndex {
    param(
        [object]$Input,
        [switch]$PassThru
    )
    if ($PassThru) { return [JCSummaryIndex] }

    [CachedJCIndexRecord]::new( $InpuT )
}

Export-ModuleMember -Function @(
    'type.PayloExportRecord'
    'type.JCSummaryIndex'
)

# class FinalJumpProps {

# }
# $jc_me = Get-JCUser -email '*jbolton*'
# [CachedJCIndexRecord]::new( $jc_Me )
# h1 'inside test' | write-warning

<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\paylo_exportRecord.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part0.ps1 #>
$script:__enableVerboseJCApi ??= $false

$PSDefaultParameterValues['ConvertTo-Json:Depth'] = 8
$PSDefaultParameterValues['ConvertFrom-Json:Depth'] = 8
# "`n`n#### -> Enter BDG_lib"

# if($script:__enableVerboseJCApi) {

    #See also: <$global:AppConf.Verbosity.MuteGetJCUser)>
if(-not  $ENV:enable_global_verbose) {
    "disabled many default verbose ==>  bdg_lib\src_static\root_entry_part0.ps1/5e6b62ee-c04b-41be-b421-579a062e99fd" | write-verbose -verbose
    $global:PSDefaultParameterValues['Set-JCUser:Verbose'] = $true
} else {
    "enabled many default verbose ==>  bdg_lib\src_static\root_entry_part0.ps1/5e6b62ee-c04b-41be-b421-579a062e99fd" | write-verbose -verbose
    $PSDefaultParameterValues['Connect-JCOnline:Verbose'] = $script:__enableVerboseJCApi
    $PSDefaultParameterValues['Set-JCOrganization:Verbose'] = $script:__enableVerboseJCApi
    $PSDefaultParameterValues['Get-JCType:Verbose'] = $script:__enableVerboseJCApi
    $PSDefaultParameterValues['Get-JCObject:Verbose'] = $script:__enableVerboseJCApi
    $PSDefaultParameterValues['Invoke-JCApi:Verbose'] = $script:__enableVerboseJCApi
    $PSDefaultParameterValues['Get-JCUser:Debug'] = $script:__enableVerboseJCApi
    $PSDefaultParameterValues['Get-JCUser:Verbose'] = $script:__enableVerboseJCApi
    $global:PSDefaultParameterValues['Get-JCUser:Debug'] = $script:__enableVerboseJCApi
    $global:PSDefaultParameterValues['Get-JCUser:Verbose'] = $script:__enableVerboseJCApi
    $global:PSDefaultParameterValues['Set-JCUser:Verbose'] = $script:__enableVerboseJCApi
    $global:PSDefaultParameterValues['Set-JCUser:Debug'] = $script:__enableVerboseJCApi
}
    # $global:PSDefaultParameterValues['Invoke-JCApi:Ea'] = 'break'
    # $PSDefaultParameterValues['Invoke-JCApi:Ea'] = 'break'
    # $global:PSDefaultParameterValues['Invoke-JCApi:Ea'] = 'continue'
    # $PSDefaultParameterValues['Invoke-JCApi:Ea'] = 'continue'
# }

function B.ToastIt {
    # mini sugar using defaults, and easier no-depend
    # [Alias(b.ToastIt')]
    [CmdletBinding()]
    param(
        [parameter()]
        [string[]]$Text,

        [string]$Title,

        # [string]$Sound #
        [switch]$NotSilent
    )
    $textList = @(
        if ($title) { $title }
        $Text | Join-String -sep "`n"
    )

    $splatIt = @{
        # The parameter requires at least 0 value(s) and no more than 3
        Text   = $TextList ?? '<NoText>'
        Silent = $true
    }
    if( -not (get-module BurntToast )) {
        $textList | Join-String -sep "`n" -op 'toast: ' | write-verbose
        return # soft dependency
    }
    if ($NotSilent) { $SplatIt.Silent = $False }
    try { New-BurntToastNotification @splatIt } catch { 'Toast: Notify Skipped' | write-verbose  }
}


function Test-IsLocalDev {
    # for now, sugar to disable when not on local vs dev vs prod
    return ($PSVersionTable.os -match 'windows')
}
# [int]$script:hardMaxRequests = 0
$ignoreErr = @{ ErrorAction = 'ignore' }
# Clear-Host
@(
    Set-Alias @ignoreErr 'sc' -Value 'set-content'
    Set-Alias @ignoreErr 'to->Json' -Value 'ConvertTo-Json'
    Set-Alias @ignoreErr 'to->Csv' -Value 'ConvertTo-Csv'
    Set-Alias @ignoreErr 'from->Json' -Value 'ConvertFrom-Json'
    Set-Alias @ignoreErr 'from->Csv' -Value 'ConvertFrom-Csv'
)

Export-ModuleMember -Alias 'sc', 'to->Json', 'to->Csv', 'from->Json', 'from->Csv'
<#
    potential lost exports:
        C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\always-mini.partial_only2.ps1
        C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part2.ps1
#>

# [hashtable]$script:itemsToExport = @{ # scope: might need global for dotsource, or not?
[hashtable]$global:itemsToExport = @{ # scope: might need global for dotsource, or not?
    Variables = @(
        # newest
        # 'ExportExcelCfg'
        # 'ExportConfig'
        # ...
        'JumpCloudGroupMapping'
        'envAPI'
        'EmployeeTypeMapping'
        '_LastAlreadyConnected'
        '__responseId'
        'LocalDB'
        # new
        'liveDB'

        # debug vars
        'paylo_JsonCache'
        'manualCache'
        'manualStep2'
        # 'DbgCfg'
        'dbg_empStep0'
        # [new and confirmed includes from refactor]
        'AppConf'
        'EmployeeInfoState'
        'EmployeeSummaryIndex'
        'JCSummaryIndex'
        'PathsExcel'
        '__writeDotOptions'
        '__writeDotEnabled'
        'ExistInBothTable'
    ) | Sort-Object -Unique -Stable
    Functions = @(
        # newer
        'b.ToastIt'
        #
        'BDG_ExportAllCsv'
        'BasicDiff'
        'hashFromObj'
        'InitializeJumpCloud'
        'InitializeBDG'
        'writeSem'
        'ResponseCacheObject'
        'resetRespCache'
        'b.iterProps'
        'getSemColor'
        '_excelAddSheet'
        '_excel-AutosizeColumns'
        'b.newExcelBook' # old:# '_excelResetSheet' # no
        # new
        'Err'
        'Paylo-GetNewIdentity'
        'PayloAPI-RefreshState'
        'iter_CompanyIds'
        # 'liveDB_SaveState'
        # 'liveDB_Stats'
        # 'liveDB_UpdateEmployeeInfo'
        # 'liveDB_LoadState'
        '_fmtError'
        'BDG_ExportExcelDebugSheet'
        # rest
        # [new and confirmed includes from refactor]
        '_mainEntryPoint' # disable
        'PayloRest-GetAllEmployees'
        'PayloRest-GetEmployee'
        '__writeDot'
        'bdgLog'
        'dropBlankKeys'
        'b.compareStringSet'
        # excel

        'b.copyExcel'
        'b.SafeFiletimePath'
        'b.debug.GrabJsonCache'

        'b.GenerateExistSummaryTable'
        # new
        'b.fm'
        'b.wrapLikeWildcard'
        'b.ReplaceIfBlank'
        'formatBlankText'
        'Format-BlanksToDefault'
        'b.New-EmployeeIdPair'
        'EmployeeIdPair'
        'b.New-EmployeeIdPair'



    ) | Sort-Object -Unique -Stable
    Aliases   = @(
        'b.Dict'
        'b.newExcelBook'
        'b.CoalesceBlanks' # 'b.ReplaceIfBlank'
    ) | Sort-Object -Unique -Stable
    # Functions
}
# [hashtable]$global:itemsToExport = $script:itemsToExport

$global:ExportExcelCfg = @{ # specifically for ExportExcelDebug()
    Imports = @{
        JumpCloud = $true
        query_jcNow_raw = $false # $true
    }
    Exports = @{
        Csv = @{
            AlwaysExportCsvFirst = $false
        }
        Json = @{}
        WorkSheet = @{
            LastToCompareReference = $true
            csv_WithoutIgnored = $false
            export_finalStatic_JCImport = $true
            FromPaylo = $true
            FromJC = $true
            FromJC_raw = $true
            JCIndexCache = $true
            IndexCache = $true
            ExistSummaryTable = $true
            ChangesSummaryTable = $true
        }
    }
}


$script:ExportConfig = @{ # specifically for: ExportCsv()
        Exports = @{
            Csv = @{
                Step0_raw = $false
                Step0 = $false
                Step1 = $false
            }
            Json = @{
                export_json_step0 = $false
                export_debug_step1 = $false

            }
        }

    }




<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part0.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part1.ps1 #>
# using namespace System.Collections.Generic
$importStyle = @{ ErrorAction = 'SilentlyContinue' }
# $ImportStyle.ErrorAction = 'Ignore'
# Import-Module @importStyle '../../ImportExcel'
# Import-Module @importStyle '../../JumpCloud'
Import-Module 'ImportExcel' -verbose:$false -DisableNameChecking
 # Import-Module @importStyle 'JumpCloud'
# $importStyle = @{ ErrorAction = 'SilentlyContinue' }
# $ImportStyle.ErrorAction = 'Ignore'
# Import-Module @importStyle '../../ImportExcel'
# Import-Module @importStyle '../../JumpCloud'
# Import-Module @importStyle 'ImportExcel'
# Import-Module @importStyle 'JumpCloud'
# Import-Module -ea 'continue' './ImportExcel'

if($ENV:enable_global_verbose) {
    $PSDefaultParameterValues['Connect-JCOnline:Force'] = $true
    $PSDefaultParameterValues['Connect-JCOnline:verbose'] = $true
    $script:PSDefaultParameterValues['Connect-JCOnline:verbose'] = $true
}
# $script:PSDefaultParameterValues['*:verbose'] = $true
# $script:PSDefaultParameterValues['Add-Content:verbose'] = $false
# $script:PSDefaultParameterValues['Set-Content:verbose'] = $false


function InitializeJumpCloud {

    <#
    .synopsis
        Import-Module JumpCloud , enables verbose mode on **all** functions
    #>
    # verbose on all jumpcloud funcs
    param(
        [switch]$SuperVerboseMode = $true
    )
    '📚 InitializeJumpCloud ==> init =>    bdg_lib\src_static\root_entry_part1.ps1/0fea5ba3-c026-4a75-8c0c-405912fe9902' | Write-Warning

    # $global:bad = Get-Content -ea 'ignore' (Get-Item -ea 'continue' $global:AppConf.JumpCloudEnv )
    if ($ENV:enable_global_verbose -and $superVerboseMode) {
        '📚 enabled ==> jumpcloud: super verbose all:  bdg_lib\src_static\root_entry_part1.ps1/6b417e2a-b1fb-4539-a108-faf102f51d77' | Write-Warning
        Get-Command -Module JumpCloud
        | ForEach-Object Name
        | ForEach-Object {
            $curKey = $_, ':', 'verbose' -join ''
            $script:PSDefaultParameterValues[ $curKey ] = $true
            $global:PSDefaultParameterValues[ $curKey ] = $true
        }
    }

    $global:JCAPIKey = $Env:JCAPIKEY = 'bc5ae14fbc58bb7b9be7ce6950c040be3a4b656b'
    # if ($null -eq $x) {
    Write-Warning '🤖refactor env var cred'
    Connect-JCOnline $env:JCAPIKEY -force -Verbose -Debug
    return

    # if ($Null -eq $global:AppConf.JumpCloudEnv) {
    #     Write-Error '"$global:AppConf.JumpCloudEnv" was missing'
    # }


    # $env:JCAPIKEY = Get-Content -ea 'continue' (Get-Item -ea 'continue' $global:AppConf.JumpCloudEnv )
    # if ($null -eq $ENV:JCAPIKEY) {
    #     Write-Warning '🤖refactor env var cred'
    #     Write-Verbose '🤖refactor env var cred'

    # }

    # # __writeDot Processing

    # if ($false -and (Test-IsLocalDev)) {


    #     $Env:JCAPIKey = 'bc5ae14fbc58bb7b9be7ce6950c040be3a4b656b'
    #     $global:Env:JCAPIKey = 'bc5ae14fbc58bb7b9be7ce6950c040be3a4b656b'
    #     if ($null -eq $Env:JCAPIKey) {
    #         Write-Warning ' ==> InitializeJumpCloud() : Env:JCApiKey not set'
    #         # todo: test only
    #     }
    #     else {
    #         Write-Verbose ' ==> InitializeJumpCloud() : intialized JC'
    #     }
    #     # __writeDot Complete
    #     ' ==> InitializeJumpCloud() : Waiting on jump....' | Write-Warning

    #     $VerbosePreference = 'continue'
    #     if ( -not $Env:JCAPIKEY) { Write-Warning ' ==> InitializeJumpCloud() : hardcoded local override, move' } {
    #         $Env:JCAPIKey = 'bc5ae14fbc58bb7b9be7ce6950c040be3a4b656b'
    #     }
    #     #
    #         $VerbosePreference = 'silentlycontinue'

    #         '📚 InitializeJumpCloud ==> exit =>    bdg_lib\src_static\root_entry_part1.ps1/0fea5ba3-c026-4a75-8c0c-405912fe9902' | Write-Warning
    #     }
    #     # return
    #     # throw "was here earliser"

    #     if ('maybe obsolete') {
    #         [hashtable]$script:LocalDB = @{}
    #         [hashtable]$script:LiveDB = @{}
    #     }
    #     # [Collections.Generic.List[PayloExportRecord]]$script:LiveDB_EmployeeInfo = @()
    #     [Collections.Generic.List[Object]]$script:LiveDB_EmployeeInfo = @()
}

function b.iterProps {
    <#
    .SYNOPSIS
        enumerateProperties
    .NOTES
        todo: expected output
            $this.SourceLeft | b.iterProps -AsString

            # epects this to be equal even if it's not correct
            b.iterProps -AsString $this.SourceLeft
    #>
    [OutputType('System.Management.Automation.PSPropertyInfo')]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        # enumerate properties as strings, instead of member info
        [Alias('AsName')]
        [switch]$AsString
    )
    process {
        if ($AsString) {
            return ($InputObject.PSObject.Properties | Sort-Object Name | ForEach-Object Name)
        }

        return ($InputObject.PSObject.Properties | Sort-Object Name)
    }
}

class basicDiffSingleResult {
    # stores two values, their key names, and if changed
    [ValidateNotNullOrEmpty()]
    [string]$Name

    [bool]$ExactlyEqual
    [object]$Left #old
    [object]$Right #new
    [bool]$ExistsLeft
    [bool]$ExistsRight
    [bool]$IsBlankLeft
    [bool]$IsBlankRight
    [bool]$IsTrueNullLeft
    [bool]$IsTrueNullRight
    [bool]$HasChanged

    # singleDeltaResult( $)
    basicDiffSingleResult ($Name, $Left, $Right ) {
        $this.Name = $Name
        $this.ExactlyEqual = $Left -eq $Right
        $this.Left = $Left
        $this.Right = $Right
        $this.ExistsLeft = -not ($null -eq $left)
        $this.ExistsRight = -not ($null -eq $right)
        $this.IsBlankLeft = [string]::IsNullOrWhiteSpace( $Left )
        $this.IsBlankRight = [string]::IsNullOrWhiteSpace( $Right )
        $this.IsTrueNullLeft = $null -eq $Left
        $this.IsTrueNullRight = $null -eq $Right
        $this.HasChanged = -not $this.isEqual()
    }
    basicDiffSingleResult ($Name, $Left, $Right, $ExistsLeft, $ExistsRight ) {
        $this.Name = $Name
        $this.ExactlyEqual = ($Left -eq $Right) #-and ($Right -eq $Left)
        $this.Left = $Left
        $this.Right = $Right
        $this.ExistsLeft = $ExistsLeft -or (-not ($null -eq $left))
        $this.ExistsRight = $existsRight -or (-not ($null -eq $right))
        $this.IsBlankLeft = [string]::IsNullOrWhiteSpace( $Left )
        $this.IsBlankRight = [string]::IsNullOrWhiteSpace( $Right )
        $this.IsTrueNullLeft = $null -eq $Left
        $this.IsTrueNullRight = $null -eq $Right
        $this.HasChanged = -not $this.isEqual()

    }
    # [bool] HasChanged() { return $this.isEqual() } # coulld be script property
    [bool] isEqual() {
        return $this.Left -eq $this.Right
    }
    [bool] isEqualAndExisted() {
        return [bool]@(
            $this.isEqual() -and $this.ExistsLeft -and $this.ExistsRight
        )
    }
}

function basicDiff {
    <#
    .SYNOPSIS
        sugar for compare-object like usage
    .EXAMPLE
        basicDiff (gi .) (gi ..) | ? HasChanged
        basicDiff (gi .) (gi ..) | ? -not HasChanged
    .NOTES
        option to allow 'blanks' to be considered equal
    #>
    [OutputType('basicDiffSingleResult')]
    [CmdletBinding()]
    param(
        # should allow ignoring nulls?
        # [AllowNull()]
        [Alias('Left', 'Old')]
        [Parameter(Mandatory)]$Object1,
        #
        # [AllowNull()]
        [Alias('Right', 'New')]
        [Parameter(Mandatory)]$Object2,

        [string]$AddNameColumn,

        # filter
        [switch]$OnlyDifferent

    )

    $emptyObj = [pscustomobject]@{}
    $Object1 ??= $emptyObj
    $Object2 ??= $emptyObj
    # [Collections.Generic.List[singleDeltaResult]]$allResults = @()
    [Collections.Generic.List[object]]$allResults = @() # just to make sure this isn't breaking
    # $meta | bdgLog -Message '-> Delta::CalculateDelta()' -Category Verbose
    # Write-Warning 'find which item, skipping step, assuming left and right are the final (ie: original) target'

    # [bool]$isSameKeyIdTarget = $this.SourceLeft.email -eq $this.SourceRight.email
    [string[]]$leftProps = @($Object1 | b.iterProps -AsString)
    [string[]]$rightProps = @($Object2 | b.iterProps -AsString)
    $potentialPropNames = @(
        $leftProps
        $rightProps
        # $Object1 | b.iterProps -AsString
        # $Object2 | b.iterProps -AsString
        # b.iterProps -InputObject
    ) | ForEach-Object tostring | Sort-Object -Unique

    $results = $potentialPropNames | ForEach-Object {
        $curPropName = $_
        $ExistInLeft = @($LeftProps) -contains $curPropName
        $ExistInRight = @($rightProps) -contains $curPropName

        # ($Name, $Left, $Right, $ExistsLeft, $ExistsRight ) {
        $obj = [basicDiffSingleResult]::new(
            $CurPropName,
            $Object1.$CurPropName,
            $Object2.$curPropName,
            $ExistInLeft,
            $ExistInRight
        )
        # $obj | fl | out-string | write-debug -debug
        # $null = 0
        $obj
    }
    if ( -not [String]::IsNullOrWhiteSpace( $AddNameColumn )) {
        $results | ForEach-Object {
            $_ | Add-Member -NotePropertyMembers @{
                Label = $AddNameColumn
            } -Force -ea Ignore -PassThru
        } # order
        | Select-Object Label, * -ea ignore
    }

    if ($OnlyDifferent) {
        $results | Where-Object HasChanged
        return
    }

    return $results
}

function hashFromObj {
    <#

    .notes
        Depedencies: none
    #>
    [Alias('b.Dict')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )

    $meta = [ordered]@{}
    $InputObject.PSObject.Properties | ForEach-Object {
        $Key = $_.Name
        $Value = $_.Value
        $meta[ $key ] = $value
    }
    return $meta
}


function ErrBdg {
    param( [switch]$Clear )
    if ($Clear) { $global:error.Clear() }
    return $global:error
}


function b.SafeFiletimePath {
    <#
    .SYNOPSIS
        timenow for safe filepaths: "2022-08-17_12-46-47Z"
    .notes
        distinct values to the level of a full second
    #>

    (Get-Date).ToString('u') -replace '\s+', '_' -replace ':', '-'
}


function b.compareStringSet {
    # todo: multiple ambigious overloads
    param(
        [ValidateNotNullOrEmpty()]
        [string[]]$ListA,

        [ValidateNotNullOrEmpty()]
        [string[]]$ListB

        # [switch]$ForceSensitive
    )

    # if(-not $ForceSensitive) {
    #     $ListA = $ListA | % ToLower
    #     $ListB = $ListB | % ToLower
    # }

    $results = [ordered]@{}
    $SetA = [HashSet[string]]::new( [string[]]$ListA, [StringComparer]::InvariantCultureIgnoreCase )
    $SetB = [HashSet[string]]::new( [string[]]$ListB, [StringComparer]::InvariantCultureIgnoreCase )

    $SetA.IntersectWith( $setB )
    $results['Intersect'] = $SetA

    $SetA = [HashSet[string]]::new( [string[]]$ListA, [StringComparer]::InvariantCultureIgnoreCase )
    $SetB = [HashSet[string]]::new( [string[]]$ListB, [StringComparer]::InvariantCultureIgnoreCase )

    # $SetA -notin $results.Intersect
    $results.'RemainingLeft' = $SetA | Where-Object {
        $results.'Intersect' -notcontains $_
    }
    $results.'RemainingRight' = $SetB | Where-Object {
        $results.'Intersect' -notcontains $_
    }

    [pscustomobject]$Results

    # [hashset[string]]::new( [string[]]('a', 'b')
}

# b.compareStringSet 'af', 'b' -ListB @('af', 'e')





# [Dictionary[EmployeeIdKey, String]]$global:paylo_JsonCache = [Dictionary[EmployeeIdKey, String]]::new()
class PayloJsonCache {
    # cache JSON before the ETL is applied
    [Collections.Generic.List[object]]$records = @()
    [int]$SleepStepSizeMs = 1 #10


    PayloJsonCache () {}
    [void] LoadFromFile() {
        $Dest = Get-Item -ea stop (Join-Path $global:appConf.prefixRootActual 'output\PayloJsonCache.json' )
        $this.LoadFromFile( $Dest )
    }
    [void] SaveToFile() {
        $Dest = Get-Item -ea stop (Join-Path $global:appConf.prefixRootActual 'output\PayloJsonCache.json' )
        $this.SaveToFile( $Dest )
    }
    [void] SaveToFile( [string]$Filename ) {
        $This.Records | ConvertTo-Json -AsArray -Depth 8 -Compress | Set-Content -Path $Filename
        bdgLog -Category CacheEvent "PayloJsonCache::SaveToFile: $Filename"
    }

    [void] LoadFromFile( [string]$Filename ) {
        [Collections.Generic.List[object]]$cache = @(
            Get-Content -Raw (Get-Item $FileName) | ConvertFrom-Json -Depth 8
        )
        if ($cache.count -gt 0) {
            $this.records = $cache
        }
        $this.records = $Cache
        bdgLog -Category CacheEvent "PayloJsonCache::LoadFromFile: $Filename"
        # $this.records.getTYpe() | out-host
        # still right type
    }
    [bool] RemoveCachedValue( $Co, $EmployeeId ) {
        if ($Co -notin (iter_CompanyIds)) { throw "Invalid Co: $Co" }
        $target = $this.records
        | Where-Object { $_.companyId -eq $Co }
        | Where-Object { $_.employeeId -eq $employeeId }
        if ($Target) {
            $this.PayloExports.Remove( $target )
            return $true
        }
        else {
            return $false
        }
    }
    [void] SetCachedValue( $Co, $EmployeeId, $Payload) {

        $msg = "SetCachedValue( $Co, $EmployeeId )"
        | bdgLog -Category CacheEvent '[PayloJsonCache]::SetCachedValue'

        # $msg | write-host

        if ($Co -notin (iter_CompanyIds)) { throw "Invalid Co: $Co, $EmployeeId," ; return; }
        # adding always replaces existing value
        if ($Payload -is 'string') {
            throw 'Expected To Cache as JSON string'
            return
        }
        # $ErrorActionPreference = 'break'
        if ( -not $co ) {
            $x = $null
            throw 'NullCo'
        }
        if ( -not $EmployeeId ) {
            $x = $null
            throw 'NullEmp'
        }
        $payloadText = $payload | ConvertTo-Json -Depth 8
        # $this.RemoveCachedValue($Co, $EmployeeId) # [global]: is removing cache?

        $Payload | Add-Member -NotePropertyName 'companyId' -NotePropertyValue $Co -Force -PassThru -ea ignore | Out-Null


        $maybeRecord = @{
            employeeId = $EmployeeId
            companyId  = $Co
            data       = $Payload
            lastUpdate = Get-Date
        }
        if ($maybeRecord) {
            $this.records.add(  $maybeRecord )

        }
    }

    [object] GetCachedValue( $Co, $EmployeeId) {
        if ( ($null -eq $Co) -or ($null -eq $EmployeeId)) {
            return $null
        }
        if ($Co -notin (iter_CompanyIds)) {
            Write-Error "Invalid Co: $Co, requestBy $EmployeeId"
            return $null
        }
        $query = $this.records
        | Where-Object { $_.companyId -eq $Co }
        | Where-Object { $_.employeeId -eq $employeeId }
        | Select-Object -First 1
        #| Select-Object -First 1

        if ($Query ) {
            return $Query.data
            # return $Query
        }
        return $null
    }
    [void] ClearCache() { $This.ClearCache( $false ) }
    [void] ClearCache( [bool]$ForceFlushFiles ) {
        # clear all cached values
        $this.records.Clear()
        if ($ForceFlushFiles) {
            # maybe dont' truncate files
            $this.SaveToFile( $global:PathsExcel.export_PayloJsonCache )
            $this.SaveToFile()
        }
    }
}
if ( -not (Test-Path $global:PathsExcel.export_PayloJsonCache)) {
    New-Item -Path $global:PathsExcel.export_PayloJsonCache -ItemType File
}

$global:paylo_JsonCache = [PayloJsonCache]::New()
# if ($AppConf.Debug_AlwaysEmptyJsonCache) {
#     Write-Warning '$AppConf.Debug_AlwaysEmptyJsonCache = $true'
#     $global:paylo_JsonCache.ClearCache()
# }
$global:paylo_JsonCache.LoadFromFile( $global:PathsExcel.export_PayloJsonCache )
# $global:paylo_JsonCache.SaveToFile( $global:PathsExcel.export_PayloJsonCache )


# $AppConf.LLogPath ??= (Join-Path $tempAppRoot 'log/main.log')

$silentMode = @{
    ErrorAction = 'ignore'
    # ErrorAction = 'ignore'
}
$msg = 'skipCacheOnContainer? {0}' -f @( $global:__skipCacheOnContainer )
$msg | write-warning
$msg | write-verbose

if ($false -and -not $global:__skipCacheOnContainer) {
    $LocalDb.SchemaCo_812849 = Get-Content -ea 'ignore' $AppConf.Paylocity.SchemaCo_812849 | ConvertFrom-Json -Depth 13 @SilentMode
    $LocalDb.SchemaCo_13294 = Get-Content -ea 'ignore' $appconf.Paylocity.SchemaCo_13294 | ConvertFrom-Json -Depth 13 @SilentMode


    if (-not $AppConf.Paylocity.SchemaCo_812849) {
        'SchemaCo_812849: falling back to inline schema def. Missing: {0}' -f @(
            $AppConf.Paylocity.SchemaCo_812849
        ) | Write-Verbose
    }
    $LocalDb.SchemaCo_812849 ??= Get-Content @silentMode (Join-Path $PSScriptRoot 'co_schema_89849.json') | ConvertFrom-Json -Depth 13 @SilentMode
    $LocalDb.SchemaCo_13294 ??= Get-Content @silentMode (Join-Path $PSScriptRoot 'co_schema_13294.json') | ConvertFrom-Json -Depth 13 @SilentMode

    'tried: "{0}"' -f @( Join-Path $PSScriptRoot 'co_schema_13294.json') | Write-Verbose

    if ($false -and 'debub on: break local db for test') {
        $LocalDb.SchemaCo_812849 = Get-Content @silentMode 'invalid path' | ConvertFrom-Json @silentMode -Depth 13
        $LocalDb.SchemaCo_13294 = Get-Content @silentMode 'invalid path' | ConvertFrom-Json @silentMode -Depth 13
        $localDB.CoResourceMapping = Get-Content @silentMode 'invalid path' | ConvertFrom-Json @silentMode -Depth 8
    }
}
function getSemColor {
    param(
        [Parameter(Position = 0, Mandatory)]
        # [ValidateSet([SemState])]
        [SemState]$Name
    )
    switch ($SemState) {
        'Warn' {
            Get-Item fg:\Yellow
        }
        'Bad' {
            Get-Item Fg:\DarkRed
        }
        'Good' {
            Get-Item fg:\green
        }
        'BrightFg' {
            $PSStyle.Formatting.BrightWhite
        }
        Default {
            # gi fg:\gray80
            $PSStyle.Foreground.BrightBlack
        }
    }
}

function writeSem {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object[]]$InputObject,

        [Parameter(Mandatory, Position = 0)]
        # [ValidateSet([SemState])]
        [SemState]$SemState
    )

    begin {
    }
    process {
        $color = getSemColor($SemState)
        $Prefix = New-Text fg:\$Color '' | ForEach-Object tostring
        $InputObject | Join-String -sep ', ' -op $prefix -os ($PSStyle.Reset)
    } end {
    }
}

[int]$script:__requestId = 0
class ResponseCacheObject {
    <#
    I know end, because it's now

    #>
    [datetime]$StartedAt
    [datetime]$EndedAt
    [timespan]$Duration # should be a property
    [Int]$RequestId
    [object[]]$Response
    [object[]]$Errors

    # somes as a Dictionary[string,cg.IEnumerable[string]]
    [object]$Headers


    ResponseCacheObject (
        [datetime]$StartedAt,
        [object[]]$Response, # / payload
        [object[]]$Errors,
        [hashtable]$Options #= @{}
    ) {
        throw 'Not Used?'
        $this.StartedAt = $StartedAt # fallback to null or else equal to Ended at for a duration of 0 ?
        $this.Response = $Response
        $this.EndedAt = [datetime]::Now
        $this.Duration = $this.EndedAt - $this.StartedAt
        $this.RequestId = $script:__requestId++
        $this.Errors = $Errors

        # $this.Session = $Options['SessionVar']
        # $this.ResponseHeader = $Options['ResponseHeaders']
        # $this.HTTPStatusCode = $Options['HttpStatusCode']
    }
}

function resetRespCache {
    $script:RespCache.Clear()
}

function Paylo-GetNewIdentity {
    [CmdletBinding()]
    param()

    $irmShared = @{
        UserAgent               = 'user agent'
        # AllowUnencryptedAuthentication = $true
        ContentType             = 'application/x-www-form-urlencoded'
        # Headers                        = @{}
        # InFile                         = ''
        MaximumRetryCount       = 2
        # Method                         = 'Post'
        # OutFile                        = 'outfile'
        # PassThru                = $true
        ResponseHeadersVariable = 'ovHeaders'
        RetryIntervalSec        = 1
        # SkipCertificateCheck           = $true
        SkipHeaderValidation    = $true
        # SkipHttpErrorCheck             = $true
        StatusCodeVariable      = 'ovStatus'
        # WebSession                     = 'session'
        # Body                           = @{}
        # Credential                     = $cred
        # Form                           = @{}
    }
    $IrmConfig.RequestMode = '-header'

    $IrmConfig.RequestMode | b.Label 'Request Mode' | Write-Information
    if ($false -and $IrmConfig.RequestMode -eq '-Bearer') {
        $requestMode_bearer = @{
            Token          = $identityToken
            Authentication = 'Basic'
            Uri            = $IrmConfig.AuthUrl
            Method         = 'Post'
        }

        $resp = Invoke-RestMethod @irmShared @requestMode_bearer
        $resp
    }
    else {
        $requestMode_Header = @{
            # Token          = $identityToken
            # Authentication = 'Basic'
            Uri    = $IrmConfig.AuthUrl
            Method = 'Post'
            Header = @{
                #  $IrmConfig.lastAuthReq
                'Authorization'   = 'Basic {0}' -f @(
                    $IrmConfig.lastAuthReq
                )
                'Accept'          = '*/*'
                'Cache-Control'   = 'no-cache'
                'Host'            = 'api.paylocity.com'
                'Accept-Encoding' = 'gzip, deflate, br'
                'Connection'      = 'keep-alive'
            }
            Body   = @{
                'grant_type' = 'client_credentials'
                'scope'      = 'WebLinkAPI'
            }
        }

        $resp = Invoke-RestMethod @irmShared @requestMode_Header

        # $script:IrmConfig.CurToken_BearerString = $null
        $script:IrmConfig.CurToken_BearerString = 'Bearer ' + $resp.access_token
        $script:IrmConfig.CurToken = $resp.access_token
        # $irmSplat.Headers.Authorization =
        # $Global:nin.lastToken = $resp.access_token
    }
}



# InitializeJumpCloud

function InitializeBDG {
    <#
    .SYNOPSIS
        Set JCAPIKey, optionally runs InitializeJumpCloud()
    #>
    param(
        [ValidateNotNull()]
        [Parameter()]
        [hashtable]$Config
    )

    __writeDot Processing
    if ( -not $Config ) {
        $Config = $AppConf
    }

    bdgLog -Category ModuleEvent 'enter -> InitializeBDG'
    $env:JCAPIKEY = Get-Content $AppConf.JumpCloudEnv

    if (! $Config.SkipLoadingJumpCloud) {
        bdgLog -Category ModuleEvent 'enter -> InitializeJumpCloud'
        InitializeJumpCloud
        bdgLog -Category ModuleEvent 'exit -> InitializeJumpCloud'
    }

    __writeDot Complete
    bdgLog -Category ModuleEvent '<-- exit InitializeBDG'
}


# enum employeeStatus {
#     "A"
#     "L"
#     "T"
#     "XT"
#     "D"
#     "R"
# }
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part1.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part2.ps1 #>
# using namespace System.Collections.Generic

# . (Join-path $PSScriptRoot 'employee_index.ps1')
# . (Join-path $PSScriptRoot 'paylo_exportRecord.ps1')



function iter_CompanyIds {
    [Alias('enum_CompanyIds')]
    param()
    return @( 89849 ; 13294 )
}

function PayloRest-GetEmployee {
    param(
        [AllowNull()]
        [AllowEmptyString()]
        [Parameter(Mandatory)]
        [ArgumentCompletions('13294', '89849')]
        [string]$companyId,

        [AllowNull()]
        [AllowEmptyString()]
        [Parameter(Mandatory)]
        [string]$employeeId,

        [hashtable]$Options = @{
            SilentIfMissing = $true
        }
    )
    if ( ( -not $companyId) -or (-not $employeeId ) ) {
        if (-not $Options.SilentIfMissing) {
            $errMsg = "Rest->GetEmployee: Invalid Invoke args, [Co: $CompanyId, Employee: $EmployeeId]"
            $errMsg | bdgLog -Category DataIntegrity
            $errMsg | Write-Error

        }
        return $null
    }

    $pre1 = @(
        $script:IrmConfig.BaseUrl
        '/api/v2/companies/{0}/employees/{1}' -f @(
            $companyId
            $employeeId
        )
    ) -join ''
    $pre2 = $script:IrmConfig.CurToken_BearerString


    $irmSplat = @{
        Uri                     = @(
            $script:IrmConfig.BaseUrl
            '/api/v2/companies/{0}/employees/{1}' -f @(
                $companyId
                $employeeId
            )
        ) -join ''
        Method                  = 'GET'
        # Authentication = 'Bearer'
        ResponseHeadersVariable = '_respHeaders'
        StatusCodeVariable      = '_statusCode'
        SkipHttpErrorCheck      = $true
        # Credential = 'a'
        # Token = 'x'
        SessionVariable         = '_session'
        RetryIntervalSec        = 1
        Headers                 = @{
            'Authorization'   = $script:IrmConfig.CurToken_BearerString
            'Accept'          = '*/*'
            'Cache-Control'   = 'no-cache'
            'Host'            = 'api.paylocity.com'
            'Accept-Encoding' = 'gzip, deflate, br'
            'Connection'      = 'keep-alive'
        }
    }

    $payload = $global:paylo_JsonCache.GetCachedValue( $companyId, $employeeId )
    if ($Payload) {
        __writeDot CacheHit
        #cache hit
        return $Payload
    }

    if ($script:AppConf.Cache.JsonForceCachedDataOnly) {
        Write-Debug 'Skiping JSON, forcing cache only'
        __writeDot Bad
    }
    # $script:IrmConfig.ForceCachedOnly = $true
    # if( $script:IrmConfig.ForceCachedOnly ) {
    #     # return failure code um?
    #     return [PSCustomObject]@{
    #         HasError   = $True
    #         StatusCode = 0
    #         Message    = 'ForceCacheOnly'
    #     }
    # }



    if ( -not $Payload) {
        __writeDot CacheMiss
        # cache miss
        # 'cache miss' | write-verbose
    }
    <#
        A connection attempt failed because the connected party did
        not properly respond after a period of time, or established connection failed
        because connected host has failed to respond. (api.paylocity.com:443)
    #>

    $response = Invoke-RestMethod @irmSplat -ea 'break'
    if ($_statusCode -eq 200) {

        #only save good results

    }

    #     __writeDot Complete
    #     return $response
    # } elseif {

    # } else {
    #     __writeDot HttpError
    # }

    __writeDot HttpRequest
    $sharedCommonError = @(400, 401, 403, 404, 429, 500)

    switch ($_statusCode) {
        200 {
            $global:paylo_JsonCache.SetCachedValue($companyId, $employeeId, $response)

            '{0} sleep {1} ms' -f @(
                @(
                    $PSStyle.Background.FromRgb('#9933b9')
                    'irm'
                    $PSStyle.Reset
                ) -join ''
                $global:paylo_JsonCache.SleepStepSizeMs
            ) | bdgLog -Message 'Invoke-RestMethod' -Category CacheEvent # future irm: strip ansi to log, but keep on hosst

            Start-Sleep -ms $global:paylo_JsonCache.SleepStepSizeMs
            return $response
        }
        { $_ -in @($sharedCommonError) } {
            __writeDot HttpError
            $errStr = "HTTP Error Status: ${_statusCode}, Co = ${companyId}, EmpId = ${employeeId}"
            $errStr | bdgLog -Message 'PayloRest-GetEmployee' -Category WebRequest
            $errStr | Write-Error
            $errStr | Write-Warning
        }
        401 {
            Write-Error -ea 'continue' 'expired auth'
            throw '401 ReAuth'
            Paylo-GetNewIdentity
            throw '401 ReAuth'
            __writeDot Red
        }
        403 {
            $errStr = @(
                "403: Query Error: Co = ${companyId}, EmpId = ${employeeId}"
                '403 can mean the employee is visible from the ftp connector, but not yet live. paylo returns a 403 in that case.'
            ) -join "`n"

            bdgLog -Message $errStr -Category DataIntegrity
            $errStr | Write-Error

            __writeDot Red
            # Paylo-GetNewIdentity
            # throw '403 ReAuth or request'
            # auto identify
        }
        429 {
            __writeDot Red

            bdgLog -Category WebRequest -Message 'TooManyRequests: HTTP 429, sleeping...' -PassThru
            | Write-Warning

            Write-Error -ea 'continue' 'HTTP 429: too many requests'
            Start-Sleep -sec 2
            if ($Options.Depth -gt 1) {
                return
            }

            return (PayloRest-GetEmployee -companyId $companyId -employeeId $employeeId -Options @{Depth = 1 })
        }
        default {
            $errStr = "Unexpected HTTP Status: ${$_statusCode}, Co = ${companyId}, EmpId = ${employeeId}"
            $errStr | bdgLog -Message 'PayloRest-GetEmployee' -Category WebRequest
            $errStr | Write-Error
            $errStr | Write-Warning
        }
    }
    if ($_statusCode -eq 200) {
        return $response
    }
    else {

    }

    #  re-test same employee
    if ($_statusCode -in @(401, 403, 429 )) {
        #re-request
        Write-Warning "re-requesting after auth from $_StatusCode"
        __writeDot No_op

        # Start-Sleep -Seconds 1
        # throw '(cleaner way to re-request without recurse)'


        # $newResponse = Invoke-RestMethod @irmSplat
        # if($_statusCode -eq 200) {
        #     $global:paylo_JsonCache.SetCachedValue($companyId, $employeeId, $response)
        #     Sleep -ms $global:paylo_JsonCache.SleepStepSizeMs
        # }

        # if($Payload) {
        #     __writeDot CacheHit
        #     #cache hit
        #     return $Payload
        # }
    }

    # todo: throttles
    # $errStr = "Response Status was not HTTP 200: ${$_statusCode}, Co = ${companyId}, EmpId = ${employeeId}"
    # $errStr | bdgLog -Message 'PayloRest-GetEmployee' -Category WebRequest
    # $errStr | Write-Error # bug: passhthrough wasn't piping to write-error

    # return failure code um?
    return [PSCustomObject]@{
        HasError   = $True
        StatusCode = $_statusCode
        Message    = $errStr
    }

}


class Get_JCUser {
    # | from Jumpcloud
    <#
    this class handles data coming from JumpCloud,
    verses going to
    #>#>
    # [string]$Employee # is employeeIdentifier
    [string]$userName
    [string]$email # #AKA: WOrkEmail.  will be a GUID, isn't yet
    [string]$alternateEmail # #AKA: WOrkEmail.  will be a GUID, isn't yet
    [string]$recoveryEmail # #AKA: WOrkEmail.  will be a GUID, isn't yet
    [string]$manager

    [string]$DisplayName
    [string]$LastName
    [string]$MiddleName
    [string]$FirstName
    [string]$JobTitle
    [string]$employeeIdentifier

    [string]$employeeType  # cost2 ?



    [string]$department
    [string]$CurrentHomeState
    [string]$costCenter

    [string]$hireDate
    [string]$Company


    [bool]$Activated
    [string]$State




    # hidden [string]$SuperVisor
    # hidden [string]$CompanyCode

    [datetime]$dateCreated
    [string]$Organization
    [string]$_id

    <#
        unhandled
        addresses
        activated = $true
    #>

    [string] GetGuid () {
        return $this.email
    }
    # [EmployeeIdPair] GetKeyIdPair () {
    #     return [EmployeeIdPair]::new($this.companyId, $this.employeeIdentifier)
    # }

    Get_JCUser ( [object]$Record ) {
        # $This.Employee = $Record.Empl
        $this.Activated = $record.account_locked
        $this.State = $record.State

        $this.Company = $Record.Company
        $this.CostCenter = $record.CostCenter
        $this.department = $record.department  ## c2

        $this.userName = $Record.userName
        $this.DisplayName = $Record.DisplayName
        $this.FirstName = $Record.FirstName
        $this.MiddleName = $Record.MiddleName
        $this.LastName = $Record.LastName
        $this.JobTitle = $Record.JobTitle

        $this.dateCreated = $record.created

        # new
        $this.email = $record.Email
        $this.alternateEmail = $record.alternateEmail
        $this.alternateEmail = $record.recoveryEmail
        $this.employeeIdentifier = $record.employeeIdentifier
        $this.employeeType = $Record.employeeType

        $this.manager = $record.manager

        # $this.SuperVisor = $Record.SuperVisor
        # $this.CompanyCode = $Record.CompanyCode
        $this._id = $Record._id
        $this.dateCreated = $Record.Created
        $this.Organization = $record.organization

        if ( [string]::IsNullOrWhiteSpace( $this.DisplayName ) ) {
            @{ email = $this.email  ; user = $this.userName ; co = $this.Company ; empId = $this.employeeIdentifier } | to->Json -Compress -Depth 5
            | bdgLog -Category DataIntegrity
        }
    }

}

. (Join-Path $PSScriptRoot 'paylo_restapi.ps1')

class EmployeeNumbersRecord {
    $companyId = ''
    [Collections.Generic.List[object]]$EmployeeList = @()
}

# . (Join-path $PSScriptRoot 'employee_index.ps1')
# . (Join-path $PSScriptRoot 'employee_infostate.ps1')



# class CachedEmplo


function liveDB_EnsureUniqueRecords {
    <#
    .synopsis
        make sure there's only one record per 'employeeIdentifier'
    #>

    $script:LiveDB_EmployeeInfo = @(
        $script:LiveDB_EmployeeInfo
        | Sort-Object -Unique 'userName'
        # | Sort -unique -Property 'employeeIdentifier'
    )
}

# $script:__writeDotOptions.SkipTypes += @('ActualRequest','Bad','Bright','CacheHit','CacheMiss','Complete','FileIO','Good','Green','GroupSegment','HttpError','HttpRequest','No_op','Processing','Red','Warn','Yellow')
function __writeDot {
    # writes to host
    [outputtype('string')]
    param(
        # No-Op does nothing, else rest render
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet(
            'Good', 'Bad', 'Warn',
            'Orange',
            'DataIntegrity',
            'Green', 'Yellow', 'Red',
            'Bright',
            'HttpError', 'HttpRequest',
            'CacheHit', 'CacheMiss',
            'EmpIndexhit', 'EmpIndexMiss',
            'No_op',
            'Complete', 'Processing',
            'ActualRequest',
            'GroupSegment',
            'FileIO'
        )]
        [string]$Type,

        # allows global disable, by running this
        [switch]$Silent,
        [switch]$Toggle,
        [switch]$GlobalOff = $true
    )
    if ( $GlobalOff ) { return }

    if ($Silent) { $script:___writeDotEnabled = $false ; return }
    if ($Toggle) { $script:___writeDotEnabled = -not $script:___writeDotEnabled; return }
    # return # test recursion issue
    if ($Type -eq 'No_Op') { return }

    if ($script:__writeDotOptions.SkipTypes -contains $Type) {
        return
    }

    if ($global:__writeDotOptions.SkipTypes -contains 'default') {
        return
    }

    # $randC = ls fg: | get-random -count 2
    $Mapping = switch ($Type) {
        { $_ -in 'EmpIndexHit' } { '#a4dcff' }   # { '#96af84' } #
        { $_ -in 'EmpIndexMiss' } { '#bf982f' } #
        { $_ -in 'GroupSegment' } { '#9933b9' } # severity 1
        { $_ -in 'ActualRequest' } { '#9933b9' } # severity 1
        { $_ -in 'Complete', 'CacheHit', 'green' } { '#96af84' } # severity 1
        { $_ -in 'FileIO' } { '#cffcff' } # severity 1
        { $_ -in @('Proces', 'Processing') } { '#8fc0df' }
        { $_ -in 'bright', 'HttpRequest' } { '#c9e3e3' } # aka color0 | write-information
        { $_ -in 'yellow', 'warn', 'orange' } { '#CB895D' } # severity 2
        { $_ -in 'DataIntegrity', 'red', 'bad', 'HttpError' } { '#d362a2' } # severity max
        default {
            # 'gray40'
            return
        }
    }
    $color = [rgbcolor]$Mapping
    $other = $color.GetComplement()

    $splat = @{
        BackgroundColor = $color
        ForegroundColor = $other
        Object          = '.'
    }

    $Msg = New-Text @splat
    Write-Host -NoNewline $msg
    # write-output -NoEnumerate $Msg
    # [console]::Write( $Msg )
    # write-host -NoNewline $Msg  # or normally worse, but, this case it's ansi colors
}

function _excel-AutosizeColumns {
    <#
    .SYNOPSIS
        autosize columns in the first 30 columns of every worksheet
    #>
    param(
        # [Parameter(Mandatory)]
        $InputObject,

        [Alias('Path')]
        [Parameter(Mandatory)]
        [string]$DestinationPath
        # [switch]$Show
    )
    # if ($null -eq $InputObject) { return }
    #     $pl.Workbook.Worksheets.count
    # $DestinationPath #??= $PathsExcel.export_mergedExcel
    # $splatExcel = @{
    #     Path = $Dest
    #
    try {
        [OfficeOpenXml.ExcelPackage]$pl = Open-ExcelPackage -Path $PathsExcel.export_mergedExcel -ea stop
    }
    catch {
        Write-Warning 'could not open excel package'
    }

    $target = $pl.WorkBook.WorkSheets
    if (-not $target) {
        return
    }

    foreach ($i in @(1..$pl.Workbook.Worksheets.count)) {
        # $pl.Workbook.Worksheets[1]
        foreach ($j in 1..80) {
            # $targetSheet = $target[$i]
            # $targetSheet.Column($j).AutoFit()
            # or
            $pl.Workbook.Worksheets[$i].Column($j).AutoFit()
        }
    }
    Close-ExcelPackage $pl

}
function b.newExcelBook {
    <#
    .SYNOPSIS
        delete file, then create empty file, for append append
    #>
    # delete excel sheet to start a new append sheet

    [Alias('_excelResetSheet')]
    [cmdletBinding()]
    param(
        # [Alias('Path')]
        [Parameter()]
        [string]$Path = $PathsExcel.export_mergedExcel,
        # otherwise automatically create a new item, building filepath for future
        [switch]$DoNotCreateMissingPath
    )
    # $Path ??= $PathsExcel.export_mergedExcel
    Remove-Item $Path -ErrorAction ignore

    if (-not $DotNotCreateMissing) {
        # to ensure nsted directories exist, not sure if Excel is okay with empty files
        New-Item -ItemType File $Path -ea Ignore
        Remove-Item $Path -ErrorAction ignore
    }
}
function _excelAddSheet {
    <#
    .synopsis
        latest, excelAddSheet, # keep appending rows to excel sheet
    .NOTES
        # future: pipe may need to collect items before passing
        see also: params:
            'ClearSheet', 'Append', 'NoLegend', 'Calculate', 'AutoSize', 'Path', 'TitleSize', 'Title', 'TitleBold', 'TitleBackgroundColor', 'TitleFillPatternLightGrid', 'AutoFilter', 'MaxAutoSizeRows', 'NoClobber', 'FreezeTopRow', 'FreezeFirstColumn', 'FreezeTopRowFirstColumn', 'FreezePane', 'MoveAfter', 'PassThru', 'ReZip', 'Numberformat', 'MoveToStart', 'MoveToEnd', 'MoveBefore', 'PivotDataToColumn', 'IncludePivotChart', 'NoHeader', 'RangeName', 'WorksheetName', 'TableName', 'PivotTableName', 'AutoNameRange'
    .LINK
        b.addExcelSheet
    .LINK
        b.addSheet
    .link
        _excelAddSheet
    #>
    param(
        [Alias('Data')]
        # [AllowNull()]
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        # [Parameter(Mandatory)]
        [string]$Label,

        [Alias('Path')]
        [Parameter()]
        [string]$DestinationPath = $PathsExcel.export_mergedExcel,

        [Parameter()]
        $TableStyle = 'Light2',

        [ArgumentCompletions(
            "@{ Title = 'title' }"
        )]
        [hashtable]$Options = @{},
        [switch]$AppendAll
        # [OfficeOpenXml.Table.TableStyles]$TableStyle = [OfficeOpenXml.Table.TableStyles]::sty
    )
    $Config = mergeHashtable -OtherHash $Options -BaseHash @{
        # AppendAll = $false
    }
    if ($AppendAll) { $Config.AppendAll = $true }
    # underscores are invalid
    if ($null -eq $InputObject) { return; }
    $OrigLabel = $Label
    $Label = $Label -replace '[ :]', '_'
    if ($OrigLabel -ne $Label) {
        'AutoReNamed bad worksheet name before passing to Export: {0} -> {1}' -f @(
            Join-String -double $Origlabel
            Join-String -double $Label
        ) | Write-Warning
    }

    # if ($false -or 'AlwaysSleep') {
    #     Start-Sleep -sec 0.3

    # }
    if ($null -eq $InputObject) {
        $InputObject = @("`u{2400}")
        Write-Warning "skipped: $Label"
        return
    }
    # wait-debugger

    $splatExcel = @{
        Path          = $DestinationPath
        TableName     = $Config.TableName ?? $Label
        WorksheetName = $Config.WorkSheetName ?? $Label
        TableStyle    = 'Light2'
        # TitleBackgroundColor = 'orange'
        TitleSize     = 14
        # Style = ...'object'
    }
    if ($Config.AppendAll) {
        $splatExcel.Append = $true
    }
    if ($Config.Title) {
        $splatExcel.Title = $Config.Title
    }

    $table_title = b.ReplaceIfBlank $splatExcel.TableName $splatExcel.Title
    $table_title ??= $Config.Title
    $table_title ??= $Config.WorksheetName
    try {
        if ($InputObject.count -gt 0) {
            $maybeTypeCount = ' [{0}] ' -f @(
                @($InputObject)[0]?.GetType().Name ?? ''
            )
        }
        else { '' }
    }
    catch {
        $maybeTypeCount = '[?!]'
    }
    $Config.Title = '{0}: Rows {1} of, {2}, {3}' -f @(
        $table_title
        ($InputObject)?.Count
        ($InputObject)?.GetType().Name ?? ''
        $maybeTypeCount ?? ''
    )
    Write-Warning 'title'
    $config.Title | Write-Warning

    $Config | to->Json -Compress | b.Label '$Config' | Write-Verbose
    $splatExcel | to->Json -Compress | b.Label 'splatExcelConfig' | Write-Verbose

    $splatCombined = mergeHash $splatExcel $Config
    $splatCombined.Remove('Label')
    if ($Config.Append -or $Append) {
        $splatCombined.Append = $true
    }

    # @() -is 'array' -and @().Length -eq 0
    $targetObj = $InputObject
    if ($targetObj -is 'array' -and $targetObj.count -eq 0) {
        $targetObj = @(
            [pscustomobject]@{
                Content    = 'ErrorResult'
                InputCount = $targetObj.Count
                Message    = 'Data was empty for this table'
            }
        )
    }

    # }
    # $splatExcel
    if ($splatCombined.Name -match 'changes') {
        $splatCombined.Append = $true
        $null -eq 0
    }
    $splatCombined | to->Json | b.Label 'splatCombined' | Write-Verbose
    try {
        $splatCombined
        | Format-Table -auto -Wrap
        | Join-String -op 'Invoke Export-Excel: '
        | Write-Verbose

        Export-Excel -Append @splatCombined -InputObject $targetObj -AutoSize -Verbose -Debug

        # $Label, $dest -join ': ' | b.Label 'BDG_ExportExcelDebugSheet: wrote' -fg orange | Write-Debug
    }
    catch {
        "_excelAddSheet threw [!]: $_ " | Write-Error -ea 'continue'
        '📚 enter ==> other ==>  bdg_lib\src_static\root_entry_part2.ps1/5c127784-0ef7-46db-8896-91f0c7774989' | Write-Warning
        # todo: close excel
    }
}

function b.GenerateExistSummaryTable {
    # basic bool table of existing in cache or not
    [OutputType('[object[]]')]
    [CmdletBinding()]
    param(
        # filter final results
        [switch]$InPaylo,
        [switch]$InJumpCloud,
        [switch]$InBoth
    )
    Write-Warning 'b.GenerateExistSummaryTable: requires filter'
    if ($InBoth) { $InPaylo = $true; $InJumpCloud = $true; }

    $work_email = @(
        $global:EmployeeSummaryIndex.AsList().WorkEmail
        $global:JCSummaryIndex.AsList().Email
    ) | Sort-Object -Unique

    # 'existence' 'existence'
    class ExistenceSummaryRecord {
        [string]$WorkEmail
        [bool]$InPaylocityCache
        [bool]$InJumpCloudCache
    }

    $final = $work_email | ForEach-Object {
        $curWorkEmail = $_
        [ExistenceSummaryRecord]@{
            WorkEmail        = $curWorkEmail
            InPaylocityCache = $null -ne $global:EmployeeSummaryIndex.GetIndex( $curWorkEmail )
            InJumpCloudCache = $null -ne $global:JCSummaryIndex.GetIndex( $curWorkEmail )
        }
    }
    if (-not $InPaylo -and -not $inJumpCloud -and -not $InBoth ) {
        return @($final | Sort-Object workEmail -Unique)
    }
    if ($inPaylo -and $InJumpCloud) {
        return @(
            $final | Sort-Object workEmail -Unique

        )
    }
    if ($InPaylo) {
        return @(
            $final
            | Where-Object { $_.InPaylocityCache }
            | ForEach-Object WorkEmail
            | Sort-Object -Unique
        )

    }
    if ($InJumpCloud) {
        return @(
            $final
            | Where-Object { $_.InJumpCloudCache }
            | ForEach-Object WorkEmail
            | Sort-Object -Unique
        )

    }
}


function b.debug.GrabJsonCache {
    <#
    .SYNOPSIS
        quickly fetch queries using JSON cache, interactively
    .EXAMPLE
        # all
        Pwsh> b.debug.GrabJsonCache

        # me
        Pwsh> b.debug.GrabJsonCache -AnyName 'jake'

    #>
    param(
        [int[]]$EmployeeId,
        [string[]]$AnyName
    )

    $empIds = @($EmployeeId)
    $namesRegex = $AnyName | Join-String -sep '|' { @( '(', [Regex]::escape($_) , ')' ) -join '' }

    $accum = ($global:paylo_JsonCache.records).data
    if ($EmployeeId.count -gt 0) {
        $accum = $accum
        | Where-Object { $empIds -contains $_.EmployeeId }
    }
    if ($AnyName.count -gt 0) {
        $accum = $accum | Where-Object {
                ($_.LastName -match $namesRegex ) -or
                ($_.FirstName -match $namesRegex ) -or
                ($_.PreferredName -match $namesRegex ) -or
                ($_.UserName -match $namesRegex )

        }
    }
    return $accum
    # | ?{ $_.employeeId -in @(12022, 11548) }
}


function b.copyExcel {
    <#
    .SYNOPSIS
        copies excel file a new file with unique timestamp, and auto-sizes all columns, optionally open.
    #>
    [cmdletBinding()]
    param([switch]$Show,
        [ArgumentCompletions('C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\output\final-excel-debug-v2.xlsx')]
        [string]$OriginalPath = $PathsExcel.export_mergedExcel,

        [ArgumentCompletions('C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\.temp\ExportSummary_{0}.export.xlsx')]
        [string]$ExportTemplate = $PathsExcel.export_safeTimeRootTemplate
    )
    '📚 maybe error throwing logic here, to catch null paths ==>  bdg_lib\src_static\root_entry_part2.ps1/3964b128-4fc3-4f4f-8e9f-be2beaacbc76' | Write-Warning


    # $Source = $OriginalPath | Get-Item -ea stop
    # $Source = $OriginalPath | Get-Item -ea 'continue'
    $template = 'b.copyExcel()',
        '  $OriginalPath => {0} ',
        '  $ExportTemplate => {1} ' -join ''

    $template -f @(
        $OriginalPath ?? '<missing>'
        $ExportTemplate ?? '<missing>'
    )
    | Write-warning



    $Source = Get-Item -ea 'continue' $OriginalPath
    if (-not $Source) {
        "📚 Source not Found: ==> '$OriginalPath' ==>  bdg_lib\src_static\root_entry_part2.ps1/e13ee312-bc75-45bf-b92e-9741fef820d8" | Write-Warning
        return
    }

    $DestAsTime = b.SafeFiletimePath

    $fullDest = $exportTemplate -f @( $destAsTime)
    # $fullDest = 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\.temp\ExportSummary_{0}.export.xlsx' -f @( $destAsTime)
    # _excel-AutosizeColumns -path $excelCopy # redundant now


    $template = @(  'b.copyExcel()'
        '  $DestAsTime => {0} '
        '  $fullDest => {1} '
    )
    | Join-String -sep "`n"

    $template -f @(
        $DestAsTime
        $fullDest
    )
    | Write-Verbose -Verbose

    $param = @{
        Source = $Source
    }
    'try format, finally writing to: {0}' -f @( $fullDest)
    | write-verbose


    $srcPkg = Open-ExcelPackage $Param.Source -Create
    $srcPkg = b.conditionalFormat.notBlankToAll -pack $srcPkg
    if(-not $srcPkg) {
        # $srcPkg = Open-ExcelPackage $Param.Source
        # write-warning 'b.copyExcel =>  went falsy'
        throw 'b.copyExcel =>  went falsy'
    }
    try {
        Close-ExcelPackage -ExcelPackage $SrcPkg -SaveAs $fullDest -show:$Show
    }
    catch {
        throw $_
        # write-warning "b.copyExcel Failed"
    }


    # if ($show) {
    #     $excelCopy | Invoke-Item
    # }
    # return
    # $excelCopy = Copy-Item $Source -Destination $fullDest -PassThru
    # $pkg = Open-ExcelPackage $excelCopy
    # b.conditionalFormat.notBlankToAll -Package $pkg
    # Close-ExcelPackage $pkg


    # $fullDest | Get-Item | ForEach-Object Fullname | b.Label 'Wrote: '
    # $excelCopy | b.Label 'opening:...'
    # if ($show) {
    #     $excelCopy | Invoke-Item
    # }
    $null = 0
}

function _fmtError {
    $global:Error.count | b.Label 'error count?: '
    # & {
    $script:___eNum = 0 # note: Join-String doesn't increment
    $global:error
    | Join-String -sep "`n`n`t-------`n`n" { $_ -split '' | Select-Object -First 100 | Join-String -sep '' -os '...' -op "$(( $script:___eNum++ )): " }

}

function b.rotateLog {
    # cycle 2 log files at 2mb
    [cmdletBinding()]
    param(
        [Parameter()]
        [object]$Target #= $global:AppConf.LLogPath
    )
    if (-not $Target) {
        return
    }
    $targetLog = Get-Item $Target # $AppConf.LLogPath
    $logSize = $targetLog | Get-Item | ForEach-Object Length
    '{0} was {1:n2} mb' -f @(
        $TargetLog | Join-String -DoubleQuote
        $LogSize / 2mb
    ) | Write-Debug
    if ($logSize -gt 2mb) {
        Write-Verbose 'rotating + clearing log, > 2mb'
        $logDest = '{0}-1' -f @($targetLog)
        Get-Content $TargetLog | Set-Content -Path $LogDest
        # Move-Item $targetLog -Destination $logDest
        Clear-Content $targetLog
    }
}

# . 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src\JCSummaryIndex.ps1'
# Paylo-GetNewIdentity

InitializeJumpCloud

# # 'main got it'
# # $exportModuleMemberSplat
# $exportModuleMemberSplat.Variable

'=== Reached final root_entry.ps1 4000. before {0}' -f $PSCommandPath
| Write-verbose -verbose

class QueryJump {
    # Query jumpm cloud, turn into records
    static [ValidateNotNull()][Collections.Generic.List[Object]]$rawRows = @()
    static [ValidateNotNull()][Collections.Generic.List[Object]]$Rows = @()

    static [int] NumRecords () {
        return ([QueryJump]::Rows).Count
    }
    static [bool] IsEmpty () {
        return ([QueryJump]::NumRecords() -eq 0)
    }

    static [bool] ContainsKeyId ( $CompanyId, $EmployeeId ) {
        $query = [QueryJump]::Rows
        | Where-Object {
            (
                $_.costCenter -eq $CompanyId) -and (
                $_.employeeIdentifier -eq $EmployeeId
            )
        }
        return $query.count -gt 0
    }

    static [void] RefreshCache () {
        [QueryJump]::RefreshCache( $false )
    }
    static [void] RefreshCache ( [bool]$Force ) {
        [bool]$isStale = $Force
        if ( [QueryJump]::IsEmpty() ) {
            $isStale = $True
        }
        if ( -not $IsStale ) { return }

        [Collections.Generic.List[Object]]$query = @( Get-JCUser )
        [Collections.Generic.List[Object]]$processed = $query | ForEach-Object {
            [Get_JCUser]::New( $_ )
        }

        [QueryJump]::rawRows = @($query)
        [QueryJump]::Rows = @($processed)
    }

    static [Collections.Generic.List[Object]] GetAll_RawRecords () {
        [QueryJump]::RefreshCache()
        return [QueryJump]::rawRows
    }
    # static [Collections.Generic.List[Get_JCUser]] GetAll () {
    static [Collections.Generic.List[Object]] GetAll () {
        [QueryJump]::RefreshCache()
        return [QueryJump]::Rows
    }
}

function New-QueryJump {
    return [QueryJump]
}

class KnownEmployeeByIdRecord {
    # [ValidateNotNullOrEmpty()]
    [string]$CompanyId

    # [ValidateNotNullOrEmpty()]
    [string]$EmployeeId

    [bool]$KnownAsExistingEmployee = $false

    # need to know whether this id should be treated as a new user or not
}


class KnownEmployeeById {
    <#
    .synopsis
        Determines whether a new record is considered new or not, to distinguish old non-fulltime from new adds
    .EXAMPLE
        (New-KnownEmployeeById)::TestEmpId( $NewEmp.CompanyId, $newEmp.EmployeeId )
        False
    .EXAMPLE
        $ke::GetAll() | ?{ $_.CompanyId -eq $CompanyId -and $_.EmployeeId -eq $EmployeeId }
    #>

    static [validatenotnull()][Collections.Generic.List[KnownEmployeeByIdRecord]]$rawRows = @()
    # SaveKnownEmployeeKnownEmployeeByIdRecord

    # // save and load

    static [Collections.Generic.List[KnownEmployeeByIdRecord]] GetAll() {
        if ($false) {
            if ( ([KnownEmployeeById]::rawRows).count -eq 0) {
                [KnownEmployeeById]::AddKnownFromJumpCloud()
            }
        }

        return [KnownEmployeeById]::rawRows
        | Sort-Object -Unique { $_.CompanyId, $_.EmployeeId } # perf?
    }
    static [void] Save() {
        $fullPath = $global:PathsExcel.export_empNewToDb
        Write-Verbose "Save: '$FullPath'"

        [KnownEmployeeById]::GetAll()
        | Sort-Object -Unique { $_.CompanyId, $_.EmployeeId }
        | ConvertTo-Csv | Set-Content -Path $FullPath
    }
    static [bool] TestEmpId ( $CompanyId, $EmployeeId ) {
        $query = [KnownEmployeeById]::rawRows
        | Where-Object { $_.CompanyId -eq $CompanyId -and $_.EmployeeId -eq $EmployeeId }
        if ($query.count -gt 0) { return $false }

        return $false
    }
    static [void] AddEmpId ( $CompanyId, $EmployeeId ) {
        if ( [KnownEmployeeById]::TestEmpId( $CompanyId, $EmployeeId ) ) {
            return
        }
        $record = [KnownEmployeeByIdRecord]@{
            CompanyId               = $CompanyId
            EmployeeId              = $EmployeeId
            KnownAsExistingEmployee = $true
        }
        [KnownEmployeeById]::rawRows.add( $record )
        [KnownEmployeeById]::Save()
        # $query = [KnownEmployeeById]::rawRows.add( )
        # | ? CompanyId -eq $CompanyId -and EmployeeId -eq $EmployeeId
    }

    static [void] Load() {
        try {
            $fullPath = $global:PathsExcel.export_empNewToDb
            if (-not (Test-Path $fullPath)) {
                "Missing file: '{0}'" -f @(
                    $global:PathsExcel.export_empNewToDb
                    return
                )
            }
            Get-Content -Path $FullPath | ConvertFrom-Csv | ForEach-Object {
                if ($null -eq $_) { return ; }
                $record = [KnownEmployeeByIdRecord]$_
                [KnownEmployeeById]::rawRows.add( $record )
            }
            Write-Verbose "Load: '$FullPath'"
        }
        catch {
            Write-Warning "failed load: $_"
        }
    }
    # $global:PathsExcel.export_empNewToDb

    static [void] AddKnownFromCurList () {
        @(
            $global:EmployeeInfoState.EmployeeNumbers[0]
            | Select-Object companyId -exp EmployeeList -ea ignore
            $global:EmployeeInfoState.EmployeeNumbers[1]
            | Select-Object companyId -exp EmployeeList -ea ignore
        ) | ForEach-Object {
            $record = [KnownEmployeeByIdRecord]@{
                EmployeeId              = $_.EmployeeId
                CompanyId               = $_.CompanyId
                KnownAsExistingEmployee = $true
            }
            [KnownEmployeeById]::rawRows.add( $record )
        }
    }
    # static [void] AddKnownFromJumpCloud () {
    #     $qj ??= New-QueryJump
    #     $qj.Rows | %{
    #         # wait-debugger
    #         $cur = $_
    #         $record = [KnownEmployeeByIdRecord]@{
    #             CompanyId = $cur.costCenter
    #             EmployeeId = $cur.employeeIdentifier
    #             KnownAsExistingEmployee = $True
    #         }
    #         [KnownEmployeeById]::rawRows.Add( $record )

    #     }
    # }
}
# wait-debugger
[QueryJump]::GetAll() | Out-Null

function New-KnownEmployeeById {
    [Alias('type.KnownEmployeeById')]
    param()
    return [KnownEmployeeById]
}

$byId = New-KnownEmployeeById
$byId::Load()
function test.EmployeeIsNewToDB {
    [OutputTYpe('System.Boolean')]
    param(
        $CompanyId,
        $EmployeeId
    )
    # known means Id should not be treated as new, even though none in jump
    return ([KnownEmployeeById]::TestEmpId( $CompanyId, $EmployeeId ))
}

# export

if($false) {

try {
        Export-ModuleMember -Function @(
        'New-KnownEmployeeById'
        'test.EmployeeIsNewToDB'
        'New-QueryJump'
    ) -Alias @(
        'type.KnownEmployeeById'
    )
    } catch {
        "ExportExcel: failed: $PSCommandPath, $_"
    }
}
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_entry_part2.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\optBasicDiff_only.ps1 #>
class optBasicDiffSingleResult {
    # stores two values, their key names, and if changed
    [ValidateNotNullOrEmpty()]
    [string]$Name

    [bool]$ExactlyEqual
    [object]$Left #old
    [object]$Right #new
    [bool]$ExistsLeft
    [bool]$ExistsRight
    [bool]$IsBlankLeft
    [bool]$IsBlankRight
    [bool]$IsTrueNullLeft
    [bool]$IsTrueNullRight
    [bool]$HasChanged

    # singleDeltaResult( $)
    optBasicDiffSingleResult ($Name, $Left, $Right ) {
        $this.Name = $Name
        $this.ExactlyEqual = $Left -eq $Right
        $this.Left = $Left
        $this.Right = $Right
        $this.ExistsLeft = -not ($null -eq $left)
        $this.ExistsRight = -not ($null -eq $right)
        $this.IsBlankLeft = [string]::IsNullOrWhiteSpace( $Left )
        $this.IsBlankRight = [string]::IsNullOrWhiteSpace( $Right )
        $this.IsTrueNullLeft = $null -eq $Left
        $this.IsTrueNullRight = $null -eq $Right
        $this.HasChanged = -not $this.isEqual()
    }
    optBasicDiffSingleResult ($Name, $Left, $Right, $ExistsLeft, $ExistsRight ) {
        $this.Name = $Name
        $this.ExactlyEqual = ($Left -eq $Right) #-and ($Right -eq $Left)
        $this.Left = $Left
        $this.Right = $Right
        $this.ExistsLeft = $ExistsLeft -or (-not ($null -eq $left))
        $this.ExistsRight = $existsRight -or (-not ($null -eq $right))
        $this.IsBlankLeft = [string]::IsNullOrWhiteSpace( $Left )
        $this.IsBlankRight = [string]::IsNullOrWhiteSpace( $Right )
        $this.IsTrueNullLeft = $null -eq $Left
        $this.IsTrueNullRight = $null -eq $Right
        $this.HasChanged = -not $this.isEqual()

    }
    # [bool] HasChanged() { return $this.isEqual() } # coulld be script property
    [bool] isEqual() {
        return $this.Left -eq $this.Right
    }
    [bool] isEqualAndExisted() {
        return [bool]@(
            $this.isEqual() -and $this.ExistsLeft -and $this.ExistsRight
        )
    }
}

function b.opt.iterProps {
    <#
    .SYNOPSIS
        enumerateProperties
    .NOTES
        todo: expected output
            $this.SourceLeft | b.opt.iterProps -AsString

            # epects this to be equal even if it's not correct
            b.opt.iterProps -AsString $this.SourceLeft
    #>
    [OutputType('System.Management.Automation.PSPropertyInfo')]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        # enumerate properties as strings, instead of member info
        [Alias('AsName')]
        [switch]$AsString
    )
    process {
        if ($AsString) {
            return ($InputObject.PSObject.Properties | Sort-Object Name | ForEach-Object Name)
        }

        return ($InputObject.PSObject.Properties | Sort-Object Name)
    }
}


function optBasicDiff {
    <#
    .SYNOPSIS
        sugar for compare-object like usage
    .EXAMPLE
        optBasicDiff (gi .) (gi ..) | ? HasChanged
        optBasicDiff (gi .) (gi ..) | ? -not HasChanged
    .NOTES
        option to allow 'blanks' to be considered equal
    #>
    [OutputType('optBasicDiffSingleResult')]
    [CmdletBinding()]
    param(
        # should allow ignoring nulls?
        # [AllowNull()]
        [Alias('Left', 'Old')]
        [Parameter(Mandatory)]$Object1,
        #
        # [AllowNull()]
        [Alias('Right', 'New')]
        [Parameter(Mandatory)]$Object2,

        [string]$AddNameColumn,

        # filter
        [switch]$OnlyDifferent

    )

    $emptyObj = [pscustomobject]@{}
    $Object1 ??= $emptyObj
    $Object2 ??= $emptyObj
    # [Collections.Generic.List[singleDeltaResult]]$allResults = @()
    [Collections.Generic.List[object]]$allResults = @() # just to make sure this isn't breaking
    # $meta | bdgLog -Message '-> Delta::CalculateDelta()' -Category Verbose
    # Write-Warning 'find which item, skipping step, assuming left and right are the final (ie: original) target'

    # [bool]$isSameKeyIdTarget = $this.SourceLeft.email -eq $this.SourceRight.email
    [string[]]$leftProps = @($Object1 | b.opt.iterProps -AsString)
    [string[]]$rightProps = @($Object2 | b.opt.iterProps -AsString)
    $potentialPropNames = @(
        $leftProps
        $rightProps
        # $Object1 | b.opt.iterProps -AsString
        # $Object2 | b.opt.iterProps -AsString
        # b.opt.iterProps -InputObject
    ) | ForEach-Object tostring | Sort-Object -Unique

    $results = $potentialPropNames | ForEach-Object {
        $curPropName = $_
        $ExistInLeft = @($LeftProps) -contains $curPropName
        $ExistInRight = @($rightProps) -contains $curPropName

        # ($Name, $Left, $Right, $ExistsLeft, $ExistsRight ) {
        $obj = [optBasicDiffSingleResult]::new(
            $CurPropName,
            $Object1.$CurPropName,
            $Object2.$curPropName,
            $ExistInLeft,
            $ExistInRight
        )
        # $obj | fl | out-string | write-debug -debug
        # $null = 0
        $obj
    }
    if ( -not [String]::IsNullOrWhiteSpace( $AddNameColumn )) {
        $results | ForEach-Object {
            $_ | Add-Member -NotePropertyMembers @{
                Label = $AddNameColumn
            } -Force -ea Ignore -PassThru
        } # order
        | Select-Object Label, * -ea ignore
    }

    if ($OnlyDifferent) {
        $results | Where-Object HasChanged
        return
    }

    return $results
}

function b.opt.hashFromObj {
    <#

    .notes
        Depedencies: none
    #>
    [Alias('b.Dict')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )

    $meta = [ordered]@{}
    $InputObject.PSObject.Properties | ForEach-Object {
        $Key = $_.Name
        $Value = $_.Value
        $meta[ $key ] = $value
    }
    return $meta
}


# function ErrBdg {
#     param( [switch]$Clear )
#     if ($Clear) { $global:error.Clear() }
#     return $global:error
# }

# function b.opt.compareStringSet {
#     # todo: multiple ambigious overloads
#     param(
#         [ValidateNotNullOrEmpty()]
#         [string[]]$ListA,

#         [ValidateNotNullOrEmpty()]
#         [string[]]$ListB

#         # [switch]$ForceSensitive
#     )

#     # if(-not $ForceSensitive) {
#     #     $ListA = $ListA | % ToLower
#     #     $ListB = $ListB | % ToLower
#     # }

#     $results = [ordered]@{}
#     $SetA = [HashSet[string]]::new( [string[]]$ListA, [StringComparer]::InvariantCultureIgnoreCase )
#     $SetB = [HashSet[string]]::new( [string[]]$ListB, [StringComparer]::InvariantCultureIgnoreCase )

#     $SetA.IntersectWith( $setB )
#     $results['Intersect'] = $SetA

#     $SetA = [HashSet[string]]::new( [string[]]$ListA, [StringComparer]::InvariantCultureIgnoreCase )
#     $SetB = [HashSet[string]]::new( [string[]]$ListB, [StringComparer]::InvariantCultureIgnoreCase )

#     # $SetA -notin $results.Intersect
#     $results.'RemainingLeft' = $SetA | Where-Object {
#         $results.'Intersect' -notcontains $_
#     }
#     $results.'RemainingRight' = $SetB | Where-Object {
#         $results.'Intersect' -notcontains $_
#     }

#     [pscustomobject]$Results

#     # [hashset[string]]::new( [string[]]('a', 'b')
# }

# b.compareStringSet 'af', 'b' -ListB @('af', 'e')





# # [Dictionary[EmployeeIdKey, String]]$global:paylo_JsonCache = [Dictionary[EmployeeIdKey, String]]::new()
# class PayloJsonCache {
#     # cache JSON before the ETL is applied
#     [Collections.Generic.List[object]]$records = @()
#     [int]$SleepStepSizeMs = 1 #10


#     PayloJsonCache () {}
#     [void] LoadFromFile() {
#         $Dest = Get-Item -ea stop (Join-Path $global:appConf.prefixRootActual 'output\PayloJsonCache.json' )
#         $this.LoadFromFile( $Dest )
#     }
#     [void] SaveToFile() {
#         $Dest = Get-Item -ea stop (Join-Path $global:appConf.prefixRootActual 'output\PayloJsonCache.json' )
#         $this.SaveToFile( $Dest )
#     }
#     [void] SaveToFile( [string]$Filename ) {
#         $This.Records | ConvertTo-Json -AsArray -Depth 8 -Compress | Set-Content -Path $Filename
#         bdgLog -Category CacheEvent "PayloJsonCache::SaveToFile: $Filename"
#     }

#     [void] LoadFromFile( [string]$Filename ) {
#         [Collections.Generic.List[object]]$cache = @(
#             Get-Content -Raw (Get-Item $FileName) | ConvertFrom-Json -Depth 8
#         )
#         if ($cache.count -gt 0) {
#             $this.records = $cache
#         }
#         $this.records = $Cache
#         bdgLog -Category CacheEvent "PayloJsonCache::LoadFromFile: $Filename"
#         # $this.records.getTYpe() | out-host
#         # still right type
#     }
#     [bool] RemoveCachedValue( $Co, $EmployeeId ) {
#         if ($Co -notin (iter_CompanyIds)) { throw "Invalid Co: $Co" }
#         $target = $this.records
#         | Where-Object { $_.companyId -eq $Co }
#         | Where-Object { $_.employeeId -eq $employeeId }
#         if ($Target) {
#             $this.PayloExports.Remove( $target )
#             return $true
#         }
#         else {
#             return $false
#         }
#     }
#     [void] SetCachedValue( $Co, $EmployeeId, $Payload) {

#         $msg = "SetCachedValue( $Co, $EmployeeId )"
#         | bdgLog -Category CacheEvent '[PayloJsonCache]::SetCachedValue'

#         # $msg | write-host

#         if ($Co -notin (iter_CompanyIds)) { throw "Invalid Co: $Co, $EmployeeId," ; return; }
#         # adding always replaces existing value
#         if ($Payload -is 'string') {
#             throw 'Expected To Cache as JSON string'
#             return
#         }
#         # $ErrorActionPreference = 'break'
#         if ( -not $co ) {
#             $x = $null
#             throw 'NullCo'
#         }
#         if ( -not $EmployeeId ) {
#             $x = $null
#             throw 'NullEmp'
#         }
#         $payloadText = $payload | ConvertTo-Json -Depth 8
#         # $this.RemoveCachedValue($Co, $EmployeeId) # [global]: is removing cache?

#         $Payload | Add-Member -NotePropertyName 'companyId' -NotePropertyValue $Co -Force -PassThru -ea ignore | Out-Null


#         $maybeRecord = @{
#             employeeId = $EmployeeId
#             companyId  = $Co
#             data       = $Payload
#             lastUpdate = Get-Date
#         }
#         if ($maybeRecord) {
#             $this.records.add(  $maybeRecord )

#         }
#     }

#     [object] GetCachedValue( $Co, $EmployeeId) {
#         if ( ($null -eq $Co) -or ($null -eq $EmployeeId)) {
#             return $null
#         }
#         if ($Co -notin (iter_CompanyIds)) {
#             Write-Error "Invalid Co: $Co, requestBy $EmployeeId"
#             return $null
#         }
#         $query = $this.records
#         | Where-Object { $_.companyId -eq $Co }
#         | Where-Object { $_.employeeId -eq $employeeId }
#         | Select-Object -First 1
#         #| Select-Object -First 1

#         if ($Query ) {
#             return $Query.data
#             # return $Query
#         }
#         return $null
#     }
#     [void] ClearCache() { $This.ClearCache( $false ) }
#     [void] ClearCache( [bool]$ForceFlushFiles ) {
#         # clear all cached values
#         $this.records.Clear()
#         if ($ForceFlushFiles) {
#             # maybe dont' truncate files
#             $this.SaveToFile( $global:PathsExcel.export_PayloJsonCache )
#             $this.SaveToFile()
#         }
#     }
# }
# if ( -not (Test-Path $global:PathsExcel.export_PayloJsonCache)) {
#     New-Item -Path $global:PathsExcel.export_PayloJsonCache -ItemType File
# }

# $global:paylo_JsonCache = [PayloJsonCache]::New()
# # if ($AppConf.Debug_AlwaysEmptyJsonCache) {
# #     Write-Warning '$AppConf.Debug_AlwaysEmptyJsonCache = $true'
# #     $global:paylo_JsonCache.ClearCache()
# # }
# $global:paylo_JsonCache.LoadFromFile( $global:PathsExcel.export_PayloJsonCache )
# # $global:paylo_JsonCache.SaveToFile( $global:PathsExcel.export_PayloJsonCache )


# # $AppConf.LLogPath ??= (Join-Path $tempAppRoot 'log/main.log')

# $silentMode = @{
#     ErrorAction = 'ignore'
#     # ErrorAction = 'ignore'
# }
# $msg = 'skipCacheOnContainer? {0}' -f @( $global:__skipCacheOnContainer )
# $msg | write-warning
# $msg | write-verbose

# if ($false -and -not $global:__skipCacheOnContainer) {
#     $LocalDb.SchemaCo_812849 = Get-Content -ea 'ignore' $AppConf.Paylocity.SchemaCo_812849 | ConvertFrom-Json -Depth 13 @SilentMode
#     $LocalDb.SchemaCo_13294 = Get-Content -ea 'ignore' $appconf.Paylocity.SchemaCo_13294 | ConvertFrom-Json -Depth 13 @SilentMode


#     if (-not $AppConf.Paylocity.SchemaCo_812849) {
#         'SchemaCo_812849: falling back to inline schema def. Missing: {0}' -f @(
#             $AppConf.Paylocity.SchemaCo_812849
#         ) | Write-Verbose
#     }
#     $LocalDb.SchemaCo_812849 ??= Get-Content @silentMode (Join-Path $PSScriptRoot 'co_schema_89849.json') | ConvertFrom-Json -Depth 13 @SilentMode
#     $LocalDb.SchemaCo_13294 ??= Get-Content @silentMode (Join-Path $PSScriptRoot 'co_schema_13294.json') | ConvertFrom-Json -Depth 13 @SilentMode

#     'tried: "{0}"' -f @( Join-Path $PSScriptRoot 'co_schema_13294.json') | Write-Verbose

#     if ($false -and 'debub on: break local db for test') {
#         $LocalDb.SchemaCo_812849 = Get-Content @silentMode 'invalid path' | ConvertFrom-Json @silentMode -Depth 13
#         $LocalDb.SchemaCo_13294 = Get-Content @silentMode 'invalid path' | ConvertFrom-Json @silentMode -Depth 13
#         $localDB.CoResourceMapping = Get-Content @silentMode 'invalid path' | ConvertFrom-Json @silentMode -Depth 8
#     }
# }
# function getSemColor {
#     param(
#         [Parameter(Position = 0, Mandatory)]
#         # [ValidateSet([SemState])]
#         [SemState]$Name
#     )
#     switch ($SemState) {
#         'Warn' {
#             Get-Item fg:\Yellow
#         }
#         'Bad' {
#             Get-Item Fg:\DarkRed
#         }
#         'Good' {
#             Get-Item fg:\green
#         }
#         'BrightFg' {
#             $PSStyle.Formatting.BrightWhite
#         }
#         Default {
#             # gi fg:\gray80
#             $PSStyle.Foreground.BrightBlack
#         }
#     }
# }

# function writeSem {
#     param(
#         [Parameter(Mandatory, ValueFromPipeline)]
#         [object[]]$InputObject,

#         [Parameter(Mandatory, Position = 0)]
#         # [ValidateSet([SemState])]
#         [SemState]$SemState
#     )

#     begin {
#     }
#     process {
#         $color = getSemColor($SemState)
#         $Prefix = New-Text fg:\$Color '' | ForEach-Object tostring
#         $InputObject | Join-String -sep ', ' -op $prefix -os ($PSStyle.Reset)
#     } end {
#     }
# }

# [int]$script:__requestId = 0
# class ResponseCacheObject {
#     <#
#     I know end, because it's now

#     #>
#     [datetime]$StartedAt
#     [datetime]$EndedAt
#     [timespan]$Duration # should be a property
#     [Int]$RequestId
#     [object[]]$Response
#     [object[]]$Errors

#     # somes as a Dictionary[string,cg.IEnumerable[string]]
#     [object]$Headers


#     ResponseCacheObject (
#         [datetime]$StartedAt,
#         [object[]]$Response, # / payload
#         [object[]]$Errors,
#         [hashtable]$Options #= @{}
#     ) {
#         throw 'Not Used?'
#         $this.StartedAt = $StartedAt # fallback to null or else equal to Ended at for a duration of 0 ?
#         $this.Response = $Response
#         $this.EndedAt = [datetime]::Now
#         $this.Duration = $this.EndedAt - $this.StartedAt
#         $this.RequestId = $script:__requestId++
#         $this.Errors = $Errors

#         # $this.Session = $Options['SessionVar']
#         # $this.ResponseHeader = $Options['ResponseHeaders']
#         # $this.HTTPStatusCode = $Options['HttpStatusCode']
#     }
# }

# function resetRespCache {
#     $script:RespCache.Clear()
# }

# function Paylo-GetNewIdentity {
#     [CmdletBinding()]
#     param()

#     $irmShared = @{
#         UserAgent               = 'user agent'
#         # AllowUnencryptedAuthentication = $true
#         ContentType             = 'application/x-www-form-urlencoded'
#         # Headers                        = @{}
#         # InFile                         = ''
#         MaximumRetryCount       = 2
#         # Method                         = 'Post'
#         # OutFile                        = 'outfile'
#         # PassThru                = $true
#         ResponseHeadersVariable = 'ovHeaders'
#         RetryIntervalSec        = 1
#         # SkipCertificateCheck           = $true
#         SkipHeaderValidation    = $true
#         # SkipHttpErrorCheck             = $true
#         StatusCodeVariable      = 'ovStatus'
#         # WebSession                     = 'session'
#         # Body                           = @{}
#         # Credential                     = $cred
#         # Form                           = @{}
#     }
#     $IrmConfig.RequestMode = '-header'

#     $IrmConfig.RequestMode | b.Label 'Request Mode' | Write-Information
#     if ($false -and $IrmConfig.RequestMode -eq '-Bearer') {
#         $requestMode_bearer = @{
#             Token          = $identityToken
#             Authentication = 'Basic'
#             Uri            = $IrmConfig.AuthUrl
#             Method         = 'Post'
#         }

#         $resp = Invoke-RestMethod @irmShared @requestMode_bearer
#         $resp
#     }
#     else {
#         $requestMode_Header = @{
#             # Token          = $identityToken
#             # Authentication = 'Basic'
#             Uri    = $IrmConfig.AuthUrl
#             Method = 'Post'
#             Header = @{
#                 #  $IrmConfig.lastAuthReq
#                 'Authorization'   = 'Basic {0}' -f @(
#                     $IrmConfig.lastAuthReq
#                 )
#                 'Accept'          = '*/*'
#                 'Cache-Control'   = 'no-cache'
#                 'Host'            = 'api.paylocity.com'
#                 'Accept-Encoding' = 'gzip, deflate, br'
#                 'Connection'      = 'keep-alive'
#             }
#             Body   = @{
#                 'grant_type' = 'client_credentials'
#                 'scope'      = 'WebLinkAPI'
#             }
#         }

#         $resp = Invoke-RestMethod @irmShared @requestMode_Header

#         # $script:IrmConfig.CurToken_BearerString = $null
#         $script:IrmConfig.CurToken_BearerString = 'Bearer ' + $resp.access_token
#         $script:IrmConfig.CurToken = $resp.access_token
#         # $irmSplat.Headers.Authorization =
#         # $Global:nin.lastToken = $resp.access_token
#     }
# }



# # InitializeJumpCloud

# function InitializeBDG {
#     <#
#     .SYNOPSIS
#         Set JCAPIKey, optionally runs InitializeJumpCloud()
#     #>
#     param(
#         [ValidateNotNull()]
#         [Parameter()]
#         [hashtable]$Config
#     )

#     __writeDot Processing
#     if ( -not $Config ) {
#         $Config = $AppConf
#     }

#     bdgLog -Category ModuleEvent 'enter -> InitializeBDG'
#     $env:JCAPIKEY = Get-Content $AppConf.JumpCloudEnv

#     if (! $Config.SkipLoadingJumpCloud) {
#         bdgLog -Category ModuleEvent 'enter -> InitializeJumpCloud'
#         InitializeJumpCloud
#         bdgLog -Category ModuleEvent 'exit -> InitializeJumpCloud'
#     }

#     __writeDot Complete
#     bdgLog -Category ModuleEvent '<-- exit InitializeBDG'
# }


# # enum employeeStatus {
# #     "A"
# #     "L"
# #     "T"
# #     "XT"
# #     "D"
# #     "R"
# # }
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\optBasicDiff_only.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\ftp_fetch.ps1 #>
'📚 enter ==> other ==>  tests-invoke\LocalInvoke\invoke-fp-compare.ps1/0f760adf-f049-494f-a274-bf0876b097ac' | Write-Warning
@'
related:
- '<file:///c:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\always-exportSheets.ps1>'
- '<file:///c:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\always-mini.partial_only4_justDiff.ps1>'
- '<file:///c:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\always-exportSheets.ps1>'
'@ | Out-Null


# @(
#     $eis | fime | Format-Table -AutoSize
#     $jsi | fime | Format-Table -AutoSize
#     $ess | fime | Format-Table -AutoSize
# ) | Out-String | Write-Debug # -Debug


function b.ftp.fetchUpdates {
    [CmdletBinding()]
    param(
        [switch]$VerboseForce
    )
    '📚 ftp ==> fetch-update-import  bdg_lib\src_static\ftp_fetch.ps1/5bdf8d29-2be2-4088-b04d-6bb646af6e02' | Write-Warning
    # move to separate lambda?
    Import-Module Posh-Ssh -Verbose:$VerboseForce
    if ($VerboseForce) {
        $PSDEfaultParameterValues['Posh-SSH*:verbose'] = $true
    }
    $temp = Join-Path $appConf.prefixRootActual '.env/ftp_config.env' | Get-Item
    $FtpConfig = Get-Content $temp | ConvertFrom-Json


    $FtpConfig | Write-Debug

    $newSSHSessionSplat = @{
        ComputerName = $FtpConfig.Host.Ip
        Credential   = $myCred
        Port         = $FtpConfig.Host.Port
        Verbose      = $true
    }

    $pw = ConvertTo-SecureString $FtpConfig.Pass -AsPlainText -Force
    $myCred = [Management.Automation.PSCredential]::new($FtpConfig.User, $pw)

    $newFTPSessionSplat = @{
        ComputerName = $FtpConfig.Host.Ip
        Credential   = $myCred
        Port         = $FtpConfig.Host.Port
        Verbose      = $true
    }
    $newFTPSessionSplat = @{
        ComputerName = $FtpConfig.Host.Ip
        Credential   = $myCred
        Verbose      = $true
    }
    function b.ftp.connect {
        <#
        .synopsis
            closes all existing connections, then connects
        #>
        b.ftp.close
        'ftp => connect... $sessFTP' | Write-Host -fore magenta
        Get-SFTPSession | Remove-SFTPSession -Verbose

        $script:sessFtp = New-SFTPSession @newFTPSessionSplat
    }
    function b.ftp.close {
        # close all
        Get-SFTPSession | Remove-SFTPSession -Verbose
        # or by 1
        #Remove-SFTPSession -SessionId $script:sessFtp.SessionId
    }
    function b.ftp.copyItem {
        param(
            # [string]$FtpPathParam,
            # [string]$DestinationParam = 'paylocity_onboarding_employee_list.xlsx'
        )
        $DestinationParam = 'Onboarding Employee Report_IT.xlsx'
        $PSBoundParameters | ft | out-string | write-warning
        $fullpath = Join-Path $AppConf.ExportTemp $DestinationParam
        # return
        # Remove-Item $FullPath -ea 'ignore'
        Remove-Item $FullPath -ea 'ignore'
        # Get-SFTPItem -SessionId 0 -Path $FullPath -Destination $FtpPathParam
        Get-SFTPItem -SessionId 0 -Path 'Onboarding Employee Report_IT.xlsx' -Destination $AppConf.ExportTemp
        $FinalDest = join-path $AppConf.ExportTemp 'Onboarding Employee Report_IT.xlsx'
        gi -ea break $FinalDest
        $FinalDest = $Fullpath
        '{0} fullpath' -f @( $FullPath)
        | write-verbose


        # @(
        #     'paths'
        # $FULLPATH | Gi
        # $FTPPATHPARAM | gi
        # ) | write-warning

        # # $getByteSplat = @{
        # #     SessionId   = 0
        # #     Path        = $FtpPathParam
        # #     ContentType = 'Byte'
        # # }

        # # $scSplat = @{
        # #     Path = $FullPath
        # # }

        # # Get-SFTPContent @getByteSplat
        # # | Set-Content @scSplat
        # # # Get-SFTPContent -SessionId 0 -Path '/Onboarding Employee Report_IT.xlsx' -ContentType Byte
        # # # | sc -Path './Onboarding Employee Report_IT.xlsx'

        'ftp: wrote: "{0}" ' -f @( $Fullpath )
        | Write-Verbose -Verbose

        $null = 0
    }
    function b.ftp.gci {
        [CmdletBinding()]
        param(
            [switch]$Extra
        )
        #  $SessId =  $script:sessFtp.SessionId  )
        Get-SFTPChildItem -Verbose -SessionId 0 -Recurse -ov 'filesImplicit'

        if ( -not $Extra ) { return }

        'ftp : listing' | Write-Verbose
        Get-SFTPChildItem -Verbose -SessionId $script:sessFtp.SessionId -Recurse -ov 'filesImplicit'
        $filesImplicit.count | b.Label 'at implicit' | Write-Verbose


        Get-SFTPChildItem -Verbose -SessionId $script:sessFtp.SessionId -Path '/' -Recurse -ov 'filesAll'
        $filesAll.count | b.Label 'recursive' | Write-Verbose

    }

    # $ErrorActionPreference = 'break'
    $ErrorActionPreference = 'continue'
    ### start
    b.ftp.close
    b.ftp.connect
    # b.ftp.gci | Out-String | Write-Verbose

    # $ftpSplat = @{
    #     # FtpPath     = '/Onboarding Employee Report_IT.xlsx'
    #     # Destination = # $fullPath 'paylocity_onboarding_employee_list.xlsx'
    #     # DestinationParam = 'paylocity_onboarding_employee_list.xlsx'
    #     verbose = $true
    # }
    # wait-debugger

    b.ftp.copyItem -verbose

    b.ftp.close

    $ErrorActionPreference = 'continue'
}

function b.ftp.getFtp_EmployeeList {
    # return the imported xlsx sheet data
    $output = b.ftp.fetchUpdates
    $path = join-path $AppConf.ExportTemp 'Onboarding Employee Report_IT.xlsx'

    return [object[]]@(import-excel -Path $path -Verbose)
}

Export-ModuleMember -Function @(
    'b.ftp.fetchUpdates'
    'b.ftp.getFtp_EmployeeList'
)

"📚 exit ==> scripty body  bdg_lib\src_static\ftp_fetch.ps1/50622423-358b-4cde-9c28-96d12cd5b357" | write-verbose
# . (gi (join-path $PSScriptRoot 'ftp_push.ps1'))
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\ftp_fetch.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1 #>
$AutoCompareChangesOnlyConfig = @{
    AutoInvokeTestAtBottom    = $true
    UsingExportExcelShowParam = $false
    MainQueryArgs             = @{
        MaxLimit = 3
        # MaxLimit = 0
    }
}


function userChanges.xl.conditionalFormat.Gen2.notBlankToAll {
    <#
    .NOTES
        warning:
            worksheets are [0..., count]
                tables are [1..., count-1 ]
    #>
    [OutputType('OfficeOpenXml.ExcelPackage')]
    [CmdletBinding()]
    param(
        [Alias('Pkg')]
        [OfficeOpenXml.ExcelPackage]$ExcelPackage
    )

    # $i_max = $ExcelPackage.Workbook.Worksheets.Count
    # foreach ($i in @(1..$i_max)) {
    #     $w_sheet = $ExcelPackage.Workbook.Worksheets[$i]
    foreach ($cur_sheet in $ExcelPackage.Workbook.Worksheets) {
        <#
        # $t_max = $w_sheet.Tables.count - 1
        # bug when t <= 0
            $t_max = $w_sheet.Tables.count - 1
            foreach ($j_table in @(0..$t_max)) {
        #>
        # $t_max = $w_sheet.Tables.count - 1
        # foreach ($j_table in @(0..$t_max)) {
        foreach ($cur_table in $cur_sheet.Tables) {
            # foreach ($cur_table in $ExcelPackage.Workbook.Worksheets[ $i ].Tables) {
            #>
            try {
                $addConditionalFormattingSplat = @{
                    # Address         = $ExcelPackage.Workbook.Worksheets[ $i ].Tables[ $j_table ].Address.Address
                    Worksheet       = $cur_sheet
                    Address         = $cur_table.Address.Address
                    RuleType        = 'ContainsBlanks'
                    BackgroundColor = [excelColor]::FromRGB( 0xff, 0xbf, 0x89 ) #'#ffbf89'
                }
                Add-ConditionalFormatting @addConditionalFormattingSplat -Verbose

            }
            catch {
                # wait-debugger
                # @{
                #     # Package = $ExcelPackage
                #     workSheet   = $cur_sheet | to->Json -depth 1
                #     tableMax    = $cur_table | to->Json -depth 1
                # } | from->Json
                Write-Warning "userChanges.xl.conditionalFormat.Gen2.notBlankToAll: Exception: $_"
                Write-Error "userChanges.xl.conditionalFormat.Gen2.notBlankToAll: Exception: $_"
            }
        }
    }
    return $ExcelPackage
}

function compareUserChanges_only {
    param(
        [ArgumentCompletions(
            '@{ MaxLimit = 3 }'
        )]
        [hashtable]$Options
    )
    # [Shape_JumpCloudUser]::ConvertFrom_JCUserUpdate_CsvRecord( $payloSettings_userList[4] )

    # $rob = Get-JCUser 'rob.eastman'
    # $raw_JCUsers = ( $raw_users ??= Get-JCUser )
    # function comp
    # $global:eis._ensureDistinct()
    if (-not $global:eis) {
        Write-Warning 'missing global:eis'
    }
    # $MaxLimit = $null
    $MaxLimit = $Options.MaxLimit ?? 0
    # wait-debugger

    'comp(): using MaxLimit = {0}' -f @( $MaxLimit )
    | Write-Verbose -Verbose


    [Collections.Generic.List[Object]]$full_RawJCUserList = @(
        if ($MaxLimit -gt 0) {
            Get-JCUser | Sort-Object { [int]$_.employeeIdentifier } -Descending | Select-Object -First $MaxLimit
            Write-Warning "LimitUsers = $($MaxLimit ?? $false)"
        }
        else {
            Get-JCUser | Sort-Object { [int]$_.employeeIdentifier } -Descending

        }
    )

    Write-Warning 'extrahardcoded samples'
    $full_RawJCUserList.AddRange(@(
            Get-JCUser 'cody.manker'
            Get-JCUser 'gracie.willett'
            Get-JCUser 'jordan.stratton'
        ))

    $full_RawJCUserList | Sort-Object -Unique username # prevent dups

    # [Collections.Generic.List[Shape_JumpCloudUser]]$prevSettings_userList = $raw_jcUsers
    # [Collections.Generic.List[Shape_JumpCloudUser]]$prevSettings = @(
    [Collections.Generic.List[object]]$prevSettings = @( # just in case
        $full_RawJCUserList | ForEach-Object {
            [Shape_JumpCloudUser]::ConvertFrom_JCUser( $_ )
        }
    )
    @{
        FullList     = $full_rawJCUserList.Count
        PrevSettings = $prevSettings.Count
    } | Format-Table | Out-String | Write-Warning -wa 'Continue'

    # generate Paylo queries
    $full_RawJCUserList
    # | s -First 20
    | ForEach-Object {
        $CoId = $_.costCenter
        $EmpId = $_.employeeIdentifier
        # skip  me


        $global:eis.FetchPaylo_Employee( $CoId, $EmpId )
    } | Out-Null

    [Collections.Generic.List[object]]$payloSettings_userList = @()


    # $erroractionpreference = 'break'
    $erroractionpreference = 'continue'
    # $prevSettings | s -First 7 | %{
    $full_RawJCUserList
    # | s -First 7
    | ForEach-Object {
        $CoId = $_.costCenter
        $EmpId = $_.employeeIdentifier
        if ($CoId -eq 2000) { return <# skip myself #> }

        $global:eis.FetchPaylo_Employee( $CoId, $EmpId )
        $global:eis.ReCalculate() # could move to the outer for pefr, if it matters.

        $elem = $global:eis.JCUpdateCsv
        | Where-Object { $_.costCenter -eq $CoId -and $_.employeeIdentifier -eq $EmpId }
        | Select-Object -First 1
        if (-not $Elem) {
            'Unexpected: No Records for [CoId: {0}, EmpId: {1} ]' -f @(
                $CoId, $EmpId

            )
            | Write-Error
        }
        if ($Elem) {
            # ignore nulls
            $payloSettings_userList.Add( $elem )
        }
    }
    $erroractionpreference = 'continue'
    $global:eis.ReCalculate()

    [Collections.Generic.List[Shape_JumpCloudUser]]$newSettings = @(
        $payloSettings_userList
        | ForEach-Object {
            [Shape_JumpCloudUser]::ConvertFrom_JCUserUpdate_CsvRecord( $_ )

        }
    )


    [collections.generic.List[Object]]$users_failed_on_diff = @()

    [collections.generic.List[Object]]$all_basicDiffs = @(
        $prevSettings | ForEach-Object {
            $cur_PrevValue = $_
            $cur_NewValue = $newSettings | Where-Object {
                $_.employeeIdentifier -eq $cur_prevValue.employeeIdentifier -and
                $_.costCenter -eq $cur_PrevValue.costCenter
            } | Select-Object -First 1

            if (-not $cur_newValue) {
                'CurNewValue not found? [ CoId: {0}, EmpId: {1} ]' -f @(
                    $cur_PrevValue.costCenter ?? '?'
                    $cur_PrevValue.employeeIdentifier ?? '?'
                ) | Write-Error
                $users_failed_on_diff.add( $cur_PrevValue )
                return
            }

            if (-not (Get-Command 'optBasicDiff' -ea ignore)) {
                # Wait-Debugger
                $null = 0
            }
            # try {
            if ($cur_prevvalue.Username -match 'marilee.hodge') {
                # '🐛
                if ($false) {
                    PayloRest-GetEmployee -companyId 13294 -employeeId 13029
                    $cur_PrevValue
                    $cur_NewValue
                    @(
                        $cur_PrevValue | b.opt.addProp source prev
                        $cur_NewValue | b.opt.addProp source next
                    ) | to-xl
                    Get-JCUser marilee.hodge | s *co*, *type*
                    # wait-debugger

                }
            }

            optBasicDiff $cur_PrevValue $cur_NewValue -ea stop
            | Add-Member -NotePropertyName 'Source' -NotePropertyValue $cur_PrevValue.Username -PassThru -ea ignore -Force
            # | b.opt.addProp 'Source' $cur_PrevValue.Username
            # }
            # catch {

            # $users_failed_on_diff.add( $cur_PrevValue )

            # 'Error:  optBasicDiff for [ CoId: {0}, EmpId: {1} ]: {2}' -f @(
            #     $cur_PrevValue.costCenter
            #     $cur_PrevValue.employeeIdentifier
            #     $_.Exception.Message
            # ) | Write-Error -ea 'Continue'
            # # return

            # }
        }
    )

    [Collections.Generic.List[Object]]$Metrics = @(

        @(
            [pscustomobject]@{
                Metric = 'Ran At'
                Value  = @(
                    (Get-Date).tostring('o')
                    (Get-Date).tostring('U')
                ) -join ' '
            }
            [pscustomobject]@{
                Metric = 'payloSettings_userList'
                Value  = $payloSettings_userList
            }
            [pscustomobject]@{
                Metric = 'full_RawJCUserList'
                Value  = $full_RawJCUserList
            }
            [pscustomobject]@{
                Metric = 'payloSettings_userList'
                Value  = $payloSettings_userList
            }
            [pscustomobject]@{
                Metric = 'full_RawJCUserList'
                Value  = $full_RawJCUserList
            }
            [pscustomobject]@{
                Metric = 'prevSettings'
                Value  = $prevSettings
            }
            [pscustomobject]@{
                Metric = 'newSettings'
                Value  = $newSettings
            }
            [pscustomobject]@{
                Metric = 'users_failed_on_diff'
                Value  = $users_failed_on_diff
            }
            [pscustomobject]@{
                Metric = 'all_basicDiffs'
                Value  = $all_basicDiffs
            }
            [pscustomobject]@{
                Metric = 'eis.JCUpdateCsv.count'
                Value  = $global:eis.JCUpdateCsv.count
            }
            [pscustomobject]@{
                Metric = 'eis.PayloExports.count'
                Value  = $global:eis.PayloExports.count
            }
        ) | Sort-Object Metric -Unique

    )

    <#
    DoExcelStart
#>

    $ExcelPath = Join-Path $AppConf.ExportTemp (
        '{0}.xlsx' -f @(
            # b.opt.SafeFiletimePath
            (Get-Date).ToString('u') -replace '\s+', '_' -replace ':', '-'
        )
    )

    Remove-Item -ea ignore $ExcelPath
    $Pkg = Open-ExcelPackage -Path $ExcelPath -Create


    $xlShared = @{
        AutoSize   = $true
        TableStyle = 'Light2'
        PassThru   = $true
    }

    if (-not $pkg) {
        Write-Error "$Pkg is empty"
    }

    <#
    chunk: ExcelWorksheet
#>
    $exportExcelSplat = @{
        WorksheetName = 'PayloSettings'
        TableName     = 'PayloSettings'
        Title         = 'From the Paylocity Api'
    }


    $Pkg = $payloSettings_userList
    | Sort-Object { [int]$_.employeeIdentifier } -Desc
    | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg

    <#
    chunk: ExcelWorksheet
    #>
    $exportExcelSplat = @{
        WorksheetName = 'All'
        TableName     = 'All'
        Title         = 'All to JumpCloud'
    }

    if ($All_BasicDiffs) {
        $Pkg = $all_basicDiffs
        | Select-Object -prop 'Name', 'HasChanged', 'ExactlyEqual', 'Left', 'Right', * -ea ignore
        | Select-Object -ExcludeProperty '*true*null*'
        | Sort-Object 'Source'
        | Export-Excel -ea 'break' @xlShared @exportExcelSplat -ExcelPackage $Pkg
    }
    <#
    chunk: ExcelWorksheet
    #>
    $exportExcelSplat = @{
        WorksheetName = 'Changed'
        TableName     = 'Changed'
        Title         = 'Modified only to JumpCloud'
    }

    if ($All_BasicDiffs) {
        $Pkg = $all_basicDiffs
        | Where-Object HasChanged
        | Select-Object -prop 'Name', 'HasChanged', 'ExactlyEqual', 'Left', 'Right', * -ea ignore
        | Select-Object -ExcludeProperty '*true*null*'
        | Sort-Object 'Source'
        | Export-Excel -ea 'break' @xlShared @exportExcelSplat -ExcelPackage $Pkg
    }
    <#
    chunk: ExcelWorksheet
#>
    $exportExcelSplat = @{
        WorksheetName = 'New_JCUsers'
        TableName     = 'New_JCUsers'
        Title         = 'JumpCloud State After Writing Changes'
    }

    $Pkg = $newSettings
    | Sort-Object { [int]$_.employeeIdentifier } -Desc
    | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg

    <#
    chunk: ExcelWorksheet
#>
    $exportExcelSplat = @{
        WorksheetName = 'NotMapped'
        TableName     = 'NotMapped'
        Title         = 'to map'
    }


    if (-not $all_basicDiffs) {
        Write-Warning 'warning: empty $all_basicDiffs'
    }
    else {
        $all_basicDiffs
        | Where-Object IsBlankRight
        | Where-Object -Not IsBlankLeft
        | Sort-Object { [int]$_.employeeIdentifier } -Desc
        | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg
    }
    <#
    chunk: ExcelWorksheet
#>
    $exportExcelSplat = @{
        WorksheetName = 'Previous_JCUsers'
        TableName     = 'Previous_JCUsers'
        Title         = 'Previous State of JumpCloud Users: ConvertFrom_JCUser'
    }

    $Pkg = $prevSettings
    | Sort-Object { [int]$_.employeeIdentifier } -Desc
    | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg
    <#
    chunk: ExcelWorksheet
#>
    $exportExcelSplat = @{
        WorksheetName = 'Metrics'
        TableName     = 'Metrics'
        Title         = 'Report Metrics'
    }

    $Pkg = $metrics
    | Sort-Object { [int]$_.employeeIdentifier } -Desc
    | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg

    <#
    chunk: ExcelWorksheet
#>
    $exportExcelSplat = @{
        WorksheetName = 'errLog'
        TableName     = 'errLog'
        Title         = 'error history'
    }
    $Pkg = (
        & { # Fetch errors
                ( $global:error.clone() )
            | ForEach-Object {
                $_ | Add-Member -Force -ea ignore -PassThru -NotePropertyMembers @{
                    ShortException          = $_.ToString()

                    'FinalTrace'            = $_.Exception.ToString()
                    'CategoryInfo'          = $_.CategoryInfo
                    'FullyQualifiedErrorId' = $_.FullyQualifiedErrorId
                    'PSMessageDetails'      = $_.PSMessageDetails
                    'ErrorDetails'          = $_.ErrorDetails
                    'Exception'             = $_.Exception
                    'ScriptStackTrace'      = $_.ScriptStackTrace
                    'InvocationInfo'        = $_.InvocationInfo
                    'TargetObject'          = $_.TargetObject
                }
            }
            | Select-Object ShortException, FinalTrace, * -ea ignore
        }
        | Sort-Object { [int]$_.employeeIdentifier } -Desc
        # | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg -Show:$($AutoCompareChangesOnlyConfig.UsingExportExcelShowParam)
        | Export-Excel @xlShared @exportExcelSplat -ExcelPackage $Pkg -Show:$false
    )

    # $script:bag.ExcelPath = $ExcelPath

    # $pkg = ...



    # $Pkg = b.conditionalFormat.notBlankToAll -excelPackage $Pkg
    # b.conditionalFormat.boolean -OriginalPath $xlSplat_diffUser.Path

    # $Pkg = b.conditionalFormat.notBlankToAll -excelPackage $Pkg
    # Close-ExcelPackage -ExcelPackage $Pkg -Show

    # do deltas
    # $groups = @( $prevSettings; $newSettings ) | group { $_.CostCenter, $_.employeeIdentifier -join '_' }
    # $groups | %{
    #     $
    # }

    <#
    DoExcelEnd
#>
    # $Pkg = b.conditionalFormat.notBlankToAll -excelPackage $Pkg

    $Pkg = userChanges.xl.conditionalFormat.Gen2.notBlankToAll -ExcelPackage $Pkg

    # $addConditionalFormattingSplat = @{
    #     # Worksheet       = 'Changes'
    #     Address         = xl.Addr.Lookup -Package $Pkg Changes HasChanged
    #     RuleType        = 'ContainsText'
    #     ConditionValue  = 'TRUE'
    #     BackgroundColor = 'Red'
    # }

    # $rule = Add-ConditionalFormatting @addConditionalFormattingSplat -PassThru -Excel $Pkg
    # $rule.GetType().FullName | out-null


    'Saving... "{0}"' -f @( $Pkg.File.FullName )
    | Write-Verbose -Verbose

        if($Pkg.Workbook.Worksheets.Name -contains 'Changed') {
            $Pkg.Workbook.Worksheets.MoveToStart('Changed')
        } else {
            write-warning 'Could not find worksheet "Changed" in Excel Package'
        }

        # Write-Warning "warning: failed to move 'Changed' to start: $_"

    Close-ExcelPackage -ExcelPackage $Pkg -Show:$($AutoCompareChangesOnlyConfig.UsingExportExcelShowParam)
}
# WAIT-DEbugger
# Import-mOdule ../bdg_lib -Force -verbose:$false
# C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1
# C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self


# compareUserChanges_only -options @{ MaxLimit = 3 }
# return

@'

# [1]
err -Clear
impo .\bdg_lib\ -Force -ea stop

# need [ExcelColor]
. 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\stand_alone_entry.ps1'
. 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1'
. compareUserChanges_only -Options @{ MaxLimit = 3 }


-----------------


# [1]

    impo .\bdg_lib\ -Force -ea stop

# [2] => impo: optBasicDiff_only.ps1

    . (gi -ea stop 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\optBasicDiff_only.ps1')

# [4] => impo: auto-compare-user-changes-v4.ps1
    # contains: Shape_JumpCloudUser

. 'tests-invoke\LocalInvoke\from_aws-end\auto-compare-user-changes-v4.ps1'
    . (gi -ea stop 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\LocalInvoke\from_aws-end\auto-compare-user-changes-v4.ps1')

# [3] => impo: invokeAutoCompareUserChanges_only.ps1
#    but requires: # Shape_JumpCloudUser

# fin
#  . (gi -ea stop 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1')
# C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\LocalInvoke\from_aws-end\auto-compare-user-changes-v4.ps1


# or also req?
# . (gi (Join-Path $AppConf.prefixModuleRoot 'src_static\root_sendEmailSummary.ps1'))
. (gi -ea stop 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1')
'@



if ($AutoCompareChangesOnlyConfig.AutoInvokeTestAtBottom) {
    <# related files:
- <file:///C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\optBasicDiff_only.ps1>
    - has [optBasic]
- <file:///C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\stand_alone_entry.ps1>
    - has [ExcelColor]

- <file:///C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1>
    - is this file. requires above.

    #>
    if($True) {
        . 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\LocalInvoke\from_aws-end\auto-compare-user-changes-v4.ps1'
    }
    if ($false -and 'before concat script') {

        # import-module .\..\..\bdg_lib\ -Force -wa Continue
        . 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\stand_alone_entry.ps1'
        . 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\optBasicDiff_only.ps1'
        # sleep 4
        . 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\LocalInvoke\from_aws-end\auto-compare-user-changes-v4.ps1'
        # sleep 4
        # . 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1'
        Toast -Text 'completed execute', 'now use -show and email'

        # 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\tests-invoke\LocalInvoke\from_aws-end\auto-compare-user-changes-v4.ps1'
        # err -Clear
        # Final invoke
        Write-Warning 'invoke here: compareUserChanges_only()'
        . compareUserChanges_only -Options $AutoCompareChangesOnlyConfig.MainQueryArgs
        . (Get-Item (Join-Path $AppConf.prefixModuleRoot 'src_static\root_sendEmailSummary.ps1'))
        b.email.SendSummaryEmail -PathAttachmentFile $ExcelPath
    }

}
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\invokeAutoCompareUserChanges_only.ps1 #>
<# AutoGen: Begin: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_sendEmailSummary.ps1 #>
if($false) {
    err -clear
    'Clearing errors: {0}' -f @( $PSCommandPath )
    |  Write-verbose
}
# $DebugPreference = 'silentlycontinue'
# $VerbosePreference = 'silentlycontinue'

function b.Text.Encoding {
    <#
    .SYNOPSIS
        sugar for returning a [Text.Encoding.Encoder] instance
    .EXAMPLE
        b.Text.Encoder 'utf8'

        'utf8' | b.Text.Encoder
    .EXAMPLE
        (b.Text.Encoder utf8).GetBytes('test')

        # out:
        116, 101, 115, 116
    .EXAMPLE
        (b.Text.Encoder utf8).GetString(116, 101, 115, 116)
    .LINK
        b.Text.Encode
    .LINK
        b.Text.Decode
    .LINK
        b.Text.Encoder
    #>
    [Alias('Text.Encoder')]
    [CmdletBinding()]
    param(
        [Parameter(mandatory, ValueFromPipeline, Position = 0)]
        [ArgumentCompletions('Utf-8', 'ascii', 'Unicode', 'utf-16le', 'utf-16be', 'utf-32le', 'utf-32be')]
        [string]$Encoding = 'utf-8'
    )
    if ($Encoding -eq 'utf8') { $Encoding = 'utf-8' } # alias it
    $encDir = [Text.Encoding]::GetEncoding( $Encoding)
    return $encDir
}

function b3.Text.Decode {
    # decodes bytes in a given encoding
    <#
    .EXAMPLE
        b.Text.Decode 'utf8' -Bytes 116, 101, 115, 116

    # out:
        test
    #>
    [OutputType('System.String')]
    [Alias('Text.GetString')]
    [CmdletBinding(defaultParameterSetName = 'fromPipeline')]
    param(
        [Parameter(mandatory, Position = 0)]
        [ArgumentCompletions('Utf-8', 'ascii', 'Unicode', 'utf-16le', 'utf-16be', 'utf-32le', 'utf-32be')]
        [string]$Encoding = 'utf-8',

        [Parameter(mandatory, Position = 1)]
        [Parameter(mandatory, ValueFromPipeline, ParameterSetName = 'fromPipeline')]
        [byte[]]$Bytes
    )
    $encDir = b.Text.Encoder $Encoding
    $encDir.GetString($Bytes)
    return
}
function b.Text.Encode {
    <#
    .synopsis
        Both gets an encoder, and encodes text in one go
    .EXAMPLE
        b.Text.Decode 'utf8' -Bytes 116, 101, 115, 116

    # out:
        test
    #>
    [OutputType('[System.Byte[]]')]
    [Alias('Text.GetBytes')]
    [CmdletBinding()]
    [CmdletBinding(defaultParameterSetName = 'fromPipeline')]
    param(
        [Parameter(mandatory, Position = 0)]
        [ArgumentCompletions('Utf-8', 'ascii', 'Unicode', 'utf-16le', 'utf-16be', 'utf-32le', 'utf-32be')]
        [string]$Encoding = 'utf-8',

        [Parameter(mandatory, Position = 1)]
        [Parameter(mandatory, ValueFromPipeline, ParameterSetName = 'fromPipeline')]
        [string[]]$Text
    )
    begin {
        $encDir = b.Text.Encoder $Encoding
    }
    process {
        $encDir.GetString($Bytes)
    }
}

function b.Text.Decode {
    # decodes bytes in a given encoding
    <#
    .SYNOPSIS
        Both gets an encoder, and decodes bytes
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [byte[]]$Bytes,

        [string]$Encoding = 'utf8'
    )
    begin {
        $encDir = b.Text.Encoder $Encoding
    }
    process {
        $encDir.GetString($Bytes)
    }
    # process {
    # [System.Text.Encoding]::ge ($Encoding).GetString($InputObject)
    # get encoder
    # $encoder = [System.Text.Encoding]::GetEncoding($Encoding)
    # }

}

if($false) {
    err -clear
    'Clearing errors: {0}' -f @( $PSCommandPath )
    |  Write-verbose
}
if ($false -and 'always force') {
    Import-Module ../../bdg_lib -ea stop -Verbose:$false -DisableNameChecking -Force:$true *>$null
    try {
        Import-Module 'AWS.Tools.SimpleEmailV2' -PassThru -ea stop | Format-Table
    }
    catch {
        $installAWSToolsModuleSplat = @{
            CleanUp = $true
            Name    = 'AWS.Tools.SimpleEmailV2'
            # Name = 'AWS.Tools.SimpleEmail', 'AWS.Tools.SimpleEmailV2'
            Force   = $true
        }

        Install-AWSToolsModule @installAWSToolsModuleSplat #manual invoke
    }
    finally {
        Import-Module 'AWS.Tools.SimpleEmailV2' -PassThru
    }
}
$docString = @'

## About

Isolated test to generate attachment email

## Notes

https://docs.aws.amazon.com/powershell/latest/reference/Index.html

- configurationSets: https://docs.aws.amazon.com/ses/latest/dg/using-configuration-sets.html
- aws cli:  <https://docs.aws.amazon.com/ses/latest/dg/configuration-sets-export-metrics.html>

- https://docs.aws.amazon.com/ses/latest/dg/verify-addresses-and-domains.html
- https://docs.aws.amazon.com/powershell/latest/reference/Index.html

> `-Select` parameter to control the cmdlet output. The default value is 'MessageId'.

Specifying -Select '*' will result in the cmdlet returning the
     whole service response (Amazon.SimpleEmail.Model.SendEmailResponse).

Specifying the name of a property of type
    Amazon.SimpleEmail.Model.SendEmailResponse
    will result in that property being returned.

Specifying -Select '^ParameterName' will result in the cmdlet

    returning the selected cmdlet parameter value.

'@



function b3.Html.Table {
    <#
    .SYNOPSIS
        render html table
    .example
        $selectEnvVarKeys = 'TMP', 'TEMP', 'windir'
        $selectKeysOnlyHash = @{}
        ls env: | ?{
            $_.Name -in @($selectEnvVarKeys)
        } | %{ $selectKeysOnlyHash[$_.Name] = $_.Value}

        #>
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory)]
        [hashtable]$InputHashtable
    )
    $renderBody = $InputHashTable.GetEnumerator() | ForEach-Object {
        '<tr><td>{0}</td><td>{1}</td></tr>' -f @(
            $_.Key ?? '?'
            $_.Value ?? '?'
        )

    } | Join-String -sep "`n"
    $renderFinal = @(
        '<table>'
        $renderBody
        '</table>'
    ) | Join-String -sep "`n"
    return $renderFinal
    # '<table>'
    # '</table>'

}

function new.HtmlContent.EnvVar {
    # function __testMailWithoutAttachment
    #     $MailConfig = @{
    #         FromAddress = 'jake.bolton.314@gmail.com'
    #         ToAddress   = 'bdg.it@bustle.com'
    #     }
        [string]$htmlTemplate = @'
<html>
<header>
    <title>Test: JumpCloud Summary</title>
    <style>
        table, th, td {{
            font-size: 16px;
            border: 1px solid black;
            border-collapse: collapse;
        }}
    </style>
</header>
<body>

{0}
</html></body>
'@

        $SelectEnvVarKeys = @(
            'AWS_DEFAULT_REGION'
            'AWS_ACCOUNT_ID'
            '_HANDLER'
            'AWS_LAMBDA_FUNCTION_HANDLER'
            'AWS_LAMBDA_FUNCTION_MEMORY_SIZE'
            'AWS_LAMBDA_FUNCTION_NAME'
            'AWS_LAMBDA_FUNCTION_TIMEOUT'
            'AWS_LAMBDA_FUNCTION_VERSION'
            'AWS_LAMBDA_LOG_GROUP_NAME'
            'AWS_LAMBDA_LOG_STREAM_NAME'
            'AWS_LAMBDA_RUNTIME_API'
            'AWS_REGION'
            'OS'
            'AWS_SAM_LOCAL'
        ) | Sort-Object -Unique

        $selectKeysOnlyHash = @{}
        Get-ChildItem env: | Where-Object {
            $_.Name -in @($selectEnvVarKeys)
        } | ForEach-Object { $selectKeysOnlyHash[$_.Name] = $_.Value }

        if($selectKeysOnlyHash.Keys.count -eq 0) {
            throw 'No matching env vars found from $SelectEnvVarKeys'

        }
        $renderTable = b3.Html.Table -InputHashtable $selectKeysOnlyHash



        # AWS_DEFAULT_REGION              us-east-1
        # AWS_ACCOUNT_ID                  123456789012
        # _HANDLER                        examplehandler.ps1::handler
        # AWS_LAMBDA_FUNCTION_HANDLER     examplehandler.ps1::handler
        # AWS_LAMBDA_FUNCTION_MEMORY_SIZE 1024
        # AWS_LAMBDA_FUNCTION_NAME        PowerShellFunction
        # AWS_LAMBDA_FUNCTION_TIMEOUT     100
        # AWS_LAMBDA_FUNCTION_VERSION     $LATEST
        # AWS_LAMBDA_LOG_GROUP_NAME       aws/lambda/PowerShellFunction
        # AWS_LAMBDA_LOG_STREAM_NAME      $LATEST
        # AWS_LAMBDA_RUNTIME_API          127.0.0.1:9001
        # AWS_REGION                      us-east-1
        # AWS_SAM_LOCAL                   true


        $renderBody = $renderTable
        $renderHtml = $htmlTemplate -f @(
            $renderBody -join "`n"
        ) | Join-String -sep "`n"


        $renderHtml
}
        <#
- <https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_SendEmail.html#API_SendEmail_RequestBody>
- sendMail: <https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_SendEmail.html#API_SendEmail_RequestBody>
- sendMail: ApiV2: <https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_SendEmail.html>
- if failed, may require: https://aws.amazon.com/premiumsupport/knowledge-center/ec2-port-25-throttle/

#>

function new.RawEmail.WithDynamicAttachment.v2 {
    # create a raw email including attachment file
    # https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-raw.html
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $FileAttachmentPath,

        [Parameter(Mandatory)]
        $Config
    )
    $file_attachItem = Get-Item $FileattachmentPath -ea stop
    $MailConfig1 = @{
        From = '"Jake Bolton" <jake.bolton.314@gmail.com>'
        To   = 'bdg.it@bustle.com'
    }


    $Cfg = @{
        From                    = $Config.From ?? 'jake.bolton.314@gmail.com'
        To                      = $Config.To ?? 'bdg.it@bustle.com'
        Subject                 = $Config.Subject ?? 'JumpCloud Changes: Feb 23 2023'
        CreationDate            = $Config.CreationDate ?? 'Sat, 05 Aug 2022 19:35:36 GMT'
        BaseName                = $file_attachItem.Name
        BodyContent_Text        = $Config.BodyText ?? 'blank'
        BodyContent_Html        = $Config.BodyHtml ?? '<p>blank</p>'
        Attachment_Base64String = ''
        Raw_Data                = $null
        #         $AttachmentType = 'application/octet-stream'
        # $AttachmentDisposition = 'attachment'
        # $AttachmentEncoding = 'base64'
    }
    $Cfg.Attachment_Base64String = [System.Convert]::ToBase64String(
        [System.IO.File]::ReadAllBytes($file_attachItem.FullName) )

    Write-Warning 'enter: new.RawEmail.WithDynamicAttachment.v2'

    $Cfg.BodyContent_Text = @(
        'body text'
        ''
        'line3'
    ) | Join-String -sep "`n" #A re


    $Cfg.BodyContent_Html = new.HtmlContent.EnvVar


    $final_rawEmailBodyTemplate = @"
From: $( $Cfg.From )
To: $( $Cfg.To )
Subject: $( $Cfg.Subject )
Content-Type: multipart/mixed;
    boundary="emailDelim"

--emailDelim
Content-Type: multipart/alternative;
    boundary="sub_emailDelim"

--sub_emailDelim
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

$( $Cfg.BodyContent_Text )

--sub_emailDelim
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

$( $Cfg.BodyContent_Html )

--sub_emailDelim--

--emailDelim
Content-Type: text/plain; name="$( $Cfg.BaseName )"
Content-Description: $( $Cfg.BaseName )
Content-Disposition: attachment;filename="$( $Cfg.BaseName )";
    creation-date="$( $Cfg.CreationDate )";
Content-Transfer-Encoding: base64

$( $Cfg.Attachment_Base64String )
--emailDelim--
"@

    $Cfg.Raw_Data = $final_rawEmailBodyTemplate


    $Cfg | Format-Table -auto | Out-String | Write-Debug
    $sendSES2_EmailSplat = @{
        FromEmailAddress      = 'jake.bolton.314@gmail.com'
        Destination_ToAddress = 'bdg.it@bustle.com'
        Raw_Data              = $final_rawEmailBodyTemplate

    }

    #localdebug
    # $sendSES2_EmailSplat.Raw_Data | sc 'temp:\email.txt'
    # Get-Item Temp:\email.txt | Join-String -double -op 'wrote: '

    Send-SES2Email -Raw_Data $sendSES2_EmailSplat.Raw_Data -Verbose #-Confirm
    'exit: new.RawEmail.WithAttachment.v2'
}

<#
@(
    Get-Command Send-SES2Email | Get-ParameterInfo | Format-Table -AutoSize
    Get-Command Send-SESRawEmail | Get-ParameterInfo | Format-Table -AutoSize
) | out-string | write-debug
#>



function b.email.SendSummaryEmail {
    param(
        [Parameter(Mandatory)]
        $PathAttachmentFile
    )
    $toAttach_itemXlsx = Get-Item -ea stop $PathAttachmentFile
     #'C:\Users\cppmo_000\SkyDrive\2022\xl\bdg\JumpCloud_Changes.2023-02-15_12-12-08Z.xlsx'

    $splat_dynamicEmail_xlsx = @{
        Config             = @{
            From = '"Jake Bolton" <jake.bolton.314@gmail.com>'
            To   = 'bdg.it@bustle.com'
        }
        FileAttachmentPath = $toAttach_itemXlsx
    }

    'attaching xlsx to email: {0}' -f @(
        $toAttach_itemXlsx | Join-String -double
    )
    | write-verbose
    new.RawEmail.WithDynamicAttachment.v2 @splat_dynamicEmail_xlsx -verbose
}

# $summaryFileToAttach = 'C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\output\final-excel-debug-v2.xlsx'
# b.email.SendSummaryEmail -PathAttachmentFile $summaryFileToAttach -Verbose
# b.email.SendSummaryEmail -PathAttachmentFile 'G:\temp\xl\JumpCloud_Changes.2023-02-20_07-30-52Z.xlsx' -Verbose

@'
try:
    $eis.PostCtorInit()
    $eis.ExportCsv()
    sleep 4
    $eis.ExportDiagnosticInfo()
    sleep 4
    $eis.ExportExcelDebug()
    sleep 3
    Toast -Text 'finished', '$eis.debug' -Sound Alarm4
'@
<# AutoGen: EndOf: C:\Users\cppmo_000\SkyDrive\Documents\2022\client_BDG\self\bdg_lib\src_static\root_sendEmailSummary.ps1 #>
