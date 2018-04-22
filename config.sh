#!/bin/bash



InstallToolsFromApt(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    sudo apt-get install fish -y
    sudo apt-get install trash-cli -y

    #4 the fuck
    #sudo apt install python3-dev python3-pip
    #sudo pip3 install thefuck

    #3 ici
    pip install ici
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

InstallToolsFromSource(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
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

    # oh-my-zsh
    sudo apt-get install zsh -y
    cd ~;sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts;./install.sh
    cd ~;sudo fc-cache dir .local -fv
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Main(){
    InstallToolsFromApt
    InstallToolsFromSource
}

Main $*
