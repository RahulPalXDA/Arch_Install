#!/bin/bash
setup_git() {
	git config --global user.name "RahulPalXDA"
	git config --global user.email "RahulPal.XDA@gmail.com"
	git config --global core.editor nvim
}
install_packages() {
	cd ~/Desktop
	git clone --depth=1 https://aur.archlinux.org/yay-bin.git
	cd yay-bin && makepkg -si
	cd .. && rm -rf yay-bin
	sudo pacman -S android-tools neovim tlp
	sudo systemctl enable tlp
}
systemdboot_hook() {
	yay -S systemd-boot-pacman-hook
}
setup_git
install_packages
if [[ -f "/boot/loader/entries/arch.conf" ]]; then
	systemdboot_hook
fi
