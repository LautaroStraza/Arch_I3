#!/bin/sh

#Configuro el teclado latinoamericano
loadkeys la-latin1

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
wget https://raw.githubusercontent.com/LautaroStraza/Arch_I3/master/chroot-install.sh -O /mnt/chroot-install.sh
chmod +x /mnt/chroot-install.sh
arch-chroot /mnt /bin/bash ./chroot-install.sh
rm /mnt/chroot-install.sh

#Desmonto
umount -R /mnt

#Saludo
clear
echo
echo "La instalación terminó, recordá quitar el disco de instalación Arch.iso" 
echo "		antes de volver a iniciar la máquina virtual"
echo
echo
echo "Lautaro Straza, Dews!"
read

#Reinicio
poweroff

exit 0
