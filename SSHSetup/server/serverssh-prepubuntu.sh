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
sudo cp sshd_config /etc/ssh/
sudo chown root:root /etc/ssh/sshd_config
sudo chmod 644 /etc/ssh/sshd_config

sudo systemctl restart sshd
