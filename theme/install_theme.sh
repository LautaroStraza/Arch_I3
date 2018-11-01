#!/bin/bash
#Instalador de temas i3+polybar Straza

if test $# -eq 2; then
	if test $2 = "desktop" -o $2 = "notebook"; then
		# Instalo grub ----------------------------------------------------- #
		sudo cp $1/Grub_Wall.png Grub_Theme/Vimix/background.png
		sudo cp -r Grub_Theme/Vimix /boot/grub/themes/
		sudo sed -i 's/.*BACKGROUND.*/#GRUB_BACKGROUND=/' /etc/default/grub
		sudo sed -i 's/.*THEME.*/GRUB_THEME="\/boot\/grub\/themes\/Vimix\/theme.txt"/' /etc/default/grub
		#sudo update-grub
		sudo grub-mkconfig -o /boot/grub/grub.cfg
		# Instalo wallpaper ------------------------------------------------ #
		sudo cp $1/Desktop_Wall.png $HOME/.config/i3/Desktop_Wall.png
		sudo cp $1/Desktop_Wall.png $HOME/.config/i3/Desktop_Wall.jpg
		# Instalo perfil --------------------------------------------------- #
		sudo cp $1/Foto_Perfil.png /usr/share/sddm/faces/$USER.face.icon
		# Instalo lock screen  --------------------------------------------- #
		if test $2 = "desktop"; then
		# Instalo lock screen  --------------------------------------------- #
			sudo cp $1/Lock_Screen.png $HOME/.config/i3/ScreenLock.png
			sudo cp Lock_Theme/Lock_Desktop.sh $HOME/.config/i3/lock.sh
			sudo chmod +x $HOME/.config/i3/lock.sh
		# Instalo sddm ----------------------------------------------------- #
      #yaourt -S sddm-maia-theme -y
      #sudo cp $1/Sddm_Wall.png /usr/share/sddm/themes/maia/background.png
      #sudo cp Sddm_Theme/theme.conf.user /usr/share/sddm/themes/maia/
      #sudo sed -i 's/.*Current.*/Current=maia/' /etc/sddm.conf
		elif test $2 = "notebook"; then
		# Instalo lock screen  --------------------------------------------- #
			sudo convert -resize 1368x768 $1/Lock_Screen.png $HOME/.config/i3/ScreenLock.png
			sudo cp Lock_Theme/Lock_Notebook.sh $HOME/.config/i3/lock.sh
			sudo chmod +x $HOME/.config/i3/lock.sh
		# Instalo sddm ----------------------------------------------------- #
      #yaourt -S sddm-maia-theme -y
      #sudo convert -resize 1368x768 $1/Sddm_Wall.png /usr/share/sddm/themes/maia/background.png
      #sudo cp Sddm_Theme/theme.conf.user /usr/share/sddm/themes/maia/
      #sudo sed -i 's/.*Current.*/Current=maia/' /etc/sddm.conf
		fi
		# Instalo Xresources  --------------------------------------------- #
			sudo cp $1/Xresources $HOME/.Xresources
	else
	echo Segundo Parámetro inválido.
	echo Llamar como: ./instalar_tema.sh \"nombre_tema\" \"desktop/notebook\"
	fi
else
echo Cantidad de parámetros incorrecta.
echo Llamar como: ./instalar_tema.sh \"nombre_tema\" \"desktop/notebook\"
fi
exit 0

#Dews!
