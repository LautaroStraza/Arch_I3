#!/bin/bash
sudo cp -r Grub_Wall.png Vimix/background.png
sudo cp -r Vimix /boot/grub/themes/
sudo sed -i 's/.*BACKGROUND.*/#GRUB_BACKGROUND=/' /etc/default/grub
sudo sed -i 's/.*THEME.*/GRUB_THEME="\/boot\/grub\/themes\/Vimix\/theme.txt"/' /etc/default/grub
sudo update-grub
exit 0
