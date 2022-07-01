#!/bin/bash

set -e

# Presumes disk has been paritioned similarly to this
# /dev/sda1 0-200M EFI
# /dev/sda1 200-1000M Linux FS
# /dev/sda3 513M-100% Linux FS

loadkeys uk

read -p "Enter device to install to: " dev
read -p "Enter partition prefix ('p' for nvme): " prefix
efi_dev=${dev}${prefix}1
boot_dev=${dev}${prefix}2
root_dev=${dev}${prefix}3
crypt_root=/dev/mapper/cryptroot
btrfs_opts="rw,noatime,ssd,compress=zstd,space_cache,commit=120"

echo "Formatting efi partition"
mkfs.vfat -nBOOT -F32 $efi_dev

echo "Formatting boot partition"
mkfs.ext2 -L grub $boot_dev

echo "Setting up encryption"
cryptsetup luksFormat --type luks1 $root_dev
cryptsetup luksOpen $root_dev cryptroot

echo "Formatting root parition"
mkfs.btrfs -L void ${crypt_root}

echo "Creating btrfs volumes"
mount -o "${btrfs_opts}" $crypt_root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt

echo "Mounting subvolumes"
mount -o "${btrfs_opts},subvol=@" /dev/mapper/cryptroot /mnt
mkdir /mnt/home
mount -o "${btrfs_opts},subvol=@home" /dev/mapper/cryptroot /mnt/home
mkdir /mnt/.snapshots
mount -o "${btrfs_opts},subvol=@snapshots" /dev/mapper/cryptroot /mnt/.snapshots

echo "Create nested subvolumes to exclude from snapshots"
mkdir -p /mnt/var/cache
btrfs subvolume create /mnt/var/cache/xbps
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv

echo "Mount boot partition"
mkdir /mnt/boot
mount -o rw,noatime ${boot_dev} /mnt/boot
mkdir /mnt/boot/efi
mount -o rw,noatime ${efi_dev} /mnt/boot/efi

echo "Install base system"
REPO=https://repo-default.voidlinux.org/current
ARCH=x86_64
XBPS_ARCH=$ARCH xbps-install -S -R "$REPO" -r /mnt base-system btrfs-progs cryptsetup grub-x86_64-efi

echo "Mount extra dirs for chroot"
for dir in dev proc sys run; do
  mount --rbind /$dir /mnt/$dir
  mount --make-rslave /mnt/$dir
done

echo "Copy DNS config"
cp /etc/resolv.conf /mnt/etc/

echo "Creating phase 2 script"
sed '0,/^### PHASE 2$/d' $0 > /mnt/install.sh
chmod 755 /mnt/install.sh

echo "chrooting into new installation. Make sure to run the second phase script"
EFI_DEV=$efi_dev \
BOOT_DEV=$boot_dev \
ROOT_DEV=$root_dev \
CRYPT_ROOT=$crypt_root \
BTRFS_OPTS="${btrfs_opts}" \
PS1="(chroot) # " \
chroot /mnt /install.sh

cat <<EOF
All done!

To get back into your system, run can run the following command:
EFI_DEV=$efi_dev \
BOOT_DEV=$boot_dev \
ROOT_DEV=$root_dev \
CRYPT_ROOT=$crypt_root \
BTRFS_OPTS="${btrfs_opts}" \
PS1="(chroot) # " \
chroot /mnt /bin/bash


Otherwise, run this to restart and boot into your new install!
umount -R /mnt
reboot
EOF

exit

### PHASE 2
#!/bin/bash

loadkeys uk

echo "Configuring hostname"
read -p "Enter hostname: " new_hostname
echo $new_hostname > /etc/hostname

echo "Configuring keymap"
echo 'KEYMAP="uk"' >> /etc/rc.conf

echo "Configuring time zone"
ln -s /usr/share/zoneinfo/Europe/London /etc/localtime

echo "Configuring Locale"
sed -i 's/^#en_GB.UTF-8/en_GB.UTF-8/' /etc/default/libc-locales
sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

echo "Set root password"
passwd

echo "Configuring fstab"
UEFI_UUID=$(blkid -s UUID -o value ${EFI_DEV})
GRUB_UUID=$(blkid -s UUID -o value ${BOOT_DEV})
ROOT_UUID=$(blkid -s UUID -o value ${CRYPT_ROOT})
cat <<EOF > /etc/fstab
UUID=$ROOT_UUID / btrfs $BTRFS_OPTS,subvol=@ 0 1
UUID=$GRUB_UUID /boot ext2 defaults,noatime 0 2
UUID=$UEFI_UUID /boot/efi vfat defaults,noatime 0 2
UUID=$ROOT_UUID /home btrfs $BTRFS_OPTS,subvol=@home 0 2
UUID=$ROOT_UUID /.snapshots btrfs $BTRFS_OPTS,subvol=@snapshots 0 2
tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0
EOF

echo "Configuring dracut"
echo "hostonly=yes" >> /etc/dracut.conf
echo 'add_dracutmodules+=" crypt btrfs "' >> /etc/dracut.conf
echo 'early_microcode="yes"' >> /etc/dracut.conf.d/amd_firmware.conf

echo "Installing AMD firmware"
xbps-install -Syu linux-firmware-amd

echo "Configuring grub"
LUKS_UUID=$(blkid -s UUID -o value ${ROOT_DEV})
echo "GRUB_CMDLINE_LINUX=\"rd.luks.name=$LUKS_UUID=cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rd.luks.options=discard rw\"" >> /etc/default/grub
echo "GRUB_ENABLE_CRYPTDISK=y" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "Installing grub"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --boot-directory=/boot --bootloader-id="Void Linux"

echo "Reconfiguring"
xbps-reconfigure -fa

echo "Installing and enabling dbus"
xbps-install -y dbus
ln -s /etc/sv/dbus /var/service/

echo "Installing and enabling NetworkManager"
xbps-install -y NetworkManager
ln -s /etc/sv/NetworkManager /var/service/
