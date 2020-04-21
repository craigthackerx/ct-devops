#!/bin/bash
set -e
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

#Install stuff - Part 1 of 3
export DEBIAN_FRONTEND=noninteractive && \
apt-get update -y && apt-get dist-upgrade -y && apt-get install -y \
apt-transport-https \
bleachbit \
build-essential \
ca-certificates \
curl \
dnsdiag \
dos2unix \
git \
gnupg-agent \
htop \
ifupdown && \

#Install stuff - Part 2 of 3
apt-get install -y \
neofetch \
net-tools \
openssh-server \
openssl && \

#Install stuff - Part 3 of 3
apt-get install -y \
realmd \
software-properties-common \
terminator \
tmux \
unzip \
wget \
whois \
zip && \

#Install Linux Headers
apt-get install linux-headers-$(uname -r) -y && \

#Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" && apt-get update -y && \
apt-get install docker-ce docker-compose docker-ce-cli containerd.io -y && usermod -aG docker cthacker && \
systemctl enable docker && \
systemctl restart docker && \

#Install Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash && \

#Final update, upgrade and clean
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y
