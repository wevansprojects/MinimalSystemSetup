#!/bin/bash
echo "Updating the System"
sudo apt update -y; sudo apt upgrade -y

echo "Installing Required Packages"
sudo apt install vim -y
sudo apt install unattended-upgrades -y
sudo apt install git -y
sudo apt install trash-cli -y
sudo apt install htop -y
sudo apt install sysstat -y
sudo apt install lynx -y

echo "Setting Up SystStat Monitoring"
cd /etc/default
sudo sed -i 's/ENABLED=\"false\"/ENABLED=\"true\"/' sysstat

echo "Applying System Service Startups"
sudo systemctl enable unattended-upgrades
sudo systemctl start unattended-upgrades
sudo systemctl enable sysstat
sudo systemctl start sysstat

sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Purging Unwanted Packages"
sudo apt purge firefox-esr -y
sudo apt purge nano -y
