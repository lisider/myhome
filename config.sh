#!/bin/bash

AddUser(){
    USERNAME=$1
    sudo useradd ${USERNAME} -s /bin/bash -G sudo ;sudo passwd ${USERNAME}
    sudo git clone https://github.com/lisider/myhome.git /home/${USERNAME}
    sudo chown ${USERNAME}:${USERNAME} /home/${USERNAME} -R
    cp /etc/skel/*  /home/${USERNAME}/
    #ln -s /home/${USERNAME}/.config/.profile /home/${USERNAME}/.profile
    #ln -s /home/${USERNAME}/.config/.bashrc /home/${USERNAME}/.bashrc
}

SudoWithoutPasswd(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    echo ${PASSWD} | sudo sed -i "\$a $USER ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers 
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}


Main(){
    echo $*
    echo $0
    echo $1
    AddUser $*
    SudoWithoutPasswd

}

Main $*
