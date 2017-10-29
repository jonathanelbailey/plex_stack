[cmdletbinding()]
param(
    $vm_name,
    [validateset("1x2","2x4","4x8","8x16")]
    $vm_size,
    [validateset("ubuntu-17.10")]
    $os
)

$ErrorActionPreference = "Stop"

switch ($vm_size) {
    "1x2"  { $memory = 2GB; $cpu = 1 }
    "2x4"  { $memory = 4GB; $cpu = 2 }
    "4x8"  { $memory = 8GB; $cpu = 4 }
    "8x16" { $memory = 16GB; $cpu = 8 }
}
switch ($os){
    "ubuntu-17.10" { $image = "artful-server-cloudimg-amd64.vhd" }
}
$image_archive = $image + '.zip'
$path = 'c:\temp'
$unc_path = '\\nas1.magiccityit.com\os_iso'
$unc_archive = Join-Path $unc_path -ChildPath $image_archive -Verbose
$archive_path = Join-Path -Path $path -ChildPath $image_archive -Verbose
$image_path = Join-Path -Path $path -ChildPath $image -Verbose
try{
    if (!(Test-Path $archive_path)){
        cp $unc_archive $archive_path -Verbose
    }
    if (!(Test-Path $image_path)){
        Expand-Archive -Path $image_path -DestinationPath $path -Verbose
    }

    new-vm -Name $vm_name -MemoryStartupBytes $memory -SwitchName "hyper-v" `
        -VHDPath $image_path -Generation 1 -Verbose
    set-vm -Name $vm_name -ProcessorCount $cpu -StaticMemory -Verbose
}
catch{
    exit 1
}