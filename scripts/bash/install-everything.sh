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
libstrongswan-extra-plugins && \

#Install stuff - Part 2 of 3
apt-get install -y \
neofetch \
net-tools \
openjdk-8-jdk \
openssh-server \
openssl \
make \
gcc \
cmake \
putty \
putty-tools && \

#Install stuff - Part 3 of 3
apt-get install -y \
realmd \
remmina \
socat \
software-properties-common \
strongswan \
terminator \
tightvncserver \
tmux \
unzip \
vlc \
wget \
whois \
zip && \

#Install Linux Headers
apt-get install linux-headers-$(uname -r) -y && \

#Install NetworkManager Tools
apt-get install network-manager-l2tp-gnome network-manager-openconnect network-manager-openconnect-gnome nmap openconnect -y && \

#Install Kvantium
add-apt-repository ppa:papirus/papirus -y && apt-get update -y && \
apt-get install adapta-kde -y && \

#Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" && apt-get update -y && \
apt-get install docker-ce docker-compose docker-ce-cli containerd.io -y && usermod -aG docker cthacker && \
systemctl enable docker && \
systemctl restart docker && \

#Install Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash && \

#Install VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | apt-key add - && \
apt-add-repository 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs vscodium main' && \
apt-get update -y && apt-get install codium -y && \

#Add Environment Variables
echo 'export NODE_OPTIONS=--max_old_space_size=4096' >> /home/cthacker/.bashrc && \
echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' >> /home/cthacker/.bashrc && \

#Install acme.sh
curl https://get.acme.sh | bash && \
chown cthacker:cthacker .acme.sh/ && \

#Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash && \

#Install SDKMAN!
curl -s "https://get.sdkman.io" | bash && \
source "$HOME/.sdkman/bin/sdkman-init.sh"

#Install SystemBack
cd $HOME/Downloads && wget https://vorboss.dl.sourceforge.net/project/systemback/1.8/Systemback_Install_Pack_v1.8.402.tar.xz && tar -xvf Systemback*.tar.xz && rm Systemback*.tar.xz && cd Systemback_Install_Pack_v1.8.402/ && echo "4" | sh install.sh && cd $HOME/Downloads && rm -rf Systemback* && \

#Install VSCODE
wget https://az764295.vo.msecnd.net/stable/a9f8623ec050e5f0b44cc8ce8204a1455884749f/code_1.44.1-1586789296_amd64.deb && \
dpkg -i code*.deb && \
rm -rf code*.deb

#Install KVM
apt-get update && apt-get install -y \
qemu-kvm \
libvirt-bin \
bridge-utils \
virt-manager \
qemu \
virt-viewer \ 
spice-vdagent \
open-vm-tools \
open-vm-tools-desktop

#Setup VNC
apt-get update && apt-get install -y \
xfce4 \
xfce4-goodies && \

touch  ~/.vnc/xstartup && \
echo "#!/bin/bash" > ~/.vnc/xstartup && \
echo "xrdb $HOME/.Xresources" >> ~/.vnc/xstartup && \
echo "startxfce4 &" >> ~/.vnc/xstartup
