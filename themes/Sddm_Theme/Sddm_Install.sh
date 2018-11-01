#!/bin/bash

yaourt -S sddm-maia-theme -y
sudo cp Sddm_Wall.png /usr/share/sddm/themes/maia/background.png
sudo cp theme.conf.user /usr/share/sddm/themes/maia/
sudo sed -i 's/.*Current.*/Current=maia/' /etc/sddm.conf
exit 0

