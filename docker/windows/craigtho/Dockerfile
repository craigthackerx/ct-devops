#Using Windows 10
FROM mcr.microsoft.com/windows:1909

#Use Powershell
SHELL ["powershell", "-Command"]

#Allow yourself to run unsigned scripts
RUN Set-ExecutionPolicy Unrestricted

#Install chocolatey
RUN Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Scoop
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iwr -useb get.scoop.sh | iex