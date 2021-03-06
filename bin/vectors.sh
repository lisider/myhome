#########################################################################
# File Name: vectors.sh
# Author: Sues
# mail: sumory.kaka@foxmail.com
# Created Time: Sat 21 Apr 2018 09:05:29 PM PDT
# Version : 1.0
#########################################################################
#!/bin/bash

Main(){

    #USERNAME=$1
    USERNAME=$0
    echo ---${USERNAME}---

    useradd ${USERNAME} -s /bin/bash -G sudo
    passwd ${USERNAME}
    git clone https://github.com/lisider/myhome.git /home/${USERNAME}
    cp /etc/skel/.profile  /home/${USERNAME}/
    cp /etc/skel/.bashrc  /home/${USERNAME}/
    cp /etc/skel/.bash_logout  /home/${USERNAME}/
    echo "source ~/.config/.alias" >> /home/${USERNAME}/.bashrc 
    chown ${USERNAME}:${USERNAME} /home/${USERNAME} -R

    sed -i "\$a ${USERNAME} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers 

    cd /home/${USERNAME}
    chmod a+x /home/${USERNAME}/bin/config.sh

    su - ${USERNAME} -c /home/${USERNAME}/bin/config.sh


    #ln -s /home/${USERNAME}/.config/.profile /home/${USERNAME}/.profile
    #ln -s /home/${USERNAME}/.config/.bashrc /home/${USERNAME}/.bashrc
}

Main $*
