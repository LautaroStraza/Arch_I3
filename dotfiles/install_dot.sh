#!/bin/bash
sudo chmod 777 Stuff/*
sudo pacman -S wget zsh vim git
sudo pacman -S texlive-most texlive-lang
# Instalar vim ----------------------------------------- #
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sudo cp Stuff/vimrc $HOME/.vimrc
vim +PluginInstall +qall
# Instalar bash ----------------------------------------- #
sudo cp Stuff/bashrc $HOME/.bashrc
exit 0
