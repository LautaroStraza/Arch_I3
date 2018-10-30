# Arch_I3
Automatización de la instalación de Arch + I3 en una máquina virtual.
Necesario:
	Instalar VirtualBox en la PC anfitrión.
	Tener descargada una imagen de Arch Linux.

Crear una máquina con VirtualBox de:
	Memoria RAM: 1024 MB.
	Un disco duro virtual:
		-Tipo vdi, y reservado dinámicamente. 
		-10 GB.

Configuraciones:
	Pantalla -> Memoria de video: 128 MB.
	Almacenamiento -> Controlador IDE -> Agregar unidad óptica: Arch_Linux.iso.
	Red -> Habilitar adaptador de red: NAT.

Bootear el disco:
	$ wget https://github.com/LautaroStraza/blob/master/install.sh
	$ chmod +x install.sh
	$ ./install.sh
