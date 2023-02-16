base_packages() {
	sudo pacman -S sway wayland foot swayimg swaylock grim brightnessctl pulseaudio pulseaudio-alsa alsa-utils wofi swaybg libnotify dunst
}
setup_tty() {
	echo "if [ "$(tty)" = "/dev/tty1" ]; then" >> ~/.bash_profile
	echo "	exec dbus-run-session sway" >> ~/.bash_profile
	echo "fi" >> ~/.bash_profile
}
base_packages
setup_tty
