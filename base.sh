#!/bin/bash
format() {
	mkfs.fat -F32 /dev/nvme0n1p1
	mkfs.ext4 /dev/nvme0n1p2
	mkfs.ext4 /dev/nvme0n1p3
}
mount_parts() {
	mount /dev/nvme0n1p2 /mnt
	mkdir /mnt/home
	mount /dev/nvme0n1p3 /mnt/home
	mkdir /mnt/boot
	mkdir /mnt/boot/efi
	mount /dev/nvme0n1p1 /mnt/boot/efi
}
base_install() {
	pacstrap -i /mnt base base-devel linux-lts linux-firmware sudo nano git ntfs-3g ttf-dejavu ttf-indic-otf noto-fonts-emoji xdg-user-dirs grub efibootmgr networkmanager
}
gen_fstab () {
	genfstab -U -p /mnt >> /mnt/etc/fstab
}
format
mount_parts
base_install
gen_fstab
cp -r pre.sh /mnt/pre.sh
arch-chroot /mnt /bin/bash
