#!/bin/bash
set -e
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

apt-get update && apt-get install xserver-xorg-core -y && \

apt-get install -y \
xserver-xorg-input-all
xorg \
xserver-xorg \
xserver-xorg-input-evdev \
xserver-xorg-video-vmware && \

apt-get install -y \
tigervnc-standalone-server \
tigervnc-viewer \
tigervnc-common \
tigervnc-xorg-extension

touch  ~/.vnc/xstartup && \
echo "#!/bin/sh" > ~/.vnc/xstartup && \
echo "[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup" >> ~/.vnc/xstartup && \
echo "[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources" >> ~/.vnc/xstartup && \
echo "vncconfig -iconic & >> ~/.vnc/xstartup" >> ~/.vnc/xstartup && \
echo "dbus-launch --exit-with-session gnome-session" & >> ~/.vnc/xstartup && \
chmod 700 ~/.vnc/xstartup && \
vncserver -localhost no -geometry 800x600 -depth 24
