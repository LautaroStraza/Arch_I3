#!/bin/bash

#    _____  __
#   / ___/ / /_ _____ ____ _ ____  ____ _
#   \__ \ / __// ___// __ `//_  / / __ `/
#  ___/ // /_ / /   / /_/ /  / /_/ /_/ /
# /____/ \__//_/    \__,_/  /___/\__,_/
#

#Instalar virtualbox guest additions
sudo pacman -S --noconfirm virtualbox-guest-modules-arch virtualbox-guest-utils

#Desmutear alsa
amixer sset Master unmute

#Instalación de vimrc
git clone https://github.com/lautarostraza/vimrc ~/vimrc
chmod +x ~/vimrc/install.sh
cd ~/vimrc
./install.sh
cd ~
rm -rf ~/vimrc

#Ejecutar arandr para ajustar la resolución de pantalla
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
echo "Si necesita cambiar la resolución de la pantalla"
echo "               ejecute arandr"
echo
echo
echo "Lautaro Straza, Dews!"
read

#Salir
exit
