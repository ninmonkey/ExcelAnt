# disk space available in VHD
# <https://learn.microsoft.com/en-us/windows/wsl/disk-space#how-to-check-your-available-disk-space>
wsl --system -d Ubuntu df -h /mnt/wslg/distro
# https://learn.microsoft.com/en-us/windows/wsl/disk-space#how-to-check-your-available-disk-space

# open in windows
explorer.exe '\\wsl$\Ubuntu'

#
(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq 'Ubuntu' }).GetValue("BasePath") + "\ext4.vhdx"
'<https://learn.microsoft.com/en-us/windows/wsl/wsl2-mount-disk#attaching-the-disk-without-mounting-it>'
# nin@nin8:~$
lsblk


<#
NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0   7:0    0 358.4M  1 loop /mnt/wsl/docker-desktop/cli-tools
loop1   7:1    0 185.5M  1 loop
sda     8:0    0 363.1M  1 disk
sdb     8:16   0     4G  0 disk [SWAP]
sdc     8:32   0   256G  0 disk /mnt/wsl/docker-desktop/docker-desktop-user-distro
sdd     8:48   0   256G  0 disk /mnt/wsl/docker-desktop-data/isocache
sd

<e     8:64   0   256G  0 disk /mnt/wslg/distro
#>
