#!/bin/bash

#    _____  __
#   / ___/ / /_ _____ ____ _ ____  ____ _
#   \__ \ / __// ___// __ `//_  / / __ `/
#  ___/ // /_ / /   / /_/ /  / /_/ /_/ /
# /____/ \__//_/    \__,_/  /___/\__,_/
#

clear
echo "    _____  __"
echo "   / ___/ / /_ _____ ____ _ ____  ____ _"
echo "   \__ \ / __// ___// __ \`//_  / / __ \`/"
echo "  ___/ // /_ / /   / /_/ /  / /_/ /_/ /"
echo " /____/ \__//_/    \__,_/  /___/\__,_/"
echo
echo "Bienvenido a la instalación de Arch Linux + I3 "
echo "      Está bastante copada la versión "
echo "        asi que disfrutala guachin."
echo
echo
echo

#Configuro el teclado latinoamericano
loadkeys la-latin1

#Ingreso de USUARIO y CLAVE
OPCION="N"
while  [ "$OPCION" = "N" ] || [ "$OPCION" = "n" ]; do
    echo -n "Ingrese un nombre para el nuevo usuario: "
    read NOMBRE
    echo -n "Ingrese una CLAVE para el nuevo usuario: "
    read CLAVE

    echo
    echo "El nombre del nuevo usuario será \"${NOMBRE}\"."
    echo "Su clave será \"${CLAVE}\"."
    echo -n "¿Continuar con la instalación? [S/n]: "
    read OPCION
done
echo
#Se guardó el nombre en NOMBRE
#Se guardó la clave en CLAVE

#Configuro la hora del sistema
timedatectl set-ntp true

#Particiono los discos para un esquema de BIOS/GPT
parted -s -a optimal /dev/sda mklabel gpt unit mib mkpart primary 1 3 name 1 grub
parted -s -a optimal /dev/sda mkpart primary 3 2051 name 2 swap
parted -s -a optimal /dev/sda mkpart primary 2051 100% name 3 root
parted -s -a optimal /dev/sda set 1 bios_grub on

#Formateo las particiones
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3

mkswap /dev/sda2
swapon /dev/sda2

#Montado de particiones
mount /dev/sda3 /mnt

#Instalación de Arch
pacstrap /mnt base base-devel

#Genero fstab para el automontado de particiones
genfstab -U /mnt >> /mnt/etc/fstab

#Arch-chroot
wget https://raw.githubusercontent.com/lautarostraza/arch-i3/master/chroot-install.sh -O /mnt/chroot-install.sh
chmod +x /mnt/chroot-install.sh
arch-chroot /mnt /bin/bash ./chroot-install.sh $NOMBRE $CLAVE
rm /mnt/chroot-install.sh

#Desmonto
umount -R /mnt

#Saludo
clear
echo "    _____  __"
echo "   / ___/ / /_ _____ ____ _ ____  ____ _"
echo "   \__ \ / __// ___// __ \`//_  / / __ \`/"
echo "  ___/ // /_ / /   / /_/ /  / /_/ /_/ /"
echo " /____/ \__//_/    \__,_/  /___/\__,_/"
echo
echo
echo "La instalación terminó, recordá quitar el disco de instalación Arch.iso"
echo "		antes de volver a iniciar la máquina virtual"
echo
echo "Lautaro Straza, Dews!"
read

#Reinicio
poweroff
