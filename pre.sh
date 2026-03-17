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
	echo "steam-mahine" >> /etc/hostname
	echo "127.0.0.1    localhost" >> /etc/hosts
	echo "::1          localhost" >> /etc/hosts
	echo "127.0.1.1    steam-mahine" >> /etc/hosts
}
enable_networkmanager() {
	systemctl enable NetworkManager
}
setup_user() {
	echo "Enter Password for Root"
	passwd
	useradd -m -g users -G wheel,video,audio,input,games,power,storage -s /bin/bash gamer
	chfn gamer
	echo "Enter Password for Gamer"
	passwd gamer
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
enable_multilib() {
	sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
	pacman -Sy
}
install_gaming() {
	pacman -S --noconfirm lib32-mesa lib32-vulkan-radeon pipewire pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack wireplumber gamescope steam brightnessctl xorg-xwayland bluez bluez-utils
	systemctl enable bluetooth
}
setup_autologin() {
	mkdir -p /etc/systemd/system/getty@tty1.service.d/
	cat <<EOF > /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin gamer --noclear %I \$TERM
EOF
}
setup_steam_session() {
	cat <<EOF > /home/gamer/.bash_profile
if [[ -z \$DISPLAY && \$(tty) == /dev/tty1 ]]; then
	gamescope -f -w 1280 -h 720 -W 1920 -H 1080 -r 60 -- steam -gamepadui -steamos3
fi
EOF
	chown gamer:users /home/gamer/.bash_profile
}
set_locale
set_date
set_hostname
enable_networkmanager
enable_multilib
install_gaming
setup_autologin
setup_user
setup_steam_session
setup_grub
setup_swap