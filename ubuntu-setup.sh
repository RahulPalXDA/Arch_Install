function cleanup(){
	sudo apt-get update;
	sudo apt-get purge gnome-logs;
}
function removeSnaps(){
	snap list;
        sudo snap remove firefox;
	sudo snap remove gnome-42-2204;
	sudo snap remove gtk-common-themes;
	sudo snap remove snap-store;
	sudo snap remove snapd-desktop-integration;
	sudo snap remove bare;
	sudo snap remove core22;
        sudo snap remove snapd;
}
function disableSnapServices(){
	sudo systemctl disable snapd.service
	sudo systemctl disable snapd.socket
	sudo systemctl disable snapd.seeded.service
	sudo rm -rf /var/cache/snapd/
	sudo rm -rf ~/snap
}
function noSnap(){
	echo -e "Package: snapd\nPin: release a=*\nPin-Priority: -10" | sudo tee /etc/apt/preferences.d/nosnap
	sudo apt-get -y purge snapd
	sudo apt-get -y autoremove
}
function setupFirefox(){
	echo -e "Package: firefox*\nPin: release o=Ubuntu*\nPin-Priority: -1" | sudo tee /etc/apt/preferences.d/firefox-no-snap
	sudo add-apt-repository ppa:mozillateam/ppa
	echo -e "Package: firefox*\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 501" | sudo tee /etc/apt/preferences.d/mozillafirefoxppa
        sudo apt-get -y update
	sudo apt-get -y install -t 'o=LP-PPA-mozillateam' firefox
}
function installEssentials(){
	sudo apt-get -y update
	sudo apt-get -y upgrade
	sudo apt-get -y install gnome-browser-connector celluloid gnome-tweaks git neovim adb fastboot
	sudo apt-get -y remove mpv
}
function setupGit(){
	git config --global user.name "RahulPalXDA"
	git config --global user.email "RahulPal.XDA@gmail.com"
	git config --global core.editor nvim
}
function draculaTerminal(){
	sudo apt-get -y install dconf-cli
	git clone --depth=1 https://github.com/dracula/gnome-terminal.git ~/Desktop/draculaTheme
	cd ~/Desktop/draculaTheme && ./install.sh
	cd .. && rm -rf ~/Desktop/draculaTheme
}
function ubusetups(){
	sudo mv /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu-logo.png.bak
	sudo sed -i 's/quiet\ splash/quiet/g' /etc/default/grub
	sudo update-grub && sudo update-grub2
}
cleanup
removeSnaps
disableSnapServices
noSnap
setupFirefox
installEssentials
setupGit
draculaTerminal
ubusetups
# The Last cleanup
sudo apt-get -y autoremove && sudo apt-get clean
