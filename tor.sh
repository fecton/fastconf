#!/usr/bin/env bash

if [[ $(uname -o) != "GNU/Linux" ]]; then
	echo "[-] Supported only on GNU/Linux!"
	echo "[+] But you can download driver! Enter: 1"
	echo "--- ---"
	read reaction
	if [[ $reaction == 1 ]]; then
		get_driver
	else
		echo "[-] Exitting!"
		exit
	fi
fi

function install_necessary(){
	sudo apt -y install git
    sudo apt -y install python2
    sudo apt -y install wget
}

function show_menu(){
    echo "0. Show this menu"
    echo "1. Download TOR + toriptables2"
    echo "2. Start TOR + toriptables2"
    echo "3. Stop TOR + toriptables2"
    echo "4. Force change IP-address"
    echo "5. Show IP"
    echo "6. Exit"
	echo "--- ---"
}

function install(){
    install_necessary
    sudo apt-get -y install tor
    cd ~
    if ! [[ -d tools ]]; then
        mkdir tools
    fi
    cd tools
    git clone https://github.com/ruped24/toriptables2.git
    echo "[+] Successfully downloaded!"
}

function start(){
    cd ~/tools/toriptables2/
    sudo systemctl start tor
    sudo python2 toriptables2.py -l
    echo "[+] Successfully started!"
}

function stop(){
    cd ~/tools/toriptables2/
    sudo python2 toriptables2.py -f
    sudo systemctl stop tor
    echo "[+] Successfully stopped!"
}

function force_change_ip(){
    sudo kill -HUP $(pidof tor)
}

function show_ip(){
    wget -qO- eth0.me
}

show_menu
while [ 1 ]
do
    read action
    if [[ $action -eq 0 ]]; then
        show_menu
    elif [[ $action -eq 1 ]]; then
        install
	echo "--- ---"
    elif [[ $action -eq 2 ]]; then
        start
	echo "--- ---"
    elif [[ $action -eq 3 ]]; then
        stop
	echo "--- ---"
    elif [[ $action -eq 4 ]]; then
        force_change_ip
	echo "--- ---"
    elif [[ $action -eq 5 ]]; then
        show_ip
	echo "--- ---"
    elif [[ $action -eq 6 ]]; then
        echo "[+] Bye!"
        exit
    fi
done



