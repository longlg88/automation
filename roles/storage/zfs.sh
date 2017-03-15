#!/bin/bash

# apt get install zfs
apt-add-repository universe
apt-get -y update
apt-get -y install zfsutils-linux debootstrap


# zfs module active
modprobe zfs

# check system hard drive which is vda or sda .. etc.
CHECK_SV=`ls -al /dev/*da | head -n 1 | awk '{ print $10 }' | awk -F/ '{ print $3 }'`

# sgdisk setting
host=$HOSTNAME"_zfs"

sgdisk -Z -n9:-8M:0 -t9:bf07 -c9:Reserved -n2:-8M:0 -t2:ef02 -c2:GRUB -n1:0:0 -t1:bf01 -c1:ZFS /dev/${CHECK_SV}

# zpool create
zpool create -m none -o ashift=12 -O atime=off -O normalization=formD -O compression=lz4 -f $host /dev/${CHECK_SV}1

# zfs create
zfs create -o mountpoint=/ $host/root

# zpool export
zpool export $host
zpool import -d /dev/disk/by-partuuid -R /mnt $host


