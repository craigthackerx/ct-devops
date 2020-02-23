#!/bin/bash
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }
echo "Warning - this probably isn't the best practice for security"
sleep 1s
echo "You have been warned."
read -p 'Please enter your desired password: ' PASSWORD
cp yourkey.key privkey1.pem && \
openssl pkcs12 -export -in fullchain.cer \
-inkey privkey1.pem -name "yourpk12name" -out \
yourfile.p12 -passin pass:$PASSWORD -passout pass:$PASSWORD && \
cp yourfile.p12 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/ && \
cd /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/ && \
keytool -noprompt -storepass $PASSWORD -srcstorepass $PASSWORD -keypass $PASSWORD -importkeystore \
 -srckeystore yourfile.p12 -srcstoretype PKCS12 \
 -destkeystore yournewfile.jks -deststoretype jks && \
 chmod 777 yournewfile.jks && mv yournewfile.jks /home