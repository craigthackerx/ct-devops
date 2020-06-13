#!/bin/bash
set -xe

    #Install stuff - Part 1 of 3
    if 

    DEBIAN_FRONTEND=noninteractive && \
    sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get install -y \
    apt-transport-https \
    bleachbit \
    build-essential \
    ca-certificates \
    chromium-browser \
    curl \
    dnsdiag \
    dos2unix \
    git \
    gnupg-agent \
    gparted \
    gufw \
    htop \
    ifupdown \
    keepassxc \
    libcharon-extra-plugins \
    libstrongswan-extra-plugins \
    neofetch \
    net-tools \
    openjdk-8-jdk \
    openssh-server \
    openssl \
    make \
    gcc \
    cmake \
    putty \
    putty-tools \
    realmd \
    remmina \
    socat \
    software-properties-common \
    strongswan \
    terminator \
    tmux \
    unzip \
    vlc \
    wget \
    whois \
    zip  ; 

    then 

        echo  "Okay, Phase 1 is fine, moving on..." && sleep 3s
  
    else 
        echo "Phase 1 failed, check the logs"

    fi

        if

        #Install Linux Headers
        sudo apt-get install linux-headers-$(uname -r) -y && \

        #Install NetworkManager Tools
        sudo apt-get install network-manager-l2tp-gnome network-manager-openconnect network-manager-openconnect-gnome nmap openconnect -y && \

        #Install Kvantium
        sudo add-apt-repository ppa:papirus/papirus -y && apt-get update -y && \
        sudo apt-get install adapta-kde -y && \

        #Install Docker
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt-get update -y && \
        sudo apt-get install docker-ce docker-compose docker-ce-cli containerd.io -y && sudo usermod -aG docker cthacker && \
        sudo systemctl enable docker && \
        sudo systemctl restart docker && \

        #Install Lazydocker
        curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash && \

        #Add Environment Variables
        echo 'export NODE_OPTIONS=--max_old_space_size=4096' >> /home/cthacker/.bashrc && \
        echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' >> /home/cthacker/.bashrc && \

        #Install acme.sh
        sudo -u cthacker curl https://get.acme.sh | bash ;

        then 
            echo "Okay, Phase 2 is fine, moving on...." && sleep 3s

        else 
            echo "Phase 2 failed, check the logs"

        fi 

        
            if 
                #Install NVM
                sudo -u cthacker curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash && \

                #Install SDKMAN!
                sudo -u cthacker curl -s "https://get.sdkman.io" | bash && \
                source "$HOME/.sdkman/bin/sdkman-init.sh" && \

                #Install SystemBack
                cd $HOME/Downloads && wget https://vorboss.dl.sourceforge.net/project/systemback/1.8/Systemback_Install_Pack_v1.8.402.tar.xz && tar -xvf Systemback*.tar.xz && rm Systemback*.tar.xz && cd Systemback_Install_Pack_v1.8.402/ && echo "4" | sudo sh install.sh && cd $HOME/Downloads && rm -rf Systemback* && \

                #Install VSCODE
                wget https://az764295.vo.msecnd.net/stable/a9f8623ec050e5f0b44cc8ce8204a1455884749f/code_1.44.1-1586789296_amd64.deb && \
                sudo dpkg -i code*.deb && \
                rm -rf code*.deb && \

                #Install KVM
                sudo apt-get update && sudo apt-get install -y \
                qemu-kvm \
                bridge-utils \
                virt-manager \
                qemu \
                virt-viewer \
                spice-vdagent \
                open-vm-tools \
                open-vm-tools-desktop

            then 
        
                echo "Okay, Phase 3 is fine, cleaning up..." && sleep 3s && \
                
                #Final update, upgrade and clean
                sudo apt-get update && sudo apt-get dist-upgrade -y &&  sudo apt-get autoremove -y && sudo apt-get autoclean -y && sudo apt-get clean -y
        
            else 
                echo "Phase 3 failed, check the logs."

            fi
