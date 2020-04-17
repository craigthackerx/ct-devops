read -p 'Please enter the username of the target machine: ' USERNAME
read -p 'Please enter the IP of the target machine: ' TARGET_IP && \

ssh-copy-id $USERNAME@$TARGET_IP && \
scp ~/.ssh/* $USERNAME@$TARGET_IP:/home/$USERNAME/.ssh && \
ssh -t $USERNAME@$TARGET_IP 'bash -i -c "chmod 700 ~/.ssh"'
