#!/bin/bash
install_base() {
	sudo pacman -S gnome-shell nautilus gnome-terminal gnome-tweaks gnome-control-center xdg-user-dirs gdm gnome-keyring bluez gvfs gvfs-mtp libmtp
}
enable_services() {
	sudo systemctl enable gdm
	sudo systemctl enable bluetooth
}
install_base
enable_services
