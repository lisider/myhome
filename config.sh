#!/bin/bash

AddUser(){

    USERNAME=$0

    echo ---${USERNAME}---
    useradd ${USERNAME} -s /bin/bash -G sudo
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

InstallToolsFromApt(){
    sudo apt-get install fish
    sudo apt-get install trash-cli
}

InstallToolsFromSource(){
    #1
    sudo wget --no-check-certificate -O /usr/bin/bd https://raw.github.com/vigneshwaranr/bd/master/bd
    sudo chmod +rx /usr/bin/bd
    echo 'alias bd=". bd -si"' >> ~/.bashrc
    source ~/.bashrc

    #2  cheat
    pip install docopt pygments
    git clone https://github.com/chrisallenlane/cheat.git
    cd cheat
    sudo python setup.py install
    wget https://github.com/chrisallenlane/cheat/raw/master/cheat/autocompletion/cheat.bash 
    sudo mv cheat.bash /etc/bash_completion.d/
    echo 'export CHEATCOLOR=true' >> ~/.bashrc
    echo 'alias q="cheat"' >> ~/.bashrc
    source ~/.bashrc

    #3 ici
    pip install ici


}

Main(){
    AddUser $*
    SudoWithoutPasswd
    InstallToolsFromSource
    InstallToolsFromApt
}

Main $*
