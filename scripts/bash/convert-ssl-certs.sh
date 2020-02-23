#!/bin/bash
read -p 'Please enter your domain name: ' DOMAIN_NAME
cd $HOME/.acme.sh/ && \
mv *.${DOMAIN_NAME} wildcard.${DOMAIN_NAME} && \
cd wildcard.${DOMAIN_NAME} && \
mv '*.${DOMAIN_NAME}.cer' wildcard.${DOMAIN_NAME}.cer && \
mv '*.${DOMAIN_NAME}.conf' wildcard.${DOMAIN_NAME}.conf && \
mv '*.${DOMAIN_NAME}.csr' wildcard.${DOMAIN_NAME}.csr && \
mv '*.${DOMAIN_NAME}.csr.conf' wildcard.${DOMAIN_NAME}.csr.conf && \
mv '*.${DOMAIN_NAME}.key' wildcard.${DOMAIN_NAME}.key