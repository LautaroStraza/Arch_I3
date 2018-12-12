#!/bin/bash

#    _____  __
#   / ___/ / /_ _____ ____ _ ____  ____ _
#   \__ \ / __// ___// __ `//_  / / __ `/
#  ___/ // /_ / /   / /_/ /  / /_/ /_/ /
# /____/ \__//_/    \__,_/  /___/\__,_/
#

#Recibo USUARIO y CLAVE
USUARIO=$1
CLAVE=$2

#Configuración básica del sistema#

#Configuración de la hora y región
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime
timedatectl set-timezone America/Buenos_Aires
hwclock --systohc --utc

#Configuración del idioma
sed -i 's/^#es_AR.UTF-8/es_AR.UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=es_AR.UTF-8' > /etc/locale.conf

#Layout del teclado para las TTY
echo 'KEYMAP=la-latin1' > /etc/vconsole.conf

#Configuración del hostname
echo 'ArchLinux' > /etc/hostname

#Crear un nuevo initramfs
mkinitcpio -p linux

#Instalación del bootloader
pacman -S --noconfirm grub intel-ucode
grub-install --target=i386-pc /dev/sda
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#Complementos para wifi
pacman -S --noconfirm wpa_supplicant ifplugd wpa_actiond dialog iw networkmanager
systemctl enable NetworkManager.service

#Creación del usuario#

#Usuario
useradd -m -G wheel -s /bin/bash $USUARIO
echo "${USUARIO}:${CLAVE}" | chpasswd
pacman -S --noconfirm sudo
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

#Configuro Pacman#

#Agrego repositorios 32bits
echo " " >> /etc/pacman.conf
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo " " >> /etc/pacman.conf
pacman -Syyu --noconfirm

#Instalación del entorno#

#Programas
pacman -S --noconfirm xorg xorg-xinit xorg-xrdb xautolock numlockx xorg-xrandr \
	arandr xf86-input-synaptics xf86-video-intel mesa gcc cmake alsa alsa-utils \
	alsa-plugins alsa-firmware pulseaudio pulseaudio-alsa \
	i3 i3lock rofi dmenu ranger feh chromium pepper-flash rxvt-unicode \
	urxvt-perls acpid compton cbatticon ttf-anonymous-pro ttf-dejavu \
	ttf-font-awesome otf-font-awesome awesome-terminal-fonts gvim net-tools wget \
	curl tree screenfetch neofetch zathura zip unzip mpd vlc libsecret \
    gnome-icon-theme gnome-keyring network-manager-applet

#Para actualizar cache de fuentes
fc-cache
#Para listar todas las fuentes instaladas: $fc-list

#Habilito servicios
systemctl enable acpid.service
systemctl enable dhcpcd.service

#Clono el repositorio
pacman -S --noconfirm git
git clone https://github.com/LautaroStraza/Arch_I3 /tmp/Arch_I3

#Guardo los wallpapers
mkdir /usr/share/wallpapers
cp /tmp/Arch_I3/imagenes/* /usr/share/wallpapers
chmod -R 777 /usr/share/wallpapers

#Guardo dotfiles
mkdir /home/$USUARIO/.config
cp -R /tmp/Arch_I3/dotfiles/i3 /home/$USUARIO/.config
cp -R /tmp/Arch_I3/dotfiles/polybar /home/$USUARIO/.config
chmod +x /home/$USUARIO/.config/i3/*.sh
chmod +x /home/$USUARIO/.config/polybar/*.sh

cp /tmp/Arch_I3/dotfiles/bash_profile /home/$USUARIO/.bash_profile
cp /tmp/Arch_I3/dotfiles/Xresources /home/$USUARIO/.Xresources
cp /tmp/Arch_I3/dotfiles/xinitrc /home/$USUARIO/.xinitrc
cp /tmp/Arch_I3/dotfiles/bashrc /home/$USUARIO/.bashrc
chmod 666 /home/$USUARIO/.bash_profile
chmod 666 /home/$USUARIO/.Xresources
chmod 666 /home/$USUARIO/.xinitrc
chmod 666 /home/$USUARIO/.bashrc

#Case insensitive para autocompletado en bash
touch /home/$USUARIO/.inputrc
echo "set completion-ignore-case on" >> /home/$USUARIO/.inputrc
#Quitar el beep de error
echo "set bell-style none" >> /home/$USUARIO/.inputrc

#Asigno nuevo propietario
chown -R $USUARIO:$USUARIO /home/$USUARIO

#Istalar polybar desde github
pacman -S --noconfirm python2 cairo libxcb xcb-proto xcb-util-image xcb-util-wm cmake gcc
git clone --recursive https://github.com/jaagr/polybar /tmp/polybar
mkdir /tmp/polybar/build
cd /tmp/polybar/build
cmake ..
make install
cd /

#Guardo el script post-install.sh
cp /tmp/Arch_I3/post-install.sh /home/$USUARIO/
chown $USUARIO:$USUARIO /home/$USUARIO/post-install.sh
chmod 777 /home/$USUARIO/post-install.sh

#Creo carpetas del usuario
sudo pacman -S --noconfirm xdg-user-dirs
xdg-user-dirs-update

#Elimino los repositorios clonados
rm -r /tmp/Arch_I3
rm -r /tmp/polybar

#Salir
exit
