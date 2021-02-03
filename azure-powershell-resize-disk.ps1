# Variables
$ResourceGroupName = 'resourcegroup1'
$vm = 'vm1'
$diskname = 'vm1_data_disk_0'
$newdisksize ='128'


# Get Disks Name
Get-AzDisk -ResourceGroupName $ResourceGroupName `
           -DiskName $vm.StorageProfile.OsDisk.Name | Select-Object Name,OsType,DiskSizeGB


# Check Disk Name
Get-AzDisk -ResourceGroupName $ResourceGroupName `
           -DiskName $diskname | Select-Object Name,OsType,DiskSizeGB


# Deallocate VM
stop-azvm -ResourceGroupName $resourcegroupname -name $vm -force


# Update Disk
$disk= Get-AzDisk -ResourceGroupName $ResourceGroupName `
                  -DiskName $diskname

$disk.DiskSizeGB = $newdisksize
Update-AzDisk -ResourceGroupName $ResourceGroupName `
              -Disk $disk  `
              -DiskName $disk.Name


# Start $VM
start-azvm -ResourceGroupName $resourcegroupname -name $vm