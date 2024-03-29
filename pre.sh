#!/bin/bash

USERNAME='rahul'
FULLNAME='Rahul Pal XDA'
PASSWORD='2705'

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
	useradd -m -g users -G wheel -s /bin/bash $USERNAME
	chfn -f $FULLNAME $USERNAME
	echo -e "$PASSWORD\n$PASSWORD" | sudo passwd $USERNAME
 	echo -e "$PASSWORD\n$PASSWORD" | sudo passwd root
	cp /etc/sudoers /tmp/sudoers
 	sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /tmp/sudoers
  	cp /tmp/sudoers /etc/sudoers
   	rm /tmp/sudoers
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
setup_swap
chmod 777 systemd-boot.sh
./systemd-boot.sh
