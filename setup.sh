#!/bin/sh

mkdir ~/.app_def
mkdir ~/.app_def/zsh-plugins



echo "[ + ] ( 1 ) - Cambiar Host"
echo "[ + ] ( 2 ) - Cambiar IP"
echo "[ + ] ( 3 ) - Cambiar resolv"
echo "[ + ] ( 4 ) - Instalar apts"
echo "[ + ] ( F ) - Fonts ( ROOT ) "
echo "[ + ] ( 5 ) - Instalar zsh + zshrc + div " 
echo "[ + ] ( 6 ) - Instalar nvim-code " 
#echo "[ + ] ( 6 ) - Alias" 
#echo "[ + ] ( 7 ) - Instalar term div ejecutar desde la ruta" 

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
        gateway "$new_gateway > /etc/network/interfaces
    ifdown $new_interface
    ifup $new_interface
    systemctl restart networking.service
fi

if [ $var_opcion = 3 ]
then
	# Resolv.conf
	echo "Nuevo servidor DNS: ( def = 8.8.8.8 ) "
	read new_dns
	echo "nameserver $new_dns " > /etc/resolv.conf
fi

if [ $var_opcion = 4 ]
then
	export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	export TERM=xterm-256color
	# APTs
	apt update -y
	apt install neovim -y 
	apt install vifm -y
	apt install tmux -y
	apt install curl -y
	apt install git -y
	apt install git-core -y 
	apt install htop -y
	apt install wget -y
	apt install git -y
	apt install neofetch -y
	apt install tree -y
	apt install fzf -y
	apt install pip -y
	apt-get install python-pip -y
	apt-get install python3-pip -y
	apt install npm -y
	apt install ranger -y
	apt install apt installueberzug -y
	apt install ripgrep -y
	apt install silver_searcher -y
	apt install fd -y
	apt install universal-ctags  -y
	apt install lazy git  -y
	#CAT
	wget https://github.com/sharkdp/bat/releases/download/v0.19.0/bat_0.19.0_amd64.deb
	dpkg -i bat_0.19.0_amd64.deb 
	wget https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_amd64.deb
	dpkg -i lsd_0.21.0_amd64.deb 
	#Alacritty
	sudo cp alacritty.yml /usr/share
	apt-get install cmake -y
	apt-get install pkg-config -y
	apt-get install libfreetype6-dev -y
	apt-get install libfontconfig1-dev -y
	apt-get install libxcb-xfixes0-dev -y
	apt-get install libxkbcommon-dev  -y
	apt-get install python3 -y
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source $HOME/.cargo/env 
	rustup override set stable
	cargo build --release
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database
	
	
fi

if [ $var_opcion = 'F' ]
then
	cd /usr/local/share/fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
	unzip Hack.zip
	rm Hack.zip
fi

if [ $var_opcion = 5 ]
then
	#ZSH
	apt install zsh -y
	
	#COPYS
	cp p10k.zsh ~/.p10k.zsh
	cp zshrc ~/.zshrc
	cp zellij ~/.app_def/zellij
	cp config.yaml ~/.app_def/config.yaml
	cp nvim.conf ~/.app_def/nvim.conf
	cp web-search.plugin.zsh ~/.app_def/zsh-plugins
	chmod a+x ~/.app_def/zellij

	#PLUGIN
	cd ~/.app_def/zsh-plugins

	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

	wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
	
	cd ~ 
	
	# OHMYZSH + FONTS & STYLES 
	apt install fonts-powerline -y
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -s
	git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
if [ $var_opcion = 6 ]
then
	echo ''
	echo 'bash <(curl -s https://gitlab.com/claudiobrt/nvim-code/-/raw/master/utils/install.sh)'
	echo ''
	unalias nvim
fi



#if [ $var_opcion = 6 ]
#then
	## ADDs 
	#echo alias "z='zsh'" >> ~/.bashrc
	#echo alias "ll='ls -l'" >> ~/.zshrc
	#echo alias "lh='ls -lh' | more" >> ~/.zshrc
	#echo alias "nv='nvim -u ~/.app_def/nvim.conf'" >> ~/.zshrc
	#source ~/.zshrc
	#echo " z = zsh // ll = ls -l // lh = ls -lh // v = nvim "
#fi

#if [ $var_opcion = 7 ]
#then
	#cp zellij ~/app_def/zellij
	#cp config.yaml ~/app_def/config.yaml
	#chmod a+x ~/app_def/zellij
	#echo alias "div='~/app_def/zellij -c ~/app_def/config.yaml options --disable-mouse-mode'" >> ~/.zshrc
	#zsh
#fi

