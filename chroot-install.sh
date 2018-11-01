#!/bin/sh

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
grub-mkconfig -o /boot/grub/grub.cfg

#Algunos complementos para wifi si llegara a ser necesario
#pacman -S --noconfirm wpa_supplicant ifplugd wpa_actiond dialog iw networkmanager


#Creación del usuario#
pacman -S --noconfirm zsh
echo "Ingrese su nombre de usuario: "
read USUARIO
echo "Su usuario nuevo es: ${USUARIO}"
useradd -m -G wheel -s /bin/zsh $USUARIO

#Instalación del entorno#

#Programas herramientas
pacman -S --noconfirm vim git net-tools wget curl tree virtualbox-guest-modules-arch virtualbox-guest-utils

#Programas para la interfaz gráfica
pacman -S --noconfirm xorg xautolock xf86-input-synaptics xf86-video-intel mesa 
pacman -S --noconfirm lxdm i3 rofi dmenu ranger feh thunar chromium rxvt-unicode acpid

#Habilito servicios
systemctl enable lxdm.service
systemctl enable acpid.service

#Clono el repositorio
git clone https://github.com/LautaroStraza/Arch_I3 /tmp/Arch_I3

#Guardo los wallpapers
mkdir /usr/share/wallpapers
chmod 777 /usr/share/wallpapers
cp /tmp/Arch_I3/Imagenes/* /usr/share/wallpapers

#Guardo dotfiles
mkdir /home/$USUARIO/.config
cp -R dotfiles/i3 /home/$USUARIO/.config
cp -R dotfiles/polybar /home/$USUARIO/.config
chmod +x /home/$USUARIO/.config/i3/*.sh
chmod +x /home/$USUARIO/.config/polybar/*.sh

cp dotfiles/bashrc /home/$USUARIO/.bashrc
cp dotfiles/zshrc /home/$USUARIO/.zshrc
cp dotfiles/vimrc /home/$USUARIO/.vimrc

#Configuro lxdm
sed -i 's/^# numlock=0/numlock=1/' /etc/lxdm/lxdm.conf
sed -i 's/^# session/session/' /etc/lxdm/lxdm.conf
sed -i 's/startlxde/i3/' /etc/lxdm/lxdm.conf
sed -i 's/^# bg=\/usr\/share\/backgrounds\/default.png/bg=\/usr\/share\/wallpapers\/Lxdm_Wall.png/' /etc/lxdm/lxdm.conf



#Crear usuario y contraseña#

#Para poder usar varios de los scripts viejos necesito yaourt y multilib


#Visudo (le doy permiso al usuario para usar sudo)
## pacman -S --noconfirm sudo
## con sed -i/#wheel/wheel en el archivo visudo

#configuro el autologin en lxdm

#Elimino el repositorio clonado
rm -r /tmp/Arch_I3

#Imprimir un mensaje que diga " Instalacion finalizada Recuerde quitar el disco de la iso" " y una vez dentro agregue contraseñas"
#Y esperar confirmacion



#Salir
exit