base_packages() {
	sudo pacman -S sway wayland foot swayimg swaylock grim brightnessctl pipewire-pulse pipewire-alsa alsa-utils wofi swaybg libnotify dunst
}
setup_tty() {
	echo "" >> ~/.bash_profile
	echo "# Force firefox to wayland" >> ~/.bash_profile
	echo "export MOZ_ENABLE_WAYLAND=1" >> ~/.bash_profile
	echo "" >> ~/.bash_profile
	echo "if [ "$(tty)" = "/dev/tty1" ]; then" >> ~/.bash_profile
	echo "	exec dbus-run-session sway" >> ~/.bash_profile
	echo "fi" >> ~/.bash_profile
}
base_packages
setup_tty
