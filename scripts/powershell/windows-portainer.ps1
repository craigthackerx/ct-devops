mkdir "C:\ProgramData\portainer" ; `
docker run -d -p 9443:9000 -p 8000:8000 `
--name portainer --restart always `
-v \\.\pipe\docker_engine:\\.\pipe\docker_engine `
-v C:\ProgramData\Portainer:C:\data `
craigtho/windows-portainer 