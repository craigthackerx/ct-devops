#!/bin/bash
set -e
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }
apt-get update && apt-get install xserver-xorg-core -y && \

apt-get install -y \
tigervnc-standalone-server
tigervnc-viewer
tigervnc-common
tigervnc-xorg-extension
