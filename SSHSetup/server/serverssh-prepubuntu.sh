#!/bin/bash
echo "This Script will prepare the Server for SSH"
echo "Note it is assumed SSH Server and client are already installed"
printf "\n"

echo "Adding a unique port for ssh in the firewall"
printf "\n"

sudo ufw deny ssh
sudo ufw allow 49155
printf "\n"

echo "Firewall Change See Below"
sudo ufw status verbose
printf "\n"
echo "Backup Old SSH File and Replace It"
cd /etc/ssh
sudo cp sshd_config sshd_config_old
sudo rm sshd_config
cd /home/$USER 
touch sshd_config

echo "Include /etc/ssh/sshd_config.d/*.conf" >> sshd_config
echo "Port 49155" >> sshd_config
echo "Protocol 2" >> sshd_config
echo "Compression no" >> sshd_config
echo "MaxAuthTries 2" >> sshd_config
echo "AllowAgentForwarding no" >> sshd_config
echo "AllowTcpForwarding no" >> sshd_config
echo "ClientAliveCountMax 2" >> sshd_config
echo "TCPKeepAlive no" >> sshd_config
echo "PermitRootLogin no" >> sshd_config
echo "AuthorizedKeysFile      .ssh/authorized_keys" >> sshd_config
echo "PermitEmptyPasswords yes" >> sshd_config
echo "KbdInteractiveAuthentication no" >> sshd_config
echo "UsePAM yes" >> sshd_config
echo "X11Forwarding no" >> sshd_config
echo "PrintMotd no" >> sshd_config
echo "AcceptEnv LANG LC_*" >> sshd_config
echo "Subsystem       sftp    /usr/lib/openssh/sftp-server" >> sshd_config

sudo mv sshd_config /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/sshd_config
