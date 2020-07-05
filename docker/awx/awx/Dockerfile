FROM debian:latest

#Bash is the prefered shell
SHELL ["/bin/bash", "-c"]

USER root

#Defined Variables below - These are used to define a personalisation element of a container
ARG debian_front=noninteractive

#Set timezone properly to prevent any sync options
ENV TIME_ZONE=Europe/London

#Locale Codes - GB is default, US if needed
ENV LOCALE_CODE en_GB.UTF-8

#Normal Username in a *NIX format.  Password for personal preference.
ENV NORMAL_USER cthacker
ENV USER_PASSWORD Sp00kyP4SS!
ENV CLEAN apt-get autoclean && apt-get clean && apt-get autoremove

#Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list && apt-get update -y && \
apt-get install sudo locales curl wget -y && \
apt-get dist-upgrade -y

RUN ${CLEAN}

#Add a standard user for later and open permissions to the local storage directories.
RUN useradd -m -s /bin/bash ${NORMAL_USER} && \
                            usermod -aG sudo $NORMAL_USER && \
                            echo ${NORMAL_USER}:${USER_PASSWORD} | chpasswd && \
                            echo root:${USER_PASSWORD} | chpasswd

RUN apt-get install -y \
    ca-certificates \
    cmake \
    curl \
    dos2unix \
    dnsdiag \
    gcc \
    git \
    htop \
    make \
    neofetch \
    net-tools \
    openssh-server \
    openssl \
    python3 \
    python3-pip \
    python3-wheel \
    realmd \
    tmux \
    unzip \
    wget \
    whois \
    zip

RUN wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -O /usr/local/bin/systemctl && chmod a+x /usr/local/bin/systemctl

#Install SDKMAN! - Used to manage packages
RUN curl -s "https://get.sdkman.io" | bash && \
                        source "$HOME/.sdkman/bin/sdkman-init.sh" && \
                        sdk install java

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN source ~/.bashrc \
    && nvm install 12.18.2 \
    && nvm use 12.18.2


RUN wget https://bootstrap.pypa.io/get-pip.py && \
echo "PATH=$PATH:usr/local/bin" >> $HOME/.bashrc && \
python3 get-pip.py && pip install \
                            docker-compose \
                            packaging \
                            msrest

RUN apt-get install ansible -y && git clone https://github.com/ansible/awx.git && \
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash && \
cd awx/installer && ansible-playbook -i inventory install.yml

ADD nginx.conf /

ENTRYPOINT [ "service ssh start && nash" ]
