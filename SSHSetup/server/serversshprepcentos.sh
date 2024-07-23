#!/bin/bash
echo "This Script will prepare the Server for SSH"
printf "\n"

mkdir $HOME/.ssh
sudo chmod 700 $HOME/.ssh
touch $HOME/.ssh/authorized_keys
sudo chmod 600 $HOME/.ssh/authorized_keys

echo "Adding a unique port for ssh in the firewall"
echo "We are assuming the default firewall is public"
printf "\n"

sudo firewall-cmd --add-port=49155/tcp --permanent
printf "\n"
sudo firewall-cmd --reload
echo "Firewall Change See Below"
sudo firewall-cmd --zone=public --list-all
printf "\n"
echo "Backup Old SSH File and Replace It"
cd /etc/ssh
sudo cp sshd_config ssh_config_old
cd /home/$USER 
touch sshd_config
rm sshd_config

echo "Include /etc/ssh/sshd_config.d/*.conf" >> sshd_config
echo "Protocol 2" >> sshd_config
echo "Compression no" >> sshd_config
echo "MaxAuthTries 2" >> sshd_config
echo "AllowAgentForwarding no" >> sshd_config
echo "AllowTcpForwarding no" >> sshd_config
echo "ClientAliveCountMax 2" >> sshd_config
echo "TCPKeepAlive no" >> sshd_config
echo "Port 49155" >> sshd_config
echo "PermitRootLogin no" >> sshd_config
echo "AuthorizedKeysFile      %h/.ssh/authorized_keys" >> sshd_config
echo "KbdInteractiveAuthentication no" >> sshd_config
echo "PasswordAuthentication no" >> sshd_config
echo "PermitEmptyPasswords yes" >> sshd_config
echo "PubKeyAuthentication yes" >> sshd_config
echo "UsePAM no" >> sshd_config
echo "X11Forwarding no" >> sshd_config
echo "Subsystem       sftp    /usr/libexec/openssh/sftp-server" >> sshd_config

sudo mv sshd_config /etc/ssh/
sudo chmod 600 /etc/ssh/sshd_config
sudo systemctl restart ssh
