[cmdletbinding()]
param(
    [validateset("1x2","2x4","4x8","8x16")]
    $vm_size,
    [validateset("ubuntu-17.10")]
    $os,
    [switch]$test
)

$ErrorActionPreference = "stop"

switch ($vm_size) {
    "1x2"  { $memory = "2048MB"; $cpu = 1 }
    "2x4"  { $memory = "4096MB"; $cpu = 2 }
    "4x8"  { $memory = "8192MB"; $cpu = 4 }
    "8x16" { $memory = "16384MB"; $cpu = 8 }
}
switch ($os){
    "ubuntu-17.10" { $image = "artful-server-cloudimg-amd64.vhd" }
}
$image_archive = $image + 'zip'
$path = 'c:\temp'
$unc_path = '\\nas1.magiccityit.com\os_iso'
$unc_archive = Join-Path $unc_path -ChildPath $image_archive
$archive_path = Join-Path -Path $path -ChildPath $image_archive
$image_path = Join-Path -Path $path -ChildPath $image
$gen2_image_path = $image_path + 'x'

if (!(Test-Path $archive_path)){
    cp $unc_archive $archive_path
}
if (!(Test-Path $image_path)){
    Expand-Archive -Path $image_path -DestinationPath $path
}
Convert-VHD -Path $image_path -DestinationPath $gen2_image_path `
    -VHDType Dynamic
new-vm -Name $vm_name -MemoryStartupBytes $memory -SwitchName "hyper-v" `
    -VHDPath $vhd_path -Generation 2
set-vm -Name $vm_name -ProcessorCount $cpu -StaticMemory
Set-VMFirmware -VMName $vm_name -EnableSecureBoot $false

if ($test){
    Get-VM -Name $vm_name | Remove-VM
}