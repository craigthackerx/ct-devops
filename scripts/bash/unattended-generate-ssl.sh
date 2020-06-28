#!/bin/bash
set -xe
STARTING_POINT=$(pwd)
PASSWORD="qwerty"
COUTNRY_CODE="UK"
STATE_CODE="City of London"
LOCATION_CODE="London"
COMPANY_CODE="Example Company"
OU_CODE="Internal IT"
COMMON_NAME_CODE="example.com"
EMAIL_CODE="example@example.com"

echo "This probably isn't the best for security" && sleep 1s && \

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

