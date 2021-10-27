#!/bin/sh


echo "[ + ] ( 1 ) - Cambiar Host"
echo "[ + ] ( 2 ) - Cambiar IP"
echo "[ + ] ( 3 ) - Instalar def" 
echo "[ + ] ( 4 ) - Instalar term div ejecutar desde la ruta" 

read var_opcion
if [ $var_opcion = 1 ]
then
    	echo "nuevo nombre del host: "
    	read new_hostname
    	read old_hostname < /etc/hostname
    	sed -i "s/"$old_hostname"/"$new_hostname"/g" /etc/hostname
    	sed -i "s/"$old_hostname"/"$new_hostname"/g" /etc/hosts
    	hostname $new_hostname
fi 

if [ $var_opcion = 2 ]
then
	echo "nueva IP ( def = 192.168.1.X ): "
	read new_address
    	echo "nueva mascara (def = 255.255.255.0 ): "
    	read new_netmask
    	echo "nuevo gateway ( def = 192.168.1.1 ): "
 	read new_gateway
    	echo "nueva interfaz (def = eth0 ): "
    	read new_interface
    	echo "
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback 
auto "$new_interface"
iface "$new_interface" inet static
	address "$new_address"
        netmask "$new_netmask"
        network "$new_gateway > /etc/network/interfaces
    ifdown $new_interface
    ifup $new_interface
    systemctl restart networking.service
fi

if [ $var_opcion = 3 ]
then
	# APTs
	apt update -y
	apt install neovim vim vifm tmux git curl gut-core htop neofetch -y
	
	#ZSH
	apt install zsh -y
	
	# FONTS & STYLES 
	apt install fonts-powerline -y
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -s
	git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	perl -pi -e "s[robbyrussell][powerlevel10k/powerlevel10k]g" ~/.zshrc
	
	# ADDs
	echo neofetch >> ~/.zshrc
	echo alias "ll='ls -l'" >> .zshrc
	echo alias "lh='ls -lh' | more" >> .zshrc
	source ~/.zshrc
fi
if [ $var_opcion = 4 ]
then
	mkdir ~/app_def
	cp zellij ~/app_def/zellij
	chmod a+x ~/app_def/zellij
	echo alias "div='~/app_def/zellij'" >> ~/.zshrc
	zsh
fi
