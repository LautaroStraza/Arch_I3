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

#Creo carpetas del usuario
sudo pacman -S --noconfirm xdg-user-dirs
sudo xdg-user-dirs-update

#Instalación de vimrc
sudo pacman -S --noconfirm gvim git dialog
git clone https://github.com/lautarostraza/vimrc ~/vimrc
chmod +x ~/vimrc/install.sh
cd ~/vimrc
./install.sh
sudo cp remap.sh /usr/local/bin/remap.sh
cd ~
rm -rf ~/vimrc

#Guardo script rankmirrors
sudo cp /tmp/arch-i3/rankmirrors.sh /usr/local/bin/rankmirrors.sh

#Istalar polybar desde github
#pacman -S --noconfirm python2 cairo libxcb xcb-proto xcb-util-image xcb-util-wm cmake gcc
#git clone --recursive https://github.com/jaagr/polybar /tmp/polybar
#mkdir /tmp/polybar/build
#cd /tmp/polybar/build
#cmake ..
#make install
#cd /

#Salir
exit
