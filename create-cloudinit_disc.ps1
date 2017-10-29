$ErrorActionPreference = "Stop"

$GuestAdminPassword = "P@ssw0rd"
$path = 'c:\temp'
$work = Join-Path $path -ChildPath 'work'
$oscd_path = Join-Path $path -ChildPath 'oscdimg.exe'
$unc_path = '\\nas1.magiccityit.com\os_iso\oscdimg.exe'
$metadata_iso = Join-Path $path -ChildPath 'metadata.iso'
try{
    if (!(Test-Path $oscd_path)){
        cp $unc_path $oscd_path -Verbose
    }
    if (Test-Path $metadata_iso){
        Remove-Item $metadata_iso -Force
    }
}
catch{
    exit 1
}
$metadata = @"
instance-id: $((get-vm -Name $env:vm_name).VMId)
local-hostname: $($env:vm_name)
"@
 
$userdata = @"
#cloud-config
password: $($GuestAdminPassword)
runcmd:
 - [ useradd, -m, -p, "", magicadmin ]
 - [ chage, -d, 0, magicadmin ]
"@

try{
    if (!(Test-Path $work)){
        md $work -Verbose
    }
    sc "$($work)\meta-data" ([byte[]][char[]] "$metadata") -Encoding Byte -Verbose
    sc "$($work)\user-data" ([byte[]][char[]] "$userdata") -Encoding Byte -Verbose
    Start-Process $oscd_path -ArgumentList $work,$metadata_iso,"-j2 -lcidata" -Wait -Verbose
    Add-VMDvdDrive -VMName $env:vm_name -Path $metadata_iso -Verbose
}
catch{
    exit 1
}