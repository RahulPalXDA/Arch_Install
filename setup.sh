#!/bin/bash
config_git() {
	git config --global user.name "RahulPalXDA"
	git config --global user.email "RahulPal.XDA@gmail.com"
	git config --global core.editor nvim
}
install_utilities() {
	sudo pacman -Syy firefox mpv ranger moc clang android-tools neovim
	git clone --depth=1 https://aur.archlinux.org/yay.git ~/Desktop/yay
	cd ~/Desktop/yay/ && makepkg -si
	cd ~/Desktop/ && rm -rf yay
	yay -S cava
}
config_git
install_utilities
