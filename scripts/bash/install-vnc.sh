#!/bin/bash
set -e
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

apt-get update && apt-get install xserver-xorg-core -y && \

apt-get install -y \
xserver-xorg-input-all \
xorg \
xserver-xorg \
xserver-xorg-input-evdev \
xserver-xorg-video-vmware && \

apt-get install -y \
tigervnc-standalone-server \
tigervnc-viewer \
tigervnc-common \
tigervnc-xorg-extension && \

mkdir ~/.vnc && \
touch ~/.vnc/xstartup && \
echo '#!/bin/sh' > ~/.vnc/xstartup && \
echo '[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup' >> ~/.vnc/xstartup && \
echo '[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources' >> ~/.vnc/xstartup && \
echo 'vncconfig -iconic &' >> ~/.vnc/xstartup && \
echo 'dbus-launch --exit-with-session gnome-session &' >> ~/.vnc/xstartup && \
chmod 777 -R ~/.vnc/xstartup

#vncserver -localhost no -geometry 1920x1080 -depth 24 && chmod 700 -R ~/.vnc
#ssh -N -T -L 5901:<server's IP address>:5901 &
