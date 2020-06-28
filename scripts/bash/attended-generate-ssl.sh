#!/bin/bash
set -xe
STARTING_POINT=$(pwd)

echo "This probably isn't the best for security" && sleep 1s && \

read -p "Please type the password you'd like for ALL certificates: " PASSWORD

read -p "Please type the Country Code (C) you want e.g. UK: " COUTNRY_CODE
read -p "Please type the State/Province (ST) you want e.g. Dumbartonshire: " STATE_CODE
read -p "Please type the Location (L) you want e.g. Glasgow: " LOCATION_CODE
read -p "Please type the Organisation name (O) you want e.g. Company Limited: " COMPANY_CODE
read -p "Please type the Organisational Unit (OU) you want e.g. Internal IT: " OU_CODE
read -p "Please type the name of the Common Name (CN) you want e.g. example.com: " COMMON_NAME_CODE
read -p "Please type your Email Address (emailAddress) e.g. example@example.come: " EMAIL_CODE

#Double slashes are needed for the -subj switch on Windows for the CN
echo "Making Key's for Portainer" && sleep 1s && \
mkdir -p $HOME/certs && cd $HOME/certs && \
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj \
'/C='"${COUTNRY_CODE}"\
'/ST='"${STATE_CODE}"\
'/L='"${LOCATION_CODE}"\
'/O='"${COMPANY_CODE}"\
'/OU='"${OU_CODE}"\
'/CN='"${COMMON_NAME_CODE}"\
'/emailAddress='"${EMAIL_CODE}" -passout pass:${PASSWORD} && \
cp key.pem portainer.key && cp cert.pem portainer.crt && \

echo "Making Root CA certs now"  && sleep 1s && \

openssl genrsa -out rootCA.key 4096 && \
openssl req -x509 -new -key rootCA.key -days 3650 -out rootCA.pem -subj \
'/C='"${COUTNRY_CODE}"\
'/ST='"${STATE_CODE}"\
'/L='"${LOCATION_CODE}"\
'/O='"${COMPANY_CODE}"\
'/OU='"${OU_CODE}"\
'/CN='"${COMMON_NAME_CODE}"\
'/emailAddress='"${EMAIL_CODE}" -passout pass:${PASSWORD} && \

echo "Making CA certs now"  && sleep 1s && \

openssl req -new -newkey rsa:4096 -nodes -out ca.csr -keyout ca.key -subj \
'/C='"${COUTNRY_CODE}"\
'/ST='"${STATE_CODE}"\
'/L='"${LOCATION_CODE}"\
'/O='"${COMPANY_CODE}"\
'/OU='"${OU_CODE}"\
'/CN='"${COMMON_NAME_CODE}"\
'/emailAddress='"${EMAIL_CODE}" -passout pass:${PASSWORD} && \

openssl x509 -trustout -signkey ca.key -days 365 -req -in ca.csr -out ca.pem && \
openssl genrsa -out client.key 4096 && \
openssl req -new -key client.key -out client.csr -subj \
'/C='"${COUTNRY_CODE}"\
'/ST='"${STATE_CODE}"\
'/L='"${LOCATION_CODE}"\
'/O='"${COMPANY_CODE}"\
'/OU='"${OU_CODE}"\
'/CN='"${COMMON_NAME_CODE}"\
'/emailAddress='"${EMAIL_CODE}" -passout pass:${PASSWORD} && \

openssl x509 -req -days 365 -CA rootCA.pem -CAkey rootCA.key \
-CAcreateserial -CAserial serial -in client.csr -out client.pem && \

echo "Moving everything here" && cp $HOME/certs/* $STARTING_POINT && echo "Done!"
