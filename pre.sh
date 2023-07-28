#!/bin/bash
set_locale() {
	sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
	locale-gen
	echo "LANG=en_US.UTF-8" >> /etc/locale.conf
}
set_date() {
	ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
	hwclock --systohc --utc
	date
}
set_hostname() {
	echo "msi-b10mw" >> /etc/hostname
	echo "127.0.0.1    localhost" >> /etc/hosts
	echo "::1          localhost" >> /etc/hosts
	echo "127.0.1.1    msi-b10mw" >> /etc/hosts
}
enable_networkmanager() {
	systemctl enable NetworkManager
}
setup_user() {
	echo "Enter Passeord for Root"
	passwd
	useradd -m -g users -G wheel -s /bin/bash rahul
	chfn rahul
	echo "Enter Password for user rahul"
	passwd rahul
	EDITOR=nano visudo
}
setup_grub() {
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
	sed -i 's/GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/g' /etc/default/grub
	grub-mkconfig -o /boot/grub/grub.cfg
}
setup_swap() {
	dd if=/dev/zero of=/swapfile bs=1M count=8192 status=progress
	chmod 0600 /swapfile
	mkswap -U clear /swapfile
	swapon /swapfile
	echo -e "/swapfile\tnone\tswap\tpri=10\t0 0" >> /etc/fstab
}
set_locale
set_date
set_hostname
enable_networkmanager
setup_user
setup_grub
setup_swap
