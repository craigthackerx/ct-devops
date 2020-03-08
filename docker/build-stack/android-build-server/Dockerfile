#Ubuntu is default, FROM teresaejunior/lubuntu:latest if GUI is needed
FROM craigtho/ubuntu:latest

#Bash is the prefered shell
SHELL ["/bin/bash", "-c"]

#Defined Variables below - These are used to define a personalisation element of a container
ARG debian_front=noninteractive

#Set timezone properly to prevent any sync options
ENV TIME_ZONE=Europe/London

#Locale Codes - GB is default, US if needed
ENV LOCALE_CODE en_GB.UTF-8

#Normal Username in a *NIX format.  Password for personal preference.
ENV NORMAL_USER cthacker
ENV USER_PASSWORD Sp00kyP4SS!
ENV HOME /home/$NORMAL_USER

#Node Options settings.  Normal parameters by default
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.16.0
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#Gradle Version.
ENV NEW_GRADLE_VERSION gradle 4.8.1

#Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

#Install & update hings
RUN apt-get update -y && apt-get -qqy install \
    android-sdk
    apt-transport-https \
    apt-utils \
    bash \
    ca-certificates \
    curl \
    fonts-liberation \
    git \
    ifupdown \
    iputils-ping \
    libappindicator3-1 \
    libgtk-3-0 \
    libxss1 \
    locales \
    lsb-release \
    nano \
    openjdk-8-jdk \
    openssh-server \
    openssl \
    python \
    samba \
    samba-common \
    software-properties-common \
    sudo \
    tmux \
    unrar \
    unzip \
    wget \
    xdg-utils \
    zip

RUN apt-get autoclean

#Make folder structure for webmin
RUN mkdir /media/storage /data /data/samba /data/webmin

#Add Volume for storage
VOLUME /data

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

#Install chrome for various GUI oriented testing.
RUN wget http://www.slimjetbrowser.com/chrome/lnx/chrome64_68.0.3440.84.deb && dpkg -i chrome* && apt-get install -f
RUN rm *.deb
RUN service dbus start

#Add Webmin source
RUN echo "deb https://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list && \
cd /root && \
wget http://www.webmin.com/jcameron-key.asc && \
apt-key add jcameron-key.asc

#Fix for Webmin install
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN rm /etc/apt/apt.conf.d/docker-gzip-indexes && \
apt-get purge apt-show-versions -y && \
rm /var/lib/apt/lists/*lz4 && \
apt-get -o Acquire::GzipIndexes=false update -y

#Install Webmins
RUN apt-get update && apt-get install webmin -y

#Edit the miniserv.conf
RUN sed -i 's/10000/80/g' /etc/webmin/miniserv.conf && \
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf

#Change to Normal user for bash enviroment variable setting & tool installation.
USER $NORMAL_USER

#Set Enviroment variables here...or don't, who cares.
RUN echo 'export NODE_OPTIONS=--max_old_space_size=4096' >> $HOME/.bashrc
RUN echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' >> $HOME/.bashrc
RUN echo 'export ANDROID_HOME="/usr/lib/android-sdk"' >> $HOME/.bashrc
RUN echo 'export PATH=$PATH::$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin' >> $HOME/.bashrc
RUN echo 'export CHROME_BIN=/usr/bin/google-chrome' >> $HOME/.bashrc
RUN echo "$USER_PASSWORD" | sudo -S mkdir -p $ANDROID_HOME/ndk-bundle/toolchains/mips64el-linux-android/prebuilt/linux-x86_64

#Install NVM because you aren't smart enough to install Node.JS manually
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use $NODE_VERSION

#Install SDKMAN! - Used to manage packages
RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install $NEW_GRADLE_VERSION && cd $HOME && gradle
RUN cd $HOME && source "$HOME/.sdkman/bin/sdkman-init.sh" && gradle


#Clean up Display Variables
RUN export DISPLAY=localhost:0
RUN export NO_AT_BRIDGE=1
RUN exec dbus-run-session -- bash

#Execute with sudo password to prevent root escalation
ENTRYPOINT echo "$USER_PASSWORD" | sudo -S service ssh start \
    && echo "$USER_PASSWORD" | sudo -S service webmin start \
    && echo "$USER_PASSWORD" | sudo -S service smbd start \
    && echo "$USER_PASSWORD" | sudo -S service nmbd start \
    && bash

#Set your user on login and restricts root behind your set password (good security practice)
WORKDIR $HOME