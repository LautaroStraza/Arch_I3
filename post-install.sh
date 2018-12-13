#!/bin/bash

#    _____  __
#   / ___/ / /_ _____ ____ _ ____  ____ _
#   \__ \ / __// ___// __ `//_  / / __ `/
#  ___/ // /_ / /   / /_/ /  / /_/ /_/ /
# /____/ \__//_/    \__,_/  /___/\__,_/
#

#Nombre
NOMBRE=$(whoami)

#Instalar virtualbox guest additions
sudo pacman -S --noconfirm virtualbox-guest-modules-arch virtualbox-guest-utils
sudo systemctl enable vboxservice
sudo usermod -a -G vboxsf ${NOMBRE}
sudo mkdir /media
sudo chmod 666 /media

#Desmutear alsa
amixer sset Master unmute

#Instalación de vimrc
git clone https://github.com/lautarostraza/vimrc ~/vimrc
chmod +x ~/vimrc/install.sh
cd ~/vimrc
./install.sh
cd ~
rm -rf ~/vimrc

#Rankmirrors (ejecutar los siguientes comandos como root)
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
#pacman -S pacman-contrib
#rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

#Saludo
clear
echo "    _____  __"
echo "   / ___/ / /_ _____ ____ _ ____  ____ _"
echo "   \__ \ / __// ___// __ \`//_  / / __ \`/"
echo "  ___/ // /_ / /   / /_/ /  / /_/ /_/ /"
echo " /____/ \__//_/    \__,_/  /___/\__,_/"
echo
echo
echo
echo
echo "Algunas recomendaciones:"
echo "              -Para cambiar la resolución de la pantalla"
echo "                  ejecute arandr."
echo "              -Reiniciar para el automontado de carpetas"
echo "                  compartidas."
echo "              -Es muy recomendable ejecutar rankmirrors."
echo
echo
echo "Lautaro Straza, Dews!"
read

#Salir
exit
