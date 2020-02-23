#!/bin/bash
mkdir $HOME/local-certs && cp $PWD/local-certs/* $HOME/local-certs && \
docker run -d \
-p 9443:9000 \
-p 10000:8000 \
--name craig-portainer \
 --restart always \
 -v "/var/run/docker.sock:/var/run/docker.sock" \
 -v $HOME/local-certs:/certs -v portainer_data:/data \
craigtho/portainer \
--ssl --sslcert /certs/portainer.crt --sslkey /certs/portainer.key