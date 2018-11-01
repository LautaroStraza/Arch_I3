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

#Instalación del entorno#

#Programas herramientas
pacman -S --noconfirm vim git net-tools wget curl tree

#Programas para la interfaz gráfica
pacman -S --noconfirm xorg xautolock xf86-input-synaptics xf86-video-intel mesa 
pacman -S --noconfirm lxdm i3 rofi dmenu ranger feh thunar chromium rxvt-unicode acpid

#Habilito algunos servicios
systemctl enable lxdm.service
systemctl enable acpid.service

#Configuro lxdm (el display manager)








#Para poder usar varios de los scripts viejos necesito yaourt y multilib

#Clono el repositorio para usar scripts mas simples que instalan y configuran programas y llamarlos desde aca#
git clone https://github.com/LautaroStraza/Arch_I3 /tmp/Arch_I3



#Eliminar el repositorio clonado
rm -r /tmp/Arch_I3


#Crear usuario y contraseña#

#Visudo (le doy permiso al usuario para usar sudo)
## pacman -S --noconfirm sudo
## con sed -i/#wheel/wheel en el archivo visudo

#configuro el autologin en lxdm


#Imprimir un mensaje que recuerde quitar el disco de la iso
#Y esperar confirmacion



#Salir
exit
