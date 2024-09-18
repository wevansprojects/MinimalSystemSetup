#!/bin/bash
echo "Updating the System"
sudo dnf upgrade -y
sudo dnf install epel-release
sudo dnf update -y
echo "Installing Required Packages"
sudo dnf install vim -y
sudo dnf install dnf-automatic -y
sudo dnf install git -y
sudo dnf install trash-cli -y
sudo dnf install htop -y
sudo dnf install sysstat -y
sudo dnf install lynx -y
sudo dnf install -y nginx 
sudo dnf install -y openssl
sudo dnf install -y policycoreutils-python-utils
echo "Applying System Service Startups"
sudo systemctl enable dnf-automatic.timer
sudo systemctl start dnf-automatic.timer

echo "Purging Unwanted Packages"
sudo dnf purge nano -y

echo "Apending host file with testsite.com"
echo "$(hostname -I) testsite.com" |sudo tee -a /etc/hosts
cat /etc/hosts
