#Ubuntu is default as always.
FROM craigtho/ubuntu:latest

#Bash is the prefered shell
SHELL ["/bin/bash", "-c"]

#Defined Variables below - These are used to define a personalisation element of a container

#Set timezone properly to prevent any sync options
ENV TIME_ZONE=Europe/London

#Locale Codes - GB is default, US if needed
ENV LOCALE_CODE en_GB.UTF-8

#Normal Username in a *NIX format
ENV NORMAL_USER cthacker
ENV USER_PASSWORD Sp00kyP4SS!
ENV HOME /home/$NORMAL_USER

#Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

#Install & update hings
RUN apt-get update -y && apt-get -y install \
    apt-transport-https \
    git \
    ifupdown \
    iputils-ping \
    locales \
    nano \
    openjdk-8-jdk \
    openssh-server \
    openssl \
    software-properties-common \
    sudo \
    unzip \
    wget \
    zip

#Clean
RUN apt-get autoclean -y && apt-get clean -y && apt-get autoremove -y

#Set System Locale
RUN locale-gen $LOCALE_CODE
RUN update-locale LANG=$LOCALE_CODE

#Fix Systemctl
RUN wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -O /usr/local/bin/systemctl
RUN chmod a+x /usr/local/bin/systemctl

#Add a standard user for later and open permissions to the local storage directories.
RUN useradd -m -s /bin/bash $NORMAL_USER
RUN usermod -aG sudo $NORMAL_USER
RUN echo $NORMAL_USER:$USER_PASSWORD | chpasswd
RUN echo root:$USER_PASSWORD | chpasswd
RUN chmod 777 -R /usr/local

#Add Environment Variables
RUN echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' >> $HOME/.bashrc 
RUN echo 'export DO_API_KEY="75310dc4ca779ac39a19f6355db573b49ce92ae126553ebd61ac3a3ae34834cc" >> $HOME/.bashrc



ENTRYPOINT service ssh start \
    && bash
