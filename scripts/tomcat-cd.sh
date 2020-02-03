#!/bin/bash
#Set Variables for script

#UNIX username
read -p 'Please enter your Tomcat username: ' USERNAME

read -p 'Please enter your Tomcat password: ' PASSWORD

#Input your customer var
read -p 'Please enter the Tomcat context path name: ' CONTEXT_PATH

#Absolute File path with permissons
read -p 'Please enter the /path/to/the/file you would like to transfer: ' FILE_PATH

#IPs within Quotation marks `" "` followed by a space.
read -p 'Please enter the IP you would like to transfer to: ' ADDRESS

#Port numbers are generally 8040, 8060 and 8080
read -p 'Please enter the port your tomcat is on: ' PORT

# Start Curl file transfer
echo "Starting curl file transfer to ${#ADDRESS} machines."
for ((i=0; i<${#ADDRESS[@]}; ++i )) ;
do
   echo "Undeploying Tomcat War ${CONTEXT_PATH}"
   curl --insecure -sSL "https://${USERNAME}:${PASSWORD}@${ADDRESS}:${PORT}/manager/text/undeploy?path=/${CONTEXT_PATH}" && \
   sleep 10s && \
   echo "Transfering ${FILE_PATH} to ${ADDRESS}:${PORT}..." && \
   curl --insecure -sSL --upload-file ${FILE_PATH} "https://${USERNAME}:${PASSWORD}@${ADDRESS}:${PORT}/manager/text/deploy?path=/${CONTEXT_PATH}&update=true"
done
wait
echo "Mischief Managed."