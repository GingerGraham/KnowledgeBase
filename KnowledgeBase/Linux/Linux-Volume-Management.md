# Linux Volume Management

## Introduction

It is often required to manage disk volumes on a Linux system including creating, deleting, resizing, and formatting individual volumes or creating RAID arrays.

Typically this requires knowledge of `lvm` to effectively provision newly attached disks and manage the existing volumes.

## Tools

When working with volumes on a Linux system, the following tools are useful:

### Block Device and Logical Volume Tools

- `lsblk` - list block devices
- `fdisk` - create, delete, and modify partitions
- `df` - show disk usage

### Logical Volume Management (LVM) Tools

- `pvcreate` - create a physical volume
- `pvdisplay` - display physical volume information
- `pvremove` - remove a physical volume
- `vgcreate` - create a volume group
- `vgdisplay` - display volume group information
- `vgremove` - remove a volume group
- `lvcreate` - create a logical volume
- `lvdisplay` - display logical volume information
- `lvremove` - remove a logical volume
- `lvextend` - extend a logical volume
- `lvreduce` - reduce a logical volume
- `lvresize` - resize a logical volume
- `lvscan` - scan for logical volumes
- `vgscan` - scan for volume groups
- `pvscan` - scan for physical volumes

### RAID Tools

- `mdadm` - manage RAID arrays

### Filesystem Tools

- `mkfs` - create a filesystem
- `/etc/fstab` - mount filesystems at boot

## Provision A New Volume

In the following example we will provision new disk block devices as individual volumes and mount them to directories in the filesystem.

We will assume that the disks are already physically connected to the system and are available as block devices.

In this tutorial we will be working with Linux LVM partitions (`8e`) however there are many other types depending on your requirements.  See <https://linuxconfig.org/list-of-filesystem-partition-type-codes> for a list of available partition types.

1. Inspect current block devices and disk configuration
   1. Show volumes: `df -h`
   2. List block devices: `lsblk`
   3. Show disk layout: `fdisk -l`
2. Create new partitions
   1. For each block volume not already provisioned
   2. Enter disk format utility: `: fdisk /dev/sdb`
      1. Replace /dev/sdb with device as required, e.g. /dev/sdc
   3. Create a new partition: `n`
   4. Create a primary partition: `p`
   5. Select a partition number: `enter`
      1. Default is 1, this is typically the value required
   6. Select starting sector: `enter`
      1. Default is 2048, this is typically the value required
   7. Select ending sector: `enter`
      1. Default is the end of the disk, this is typically the value required
   8. Set partition type: `t`
   9.  Set partition as Linux LVM: `8e`
   10. Write changes to disk: `w`
   11. Repeat for each block device
3.  Update kernel with new block devices
    1. Rescan for new block devices: `partprobe`
4. Inspect new block devices
   1. List block devices: `lsblk`
   2. Show volumes: `df -h`
   3. Confirm that there are no changes to `df -h` but that `lsblk` shows the new partitions
5. Create a physical volume for each new partition
   1. Create a physical volume: `pvcreate /dev/sdb1`
      1. Replace /dev/sdb1 with device as required, e.g. /dev/sdc1
   2. Repeat for each new partition
6. Create a volume group for the new physical volumes
   1. Create a volume group: `vgcreate vg01 /dev/sdb1`
      1. Replace /dev/sdb1 with device as required, e.g. /dev/sdc1
      2. Update the volume group name as required, `vg01`, `vg02`, etc.
   2. Repeat for each new partition
7. Create a logical volume for the new volume group
   1. Create a logical volume: `lvcreate -n lv01 -L 10G vg01`
      1. Replace `vg01` with the volume group name as required
      2. Update the logical volume name as required, `lv01`, `lv02`, etc.
      3. Update the logical volume size as required, `10G`, `20G`, etc.
      4. Alternatively to specify the entire free size of the volume group, use `-l 100%FREE`
         1. e.g. `lvcreate -n lv01 -l 100%FREE vg01`
   2. Repeat for each new volume group
8. Set a filesystem on the new logical volume
   1. Create a filesystem: `mkfs.ext4 /dev/vg01/lv01`
      1. Replace `/dev/vg01/lv01` with the logical volume as required
   2. Alternatively `/dev/mapper` can be used to reference the logical volume
      1. e.g. `mkfs.ext4 /dev/mapper/vg01-lv01`
9. Update the filesystem table `fstab`
   1.  Take a backup of the current `fstab` file: `cp /etc/fstab /etc/fstab.bak`
   2.  Add new lines, as required, to the `fstab` file
       1.  e.g. `/dev/mapper/vg01-lv01 /mnt/lv01 ext4 defaults 0 0`
       2.  Could use `echo` here to write to the file
           1.  e.g. `echo "/dev/mapper/vg01-lv01 /mnt/lv01 ext4 defaults 0 0" >> /etc/fstab`
       3.  Update the device, mount point, filesystem type, and options as required
   3.  Verify the new lines have been added to the `fstab` file
       1.  e.g. `cat /etc/fstab`
10. [Optional] Mount the new filesystem
    1.  Mount the new filesystem: `mount /mnt/lv01`
        1.  Replace `/mnt/lv01` with the mount point as required
    2.  Alternatively the filesystem can be mounted at boot
        1.  e.g. `mount -a`
    3.  Further alternative, when mounting the filesystem type and options can be specified
        1.  e.g. `mount -t ext4 -o defaults /dev/mapper/vg01-lv01 /mnt/lv01`
11. Inspect the new filesystem
    1.  Show volumes: `df -h`
    2.  List block devices: `lsblk`
    3.  Should now see the new filesystem mounted to the specified mount point
12. [Optional] Reboot the system and confirm that the new filesystem is mounted at boot
    1.  Reboot the system: `reboot`
    2.  Confirm that the new filesystem is mounted at boot
        1.  Show volumes: `df -h`
        2.  List block devices: `lsblk`
        3.  Should now see the new filesystem mounted to the specified mount point

### Example of commands used

```bash
#  Adding two new block volumes, sdb and sdc, to two new volume groups
df -h
lsblk
fdisk -l
fdisk /dev/sdb # n p 1 enter enter t 1 8e w
fdisk /dev/sdc # n p 1 enter enter t 1 8e w
partprobe
lsblk
fdisk -l
pvcreate /dev/sdb1
pvcreate /dev/sdc1
vgcreate vg01 /dev/sdb1
vgcreate vg02 /dev/sdc1
lvcreate -n pssvol -l +100%FREE vg01
lvcreate -n logvol -l +100%FREE vg02
mkfs.ext4 /dev/mapper/vg01-pssvol
mkfs.ext4 /dev/mapper/vg02-logvol
mkdir /pss
mkdir /log
cp /etc/fstab /etc/fstab.BAK
echo "/dev/mapper/vg01-pssvol /pss ext4
defaults 1 2" >> /etc/fstab
echo "/dev/mapper/vg02-logvol /log ext4
defaults 1 2" >> /etc/fstab
cat /etc/fstab
mount -t ext4 /dev/mapper/vg01-pssvol /pss
mount -t ext4 /dev/mapper/vg02-logvol /log
df -h
lsblk
systemctl reboot now
df -h
lsblk
```

### Full example with output

```bash
# df -h # Check disk volumes
[root@dc1vpvoceraapp2 ~]# df -h
Filesystem Size Used Avail Use% Mounted on
devtmpfs 12G 0 12G 0% /dev
tmpfs 12G 0 12G 0% /dev/shm
tmpfs 12G 8.6M 12G 1% /run
tmpfs 12G 0 12G 0% /sys/fs/cgroup
/dev/mapper/vg00-slashvol 16G 2.1G 13G 14% /
/dev/sda1 465M 144M 294M 33% /boot
tmpfs 2.4G 0 2.4G 0% /run/user/0

#lsblk # Inspect block devices
[root@dc1vpvoceraapp2 ~]# lsblk
NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda 8:0 0 20G 0 disk
sda1 8:1 0 488M 0 part /boot
sda2 8:2 0 19.5G 0 part
 vg00-slashvol 253:0 0 15.8G 0 lvm /
 vg00-swapvol 253:1 0 3.7G 0 lvm [SWAP]
sdb 8:16 0 20G 0 disk
sdc 8:32 0 100G 0 disk
sr0 11:0 1 1024M 0 rom

#fdisk -l # Inspect partitions
[root@dc1vpvoceraapp2 ~]# fdisk -l
Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xa330f7e7
Device Boot Start End Sectors Size Id Type
/dev/sda1 * 2048 1001471 999424 488M 83 Linux
/dev/sda2 1001472 41943039 40941568 19.5G 8e Linux LVM
Disk /dev/sdc: 100 GiB, 107374182400 bytes, 209715200 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/mapper/vg00-slashvol: 15.8 GiB, 16953376768 bytes, 33112064
sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/mapper/vg00-swapvol: 3.7 GiB, 4001366016 bytes, 7815168
sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

#fdisk /dev/sdb # Create a new partition
#n # New partition
#p # Primary partition
#1 # Partition number (default)
#Enter # First sector (default)
#Enter # Last sector (default)
#t # Change partition type
#8e # Linux LVM
#w # Write changes
#Repeat for /dev/sdc
[root@dc1vpvoceraapp2 ~]# fdisk /dev/sdc
Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.
Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xa7427dbe.
Command (m for help): n
Partition type
 p primary (0 primary, 0 extended, 4 free)
 e extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-209715199, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-209715199, default
209715199):
Created a new partition 1 of type 'Linux' and of size 100 GiB.
Command (m for help): t
Selected partition 1
Hex code (type L to list all codes): 8e
Changed type of partition 'Linux' to 'Linux LVM'.
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

#partprobe # Update kernel partition table
[root@dc1vpvoceraapp2 ~]# partprobe

#lsblk # Inspect block devices - should see sdb1 and sdc1
[root@dc1vpvoceraapp2 ~]# lsblk
NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda 8:0 0 20G 0 disk
sda1 8:1 0 488M 0 part /boot
sda2 8:2 0 19.5G 0 part
 vg00-slashvol 253:0 0 15.8G 0 lvm /
 vg00-swapvol 253:1 0 3.7G 0 lvm [SWAP]
sdb 8:16 0 20G 0 disk
sdb1 8:17 0 20G 0 part
sdc 8:32 0 100G 0 disk
sdc1 8:33 0 100G 0 part
sr0 11:0 1 1024M 0 rom

#pvcreate /dev/sdb1 # Create physical volume
[root@dc1vpvoceraapp2 ~]# pvcreate /dev/sdb1
 Physical volume "/dev/sdb1" successfully created.

#vgcreate vg01 /dev/sdb1 # Create volume group
[root@dc1vpvoceraapp2 ~]# vgcreate vg01 /dev/sdb1
 Volume group "vg01" successfully created

#lvcreate -n pssvol -l +100%FREE vg01 # Create logical volume
[root@dc1vpvoceraapp2 ~]# lvcreate -n pssvol -l +100%FREE vg01
 Logical volume "pssvol" created.

#mkfs.ext4 /dev/mapper/vg01-pssvol # Format logical volume
[root@dc1vpvoceraapp2 ~]# mkfs.ext4 /dev/mapper/vg01-pssvol
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 5241856 4k blocks and 1310720 inodes
Filesystem UUID: 0232d397-27e4-4d80-9718-3254eca3f27d
Superblock backups stored on blocks:
 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632,
2654208,
 4096000
Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

#mkdir /pss # Create mount point
[root@dc1vpvoceraapp2 ~]# mkdir /pss

#cp /etc/fstab /etc/fstab.BAK # Backup fstab
[root@dc1vpvoceraapp2 ~]# cp /etc/fstab /etc/fstab.BAK

#vim /etc/fstab # Add new mount points to fstab
[root@dc1vpvoceraapp2 ~]# vim /etc/fstab

# Add lines
/dev/mapper/vg01-pssvol /pss ext4 defaults
1 2
/dev/mapper/vg02-logvol /log ext4 defaults
1 2

# File will look similar to
root@dc1vpvoceraapp2 ~]# cat /etc/fstab
#
# /etc/fstab
# Created by anaconda on Thu Apr 9 21:13:33 2020
#
# Accessible filesystems, by reference, are maintained under '/dev/disk
/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more
info.
#
# After editing this file, run 'systemctl daemon-reload' to update
systemd
# units generated from this file.
#
/dev/mapper/vg00-slashvol / ext4
defaults 1 1
UUID=21164eb9-b71e-4227-9c64-20f6553740bf /boot
ext4 defaults 1 2
/dev/mapper/vg00-swapvol swap swap
defaults 0 0
/dev/mapper/vg01-pssvol /pss ext4 defaults
1 2
/dev/mapper/vg02-logvol /log ext4 defaults
1 2

#mount -t ext4 /dev/mapper/vg01-pssvol /pss # Mount logical volume
[root@dc1vpvoceraapp2 ~]# mount -t ext4 /dev/mapper/vg01-pssvol /pss # Mount logical volume

#df -h # Inspect mount points
[root@dc1vpvoceraapp2 ~]# df -h
Filesystem Size Used Avail Use% Mounted on
devtmpfs 12G 0 12G 0% /dev
tmpfs 12G 0 12G 0% /dev/shm
tmpfs 12G 8.6M 12G 1% /run
tmpfs 12G 0 12G 0% /sys/fs/cgroup
/dev/mapper/vg00-slashvol 16G 2.1G 13G 14% /
/dev/sda1 465M 144M 294M 33% /boot
tmpfs 2.4G 0 2.4G 0% /run/user/0
/dev/mapper/vg01-pssvol 20G 45M 19G 1% /pss

#systemctl reboot now # Reboot server - verify mount points after reboot
[root@dc1vpvoceraapp2 ~]# systemctl reboot now # Reboot server - verify mount points after reboot

#df -h # Inspect mount points
[root@dc1vpvoceraapp2 ~]# df -h # Inspect mount points
Filesystem Size Used Avail Use% Mounted on
devtmpfs 12G 0 12G 0% /dev
tmpfs 12G 0 12G 0% /dev/shm
tmpfs 12G 8.7M 12G 1% /run
tmpfs 12G 0 12G 0% /sys/fs/cgroup
/dev/mapper/vg00-slashvol 16G 2.1G 13G 14% /
/dev/sda1 465M 144M 293M 33% /boot
/dev/mapper/vg01-pssvol 20G 45M 19G 1% /pss
/dev/mapper/vg02-logvol 98G 61M 93G 1% /log
tmpfs 2.4G 0 2.4G 0% /run/user/0
```
