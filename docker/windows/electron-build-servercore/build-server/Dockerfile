#From my base image - Windows 10 1909 with Scoop and Choco installed
FROM craigtho/windows-servercore-but-useful:latest

#Use Powershell
SHELL ["powershell", "-Command"]

#Install Unix utils
RUN scoop install git wget which curl sudo nano vim zip unzip unrar 7zip dos2unix sed
RUN scoop bucket add extras
RUN scoop bucket add java

#Install Electron Packages - Scoop
RUN scoop install ojdkbuild8
RUN scoop install gradle@4.8.1
RUN scoop install android-sdk
RUN scoop install googlechrome
RUN scoop install chromium
RUN scoop install nvm
RUN nvm install 10.16.0
RUN nvm use 10.16.0

#Install Electron Packages - Chocolatey - These are prone to failure. Especially VisualStudo and WindowsSDK
RUN choco install -y sqlserver-odbcdriver --version=13.1.4413.46
RUN choco install -y python
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
