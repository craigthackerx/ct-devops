#From my base image - Windows 10 1909 with Scoop and Choco installed
FROM craigtho/winservercoreltsc:latest

#Use Powershell
SHELL ["powershell", "-Command"]

#Install Unix utils
RUN scoop install git wget which curl sudo nano vim zip unzip unrar 7zip dos2unix
RUN scoop bucket add extras
RUN scoop bucket add java

#Install and enable OpenSSH
RUN scoop install win32-openssh
RUN sudo C:\Users\ContainerAdministrator\scoop\apps\win32-openssh\current\install-sshd.ps1
RUN Get-Service *ssh* | Start-Service
RUN Set-Service -Name ssh-agent -StartupType Automatic ; Set-Service -Name sshd -StartupType Automatic

#Install Electron Packages - Scoop
RUN scoop install gradle@4.8.1
RUN scoop install python
RUN scoop install android-sdk
RUN scoop install googlechrome
RUN scoop install chromium

#Install Electron Packages - Chocolatey - These are prone to failure. Especially VisualStudo and WindowsSDK
RUN choco install -y nodejs -version 10.16.3
RUN choco install -y sqlserver-odbcdriver --version=13.1.4413.46
RUN choco install -y azure-CLI
RUN choco install -y sqllocaldb
RUN choco install -y microsoft-visual-cpp-build-tools
RUN choco install -y webdeploy
RUN choco install -y dotnetcore-sdk
RUN choco install -y visualstudio2019community
RUN choco install -y windows-sdk-10.1

#Set Node.JS Options for old space
RUN $Env:NODE_OPTIONS +=\"--max-old-space-size=4096\""

#Set WorkingDirectory
WORKDIR 'C:\Users\ContainerAdministrator\Desktop'

#Start in PowerShell
ENTRYPOINT [ "powershell" ]
