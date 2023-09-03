#!/bin/bash
installPkgs() {
	sudo pacman -Syy \
		sway \
		waybar \
		wayland \
		xorg-xwayland \
		alacritty \
		swaybg \
		swayimg \
		swaylock \
		wofi \
		ttf-font-awesome \
		polkit \
		pulseaudio \
		pulseaudio-alsa \
		alsa-utils \
		brightnessctl
}
startSway() {
		echo -e '''if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then''' >> ~/.bash_profile
		echo -e '''		exec sway''' >> ~/.bash_profile
		echo -e '''fi''' >> ~/.bash_profile
}
installUtils() {
		sudo pacman -S \
				mpv \
				grim \
				ranger \
				firefox \
				neovim \
				ttf-sourcecodepro-nerd
}
installPkgs
startSway
installUtils
