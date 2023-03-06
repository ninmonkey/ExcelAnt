#  'https://docs.docker.com/desktop/windows/wsl/#best-practices'
$Paths = @{ Root = Get-Item $PSSCriptRoot }
$Paths += @{
    Source = @{
        first = Get-Item (Join-Path $Paths.Root 'proc.cpuinfo.txt')
    }
}
[Collections.Generic.List[Object]]$script:records = @()
$Id = 0
function wsl.GetVhdx {
    <#
    .EXAMPLE
        wsl.GetVhdx

            C:\Users\cppmo_000\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\ext4.vhdx
    #>
    (Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq 'Ubuntu' }).GetValue("BasePath") + "\ext4.vhdx"
}

function _collect.lineGrouping2 {
    $curHash = [ordered]@{}

    Get-Content $Paths.Source.first
    | ForEach-Object {
        if ($_ -notmatch ':') {
            $id++
            continue
        }
        else {
            $Key, $Value = $_ -split '\s+:\s+', 2
            '{0} => {1}' -f @( $Key, $Value ) | Write-Verbose -Verbose
            $curHash[$Key] = $Value
            $curHash.GroupId = $Id

            $records.Add(
                [pscustomobject]$curHash
            )
        }

        $records
        | Where-Object { $_ }
        | CountIt
        $records.count
        $null = 0

    }
}

function _collect.lineGrouping {
    $curHash = [ordered]@{}
    Get-Content $Paths.Source.first
    | ForEach-Object {
        if ($_ -notmatch ':') {
            if (-not $curhash) {
                Write-Warning 'emptyCurHash'
                continue
            }
            $records.Add(  [pscustomobject]$curHash )
            $curHash = @{}
            continue
        }
        else {
            $Key, $Value = $_ -split '\s+:\s+', 2
            '{0} => {1}' -f @( $Key, $Value ) | Write-Verbose -Verbose
            $curHash[$Key] = $Value
        }

        $null = 0

    }
    $records
    $records.count
    $null = 0

}

_collect.lineGrouping2
# $Paths = mergeHash $Paths (Get-ChildItem -Path $Paths.Root -Recurse -File -Filter *.log | Group-Object -Property DirectoryName | Select-Object -ExpandProperty Group | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1)
