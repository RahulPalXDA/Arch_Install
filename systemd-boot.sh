root_uuid=$(blkid | grep nvme0n1p2 | cut -d ' ' -f 2 | sed 's/"//g')

bootctl install
echo 'editor no' >> /boot/loader/loader.conf
echo 'default arch.conf' >> /boot/loader/loader.conf

echo -e "title	Arch Linux
linux	/vmlinuz-linux-lts
initrd	/intel-ucode.img
initrd	/initramfs-linux-lts.img
options	root='$root_uuid' rw" >> /boot/loader/entries/arch.conf

echo -e "title	Arch Linux fallback
linux	/vmlinuz-linux-lts
initrd	/intel-ucode.img
initrd	/initramfs-linux-lts-fallback.img
options	root='$root_uuid' rw" >> /boot/loader/entries/arch-fallback.conf
