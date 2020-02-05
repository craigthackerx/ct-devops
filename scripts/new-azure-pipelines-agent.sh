#!/bin/bash
AZURE_LINK="https://vstsagentpackage.azureedge.net/agent/2.164.6/vsts-agent-linux-x64-2.164.6.tar.gz"

read -p 'Please enter your desired Agent Name...: ' AGENT_NAME && \
echo "Downloading Azure Agents Package..." && \
cd $HOME && wget ${AZURE_LINK} && \
echo "Download Complete" && \
mkdir $HOME/${AGENT_NAME} && chmod 755 -R $HOME/${AGENT_NAME} && cd $HOME/${AGENT_NAME} && \

echo "Unzipping Agent Package"
tar zxvf $HOME/vsts-agent-linux-*.tar.gz && rm $HOME/vsts-agent-linux*.tar.gz && \
cd $HOME/${AGENT_NAME} && \
echo "Running config script" && \
./config.sh --unattended --url https://dev.azure.com/yourproject --auth pat --token yourtoken --pool "yourpool" --agent ${AGENT_NAME} --acceptTeeEula && \
echo "Config done! Running Agent now" && \
./run.sh
