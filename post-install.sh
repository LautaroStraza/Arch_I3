#!/bin/sh

#Instalar virtualbox guest additions
sudo pacman -S --noconfirm virtualbox-guest-modules-arch virtualbox-guest-utils

#Configurar vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#Desmutear alsa
amixer sset Master unmute

#Ejecutar arandr para ajustar la resolución de pantalla
clear
echo
echo "Si necesita cambiar la resolución de la pantalla
	ejecute arandr"
read
