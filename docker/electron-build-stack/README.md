Running a Windows Portainer is not easy. Below are instructions on how to *hack* Docker Desktop for Windows to **make** Windows Portainer work.
Here are the steps:

***ADMIN REQUIREMENT*** - Run `cmd` as Admin and run the following:

```
netsh advfirewall firewall add rule name="Docker" dir=in action=allow protocol=TCP localport=2375 enable=yes profile=domain,private,public
```

1.  Go to the Docker Desktop Settings Dashboard > General > Enable `"Expose daemon on tcp://localhost:2375 without TLS"`

2. Next, go to `C:\ProgramData\Docker\config` and Edit the Docker `daemon.json` file.  There is an example `daemon.json` file inside this folder for you to copy.

3. Restart Docker - `Get-Service Docker | Restart-Service`

4.  Run `docker-compose up` with the YAML in this project folder.

5. Go to `$YOUR_IP:9443` e.g. `192.168.1.1:9443` & Create your user

6. Select Remote and leave TLS unticked for now.  Enter an appropriate name for your Docker cluster and enter your IP followed by the port 2375 e.g. `192.168.1.1:2375`

7.  Done! You should now be able to access your Docker endpoint.