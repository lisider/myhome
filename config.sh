#!/bin/bash

AddUser(){

    USERNAME=$0

    echo ---${USERNAME}---
    useradd ${USERNAME} -s /bin/bash -G sudo ;
    passwd ${USERNAME}
    git clone https://github.com/lisider/myhome.git /home/${USERNAME}
    cp /etc/skel/.profile  /home/${USERNAME}/
    cp /etc/skel/.bashrc  /home/${USERNAME}/
    cp /etc/skel/.bash_logout  /home/${USERNAME}/
    echo "source ~/.config/.alias" >> /home/suweishuai/.bashrc 
    chown ${USERNAME}:${USERNAME} /home/${USERNAME} -R
    #ln -s /home/${USERNAME}/.config/.profile /home/${USERNAME}/.profile
    #ln -s /home/${USERNAME}/.config/.bashrc /home/${USERNAME}/.bashrc
}

SudoWithoutPasswd(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    echo ${PASSWD} | sudo sed -i "\$a ${USERNAME} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers 
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}


Main(){

    AddUser $*

    SudoWithoutPasswd

}

Main $*
