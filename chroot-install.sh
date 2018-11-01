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
##Revisar si puedo quitar el primer grub-mkconfig
#grub-mkconfig -o /boot/grub/grub.cfg
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#Algunos complementos para wifi si llegara a ser necesario
#pacman -S --noconfirm wpa_supplicant ifplugd wpa_actiond dialog iw networkmanager

#Creación del usuario#

#Usuario
pacman -S --noconfirm zsh
clear
echo "## Creación de usuario ##"
echo "Ingrese un nombre de usuario: "
read USUARIO
echo "Su usuario nuevo es: ${USUARIO}"
useradd -m -G wheel -s /bin/zsh $USUARIO
echo "Agregar contraseña para el usuario: ${USUARIO}"
passwd ${USUARIO}
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

#Programas para la interfaz gráfica
pacman -S --noconfirm xorg xorg-xinit xorg-xrdb xautolock xf86-input-synaptics xf86-video-intel mesa 
pacman -S --noconfirm lxdm i3 rofi dmenu ranger feh thunar chromium rxvt-unicode urxvt-perls acpid

#Habilito servicios
systemctl enable lxdm.service
systemctl enable acpid.service
systemctl enable dhcpcd.service

#Clono el repositorio
pacman -S --noconfirm git
git clone https://github.com/LautaroStraza/Arch_I3 /tmp/Arch_I3

#Guardo los wallpapers
mkdir /usr/share/wallpapers
chmod 666 /usr/share/wallpapers
cp /tmp/Arch_I3/Imagenes/* /usr/share/wallpapers

#Guardo dotfiles
mkdir /home/$USUARIO/.config
cp -R /tmp/Arch_I3/dotfiles/i3 /home/$USUARIO/.config
cp -R /tmp/Arch_I3/dotfiles/polybar /home/$USUARIO/.config
chmod +x /home/$USUARIO/.config/i3/*.sh
chmod +x /home/$USUARIO/.config/polybar/*.sh

cp /tmp/Arch_I3/dotfiles/Xresources /home/$USUARIO/.Xresources
cp /tmp/Arch_I3/dotfiles/bashrc /home/$USUARIO/.bashrc
cp /tmp/Arch_I3/dotfiles/zshrc /home/$USUARIO/.zshrc
cp /tmp/Arch_I3/dotfiles/vimrc /home/$USUARIO/.vimrc
chmod 666 /home/$USUARIO/.Xresources
chmod 666 /home/$USUARIO/.bashrc
chmod 666 /home/$USUARIO/.zshrc
chmod 666 /home/$USUARIO/.vimrc

chown -R $USUARIO:$USUARIO /home/$USUARIO

#Configuro lxdm
sed -i 's/^# numlock=0/numlock=1/' /etc/lxdm/lxdm.conf
sed -i 's/^# session/session/' /etc/lxdm/lxdm.conf
sed -i 's/startlxde/i3/' /etc/lxdm/lxdm.conf
sed -i 's/^# bg=\/usr\/share\/backgrounds\/default.png/bg=\/usr\/share\/wallpapers\/Lxdm_Wall.png/' /etc/lxdm/lxdm.conf

#Programas herramientas
pacman -S --noconfirm vim net-tools wget curl tree neofetch

#Falta terminar de configurar la estetica de lxdm
#configuro el autologin en lxdm

#Elimino el repositorio clonado
rm -r /tmp/Arch_I3

#Imprimir un mensaje que diga " Instalacion finalizada Recuerde quitar el disco de la iso" " y una vez dentro agregue contraseñas"
#Y esperar confirmacion

#Salir
exit 0
