FROM ubuntu:latest

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

#Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone