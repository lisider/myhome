#!/bin/bash

AddUser(){

    USERNAME=$0

    echo ---${USERNAME}---
    sudo useradd ${USERNAME} -s /bin/bash -G sudo ;sudo passwd ${USERNAME}
    sudo git clone https://github.com/lisider/myhome.git /home/${USERNAME}
    sudo cp /etc/skel/*  /home/${USERNAME}/
    sudo chown ${USERNAME}:${USERNAME} /home/${USERNAME} -R
    #ln -s /home/${USERNAME}/.config/.profile /home/${USERNAME}/.profile
    #ln -s /home/${USERNAME}/.config/.bashrc /home/${USERNAME}/.bashrc
}

SudoWithoutPasswd(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    echo ${PASSWD} | sudo sed -i "\$a $USER ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers 
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}


Main(){

    AddUser $*

    SudoWithoutPasswd

}

Main $*
